(require 'mikio-util)

;;(define-key global-map (kbd "<f5>") 'recenter-top-bottom)
(when (require 'smartrep nil t)

  ;; move
  (defun split-window-conditinal ()
    (interactive)
    (if (> (* (window-height) 2) (window-width))
        (split-window-vertically)
      (split-window-horizontally)))
  (setq windmove-wrap-around t)
 
  (smartrep-define-key global-map "C-z"
    '(
      ("SPC" . 'scroll-up)
      ("b"   . 'scroll-down)
      ("t"   . 'other-window-or-split)
      ("w"   . 'forward-word)
      ("e"   . 'backward-word)

      ("l"   . 'forward-char)
      ("h"   . 'backward-char)
      ("j"   . 'next-line)
      ("k"   . 'previous-line)

      ("q"   . 'keyboard-quit)

      ("S" . 'split-window-conditinal)
      ("D" . 'delete-window)
      ("M" . 'delete-other-windows)

      ("C-h" . 'windmove-left)
      ("C-j" . 'windmove-down)
      ("C-k" . 'windmove-up)
      ("C-l" . 'windmove-right)

      ("n" . 'tabbar-forward-tab)
      ("p" . 'tabbar-backward-tab)

      ("P" . (lambda () (progn (delete-other-windows) (tabbar-forward-group))))
      ("N" . (lambda () (progn (delete-other-windows) (tabbar-backward-group))))
      ))

  )

(provide 'mikio-smartrep)
