(require 'mikio-util)

;; 参考URL
;; http://epian-wiki.appspot.com/wiki/Emacs/JDEE

(add-to-list 'load-path (mikio/site-lisp-directory "jdee-old/jdee/dist/jdee-2.4.1/lisp"))
(add-to-list 'load-path (mikio/site-lisp-directory "emacs-helm-jdee-method"))

;; load autoloads file
(load "jde-autoload")

(defun my-jde-main-src-dir? ()
  "カレントバッファのファイルがメインソースのディレクトリかどうか？"
  (let* ((bfname (buffer-file-name)))
    (if (string-match my-jde-main-source-dir bfname)
        t
      nil)))

(defun my-jde-test-src-dir? ()
  "カレントバッファのファイルがテストソースのディレクトリかどうか？"
  (let* ((bfname (buffer-file-name)))
    (if (string-match my-jde-test-source-dir bfname)
        t
      nil)))

(defun my-jde-get-abs-main-dir-name ()
  (expand-file-name (concat my-jde-project-root-dir my-jde-main-source-dir))) 

(defun my-jde-get-abs-test-dir-name ()
  (expand-file-name (concat my-jde-project-root-dir my-jde-test-source-dir))) 

(defun my-jde-get-main-file-name (bfname)
  (message "my-jde-get-main-file-name")
  (let* ((mdir (my-jde-get-abs-main-dir-name))
         (tdir (my-jde-get-abs-test-dir-name))
         (basename (replace-regexp-in-string tdir mdir bfname)))
    (concat (substring basename 0 -4) ".java")))

(defun my-jde-get-test-file-name (bfname)
  (message "my-jde-get-test-file-name")
  (let* ((mdir (my-jde-get-abs-main-dir-name))
         (tdir (my-jde-get-abs-test-dir-name))
         (basename (replace-regexp-in-string mdir tdir bfname)))
    (concat basename "Test.java")))

;; (replace-regexp-in-string
;;  "c:/Users/m-oono/Desktop/sample-java-project/src"
;;  "c:/Users/m-oono/Desktop/sample-java-project/test"
;;  "c:/Users/m-oono/Desktop/sample-java-project/src/sample/java/project/SampleJavaProject"
;;  )

;; (my-jde-get-test-file-name "c:/Users/m-oono/Desktop/sample-java-project/src/sample/java/project/SampleJavaProject")

(defun my-jde-toggle-main-test ()
  "メインクラスとテストクラスのソースを切り替えます。"
  (interactive)
  (let* ((bfname (file-name-sans-extension (buffer-file-name)))
         (filename (if (my-jde-test-src-dir?)
                       (my-jde-get-main-file-name bfname)
                     (my-jde-get-test-file-name bfname))))
    (condition-case err
        (find-file filename)
      (error (message "Could not find source file for \"%s\"." filename)))
    ))

(defun my-jde-make-class-dir ()
  "クラスファイル出力ディレクトリを作成する。"
  (message "my-jde-make-class-dir")
  (let* ((mclass-dir (concat my-jde-project-root-dir my-jde-main-class-dir))
         (tclass-dir (concat my-jde-project-root-dir my-jde-test-class-dir)))
    (if (not (file-exists-p mclass-dir))
        (make-directory mclass-dir t))
    (if (not (file-exists-p tclass-dir))
        (make-directory tclass-dir t))))

(defadvice jde-compile (before my-jde-compile activate)
  "対象の.javaが*Testであればテストクラス用のディレクトリに.classファイルを出力する"
  (princ "jde-compile before")
  (my-jde-make-class-dir)
  (if (my-jde-test-src-dir?)
      (setq jde-compile-option-directory my-jde-test-class-dir)
    (setq jde-compile-option-directory my-jde-main-class-dir)))

(defun my-jde-bsh-restart ()
  "BeanShellを再起動してprj.elを読みこむ"
  (interactive)
  (jde-bsh-exit)
  (sleep-for 1)
  (jde-load-project-file)
  (jde-bsh-run)
  (end-of-buffer))

(defun my-jde-mode-hook ()
  (require 'helm-jdee-method)
  (require 'jde)

  (auto-complete-mode t)

  (setq jde-build-function 'jde-ant-build) ; ビルドにantを利用する
  (setq jde-ant-read-target t)             ; targetを問い合わせる
  (setq jde-ant-enable-find t)             ; antに-findオプションを指定する(要らないかも)

  ;; compilationバッファを自動的にスクロールさせる
  (setq compilation-ask-about-save nil)
  (setq compilation-scroll-output 'first-error)

  (define-key jde-mode-map (kbd "C-c C-v .") 'jde-complete-minibuf)
  (define-key jde-mode-map (kbd "C-c C-v C-i") 'helm-jdee-method)

  ;; junit
  ;; jde-epn-toggle-main-test関数を呼びだすと、キーバインドがリセットされるっぽい。
  ;;(define-key jde-mode-map (kbd "C-c C-v C-t") 'jde-junit-run)
  (define-key jde-mode-map (kbd "<f11>") 'jde-junit-run)

  ;; テストクラスのトグル
  ;; C-c C-v t を定義したがうまくいかない。
  ;; jde-epn-toggle-main-test関数を呼びだすと、キーバインドがリセットされるっぽい。
  ;;(define-key jde-mode-map (kbd "C-c C-v t") 'jde-epn-toggle-main-test)
  (define-key jde-mode-map (kbd "<f5>") 'my-jde-toggle-main-test)

  (define-key jde-mode-map (kbd "C-c C-v r") 'my-jde-bsh-restart)

  ;; import文のソート
  ;; jde-import-all,jde-import-find-and-import時に勝手にソートする用に設定している
  ;; => なぜか効かない
  (setq jde-import-auto-sort t)
  
  ;; (require 'jde-flymake)
  ;; (setq jde-flymake-jikes-app-name "javac")
  ;; (push '(".+\\.java$"
  ;;         flymake-jde-jikes-java-init
  ;;         flymake-simple-java-cleanup
  ;;         flymake-get-real-file-name)
  ;;       flymake-allowed-file-name-masks)
  ;; (flymake-mode)


  (setq jde-compile-option-command-line-args nil)
  ;; (setq jde-compile-option-command-line-args '("-J-Duser.language=en"
  ;;                                              ;;"-J-Dfile.encoding=UTF8"
  ;;                                              ))
  (setq jde-compile-option-command-line-args '("-g"
                                               ))

  ;;http://groups.yahoo.co.jp/group/jdee-jp/messages/33?viscount=14&expand=1
  ;; Jde Compile Option Vm Argsに設定します。
  (setq jde-compile-option-vm-args nil)
  ;; (setq jde-compile-option-vm-args '(
  ;;                                    "-Duser.language=en"
  ;;                                    ))
  ;; (setq jde-compile-option-vm-args '("-Duser.language=en"
  ;;                                    "-Dfile.encoding=UTF8"
  ;;                                    ))

  ;;(setq jde-db-read-vm-args "-J-Dfile.encoding=UTF8")
  ;;(setq jde-debugger '("jdb -J-Duser.language=en"))
  (setq jde-db-option-vm-args '("-J-Duser.language=en"))
  (setq jde-debugger '("jdb"))


  )

(setq ac-modes (append ac-modes '(jde-mode)))
(add-hook 'jde-mode-hook 'my-jde-mode-hook)
;;(add-hook 'jde-entering-java-buffer-hook '(lambda () (auto-complete-mode t)))
(add-hook 'jde-entering-java-buffer-hook 'my-jde-mode-hook)


(provide 'mikio-jdee)
