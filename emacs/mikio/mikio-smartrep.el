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
  ;;(define-prefix-command 'window-move-map)
  ;;(global-set-key (kbd "C-q") 'window-move-map)

  (defvar ctl-l-map (make-keymap))
  (define-key global-map (kbd "C-l") ctl-l-map)
  (smartrep-define-key global-map "C-l"
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

      ;; ("i"   . 'keyboard-quit)

      ("S" . 'split-window-conditinal)
      ("D" . 'delete-window)
      ("M" . 'delete-other-windows)

      ("C-h" . 'windmove-left)
      ("C-j" . 'windmove-down)
      ("C-k" . 'windmove-up)
      ("C-l" . 'windmove-right)
      ))

  (defvar ctl-z-map (make-keymap))
  (define-key global-map (kbd "C-z") ctl-z-map)
  (smartrep-define-key global-map (kbd "C-z")
    '(
      ("l" . 'tabbar-forward-tab)
      ("h" . 'tabbar-backward-tab)

      ("L" . (lambda () (progn (delete-other-windows) (tabbar-forward-group))))
      ("H" . (lambda () (progn (delete-other-windows) (tabbar-backward-group))))
      ("C-z" . 'suspend-emacs)
      ))

  )

(provide 'mikio-smartrep)
