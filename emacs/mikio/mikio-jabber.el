(require 'mikio-util)
(require 'info)
(add-to-list 'load-path (mikio/site-lisp-directory "emacs-jabber-0.8.91"))
(add-to-list 'Info-directory-list (mikio/site-lisp-directory "emacs-jabber-0.8.91"))

;; 下記に依存
;; (install-elisp "http://www.emacswiki.org/emacs-en/download/hexrgb.el") 
(require 'jabber)
;;(define-key ctl-x-map "\C-j" jabber-global-keymap)
(define-key ctl-x-map "\C-j" nil)
;;(define-key ctl-x-map "j" jabber-global-keymap)


(when mikio/office-type
  (cond
   ((equal :office mikio/office-type)
    (require 'mikio-jabber-office))
   ((equal :home mikio/office-type)
    (require 'mikio-jabber-home))
   (t
    ))

;; example
;; (setq jabber-account-list
;;       '(("mikio@hoge.com"
;;          (:network-server . "123.123.123.123")
;;          (:connection-type . ssl))))

  
(provide 'mikio-jabber)

