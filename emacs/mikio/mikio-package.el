(require 'mikio-util)

(when (require 'package nil t)

  ;; Marmalade
  ;; (add-to-list 'package-archives
  ;;              '("marmalade" . "http://marmalade-repo.org/packages/"))

  ;; MELPA
  (add-to-list 'package-archives
               '("melpa" . "http://melpa.milkbox.net/packages/") t)

  ;;インストールするディレクトリを指定
  (setq package-user-dir (mikio/elisp-home "package/"))

  ;; 
  (package-initialize)

  (setq my-packages
        '(helm
          auto-complete
          popwin
          smartrep
          ;;color-moccur
          yasnippet
          undo-tree

          helm-gtags
          helm-c-moccur

          paredit
          ruby-mode
          php-mode
          js2-mode
          web-mode

          nrepl
          ac-nrepl
          ;;ac-slime
          magit

          jaunte
          rainbow-delimiters

          twittering-mode              ; github
          o-blog                       ; github

          ))

  (require 'cl)
  (mapcar (lambda (x)
            (when (not (package-installed-p x))
              (package-install x)))
          my-packages)
   
  
  

  ;; (when nil
  ;;   (require 'cl)
  ;;   (defvar installing-package-list
  ;;     '(
  ;;       ;; ここに使っているパッケージを書く。
  ;;       auto-complete   ; github
  ;;       ;;    anything                     ; git(http)
  ;;       ;;    undo-tree                    ; git(http)
  ;;       ;;    smartrep                     ; github
  ;;       ;;    popwin                       ; github
  ;;       ;;    yasnippet                    ; github

  ;;       ;;    revive                       ; http(windows.elが依存)
  ;;       ;;    windows                      ; http
        
  ;;       ;;    paredit                      ; http
  ;;       ;;    lispxmp                      ; emacswiki
  ;;       ;;    tabbar                       ; emacswiki

  ;;       ;;    clojure-mode                 ; github
  ;;       ;;    js2-mode                     ; github
  ;;       ;;    ruby-mode                    ; elpa
  ;;       ;;    ac-slime                     ; github
  ;;       ;;    magit                        ; github

  ;;       ;;    jaunte                       ; github
  ;;       ;;    rainbow-delimiters           ; github

  ;;       ))

  ;;   (let ((not-installed (loop for x in installing-package-list
  ;;                              when (not (package-installed-p x))
  ;;                              collect x)))
  ;;     (when not-installed
  ;;       (package-refresh-contents)
  ;;       (dolist (pkg not-installed)
  ;;         (package-install pkg))))
  ;;   )
  

)

(provide 'mikio-package)
