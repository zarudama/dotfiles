(require '_util)

(require 'auto-async-byte-compile)
(require 'auto-install)
(require 'package)

;;-----------------------------------------------------------------
;; 自動インストーラー
;;-----------------------------------------------------------------

;; for auto-install
;; cd .emacs.d
;; mkdir auto-install
;; cd auto-install
;; wget http://www.emacswiki.org/emacs/download/auto-install.el
;; emacs --batch -Q -f batch-byte-compile auto-install.el
;; (setq auto-install-directory (format "%s/elisp" my-elisp-dir))
(setq auto-install-directory (mikio/elisp-home  "elisp/")) ;; 末尾に"/"を忘れないこと
(auto-install-update-emacswiki-package-name t)
(auto-install-compatibility-setup)

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
;; (add-to-list 'package-archives
;;              '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)

;;インストールするディレクトリを指定
(setq package-user-dir (mikio/elisp-home  "elisp/"))

;;インストールしたパッケージにロードパスを通してロードする
(package-initialize)

