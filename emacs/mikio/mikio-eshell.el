(require 'mikio-util)

(require 'eshell)

;;; マクロはトップレベルじゃないと駄目っぽい
(defmacro eval-after-load* (name &rest body)
  (declare (indent 1))
  `(eval-after-load ,name '(progn ,@body)))

;;;-----------------------------------------------------------------
;;; eshell tips
;;;-----------------------------------------------------------------

;;; シェルコマンドの履歴から補完する
(require 'shell-history)
;;(anything-complete-shell-history-setup-key (kbd "C-o"))
(setq eshell-mode-hook
      '(lambda ()
         (local-set-key (kbd "C-o") 'anything-eshell-history)
         ))

;;; tabbar用にバッファ名から「＊」を取り除く
;;;(setq eshell-buffer-name "eshell")

(setq eshell-history-size 10000)
(setq eshell-last-dir-ring-size 1000)

;;; 補完時に大文字小文字を区別しない
(setq eshell-cmpl-ignore-case t)

;;; 確認なしでヒストリ保存
(setq eshell-ask-to-save-history (quote always))

;;; プロンプトの変更
(defun my-eshell-prompt ()
  (format "%s%s" (eshell/pwd) "$ "))
(setq eshell-prompt-function 'my-eshell-prompt)
(setq eshell-prompt-regexp "^[^#$\n]*[#$] ")

;; cygwinの場合のパス問題を解決する
;; http://d.hatena.ne.jp/takuya_1st/20110423/1303586388
;;(setenv "CYGWIN" "nodosfilewarning") 
(setenv "ANT_OPTS" "-Dfile.encoding=UTF-8")

;; ;;-----------------------------------------------------------------
;; ;; エスケープしケーンスによるカラー表示
;; ;;-----------------------------------------------------------------
;; ;; (autoload 'ansi-color-for-comint-mode-on "ansi-color"
;; ;;           "Set `ansi-color-for-comint-mode' to t." t)
;; ;; (add-hook 'eshell-load-hook 'ansi-color-for-comint-mode-on)
;; ;; http://www.emacswiki.org/emacs-ja/EshellColor
;; (require 'ansi-color)
;; (require 'eshell)
;; (defun eshell-handle-ansi-color ()
;;   (ansi-color-apply-on-region eshell-last-output-start
;;                               eshell-last-output-end))
;; (add-to-list 'eshell-output-filter-functions 'eshell-handle-ansi-color)

;; ;;-----------------------------------------------------------------
;; ;; auto-complete
;; ;;-----------------------------------------------------------------
;; ;;  Symbol's value as variable is void: pcomplete
;; (when (require 'pcomplete nil t)
;;   (defun pcomplete () (list))
;;   (add-hook 'eshell-mode-hook 'pcomplete-shell-setup)
;;   (add-to-list 'ac-modes 'eshell-mode)
;;   (ac-define-source pcomplete
;;     '((candidates . pcomplete-completions)))

;;   (defun my-ac-eshell-mode ()
;;     (setq ac-sources
;;           '(ac-source-pcomplete
;;             ac-source-words-in-buffer
;;             ac-source-dictionary)))

;;   (add-hook 'eshell-mode-hook
;;             (lambda ()
;;               (my-ac-eshell-mode)
;;               (define-key eshell-mode-map (kbd "C-i") 'auto-complete)))
;;   )

;; ;;-----------------------------------------------------------------
;; ;; auto-complete
;; ;; http://sheephead.homelinux.org/2011/02/21/6612/
;; ;;-----------------------------------------------------------------

;; (add-to-list 'ac-modes 'eshell-mode)

;; ;;pcomplete-parse-argumentsの一部を削除しただけ
;; (defun ac-pcomplete-parse-arguments (&optional expand-p)
;;   "Parse the command line arguments.  Most completions need this info."
;;   (let ((results (funcall pcomplete-parse-arguments-function)))
;;     (when results
;;       (setq pcomplete-args (or (car results) (list ""))
;;             pcomplete-begins (or (cdr results) (list (point)))
;;             pcomplete-last (1- (length pcomplete-args))
;;             pcomplete-index 0
;;             pcomplete-stub (pcomplete-arg 'last))
;;       (let ((begin (pcomplete-begin 'last)))
;;         (if (and pcomplete-cycle-completions
;;                  (listp pcomplete-stub) ;??
;;                  (not pcomplete-expand-only-p))
;;             (let* ((completions pcomplete-stub) ;??
;;                    (common-stub (car completions))
;;                    (c completions)
;;                    (len (length common-stub)))
;;               (while (and c (> len 0))
;;                 (while (and (> len 0)
;;                             (not (string=
;;                                   (substring common-stub 0 len)
;;                                   (substring (car c) 0
;;                                              (min (length (car c))
;;                                                   len)))))
;;                   (setq len (1- len)))
;;                 (setq c (cdr c)))
;;               (setq pcomplete-stub (substring common-stub 0 len)
;;                     pcomplete-autolist t)
;;               (throw 'pcomplete-completions completions))
;;           (when expand-p
;;             (if (stringp pcomplete-stub)
;;                 (if (and (listp pcomplete-stub)
;;                          pcomplete-expand-only-p)
;;                     ;; this is for the benefit of `pcomplete-expand'
;;                     (setq pcomplete-last-completion-length (- (point) begin)
;;                           pcomplete-current-completions pcomplete-stub)
;;                   (error "Cannot expand argument"))))
;;           (if pcomplete-expand-only-p
;;               (throw 'pcompleted t)
;;             pcomplete-args))))))

;; (defun ac-pcmpl ()
;;   "Return a list of completions for the current argument position."
;;   (catch 'pcomplete-completions
;;     (when (ac-pcomplete-parse-arguments pcomplete-expand-before-complete)
;;       (if (= pcomplete-index pcomplete-last)
;;           (funcall pcomplete-command-completion-function)
;;         (let ((sym (or (pcomplete-find-completion-function
;;                         (funcall pcomplete-command-name-function))
;;                        pcomplete-default-completion-function)))
;;           (ignore
;;            (pcomplete-next-arg)
;;            (funcall sym)))))))

;; (ac-define-source pcomplete
;;   '((candidates . ac-pcmpl)))

;; (defun my-ac-eshell-mode ()
;;   (setq ac-sources
;;         '(ac-source-pcomplete
;;           ;;ac-source-words-in-buffer
;;           ac-source-dictionary)))

;; (add-hook 'eshell-mode-hook
;;           (lambda ()
;;             (my-ac-eshell-mode)))


;; ----------------------------------------
;; sudo の後のコマンドも補完が効くように。
;; ----------------------------------------
;; (defun pcomplete/sudo ()
;;   "Completion rules for the `sudo' command."
;;   (let ((pcomplete-help "complete after sudo"))
;;     (pcomplete-here (pcomplete-here (eshell-complete-commands-list)))))

;; ----------------------------------------
;; 画面クリア
;; ----------------------------------------
(defun eshell/clear ()
  "Clear the current buffer, leaving one prompt at the top."
  (interactive)
  (let ((inhibit-read-only t))
    (erase-buffer)))

;; ----------------------------------------
;; コマンド解釈乗っ取り
;; ----------------------------------------
(require 'esh-myparser)
;; zsh用のzコマンド定義
(defun eshell-parser/z (str) (eshell-parser/b str "zsh"))

;; ----------------------------------------
;; eshellをポップアップする
;; (install-elisp-from-emacswiki "shell-pop.el")
;; (install-elisp "http://www.rubyist.net/~rubikitch/private/eshell-pop.el")
;; ----------------------------------------
;; (require 'eshell-pop)
;; (global-set-key (kbd "C-x C-z") 'shell-pop)
;;(setq shell-pop-window-height 100)
(global-set-key (kbd "C-x C-z") 'eshell)

;; ----------------------------------------
;; eshellで実装されたコマンド群を削除する
;; ----------------------------------------
(defun eshell-disable-unix-command-emulation ()
  (eval-after-load* "em-ls"
    (fmakunbound 'eshell/ls))
  (eval-after-load* "em-unix"
    (mapc 'fmakunbound '(eshell/agrep
                         eshell/basename
                         eshell/cat
                         eshell/c
                         eshell/cp
                         eshell/date
                         eshell/diff
                         eshell/dirname
                         eshell/du
                         eshell/egrep
                         eshell/echo
                         eshell/fgrep
                         eshell/glimpse
                         eshell/grep
                         eshell/info
                         eshell/ln
                         eshell/locate
                         eshell/make
                         eshell/man
                         eshell/mkdir
                         eshell/mv
                         eshell/occur
                         eshell/rm
                         eshell/rmdir
                         eshell/su
                         eshell/sudo
                         eshell/time))))
(eshell-disable-unix-command-emulation)

;;-----------------------------------------------------------------
;; eshell を通常のシェルの挙動に近づける。
;;-----------------------------------------------------------------
(progn
  (defun eshell-in-command-line-p ()
    (<= eshell-last-output-end (point)))
  (defmacro defun-eshell-cmdline (key &rest body)
    (let ((cmd (intern (format "eshell-cmdline/%s" key))))
      `(progn
         (add-hook 'eshell-mode-hook
                   (lambda () (define-key eshell-mode-map (read-kbd-macro ,key) ',cmd)))
         (defun ,cmd ()
           (interactive)
           (if (not (eshell-in-command-line-p))
               (call-interactively (lookup-key (current-global-map) (read-kbd-macro ,key)))
             ,@body)))))
  (defun eshell-history-and-bol (func)
    (delete-region eshell-last-output-end (point-max))
    (funcall func 1)
    (goto-char eshell-last-output-end)))

;; C-wの挙動を拡張
(defun-eshell-cmdline "C-w"
  (if (eq (point-max) (point))
      (backward-kill-word 1)
    (kill-region (region-beginning) (region-end))))

;; コマンドライン上で押されたときは履歴操作
(defun-eshell-cmdline "C-p"
  (let ((last-command 'eshell-previous-matching-input-from-input))
    (eshell-history-and-bol 'eshell-previous-matching-input-from-input)))

;; コマンドライン上で押されたときは履歴操作
(defun-eshell-cmdline "C-n"
  (let ((last-command 'eshell-previous-matching-input-from-input))
    (eshell-history-and-bol 'eshell-next-input)))

;; eshellデフォルトだと、履歴のポインタを戻せない。
;; 通常のシェルのように、RET C-pを押したら、直前の履歴を取り出す。
(defadvice eshell-send-input (after history-position activate)
  (setq eshell-history-index -1))

;;-----------------------------------------------------------------
;; elispの変数の値を調べるためのeコマンド
;; ex.
;; $ e major-mode
;;-----------------------------------------------------------------
(defun eshell/e (arg)
  (eval (read (format "%s" arg))))

;;-----------------------------------------------------------------
;; eshell上で新しいeshellバッファの作成
;;-----------------------------------------------------------------
(progn
  (defun eshell-new ()
    (interactive)
    (eshell t)
    (delete-other-windows)
    )
  (defun eshell-mode-hook0 ()
    (define-key eshell-mode-map "\C-c\C-z" 'eshell-new))
  (add-hook 'eshell-mode-hook 'eshell-mode-hook0))

;;   (if (eq window-system 'w32)
;;       (progn
;;         (message "w32!")
;;         ;; (setq explicit-shell-file-name "c:\\cygwin\\bin\\bash.exe")
;;         ;; (setq shell-file-name "c:\\cygwin\\bin\\sh.exe")
;;         ;;(setq eshell-windows-shell-file "c:/cygwin/bin/bash.exe")


;; ;; C:
;; ;; chdir C:\cygwin\bin
;; ;; bash --login -i


;;         ;; (DECODING . ENCODING) specifying the coding
;;         ;;(modify-coding-system-alist 'process "shell" '(undecided-dos . sjis-unix))
;;         (modify-coding-system-alist 'process "eshell" '(undecided-unix  . undecided-unix ))
;;         ;; (setq explicit-shell-file-name "bash.exe")
;;         ;; (setq shell-file-name "sh.exe")
;;         ;; (setq shell-command-switch "-c")
;;         ;;(set-buffer-process-coding-system 'sjis-unix 'sjis-unix )
;;         ;;(set-buffer-process-coding-system 'utf-8-unix 'utf-8-unix)
;;         ;;(set-buffer-process-coding-system 'sjis-unix 'utf-8-unix)
;;         ;;(set-buffer-process-coding-system 'utf-8-unix 'sjis-unix)
;;         ;;      (modify-coding-system-alist 'process "shell" '(undecided-dos . utf-8-unix))

;;         ;; (modify-coding-system-alist 'process ".*sh\\.exe" '(undecided-dos . euc-japan))
;;         ;; argument-editing の設定                                                      
;;         ;; (require 'mw32script)                                                           
;;         ;; (mw32script-init)                                                               
;;         ;; (setq exec-suffix-list '(".exe" ".sh" ".pl"))                                   
;;         ;; (setq shell-file-name-chars "~/A-Za-z0-9_^$!#%&{}@`'.:()-")                     

;;         ;;      (setenv "JAVA_HOME" "C:\\m-oono\\opt\\jdk1.6.0_24")
;;         ;;      (setenv "M2_HOME" "c:\\m-oono\\opt\\apache-maven-2.2.1")
;;         ;;      (setenv "MAVEN_OPTS" (concat "-Duser.home=" (getenv "HOME"))) 
;;         ;;      (setenv "PATH" 
;;         ;;              (concat
;;         ;;               "C:\\cygwin\\bin;"
;;         ;;               "C:\\cygwin\\usr\\local\\bin;"
;;         ;;               "C:\\m-oono\\bin;"
;;         ;;               (getenv "JAVA_HOME") "\\bin;"
;;         ;;               (getenv "MAVEN_HOME") "\\bin;"
;; ;;;;               (getenv "USERPROFILE") "\\.lein\\bin;"
;;         ;;               ))
;;         ;;      (setq explicit-bash-args '("--noediting" "--rcfile" "~/.emacs.d/.bashrc" "-i"))
;;         ;;      (setq explicit-bash-args '("--noediting" "--rcfile" "~/.emacs.d/.bashrc" "-i"))
;;         ;;      (set-background-color "black")
;;         ;;      (set-foreground-color "#888888")
;;         ;;      (set-background-color "#dddddd")
;;         ))


;;;-----------------------------------------------------------------
;;; コマンドラインスタックの実現
;;; (install-elisp "http://www.rubyist.net/~rubikitch/private/esh-cmdline-stack.el")
;;;-----------------------------------------------------------------
(require 'esh-cmdline-stack)


(provide 'mikio-eshell)
