(require 'mikio-util)

(add-to-list 'load-path (mikio/site-lisp-directory "ajc-java-complete"))
(require 'ajc-java-complete-config)
(add-hook 'java-mode-hook 'ajc-java-complete-mode)

(provide 'mikio-auto-complete-java)
