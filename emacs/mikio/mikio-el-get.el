(require 'mikio-util)

;;; el-getそのもののインストールディレクトリ 
(setq el-get-dir (format "%s/el-get" mikio/elisp-directory))

;; インストール後のロードパスの用意(el-get自身用)
(add-to-list 'load-path (mikio/elisp-home "el-get/el-get"))

;;; もし el-get がなければインストールを行う
(unless (require 'el-get nil t)
  (url-retrieve
   "https://github.com/dimitri/el-get/raw/master/el-get-install.el"
   (lambda (s)
     (let (el-get-master-branch)
       (end-of-buffer)
       (eval-print-last-sexp)))))

(when (require 'el-get nil t)
  (setq el-get-sources
        '(
          (:name anything-project
                 :type github
                 :pkgname "imakado/anything-project")
                       
          (:name color-moccur
                 :type emacswiki)
          (:name moccur-edit
                 :type emacswiki)
          (:name anything-c-moccur
                 :type http
                 :url "http://svn.coderepos.org/share/lang/elisp/anything-c-moccur/trunk/anything-c-moccur.el")
                       
          (:name anything-project
                 :type github
                 :pkgname "imakado/anything-project")

          (:name eldoc-extension
                 :type emacswiki)

          ;; diredバッファの抑制
          ;; (:name joseph-single-dired
          ;;        :type emacswiki)

          ;; ;; win Exploer風の移動
          ;; (:name dired-view
          ;;        :type emacswiki)

          ;; for mikio-eshell
          (:name shell-history
                 :type emacswiki)
          (:name esh-myparser
                 :type emacswiki)
          (:name esh-cmdline-stack
                 :type http
                 :url "http://www.rubyist.net/~rubikitch/private/esh-cmdline-stack.el")
        
          
          ;; 標準のレシピだとinfoのインストールでエラーになるので再定義した。
          ;; (:name slime
          ;;        :description "Superior Lisp Interaction Mode for Emacs"
          ;;        :type github
          ;;        :features slime-autoloads
          ;;        ;;:info "doc"
          ;;        :pkgname "nablaone/slime"
          ;;        :load-path ("." "contrib")
          ;;        :compile (".")
          ;;        ;;:build ("make -C doc slime.info")
          ;;        :post-init (slime-setup)
          ;;        )

           (:name nrepl
                 :type github
                 :pkgname "kingtim/nrepl.el"
                 )

           (:name ac-nrepl
                  :type github
                  :pkgname "ponkore/ac-nrepl"
                  ;;:pkgname "purcell/ac-nrepl"
                  )

           (:name tag-group
                  :type github
                  :pkgname "tarao/tab-group-el")
           (:name key-intercept
                  :type github
                  :pkgname "tarao/key-intercept-el")
           (:name multi-mode-util
                  :type github
                  :pkgname "tarao/multi-mode-util")
           (:name multi-mode
                  :type github
                  :pkgname "emacsmirror/multi-mode")
           (:name term-plus-el
                 :type github
                 :pkgname "tarao/term-plus-el"
                 :submodule nil
                 )

          ;; うまく動かないのでとりあえず保留
          ;; (:name anything-c-yasnippet-2
          ;;        :type http
          ;;        :url "http://www.rubyist.net/~rubikitch/archive/anything-c-yasnippet-2.el")

          (:name yasnippet-config
                 :type emacswiki)

          (:name sha1-el
                 :type http
                 :url "http://stuff.mit.edu/afs/sipb/contrib/emacs/packages/flim-1.14.7/sha1-el.el")
          (:name anything-hatena-bookmark
                 :type http
                 :url "https://raw.github.com/k1LoW/anything-hatena-bookmark/master/anything-hatena-bookmark.el")

          (:name text-translator
                 :type emacswiki)
          (:name text-translator-vars
                 :type emacswiki)
          (:name text-translator-load
                 :type emacswiki)

          (:name sudo-ext
                 :type emacswiki)

          ;; 標準のレシピでは取得できなかったので(オリジナルのgitリポジトリ)
          ;; github上のリポジトリから取得する。
          ;; (:name evil
          ;;        :type git
          ;;        :url "https://git.gitorious.org/evil/evil.git"
          ;;        )
          ;; (:name evil-leader
          ;;        :type git
          ;;        :url "https://github.com/cofi/evil-leader.git"
          ;;        )

          (:name jaunte
                 :type github
                 :pkgname "kawaguchi/jaunte.el"
                 )

          ;; for skk auto-complete
          ;; (:name ac-ja
          ;;        :type github
          ;;        :pkgname "myuhe/ac-ja.el")

          (:name web-mode
                 :type github
                 :pkgname "fxbois/web-mode")

          ))

  ;; append:第一引数のリストに残りの引数の各リストの各要素を追加していく。
  (setq mikio-packages 
        (append 
         '(
           auto-install                 ; emacswiki
           ;;package                      ; http

           auto-complete                ; github
           anything                     ; git(http)
           ;;helm                         ; git(http)
           undo-tree                    ; git(http)
           smartrep                     ; github
           popwin                       ; github
           yasnippet                    ; github
           
           revive                       ; http(windows.elが依存)
           windows                      ; http
       
           paredit                      ; http
           lispxmp                      ; emacswiki
           tabbar                       ; emacswiki

           clojure-mode                 ; github
           js2-mode                     ; github
           ruby-mode                    ; elpa
           web-mode                     ; github
           ac-slime                     ; github
           magit                        ; github

           jaunte                       ; github
           rainbow-delimiters           ; github

           ;;emacs-jabber                 ; git(git://)
           twittering-mode              ; github
           o-blog                       ; github
           ;;howm                         ; tar+configure+make

           )

         (mapcar 'el-get-source-name el-get-sources)))

  ;; el-get:
  ;; 引数にはパッケージ名のはいったリストを渡す
  ;; また、各パッケージのload-pathをとおす。
  (el-get 'sync mikio-packages)
  )

(provide 'mikio-el-get)
