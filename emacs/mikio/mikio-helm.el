(require 'mikio-util)

(require 'helm-config)

;; 過去のkillリングの内容を表示する。
(define-key global-map (kbd "M-y") 'helm-show-kill-ring)

;;(define-key helm-find-files-map (kbd "C-h") 'delete-backward-char)

;;(helm-dired-bindings 1)

;;-----------------------------------------------------------------
;; eshell
;; https://github.com/emacs-helm/helm/wiki
;;-----------------------------------------------------------------

;; eshellコマンドの履歴
(add-hook 'eshell-mode-hook
          #'(lambda ()
              (define-key eshell-mode-map 
                (kbd "C-o")
                'helm-eshell-history)))

(add-hook 'eshell-mode-hook
          #'(lambda ()
              (define-key eshell-mode-map 
                [remap pcomplete]
                'helm-esh-pcomplete)))

;;-----------------------------------------------------------------
;; 起動コマンド
;;-----------------------------------------------------------------
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "C-x b") 'helm-buffers-list)
(global-set-key (kbd "C-x a r") 'helm-recentf)
;; (global-set-key (kbd "C-x a h b") 'helm-hatena-bookmark)
(global-set-key (kbd "C-x a b") 'helm-bookmarks)
(global-set-key (kbd "C-x a i") 'helm-imenu)
(global-set-key (kbd "C-x a g") 'helm-do-grep)
;;(global-set-key (kbd "C-x a g") 'helm-ack)
(global-set-key (kbd "C-x a d") 'helm-for-document)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
;;(helm-mode t) ; なんでもhelm
(provide 'mikio-helm)
