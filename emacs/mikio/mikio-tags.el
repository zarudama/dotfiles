(require 'mikio-util)

;;-----------------------------------------------------------------
;; gtags
;; タグファイルの作り方
;;   $ cd $SRC_ROOT
;;   $ gtags -v
;; M-. 関数定義へジャンプ
;; M-* 戻る
;;-----------------------------------------------------------------
(when (executable-find "gtags")
  (when (require 'gtags nil t)
    (setq gtags-path-style 'relative) ; パス表示を相対パスにする。
    (setq view-read-only t)           ; 読み込み専用で開く。
    (setq gtags-read-only t)          ; 上とセットの定義。
    (setq gtags-pop-delete t)         ; M-*で元の位置に戻ったとき、戻る前のバッファを削除する。
    (setq gtags-mode-hook
          '(lambda ()
             (local-set-key (kbd "M-.") 'gtags-find-tag-from-here)    ; 空気を読む便利コマンドらしい。
             ;;(local-set-key (kbd "M-t") 'gtags-find-tag)    ; 関数の定義元へ移動
             ;;(local-set-key (kbd "M-r") 'gtags-find-rtag)   ; 関数を参照元の一覧を表示．RET で参照元へジャンプできる
             ;;(local-set-key (kbd "M-s") 'gtags-find-symbol) ; 変数の定義元と参照元の一覧を表示．RET で該当箇所へジャンプできる．
             ;;(local-set-key (kbd "C-t") 'gtags-pop-stack)   ; 変数の定義元と参照元の一覧を表示．RET で該当箇所へジャンプできる．
             ))

    (add-hook 'c-mode-common-hook 'gtags-mode)
    (add-hook 'c++-mode-hook 'gtags-mode)
    (add-hook 'java-common-hook 'gtags-mode)
    ;;(add-hook 'php-mode-hook 'gtags-mode) ;; ctagsのほうが使いやすいかも。なのでコメントアウト

    (when (require 'anything-gtags nil t)
      )
    ))

(provide 'mikio-tags)
