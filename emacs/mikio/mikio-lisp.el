(require 'mikio-util)

;-----------------------------------------------------------------
;; modify lisp indent
;; (install-elisp "http://boinkor.net/lisp/cl-indent-patches.el")
;;-----------------------------------------------------------------
(when (require 'cl-indent-patches nil t)
  ;; emacs-lispのインデントと混同しないように
  (setq lisp-indent-function
        (lambda (&rest args)
          (apply (if (memq major-mode '(emacs-lisp-mode lisp-interaction-mode))
                     'lisp-indent-function
                     'common-lisp-indent-function)
                 args))))


;-----------------------------------------------------------------
;; カッコの対応を取りながらS式を編集する。
;; (install-elisp "http://mumble.net/~campbell/emacs/paredit.el")
;;-----------------------------------------------------------------
(require 'paredit)
(add-hook 'lisp-mode-hook 'enable-paredit-mode)

(provide 'mikio-lisp)
