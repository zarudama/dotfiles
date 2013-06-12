(require 'mikio-util)

;;-----------------------------------------------------------------
;; nrepl
;;-----------------------------------------------------------------
(when (require 'nrepl nil t)
  (require 'clojure-mode)

  ;; (when (require 'ac-nrepl nil t)
  ;;   (add-hook 'nrepl-mode-hook 'ac-nrepl-setup)
  ;;   (add-hook 'nrepl-interaction-mode-hook 'ac-nrepl-setup)
  ;;   (eval-after-load "auto-complete"
  ;;     '(add-to-list 'ac-modes 'nrepl-mode)))

  (when (require 'paredit nil t)
    (add-hook 'nrepl-mode-hook (lambda () (paredit-mode))))
  )


(defun my-nrepl-mode-setup ()
  (require 'nrepl-ritz))
(add-hook 'nrepl-interaction-mode-hook 'my-nrepl-mode-setup)

(provide 'mikio-nrepl)
