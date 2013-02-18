(require 'mikio-util)
(add-to-list 'load-path (mikio/site-lisp-directory "term-plus-all"))

(add-to-list 'load-path (mikio/site-lisp-directory "term-plus-manual"))
(add-to-list 'load-path (mikio/site-lisp-directory "term-plus-manual/key-intercept-el"))
(add-to-list 'load-path (mikio/site-lisp-directory "term-plus-manual/multi-mode-util"))
(add-to-list 'load-path (mikio/site-lisp-directory "term-plus-manual/tab-group-el"))

(require 'term+)
(require 'xterm-256color)

(require 'term+key-intercept)
(require 'term+mode)
(require 'term+mux)
;;(require 'term+anything-shell-history)

;; (setq term+mux-char-prefix "C-q")
;; (setq term+mux-line-prefix "C-q")

(provide 'mikio-term+)
