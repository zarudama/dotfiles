(require 'mikio-util)
(add-to-list 'load-path (mikio/site-lisp-directory "emacs-java"))


(require 'java-mode-plus)
(require 'java-docs)
;;(java-docs "/usr/share/doc/openjdk-6-jdk/api")
;;(java-docs "c:/Users/miki/Dropbox/java6_ja_apidocs/ja/api")
(java-docs "~/Dropbox/java6_ja_apidocs/ja/api")
;;(java-docs "file:///cygdrive/c/Users/miki/Dropbox/java6_ja_apidocs/ja/api")

;;(define-key java-mode-plus-map (kbd "C-c C-d") 'java-docs-lookup)
(define-key java-mode-plus-map (kbd "C-c C-j d") 'java-docs-lookup)


(provide 'mikio-java-mode-plus)
