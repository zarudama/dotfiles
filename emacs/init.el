;;;; コメントだけの行は;;
;;;; 行をコメントアウトするときは;;
;;;; 行末の1行コメントは;
;;;; プログラムの動作原理を示すときは;;;
;;;; ヘッダは;;;;
;;;;
;;;; TIPS
;;;; C-x C-eでその場でS式を実行する。
;;;;
;;;; M-x toggle-debug-on-error
;;;; (setq debug-on-error t)
;;;;
;;;; M-x find-function org-captureで関数定義を再び
;;;; 開き、C-M-a C-M-h M-wで関数をコピーします。
;;;; 問題は無事に解決し、C-x b org-capture.elで
;;;; 元の関数に戻り、M-x compile-defunを実行しました。
;;;; 
;;;; M-x compile-defunは、C-M-xと同様関数再定義ですが、
;;;; その場でバイトコンパイルする点が異なります。

;;; 自前関数の定義
(add-to-list 'load-path (format "%s/mikio/" my-elisp-dir))
(add-to-list 'load-path (format "%s/mikio/private" my-elisp-dir))
(require 'mikio-util)

;;; custom-flleもDropboxにする
(load (format "%s/custom.el" my-elisp-dir))

;;; snippetsの保存ディレクトリ
(setq yas-snippet-dirs
      (list (format "%s/snippets" my-elisp-dir) ;; personal snippets
            (format "%s/el-get/yasnippet/snippets" my-elisp-dir) ;; the default collection
             ))

;;; 標準ライブラリを上書きするパッケージはここに。
(require 'mikio-overwrite)

;;;-----------------------------------------------------------------
;;; 標準の機能だけで実現する最低限の設定
;;;-----------------------------------------------------------------
(require 'mikio-basic) ; 超基本設定
(require 'mikio-font)

;;;-----------------------------------------------------------------
;;; パッケージ管理システム
;;;-----------------------------------------------------------------
(require 'mikio-el-get)
(require 'mikio-package)
(require 'mikio-auto-install)

;;;-----------------------------------------------------------------
;;; 必須の設定たち
;;;-----------------------------------------------------------------
(require 'mikio-ext)
(require 'mikio-dired)
(require 'mikio-undo)
(require 'mikio-windows)
(require 'mikio-tabbar)
;(require 'mikio-anything) ; 24.2以降で、自分で定義した関数がM-xで表示されなくなった。
(require 'mikio-helm)
(require 'mikio-auto-complete)
(require 'mikio-popwin)
(require 'mikio-smartrep)

(require 'mikio-moccur)
(require 'mikio-yasnippet)

(require 'mikio-eshell)

;;;-----------------------------------------------------------------
;;; プログラミング支援
;;;-----------------------------------------------------------------
(require 'mikio-magit)
(require 'mikio-gtags) ;; manual
(require 'mikio-slime) ;; manual
(require 'mikio-nrepl)
(require 'mikio-flymake)
(require 'mikio-jdee) ;; manual

;;;-----------------------------------------------------------------
;;; メジャーモード
;;;-----------------------------------------------------------------
(require 'mikio-java)
(require 'mikio-javascript)
(require 'mikio-php)
(require 'mikio-ruby)
(require 'mikio-clojure)
(require 'mikio-elisp)
(require 'mikio-xml)
;; (require 'mikio-scala)
;; (require 'mikio-lisp)

;;;-----------------------------------------------------------------
;;; 主にデスクトップのemacsで使用する拡張たち
;;;-----------------------------------------------------------------
(cond ((or window-system (eq system-type 'cygwin))
       (require 'mikio-skk)    ; manual-install
       ;;(require 'mikio-info) 
       (require 'mikio-org)
       (require 'mikio-o-blog)
       (require 'mikio-gnus)
       (require 'mikio-twitter)    ; manual-install
       ;;(require 'mikio-jabber)     ; manual-install
       ;;(require "mikio-navi2ch") ; manual-install
       ))

;;;-----------------------------------------------------------------
;;; その他
;;;-----------------------------------------------------------------
(require 'mikio-text-translator)
(require 'mikio-tramp)
(require 'mikio-w3m)   ; manual-install
(require 'mikio-sdic)  ; manual-install

;;;-----------------------------------------------------------------
;;; いつのまにか使わなくなった拡張たち
;;;-----------------------------------------------------------------
;;(require "mikio-newsticker")
;;(require "mikio-elscreen")
;;(require "mikio-mew")
;;(require "mikio-e2wm")
;;(require "mikio-svn")
;;(require "mikio-marabar")
;;(require "mikio-migemo")

;;(require 'mikio-ibuffer)
;;(require 'mikio-shell)
;;(require "mikio-keybind")
;;(require 'mikio-bookmark)
;;(require 'mikio-minimum_win)
;;(require "mikio-final")
;;(require "mikio-auto-compile")
;;(require 'mikio-color) ; color-theme

;;;-----------------------------------------------------------------
;;; vim化
;;;-----------------------------------------------------------------
;; (require 'evil)
;; (evil-mode 1)
;;(require 'mikio-evil)




