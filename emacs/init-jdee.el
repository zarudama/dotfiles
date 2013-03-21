(savehist-mode 1)
(define-key global-map (kbd "C-h") 'delete-backward-char)
(define-key global-map (kbd "M-C-h") 'backward-kill-word)

;; ↓とにかく設定ファイルの最初のほうで読みこむ
(load-file "~/site-lisp/cedet-1.1/common/cedet.el") 

(add-to-list 'load-path "~/site-lisp/jdee/dist/jdee-2.4.1/lisp")
(load "jde-autoload")

(defun my-jde-mode-hook ()
  (require 'jde)

  (setq jde-build-function 'jde-ant-build) ; ビルドにantを利用する
  (setq jde-ant-read-target t)             ; targetを問い合わせる
  (setq jde-ant-enable-find t)             ; antに-findオプションを指定する(要らないかも)

  ;; complilationバッファを自動的にスクロールさせる
  (setq compilation-ask-about-save nil)
  (setq compilation-scroll-output 'first-error)

  (define-key jde-mode-map (kbd "C-c C-v .") 'jde-complete-minibuf)
  )

(add-hook 'jde-mode-hook 'my-jde-mode-hook)
