(require 'mikio-util)

;;-----------------------------------------------------------------
(find-function-setup-keys) ;; C-x F, C-x Kなどを使えるようにする。

;;-----------------------------------------------------------------
;; => find-variable-other-frame
;; M-x install-elisp-from-emacswiki lispxmp.le
;;-----------------------------------------------------------------
(require 'lispxmp)		
(define-key emacs-lisp-mode-map (kbd "C-c C-d") 'lispxmp)

;;-----------------------------------------------------------------
;; eldoc
;; M-x install-elisp-from-emacswiki eldoc-extention.el
;;-----------------------------------------------------------------
(require 'eldoc-extension)
(add-hook 'emacs-lisp-mode-hook 'turn-on-eldoc-mode)
(add-hook 'lisp-interaction-mode-hook 'turn-on-eldoc-mode)
(add-hook 'ielm-mode-hook 'turn-on-eldoc-mode)
(setq eldoc-idle-delay 0.2)
(setq eldoc-minor-mode-string "")

;-----------------------------------------------------------------
;; カッコの対応を取りながらS式を編集する。
;; (install-elisp "http://mumble.net/~campbell/emacs/paredit.el")
;;-----------------------------------------------------------------
(require 'paredit)
(add-hook 'emacs-lisp-mode-hook 'enable-paredit-mode)
(add-hook 'lisp-interaction-mode-hook 'enable-paredit-mode)
(add-hook 'ielm-mode-hook 'enable-paredit-mode)

(when (require 'popwin nil t)
  )

(provide 'mikio-elisp)
