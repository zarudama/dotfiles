(require 'mikio-util)

;;;-----------------------------------------------------------------
;; escreen.el
;; (install-elisp "http://www.splode.com/~friedman/software/emacs-lisp/src/escreen.el")
;;-----------------------------------------------------------------
;;(load "escreen")
;;(escreen-install)

;-----------------------------------------------------------------
;;; Elscreen: GNU Screenライクなウィンドウ管理を実現
;;-----------------------------------------------------------------
;; (when (require 'elscreen nil t)
;;   (if window-system
;;       (define-key elscreen-map (kbd "C-z") 'iconify-or-deiconify-frame)
;;     (define-key elscreen-map (kbd "C-z") 'suspend-emacs))
;;   (require 'elscreen-dired nil t))

(when (require 'elscreen nil t)
  (elscreen-start))

;;--------------------------------------
;; 自動でスクリーンを作る
;;--------------------------------------
(defmacro elscreen-create-automatically (ad-do-it)
  `(if (not (elscreen-one-screen-p))
       ,ad-do-it
     (elscreen-create)
     (elscreen-notify-screen-modification 'force-immediately)
     (elscreen-message "New screen is automatically created")))

(defadvice elscreen-next (around elscreen-create-automatically activate)
  (elscreen-create-automatically ad-do-it))

(defadvice elscreen-previous (around elscreen-create-automatically activate)
  (elscreen-create-automatically ad-do-it))

(defadvice elscreen-toggle (around elscreen-create-automatically activate)
  (elscreen-create-automatically ad-do-it))
;;--------------------------------------

;;(define-key elscreen-map (kbd "C-o") '(lambda () (interactive) (anything 'anything-c-source-elscreen)))
;;(define-key global-map (kbd "C-x b") '(lambda () (interactive) (anything 'anything-c-source-elscreen)))

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

      ("n" . 'elscreen-next)
      ("p" . 'elscreen-previous)
      ("K" . (lambda () (interactive) (kill-buffer (buffer-name (current-buffer)))))

      ))

  )


(provide 'mikio-elscreen)
