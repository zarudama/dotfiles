(require 'mikio-util)
(require 'ibuffer)
;;-----------------------------------------------------------------
;; ibufferを標準のバッファリストとして使う
;; http://www.emacswiki.org/emacs/IbufferMode
;;-----------------------------------------------------------------
(global-set-key (kbd "C-x C-b") 'ibuffer)
;;(define-key ibuffer-mode-map (kbd "C-t") 'switch-to-last-buffer-or-other-window)
(autoload 'ibuffer "ibuffer" "List buffers." t)
(setq ibuffer-saved-filter-groups
      (quote (("default"
               ("dired" (mode . dired-mode))
               ("emacs" (or
                         (name . "^\\*scratch\\*$")
                         (name . "^\\*Messages\\*$")))
               ("anything" (or
                            (name . "^\\*anything.*$")))
               ("gnus" (or
                        (mode . message-mode)
                        (mode . bbdb-mode)
                        (mode . mail-mode)
                        (mode . gnus-group-mode)
                        (mode . gnus-summary-mode)
                        (mode . gnus-article-mode)
                        (name . "^\\.bbdb$")
                        (name . "^\\.newsrc-dribble")))))))
(add-hook 'ibuffer-mode-hook
          (lambda ()
            (ibuffer-switch-to-saved-filter-groups "default")))


(define-key ibuffer-mode-map (kbd "j") 'ibuffer-forward-line)
(define-key ibuffer-mode-map (kbd "k") 'ibuffer-backward-line)
(define-key ibuffer-mode-map (kbd "C-t") 'switch-to-last-buffer-or-other-window)

(provide 'mikio-ibuffer)
