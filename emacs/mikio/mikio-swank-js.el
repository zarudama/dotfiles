(require 'mikio-util)
(require 'slime)
;; ;; for javascript
(add-to-list 'load-path (format "%s/swank-js/" mikio/site-lisp-directory))
(global-set-key [f5] 'slime-js-reload)
(add-hook 'js2-mode-hook
          (lambda ()
            (slime-js-minor-mode 1)))


(provide 'mikio-swank-js)
