(require 'mikio-util)

(add-to-list 'load-path (mikio/site-lisp-home "color-theme-6.6.0"))
(require 'color-theme)
(color-theme-initialize)
(color-theme-arjen)

;;-----------------------------------------------------------------
;; 正規表現のグルーピングを色分け
;;-----------------------------------------------------------------
(set-face-foreground 'font-lock-regexp-grouping-backslash "green3")
(set-face-foreground 'font-lock-regexp-grouping-construct "green")

(provide 'mikio-color)
