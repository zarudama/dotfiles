(require 'mikio-util)

;;;-----------------------------------------------------------------
;; nxml-mode
;;-----------------------------------------------------------------
(add-hook 'nxml-mode-hook
          (lambda ()
            (setq nxml-slash-auto-complete-flag t)
            (setq nxml-child-indent 2)
            (setq indent-tabs-mode t)
            (setq tab-width 2)))
;;(add-hook 'nxml-mode-hook
;;          (lambda ()
;;            (setq nxml-slash-auto-complete-flag t)
;;            (setq nxml-child-indent 2)
;;            (setq indent-tabs-mode t)
;;            (setq tab-width 2)
;;            (define-key nxml-mode-map "\r" 'newline-and-indent)
;;            (hs-minor-mode 1)
;;            ))

;;(add-to-list 'hs-special-modes-alist
;;             '(nxml-mode
;;               "<!--\\|<[^/>]>\\|<[^/][^>]*[^/]>"
;;               ""
;;               "<!--"
;;               nxml-skip-tag-forward
;;               nil))
;;
;; key bind
;;(define-key nxml-mode-map (kbd "C-c C-o") 'hs-toggle-hiding)
;;(define-key nxml-mode-map (kbd "C-c C-l") 'hs-hide-level)
;;(define-key nxml-mode-map (kbd "C-c C-s") 'hs-show-all)

(add-hook 'sgml-mode-hook
          '(lambda()
             (hs-minor-mode 1)))
(add-to-list 'hs-special-modes-alist
             '(sgml-mode
               "<!--\\|<[^/>]>\\|<[^/][^>]*[^/]>"
               ""
               "<!--"
               sgml-skip-tag-forward
               nil))

;; key bind
;;(define-key sgml-mode-map (kbd "C-c C-o") 'hs-toggle-hiding)
;;(define-key sgml-mode-map (kbd "C-c C-l") 'hs-hide-level)
;;(define-key sgml-mode-map (kbd "C-c C-s") 'hs-show-all)

(provide 'mikio-xml)
