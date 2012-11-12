(require 'mikio-util)
(add-to-list 'load-path (mikio/site-lisp-directory "emacs-java"))


(require 'java-mode-plus)
(require 'java-docs)
;;(java-docs "/usr/share/doc/openjdk-6-jdk/api")
(java-docs "file://c:/Users/m-oono/opt/java6-apidocs")

(provide 'mikio-java-mode-plus)
