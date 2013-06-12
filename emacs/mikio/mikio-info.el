(require 'mikio-util)
(require 'info)
;;-----------------------------------------------------------------
;; パッケージに属さないinfoの定義用。
;; emacs info 日本語版とか。
;;-----------------------------------------------------------------

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
;;(add-to-list 'Info-directory-list (mikio/site-lisp-directory "emacs-jabber-0.8.91"))
(add-to-list 'Info-directory-list "~/Dropbox/info")k

(provide 'mikio-info)


