(require 'mikio-util)

(add-to-list 'load-path (mikio/site-lisp-directory "g-client"))

(load-library "g")
(setq g-user-email "ocha.awk@gmail.com")
;; (setq gcal-user-email "カレンダーのアカウント")
;; (setq gblogger-user-email "bloggerのアカウント")
(setq browse-url-browser-function 'w3m-browse-url)

;; (when (locate-library "g")
;;   (eval-after-load 'g
;;     '(progn
;;        (autoload 'gblogger-sign-in "g" "Resets client so you can start with a different userid." t)
;;        (autoload 'gblogger-blog "g" "Retrieve and display feed of feeds after authenticating." t)
;;        (setq g-user-email "ocha.awk@gmail.com")
;;        (setq browse-url-browser-function 'w3m-browse-url))))

(provide 'mikio-greader)
