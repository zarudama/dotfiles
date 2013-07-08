(require 'mikio-util)

;; 参考URL
;; http://epian-wiki.appspot.com/wiki/Emacs/JDEE

(add-to-list 'load-path (mikio/site-lisp-directory "jdee/lisp"))
(add-to-list 'load-path (mikio/site-lisp-directory "emacs-helm-jdee-method"))

;; load autoloads file
(load "jde-autoload")

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
  (require 'jde-quick-junit)

  (auto-complete-mode t)

  ;; compilationバッファを自動的にスクロールさせる
  (setq compilation-ask-about-save nil)
  (setq compilation-scroll-output 'first-error)

  (define-key jde-mode-map (kbd "C-c C-v .") 'jde-complete-minibuf)
  (define-key jde-mode-map (kbd "C-c C-v C-i") 'helm-jdee-method)

  ;; junit
  ;; jde-epn-toggle-main-test関数を呼びだすと、キーバインドがリセットされるっぽい。
  ;;(define-key jde-mode-map (kbd "C-c C-v C-t") 'jde-junit-run)
  ;;(define-key jde-mode-map (kbd "<f11>") 'jde-quick-junit-run)
  (define-key jde-mode-map (kbd "<f11>") 'jde-junit-run)

  ;; テストクラスのトグル
  ;; C-c C-v t を定義したがうまくいかない。
  ;; jde-epn-toggle-main-test関数を呼びだすと、キーバインドがリセットされるっぽい。
  ;;(define-key jde-mode-map (kbd "C-c C-v t") 'jde-epn-toggle-main-test)
  (define-key jde-mode-map (kbd "<f5>") 'jde-quick-junit-toggle-main-test)

  (define-key jde-mode-map (kbd "C-c C-v r") 'my-jde-bsh-restart)

  ;; (require 'jde-flymake)
  ;; (setq jde-flymake-jikes-app-name "javac")
  ;; (push '(".+\\.java$"
  ;;         flymake-jde-jikes-java-init
  ;;         flymake-simple-java-cleanup
  ;;         flymake-get-real-file-name)
  ;;       flymake-allowed-file-name-masks)
  ;; (flymake-mode)



  )

(setq ac-modes (append ac-modes '(jde-mode)))
(add-hook 'jde-mode-hook 'my-jde-mode-hook)
;;(add-hook 'jde-entering-java-buffer-hook '(lambda () (auto-complete-mode t)))
(add-hook 'jde-entering-java-buffer-hook 'my-jde-mode-hook)


(provide 'mikio-jdee)
