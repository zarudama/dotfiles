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
(when (require 'elscreen nil t)
  (if window-system
      (define-key elscreen-map (kbd "C-z") 'iconify-or-deiconify-frame)
    (define-key elscreen-map (kbd "C-z") 'suspend-emacs))
  (require 'elscreen-dired nil t))

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

(define-key elscreen-map (kbd "C-o") '(lambda () (interactive) (anything 'anything-c-source-elscreen)))
;;(define-key global-map (kbd "C-x b") '(lambda () (interactive) (anything 'anything-c-source-elscreen)))


(provide 'mikio-elscreen)
