(require 'mikio-util)
;-----------------------------------------------------------------
;; 標準ライブラリを上書きするパッケージはここに。
;;-----------------------------------------------------------------
(load "mikio-cedet")

;; emacs24だと、最新のorg-7.8.11が同梱されている。
;; (load-file (mikio/site-lisp-directory "org-7.8.11/lisp/org.el"))
;; (add-to-list 'load-path (mikio/site-lisp-directory "org-7.8.11/lisp"))
;; (add-to-list 'load-path (mikio/site-lisp-directory "org-7.8.11/contrib/lisp"))

(provide 'mikio-overwrite)
