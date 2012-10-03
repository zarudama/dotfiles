(require 'mikio-util)

;;-----------------------------------------------------------------
;; バッファ内を検索する
;;-----------------------------------------------------------------

;;; color-moccur: 検索結果をリストアップ
;; (install-elisp "http://www.emacswiki.org/emacs/download/color-moccur.el")
;; (install-elisp "http://www.emacswiki.org/emacs/download/moccur-edit.el")
(when (require 'color-moccur nil t)
  ;; グローバルマップにoccur-by-moccurを割り当て
  (define-key global-map (kbd "M-o") 'occur-by-moccur)
  ;; スペース区切りでAND検索
  (setq moccur-split-word t)
  ;; ディレクトリ検索のとき除外するファイル
  (add-to-list 'dmoccur-exclusion-mask "\\.DS_Store")
  (add-to-list 'dmoccur-exclusion-mask "^#.+#$")
  (require 'moccur-edit nil t)
  ;; (when (and (executable-find "cmigemo")
  ;;            (require 'migemo nil t))
  ;;   (setq moccur-use-migemo t))
  )

(when (require 'anything-c-moccur nil t)
  (setq moccur-split-word t)
  (global-set-key (kbd "C-c s") 'anything-c-moccur-occur-by-moccur)
  ;; インクリメンタルサーチから以降できるように。
  (define-key isearch-mode-map (kbd "C-o") 'anything-c-moccur-from-isearch))

(provide 'mikio-moccur)
