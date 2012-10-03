;;; 自前関数の定義
(add-to-list 'load-path (format "%s/mikio/" mikio/elisp-directory))
(require 'mikio-util)

;;; custom-flleもDropboxにする
;;; custom-flleもDropboxにする
(load (format "%s/custom.el" mikio/elisp-directory))

;;; snippetsの保存ディレクトリ
(setq yas-snippet-dirs
      (list (format "%s/snippets" mikio/elisp-directory) ;; personal snippets
            (format "%s/el-get/yasnippet/snippets" mikio/elisp-directory) ;; the default collection
             ))

;;; 標準ライブラリを上書きするパッケージはここに。
(require 'mikio-overwrite)

;;;-----------------------------------------------------------------
;;; 標準の機能だけで実現する最低限の設定
;;;-----------------------------------------------------------------
(require 'mikio-basic) ; 超基本設定
(require 'mikio-font)

;;;-----------------------------------------------------------------
;;; 標準の機能だけで実現する最低限の設定
;;;-----------------------------------------------------------------
;;-----------------------------------------------------------------
(add-to-list 'load-path (mikio/site-lisp-home "evil-evil"))
(require 'evil)
(evil-mode 1)


