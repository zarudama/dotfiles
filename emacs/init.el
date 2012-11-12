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
(add-to-list 'load-path (format "%s/mikio/" mikio/elisp-directory))
(add-to-list 'load-path (format "%s/mikio/private" mikio/elisp-directory))
(require 'mikio-util)

;;; 標準ライブラリを上書きするパッケージはここに。
(require 'mikio-overwrite)

;;; custom-flleもDropboxにする
;;(load (format "%s/custom.el" mikio/elisp-directory))

;;;-----------------------------------------------------------------
;;; 標準の機能だけで実現する最低限の設定
;;;-----------------------------------------------------------------
(require 'mikio-basic) ; 超基本設定
(require 'mikio-font)

;;;-----------------------------------------------------------------
;;; パッケージ管理システム
;;; インストールの方針は以下のとおり。
;;; - 基本的にemacs標準のpackage.elのMELPAリポジトリを使用する。
;;; - MELPAに登録されていないものについては(emacswikiや個人サイト)
;;;   el-getでインストールする。
;;; - 上記以外でel-getは原則として使用しない。なぜなら、gitプロトコルや
;;;   サブモジュールなどでうまく動作しないことがあるから。
;;;   特にlinux以外の環境だとhttp以外のインストールは
;;;   うまういかない場合が多いため。
;;; - 例外的にel-getを使用する例としては、MELPAに登録していないものを
;;;   一時的に利用したい場合など。
;;;-----------------------------------------------------------------
;;(require 'mikio-auto-install)
(require 'mikio-el-get)
(require 'mikio-package)

;;;-----------------------------------------------------------------
;;; 必須の設定たち
;;;-----------------------------------------------------------------
(require 'mikio-ext)
(require 'mikio-dired)
(require 'mikio-undo)
(require 'mikio-windows) ;; install-elisp(original)
(require 'mikio-color-moccur)

;;(require 'mikio-anything) ; 24.2以降で、自分で定義した関数がM-xで表示されなくなった。
;;(require 'mikio-moccur) ;; color-moccur(melpa), moccur-edit(emacswiki)

(require 'mikio-helm)
(require 'mikio-helm-project)
;;(require 'mikio-helm-git)
(require 'mikio-helm-moccur)
(require 'mikio-helm-gtags)
(require 'mikio-helm-ack)

(require 'mikio-auto-complete)
;;(require 'mikio-popwin)
(require 'mikio-smartrep)
(require 'mikio-tabbar) ;; install-elisp(emacswiki)

(require 'mikio-yasnippet)

(require 'mikio-eshell)
;; (require 'mikio-term+)

;; ;;;-----------------------------------------------------------------
;; ;;; プログラミング支援
;; ;;;-----------------------------------------------------------------
(require 'mikio-magit)
;; ;;(require 'mikio-gtags) ;; manual
(require 'mikio-helm-gtags)

;; ;;(require 'mikio-slime) ;; manual
(require 'mikio-nrepl)
;; (require 'mikio-flymake)
(require 'mikio-jdee) ;; manual

;; ;;;-----------------------------------------------------------------
;; ;;; メジャーモード
;; ;;;-----------------------------------------------------------------
(require 'mikio-java)
;;(require 'mikio-java-mode-plus)
;;(require 'mikio-auto-complete-java)
(require 'mikio-javascript)
(require 'mikio-php)
(require 'mikio-ruby)
(require 'mikio-clojure)
(require 'mikio-elisp)
(require 'mikio-xml)
(require 'mikio-web-mode)
;; (require 'mikio-scala)
;; (require 'mikio-lisp)

;; ;;;-----------------------------------------------------------------
;; ;;; 主にデスクトップのemacsで使用する拡張たち
;; ;;;-----------------------------------------------------------------
(when mikio/skk-use  (require 'mikio-skk)) ; manual-install
;; (when mikio/info-use (require 'mikio-info)) 
(when mikio/org-use (require 'mikio-org))
(when mikio/o-blog-use (require 'mikio-o-blog))
(when mikio/gnus-use (require 'mikio-gnus))
(when mikio/twitter-use (require 'mikio-twitter)); manual-install
;; (when mikio/jabber-use (require 'mikio-jabber)) ; manual-install
;; (when mikio/navi2ch-use (require mikio-navi2ch)) ; manual-install
(when mikio/newsticker-use (require 'mikio-newsticker))
(when mikio/howm-use (require 'mikio-howm)) ; manual-install

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
;;(require "mikio-mew")
;;(require "mikio-e2wm")
;;(require "mikio-svn")
;;(require "mikio-marabar")
;;(require "mikio-migemo")
;;(require 'mikio-elscreen)

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
;;(require 'mikio-evil)







