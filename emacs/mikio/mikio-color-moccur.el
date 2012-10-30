(require 'mikio-util)

(require 'color-moccur nil t)

;; グローバルマップにoccur-by-moccurを割り当て
(define-key global-map (kbd "M-o") 'occur-by-moccur)

;; スペース区切りでAND検索
(setq moccur-split-word t)
;; ディレクトリ検索のとき除外するファイル
(add-to-list 'dmoccur-exclusion-mask "\\.DS_Store")
(add-to-list 'dmoccur-exclusion-mask "^#.+#$")

(provide 'mikio-color-moccur)
