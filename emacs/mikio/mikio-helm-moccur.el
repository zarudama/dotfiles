(require 'mikio-util)

(require 'helm-c-moccur)
(setq moccur-split-word t)
(global-set-key (kbd "C-c s") 'helm-c-moccur-occur-by-moccur)
;; インクリメンタルサーチから以降できるように。
;;(define-key isearch-mode-map (kbd "C-o") 'anything-c-moccur-from-isearch)
(define-key isearch-mode-map (kbd "C-o") 'helm-c-moccur-from-isearch)

(provide 'mikio-helm-moccur)
