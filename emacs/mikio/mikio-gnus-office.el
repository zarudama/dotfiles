(require 'mikio-util)
(require 'gnus)
;; http://ag5.net/~hat2beard/tips/meadow_again.html
(setq user-full-name "OONO, Miki")
(setq user-mail-address "m-oono@nttr.co.jp")

;;; SMTPサーバの設定
(setq smtpmail-smtp-server "smtp.nttr.co.jp")
(setq smtpmail-local-domain "nttr.co.jp")
(setq message-send-mail-function 'message-smtpmail-send-it)

;;; POPサーバの設定
;;; (.... :leave t ) ;;=> メールをメールサーバ上に残す場合
(setq mail-sources
        '((pop :server "pop.nttr.co.jp" :user "m-oono" :leave t)))

;;; Gnusで主にメールを使う設定
(setq gnus-select-method '(nnml ""))

;; アドレス帳の補完
(add-hook 'message-setup-hook
          (lambda ()
            (define-key message-mode-map (kbd "C-c C-a") 'mail-abbrev-insert-alias)))

;; 記事バッファの表示
(setq gnus-visible-headers
"^From:\\|^Subject:\\|^To:\\|^Date:\\|^Reply-To:\\|^X-Mailer:\\|^User-Agent:")

;; 全文検索エンジン HyperEstraier
;; (install-elisp "https://raw.github.com/kawabata/gnus-est/master/gnus-est.el")
;;(require 'gnus)
;;(require 'gnus-agent)
;;(defsubst gnus-est/indexed-servers ())
;; (require 'gnus-est)
;; (gnus-est-insinuate)



(provide 'mikio-gnus-office)
