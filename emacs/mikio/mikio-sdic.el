(require 'mikio-util)


;;-----------------------------------------------------------------
;; sdic
;;-----------------------------------------------------------------
;;; sdic-mode 用の設定
(add-to-list 'load-path (mikio/site-lisp-directory "sdic"))
(when (require 'sdic nil t)
  (global-set-key (kbd "C-c w") 'sdic-describe-word)
  (global-set-key (kbd "C-c W") 'sdic-describe-word-at-point)
 ; (strategy direct)
  )

;; ;;(autoload 'sdic-describe-word "sdic" "英単語の意味を調べる" t nil)
;; (global-set-key "\C-cw" 'sdic-describe-word)
;; ;;(autoload 'sdic-describe-word-at-point "sdic" "カーソルの位置の英単語の意味を調べる" t nil)
;; (global-set-key "\C-cW" 'sdic-describe-word-at-point)

(provide 'mikio-sdic)
