(require 'mikio-util)

(when (require 'package nil t)

  ;; Marmalade
  ;; (add-to-list 'package-archives
  ;;              '("marmalade" . "http://marmalade-repo.org/packages/"))

  ;; MELPA
  ;; (add-to-list 'package-archives
  ;;              '("melpa" . "http://melpa.milkbox.net/packages/") t)

  ;; MELPAのみにする。
  (setq package-archives (list '("melpa" . "http://melpa.milkbox.net/packages/")))

	

  ;;インストールするディレクトリを指定
  (setq my-package-directory (mikio/elisp-home "package"))
  (mikio/make-directory my-package-directory)
  (setq package-user-dir (concat my-package-directory "/"))

  ;; 
  (package-initialize)

  (setq my-packages
        '(undo-tree
          helm
          auto-complete
          popwin
          smartrep
          color-moccur
          yasnippet

          helm-git
          helm-gtags
          helm-c-moccur

          paredit
          ruby-mode
          php-mode
          js2-mode
          web-mode

          nrepl
          nrepl-ritz
          ac-nrepl
          ;;ac-slime
          magit

          jaunte
          rainbow-delimiters

          ;; window manager by kiwanami
          window-layout
          e2wm

          twittering-mode
          ;;o-blog

          evil
          ))

  (require 'cl)
  (mapcar (lambda (x)
            (when (not (package-installed-p x))
              (package-install x)))
          my-packages)
)

(provide 'mikio-package)
