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
  (global-set-key (kbd "M-s") 'anything-c-moccur-occur-by-moccur)
  ;; インクリメンタルサーチから以降できるように。
  (define-key isearch-mode-map (kbd "C-o") 'anything-c-moccur-from-isearch)
  ;; 旧来のisearch-occurはC-M-oへ引越足
  (define-key isearch-mode-map (kbd "C-M-o") 'isearch-occur)

;;;; WebDBの設定
  ;; (setq
  ;;  ;; anything-c-moccur用 `anything-idle-delay'
  ;;  anything-c-moccur-anything-idle-delay 0.1
  ;;  ;; バッファの情報をハイライトする
  ;;  anything-c-moccur-higligt-info-line-flag t
  ;;  ;; 現在選択中の候補の位置を他のwindowに表示する
  ;;  anything-c-moccur-enable-auto-look-flag t
  ;;  ;; 起動時にポイントの位置の単語を初期パターンにする
  ;;  anything-c-moccur-enable-initial-pattern t)

  ;; (global-set-key (kbd "C-M-o")
  ;;                 'anything-c-moccur-occur-by-moccur))
  )

(provide 'mikio-moccur)
