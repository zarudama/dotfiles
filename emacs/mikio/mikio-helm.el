(require 'mikio-util)

(require 'helm-config)

;;-----------------------------------------------------------------
;; 起動コマンド
;;-----------------------------------------------------------------
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "C-x b") 'helm-buffers-list)
(global-set-key (kbd "C-x a r") 'helm-recentf)
;; (global-set-key (kbd "C-x a h b") 'helm-hatena-bookmark)
;; (global-set-key (kbd "C-x a b") 'helm-bookmarks)
;; (global-set-key (kbd "C-x a i") 'helm-imenu)
;; (global-set-key (kbd "C-x a g") 'helm-google-suggest)
;; (global-set-key (kbd "C-x a p") 'helm-project)
;; (global-set-key (kbd "C-x a d") 'helm-for-document)

(provide 'mikio-helm)
