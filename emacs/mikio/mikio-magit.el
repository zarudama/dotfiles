;;-----------------------------------------------------------------
;; magit
;;-----------------------------------------------------------------
(mikio/add-to-load-path "site-lisp/magit")
(require 'magit)
(global-set-key (kbd "C-x v d") 'magit-status) ;; vc-dirコマンドを置き換える

