(require 'mikio-util)
;; (growl-notify "あいうえお" "こんにちは")
(defvar growl-program "growlnotify.exe")

(when (executable-find growl-program)
  (defvar growl-notify-icon (concat data-directory "images/icons/hicolor/128x128/apps/emacs.png"))
  (defvar growl-notify-application-name "Emacs")
  (defvar growl-notify-password "growl")
  (defun growl-notify (title message)
    (interactive)
    (call-process growl-program nil 0 nil
                  "/r:\"General Notification\""
                  (concat "/a:" (shell-quote-argument growl-notify-application-name))
                  (concat "/ai:" (shell-quote-argument growl-notify-icon))
                  (concat "/t:" (shell-quote-argument
                                 (encode-coding-string title 'shift_jis)))
                  "/host:\"localhost\""
                  (concat "/pass:" (shell-quote-argument growl-notify-password))
                  (encode-coding-string message 'shift_jis))))

(provide 'mikio-growl-win)

