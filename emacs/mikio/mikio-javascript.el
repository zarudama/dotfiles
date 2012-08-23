(require 'mikio-util)
;;-----------------------------------------------------------------
;; java-script
;;-----------------------------------------------------------------
(autoload 'js2-mode "js2" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
(setq js-indent-level 2)
;;(add-hook 'js2-mode-hook
;;          '(lambda ()
;;
;;             (setq-default js2-basic-offset 2)
;;             ;;(setq-default c-basic-offset 4)
;;             ))

;; ;;-----------------------------------------------------------------
;; ;; js-comint
;; ;; rhino用のSLIMEみたいな拡張
;; ;;-----------------------------------------------------------------
;; ;;これはDebian系で対象実装がRhinoの場合。他のケースは上のパスを書き換えて。
;; (when (require 'js-comint nil t)
;;   ;;(setq inferior-js-program-command "/usr/bin/rhino")
;;     (add-hook 'js2-mode-hook '(lambda () ;;この辺はキーバインド設定なのでお好みで。デフォルト設定だと余り一般的じゃないかも。
;;                              (local-set-key "\C-x\C-e" 'js-send-last-sexp)
;;                              (local-set-key "\C-\M-x" 'js-send-last-sexp-and-go)
;;                              (local-set-key "\C-cb" 'js-send-buffer)
;;                              (local-set-key "\C-c\C-b" 'js-send-buffer-and-go)
;;                              (local-set-key "\C-cl" 'js-load-file-and-go)
;;                              )))

(provide 'mikio-javascript)
