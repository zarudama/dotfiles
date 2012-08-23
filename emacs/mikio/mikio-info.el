(require '_util)
(require 'info)

;;-----------------------------------------------------------------
;; 日本語 info
;;-----------------------------------------------------------------
;; infoファイルの場所を設定
;; $ cd ~/.emacs.d
;; $ wget http://www.rubyist.net/~rubikitch/archive/emacs-elisp-info-ja.tgz
;; $ tar xvfz emacs-elisp-info-ja.tgz
;; /usr/share/info/dirに下記を追加
;; * Elisp: (elisp-ja).             The Emacs Lisp Reference Manual(Japanase).
;; * Emacs: (emacs-ja).             The extensible self-documenting text editor(Japanese).
;;(add-to-list 'Info-directory-list "~/.emacs.d/info")


;;-----------------------------------------------------------------
;; local info
;;-----------------------------------------------------------------
(setq Info-directory-list
      (list
       (format "%s/info/emacs" my-elisp-dir)
       (format "%s/info/navi2ch" my-elisp-dir)
       (format "%s/info/org" my-elisp-dir)
       (format "%s/info/w3m" my-elisp-dir)
       (format "%s/info/skk" my-elisp-dir)
       (format "%s/info/mew" my-elisp-dir)
       (format "%s/info/sdic" my-elisp-dir)
       ))

