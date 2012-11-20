(require 'mikio-util)
;;-----------------------------------------------------------------
;; 参考
;; - http://epian-wiki.appspot.com/wiki/Emacs/JDEE#i1C861AE907CB2F41F9C71F925BC21092
;;-----------------------------------------------------------------
(add-to-list 'load-path (mikio/site-lisp-directory "jdee/dist/jdee-2.4.1/lisp"))

;; load autoloads file
(load "jde-autoload")

(defun my-jde-mode-hook ()
  (require 'jde)
  (require 'helm-jdee-method)

  ;; Ant
  ;;(require 'jde-ant)
  (setq jde-build-function 'jde-ant-build) ; ビルドにantを利用する
  (setq jde-ant-read-target t)               ; targetを問い合わせる
  (setq jde-ant-enable-find t) ; antに-findオプションを指定する(要らないかも)
  ;;(setq jde-ant-enable-find nil) ; antに-findオプションを指定する(要らないかも)

  ;; coplilationバッファを自動的にスクロールさせる
  (setq compilation-ask-about-save nil)
  (setq compilation-scroll-output 'first-error)

  ;;(setq jde-db-read-vm-args "-J-Dfile.encoding=UTF8")
  ;;(setq jde-debugger '("jdb -J-Dfile.encoding=UTF8"))

  ;; (require 'jde-flymake)
  ;; (setq jde-flymake-jikes-app-name "javac")
  ;; (push '(".+\\.java$"
  ;;         flymake-jde-jikes-java-init
  ;;         flymake-simple-java-cleanup
  ;;         flymake-get-real-file-name)
  ;;       flymake-allowed-file-name-masks)
  ;; (flymake-mode)

  (define-key jde-mode-map (kbd "C-c C-v .") 'jde-complete-minibuf)
  ;;(define-key jde-mode-map (kbd "C-c C-SPC") 'mikio/jde-debug)

  (auto-complete-mode t)
  )

(setq ac-modes (append ac-modes '(jde-mode)))
(add-hook 'jde-mode-hook 'my-jde-mode-hook)
(add-hook 'jde-entering-java-buffer-hook '(lambda () (auto-complete-mode t)))


(provide 'mikio-jdee)
