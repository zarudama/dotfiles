(require 'mikio-util)
;-----------------------------------------------------------------
;; 標準ライブラリを上書きするパッケージはここに。
;;-----------------------------------------------------------------

;; cedet1.1(bzr)
;;(load-file (mikio/site-lisp-directory "cedet/cedet-devel-load.el"))

;; JDEE with emacs24 and cedet1.1(github)
;; (load-file (mikio/site-lisp-directory "jdee-new/cedet/cedet-devel-load.el"))
;; (add-to-list 'Info-directory-list (mikio/site-lisp-directory "jdee-new/cedet/doc/info"))

;; JDEE with emacs24 and cedet1.1(tar.gz)
(load-file (mikio/site-lisp-directory "jdee-old/cedet-1.1/common/cedet.el"))

;; emacs24だと、最新のorg-7.8.11が同梱されている。
;; (load-file (mikio/site-lisp-directory "org-7.8.11/lisp/org.el"))
;; (add-to-list 'load-path (mikio/site-lisp-directory "org-7.8.11/lisp"))
;; (add-to-list 'load-path (mikio/site-lisp-directory "org-7.8.11/contrib/lisp"))

(provide 'mikio-overwrite)
