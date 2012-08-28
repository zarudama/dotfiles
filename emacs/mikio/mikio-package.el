(require 'mikio-util)

(when (require 'package nil t)
  ;;-----------------------------------------------------------------
  ;; package.el(emacs24からは標準)
  ;;   参考
  ;;     Marmaladeはelpaを拡張する？新しいパッケージ管理システム
  ;;     http://sheephead.homelinux.org/2011/06/17/6724/
  ;; (install-elisp "http://repo.or.cz/w/emacs.git/blob_plain/1a0a666f941c99882093d7bd08ced15033bc3f0c:/lisp/emacs-lisp/package.el")
  ;; M-x list-packages でパッケージ画面を表示できる。
  ;; Iで選択。Xで実行
  ;; autoloadが定義されてないパッケージだと最後にこける。
  ;; この場合、手動で設定ファイルを.emacs似追加する必要がある。
  ;;-----------------------------------------------------------------

  ;;リポジトリにMarmaladeを追加
  (add-to-list 'package-archives
               '("marmalade" . "http://marmalade-repo.org/packages/"))
  (add-to-list 'package-archives
               '("melpa" . "http://melpa.milkbox.net/packages/") t)

  ;;インストールするディレクトリを指定
  (setq package-user-dir (mikio/elisp-home  "package/"))

  ;;インストールしたパッケージにロードパスを通してロードする
  (package-initialize)
  )

(provide 'mikio-package)
