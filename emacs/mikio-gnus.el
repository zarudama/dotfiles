(require 'mikio-util)
(require 'mikio-growl-win)
(require 'gnus)

;;(setq my-gnus-type (getenv "GNUS_TYPE"))

(when mikio/office-type
  (cond
   ((equal :office mikio/office-type)
    (require 'mikio-gnus-office))
   ((equal :home mikio/office-type)
    (require 'mikio-gnus-gmail))
   (t
    ))

  ;; アドレス補完
  ;; - http://www.bookshelf.jp/soft/meadow_56.html#SEC859
  ;; (install-elisp "http://www.bookshelf.jp/elc/invoke-mail.el")
  ;;(require 'invoke-mail)
  
;;  (add-hook 'gnus-group-mode-hook 'mikio/biff-get-mail-count)


  ;;(mac-biff-update) 

  ;;-----------------------------------------------
  ;; 定期的なメールチェック
  ;;-----------------------------------------------

  ;; growlによる通知
  (defvar mikio/biff-lighter ""
    "Lighter used by `mikio/biff-mode'.")

  (defvar mikio/biff-mail-regex "\\([[:digit:]]+\\).*InBox"
    "Regular expression to match number counts in a Gnus buffer.")

  (defvar mikio/biff-timer-id nil)

  (defun mikio/biff-growl (count)
    (let ((msg (format "未読メールが%s通ありまっせ!" count)))
      (message msg)
      (growl-notify "あいうえお" "こんにちは")
      (growl-notify "Gnus メール通知" msg)))

  (defun mikio/biff-get-mail-count ()
    "Read the mail count from Gnus."
    (let ((buffer (get-buffer "*Group*"))
          (count 0))
      (when buffer
        (with-current-buffer buffer
          (goto-char (point-min))
          (while (re-search-forward mikio/biff-mail-regex nil t)
            (setq count (+ count (string-to-number (match-string 1)))))))
      count))

  (defun mikio/biff-check-mail ()
    (interactive)
    (gnus-group-get-new-news)
    (let ((count (mikio/biff-get-mail-count)))
      (if (> count 0)
          (mikio/biff-growl count)
        )))

  (define-minor-mode mikio/biff-mode
    "Minor mode to display state of new email."
    :init-value nil
    :lighter " biff"
    :global t
    (if mikio/biff-mode
        (progn
          (setq mikio/biff-timer-id (run-at-time 10 600 'mikio/biff-check-mail)))
      (cancel-timer mikio/biff-timer-id)
      ))
  )

(provide 'mikio-gnus)

