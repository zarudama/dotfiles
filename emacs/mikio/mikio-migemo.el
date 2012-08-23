(require '_util)
;;-----------------------------------------------------------------
;; migemo: ローマ字インクリメンタルサーチ
;; (auto-install-from-gist "457761")
;; cmigemo(本家はrubyだがこれはcによる実装版)
;; cmigemo -d ~/src/cmigemo-1.3c/dict/
;;-----------------------------------------------------------------
(when (executable-find "cmigemo")
  (message "initialize migemo...")
  (setq migemo-command (executable-find "cmigemo"))
  ;; migemoのコマンドラインオプション
  (setq migemo-options '("-q" "--emacs" "-i" "\g"))
  ;; migemo辞書の場所
  (setq migemo-dictionary (expand-file-name "~/Dropbox/dict/migemo/utf-8/migemo-dict"))
  ;; cmigemoで必須の設定
  (setq migemo-user-dictionary nil)
  (setq migemo-regex-dictionary nil)
  ;; キャッシュの設定
  (setq migemo-use-pattern-alist t)
  (setq migemo-use-frequent-pattern-alist t)
  (setq migemo-pattern-alist-length 1000)
  (setq migemo-coding-system 'utf-8-unix)

  ;; migemoを起動する
  (load-library "migemo")
  (migemo-init))

;
