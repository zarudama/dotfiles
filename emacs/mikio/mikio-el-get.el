(require 'mikio-util)


;;; el-get経由でインストールしたパッケージのディレクトリ
(setq el-get-dir (mikio/elisp-home "el-get"))

(mikio/make-directory el-get-dir)

;; インストール後のロードパスの用意(el-get自身用)
(add-to-list 'load-path (concat el-get-dir "/el-get"))

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
          (:name moccur-edit
                 :type emacswiki)
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
        
           ;; (:name ac-nrepl
           ;;        :type github
           ;;        :pkgname "ponkore/ac-nrepl"
           ;;        ;;:pkgname "purcell/ac-nrepl"
           ;;        )

           ;; (:name tab-group
           ;;        :type github
           ;;        :pkgname "tarao/tab-group-el")
           ;; (:name key-intercept
           ;;        :type github
           ;;        :pkgname "tarao/key-intercept-el")
           ;; (:name multi-mode-util
           ;;        :type github
           ;;        :pkgname "tarao/multi-mode-util")
           ;; (:name multi-mode
           ;;        :type github
           ;;        :pkgname "emacsmirror/multi-mode")
           ;; (:name term-plus-el
           ;;       :type github
           ;;       :pkgname "tarao/term-plus-el"
           ;;       :submodule nil
           ;;       )

          ;; うまく動かないのでとりあえず保留
          ;; (:name anything-c-yasnippet-2
          ;;        :type http
          ;;        :url "http://www.rubyist.net/~rubikitch/archive/anything-c-yasnippet-2.el")

          ;; (:name yasnippet-config
          ;;        :type emacswiki)

          ;; (:name sha1-el
          ;;        :type http
          ;;        :url "http://stuff.mit.edu/afs/sipb/contrib/emacs/packages/flim-1.14.7/sha1-el.el")
          ;; (:name anything-hatena-bookmark
          ;;        :type http
          ;;        :url "https://raw.github.com/k1LoW/anything-hatena-bookmark/master/anything-hatena-bookmark.el")

          (:name text-translator
                 :type emacswiki)
          (:name text-translator-vars
                 :type emacswiki)
          (:name text-translator-load
                 :type emacswiki)

          ;; (:name sudo-ext
          ;;        :type emacswiki)

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

          ))

  ;; append:第一引数のリストに残りの引数の各リストの各要素を追加していく。
  (setq mikio-packages 
        (append 
         '(
           ;; auto-install                 ; emacswiki
           ;; package                      ; http
           
           ;; revive                       ; http(windows.elが依存)
           ;; windows                      ; http
       
           tabbar                       ; emacswiki
           )

         (mapcar 'el-get-source-name el-get-sources)))

  ;; el-get:
  ;; 引数にはパッケージ名のはいったリストを渡す
  ;; また、各パッケージのload-pathをとおす。
  (el-get 'sync mikio-packages)
  )

(provide 'mikio-el-get)
