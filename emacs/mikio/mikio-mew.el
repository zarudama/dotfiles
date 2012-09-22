(require 'mikio-util)

(mikio/add-to-load-path "site-lisp/mew")
(require 'mew)

;; ;; Fromの表示名
;; (setq mew-name "mikio_kun")
;; ;; Fromのメールアドレスの@の左側
;; (setq mew-user "ocha.awk")
;; ;; Fromのメールアドレスの@の右側
;; (setq mew-mail-domain "gmail.com")
;; ;; Mew起動時のフォルダ
;; ;;   "+" : +inbox
;; ;;   "$" : $inbox
;; ;;   "%" : %inbox
;; ;;   "-" : -fj.mail.reader.mew
;; (setq mew-proto "%")
;; ;; IMAPサーバ
;; (setq mew-imap-server "imap.gmail.com")
;; ;; IMAPのユーザID
;; (setq mew-imap-user "ocha.awk@gmail.com")
;; ;; SMTPサーバ
;; (setq mew-smtp-server "smtp.gmail.com")
;; ;; SMTP-AUTHのユーザID
;; (setq mew-smtp-user "ocha.awk@gmail.com")
;; ;; 証明書を検証するレベル
;; ;;   0 : サーバの証明書があっても無くても検証せずにSSL接続
;; ;;   1 : サーバの証明書が「無し」か「ありで検証OK」のときだけSSL接続
;; ;;   2 : サーバの証明書が「ありで検証OK」のときだけSSL接続
;; ;;   3 : サーバが送ってきたものではなくローカルの証明書で検証OKのときだけSSL接続
;; (setq mew-ssl-verify-level 0)
;; ;; ルート認証局の証明書のパス
;; (setq mew-ssl-cert-directory (mikio/elisp-home  ".certs/"))
;; ;; IMAP over SSLを使う
;; (setq mew-imap-ssl t)
;; ;; SMTP over SSLを使う
;; (setq mew-smtp-ssl t)


;(setq mew-pop-auth 'hogehoge) 

(setenv "TZ" "JST-9")

;; 両方tでないとファイルに書き出さない
(setq mew-use-cached-passwd t) ;; パスワードをメモリにキャッシュする
(setq mew-use-master-passwd t) ;; パスワードをファイルにキャッシュする

;; 以下は初期値
;;(setq mew-summary-form '(type (5 date) " " (14 from) " " t (30 subj) "|" (0 body))) 

;; サマリに時刻を表示する。
;; (setq mew-summary-form
;;       '(type (5 date) " [" (-4 time) "] "
;;              (28 from) " " t (0 subj)))
(setq mew-summary-form
      '(type (4 year) " "  (5 date) " [" (-4 time) "] "
             (30 from) " " t (0 subj)))



;; 未読マークをつける。
;;(setq mew-use-unread-mark t)

;; To use local mailbox "mbox" or "maildir" instead of POP
;;(executable-find "incm")
;; (setq mew-mailbox-type 'mbox)
;; (setq mew-mbox-command "incm")
;; (setq mew-mbox-command-arg "-u -m C:/Users/m-oono/mbox-data/2011")
;; If /path/to/mbox is a file, it means "mbox".
;; If /path/to/mbox is a directory, it means "maildir".

(setq mew-refile-guess-alist
      '(("Date: "
         ;; ("Jan 2011"  "+2011/01")
         ;; ("Feb 2011"  "+2011/02")
         ;; ("Mar 2011"  "+2011/03")
         ;; ("Apr 2011"  "+2011/04")
         ;; ("May 2011"  "+2011/05")
         ;; ("Jun 2011"  "+2011/06")
         ;; ("Jul 2011"  "+2011/07")
         ;; ("Aug 2011"  "+2011/08")
         ;; ("Sep 2011"  "+2011/09")
         ;; ("Oct 2011"  "+2011/10")
         ;; ("Nov 2011"  "+2011/11")
         ;; ("Dec 2011"  "+2011/12")
         (" 2011"  "+2011")
         (" 2012"  "+2012")
         )))

;; 検索エンジンにhyperestraierを指定
(setq mew-search-method 'est)
;; for windows
(setq mew-prog-est "estcmd.exe")
(setq mew-prog-est-update "sh mewest")

;; To use local mailbox "mbox" or "maildir" instead of POP
;; Usage: incm [-abchosv] [-d maildir] [-i inboxdir] [-x suffix]
;;     -h            Display this help message.
;;     -v            Display the version.
;;     -d <mail>     Path to mbox/maildir.
;;     -m <mail>     Path to mbox/maildir.
;;     -s            Read one mail from stdin instead of mbox/maildir.
;;     -i <inboxdir> Path to inboxdir.
;;     -b            Backup mail.
;;                     mbox: No truncate mbox file.
;;                     maildir: To maildir/cur directory.
;;     -a            Retrieve all mail from maildir/{cur,new} directory.
;;                   (no backup) (for maildir)
;;     -c            Use Content-Length: field. (for mbox)
;;     -u            Don't create inboxdir/.mew-mtime file.
;;     -f            Preserve Unix From (Envelope Sender). (for mbox)
;;     -p <fmode>    Specify file permission. (for mbox)
;;     -o            Use the suffix when creating messages.
;;     -x <suffix>   Use this suffix.


;; M-x mew, C(CaseValue)で選択できる
(setq mew-config-alist `(
                         (default)			;; デフォルトは設定なし

                         ;; ローカルメールボックス(ThunderBird移行用)
                         (local
                          (mailbox-type  mbox)
                          (mbox-command  "incm")
                          (mbox-command-arg "-u -m C:\\Users\\m-oono\\mbox-data\\2012"))

                         (gmail-pop
                           (name               "mikio_kun")
                           (user               "ocha.awk")
                           (pop-ssl            t)
                           (pop-ssl-port       995)
                           (inbox-folder       "+ocah.awk")
                           (mail-domain        "gmail.com")
                           (pop-user           "ocha.awk@gmail.com")
                           (pop-server         "pop.gmail.com")
                           (pop-auth           pass)
                           (smtp-user          "ocha.awk@gmail.com")
                           (smtp-server        "smtp.gmail.com")
                           (smtp-ssl           t)
                           (smtp-ssl-port      465)
                           (use-smtp-auth      t)
                           (pop-delete         nil) ;; nil:サーバー上のデータを削除しない
                           (ssl-verify-level   0)
                           (ssl-cert-directory (mikio/elisp-home  ".certs/"))
                           )

                         ;; ("gmail-imap"
                         ;;  (name               . "mikio_kun")
                         ;;  (user               . "ocha.awk")
                         ;;  (mail-domain        . "gmail.com")
                         ;;  (proto              . "%")
                         ;;  (imap-server        . "imap.gmail.com")
                         ;;  (imap-ssl           . t)
                         ;;  (imap-ssl-port      . "993")
                         ;;  (imap-user          . "ocha.awk@gmail.com")
                         ;;  (imap-auth          . t)
                         ;;  (imap-delete        . nil)
                         ;;  (imap-trash-folder  . "%[Gmail]/ゴミ箱") ;
                         ;;  (smtp-ssl           . t)
                         ;;  (smtp-server        . "smtp.gmail.com")
                         ;;  (smtp-ssl-port      . "465")
                         ;;  (use-smtp-auth      . t)
                         ;;  (smtp-user          . "ocha.awk@gmail.com")
                         ;;  (ssl-verify-level   . 0)
                         ;;  (ssl-cert-directory . ,(mikio/elisp-home  ".certs/"))
                         ;;  )

                         (office
                          (name               "OONO Miki")
                          (user               "m-oono")
                          (inbox-folder       "+inbox")
                          (mail-domain        "nttr.co.jp")
                          (pop-ssl            nil)
                          (pop-port           110)
                          (pop-user           "m-oono")
                          (pop-server         "pop.nttr.co.jp")
                          (pop-auth           pass)
                          (pop-delete         nil) ;; nil:サーバー上のデータを削除しない
                          (smtp-server        "smtp.nttr.co.jp")
                          (smtp-user          nil)
                          (smtp-port          25)
                          (smtp-ssl           nil)
                          (use-smtp-auth      Nil)
                          )))
                          
(provide 'mikio-mew)
