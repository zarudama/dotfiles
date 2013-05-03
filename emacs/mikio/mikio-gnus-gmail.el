(require 'mikio-util)
(require 'gnus)
(load "gnus-setup")
(require 'gnus-start)
(require 'gnus-art)
(require 'auth-source)
(require 'starttls)
(require 'nnimap)
(require 'nnir)

;; Username and mail address.
(setq user-full-name "mikio_kun"
      user-mail-address "ocha.awk@gmail.com")

;; for reading mail by imap.
(setq gnus-select-method
      '(nnimap "gmail"
	       (nnimap-address "imap.gmail.com")
	       (nnimap-server-port 993)
	       (nnimap-authinfo-file "~/.emacs.d/.authinfo")
	       (nnimap-stream ssl)))

;; for sending mail.
(setq message-send-mail-function 'smtpmail-send-it
      send-mail-function 'smtpmail-send-it
      smtpmail-starttls-credentials '(("smtp.gmail.com" 465 nil nil))
      smtpmail-auth-credentials '(("smtp.gmail.com" 465
				   "ocha.awk@gmail.com" nil))
      smtpmail-default-smtp-server "smtp.gmail.com"
      smtpmail-smtp-server "smtp.gmail.com"
      smtpmail-smtp-service 465
      ;; Cc: and Bcc: to header of message-mode.
      message-default-mail-headers "Cc: \nBcc: \n")

;; customize `gnu-summary-line-foramt'.
(defvar my-gnus-mail-addres-regex "ocha\\.awk\\(\\+[^@]+\\)?@gmail\\.com"
  "*Regular expression of mail address that indicates for me.")

;; from http://emacs.wordpress.com/2007/10/07/gmail-envy/
;; and customize it.
(defun gnus-user-format-function-j (headers)
  "Return a \">\" if variable `my-gnus-mail-addres-regex' matches in To,
CC or Bcc. If not matched, return a \" \"."
  (cond
   ((or (string-match my-gnus-mail-addres-regex
		      (gnus-extra-header 'To headers))
	(string-match my-gnus-mail-addres-regex
		      (gnus-extra-header 'Cc headers))
	(string-match my-gnus-mail-addres-regex
		      (gnus-extra-header 'BCc headers)))
    ">")
   (t
    " ")))
(setq gnus-summary-line-format "%uj%U%R%I%(%[%-23,23f%]%) %s\n")

;; gnu-topic-mode by default
(add-hook 'gnus-group-mode-hook 'gnus-topic-mode)

;; MUA is gnus.
(setq read-mail-command 'gnus
      mail-user-agent 'gnus-user-agent)

(setq ;; Do not use mailcrypt.
      gnus-use-mailcrypt nil
      gnus-check-new-newsgroups nil
      gnus-use-cache t
      gnus-cache-directory "~/Mail/cache/"
      gnus-cache-enter-articles '(ticked dormant read unread)
      gnus-cache-remove-articles nil
      gnus-cacheable-groups "^nnimap"
      gnus-posting-styles '((".*" (name "HAMANO Kiyoto")))
      ;; Do not split the mail when mail was large.
      mime-edit-split-message nil
      ;; treates wide character
      gnus-use-correct-string-widths t
      ;; Do not ask online or not.
      gnus-agent-go-online t
      ;; do not goto cursor to unread group.
      gnus-group-goto-unread nil
      ;; show also user-agent.
      gnus-visible-headers (concat gnus-visible-headers "\\|^User-Agent")
      ;; extra headers to parse.
      gnus-extra-headers '(To Newsgroups X-Newsreader
			      Content-Type CC User-Agent Gnus-Warning)
      nnmail-extra-headers gnus-extra-headers
      ;; If member of thread that includes new article has old
      ;; article, grab old articles to display thread.
      gnus-fetch-old-headers t)

;; Display always 500 articles at least in summary buffer.
(defvar my-gnus-summary-maximum-articles 500
  "*The recent X number of articles that displayed in summary-buffer
by use `gnus-topic-select-group' (RET) in gnus-group-buffer. The default
value is 500. The recent 500 articles are always displayed at least.")
(setq gnus-alter-articles-to-read-function
      #'(lambda (group articles)
	  (let ((active (gnus-active group)))
	    (delete-dups
	     (append articles
		     (gnus-uncompress-range
		      (cond
		       (my-gnus-summary-maximum-articles
			;; show `my-gnus-summary-maximum-articles' messages.
			(cons (max (car active)
				   (- (cdr active)
				      my-gnus-summary-maximum-articles
				      -1))
			      (cdr active)))
		       (t
			;; show always all messages.
			active))))))))

;; Gnus + EasyPG
(require 'epg-config)
(require 'gnus-msg)
(require 'mml2015)
(setq gnus-message-replysign t
      gnus-message-replyencrypt t
      gnus-message-replysignencrypted t
      mm-verify-option 'always
      mm-decrypt-option 'always
      mml2015-use 'epg
      mml2015-encrypt-to-self t
      mml2015-always-trust nil
      mml2015-cache-passphrase t
      mml2015-passphrase-cache-expiry '36000
      mml2015-sign-with-sender t
      gnus-buttonized-mime-types '("multipart/alternative"
				   "multipart/encrypted"
				   "multipart/signed"))

;; ;; mail contacts list manager.
;; (require 'bbdb)
;; ;; take mail address automatically
;; (setq bbdb/news-auto-create-p t)
;; ;; add address automatically
;; (setq bbdb-always-add-addresses t)
;; ;; do not use popup
;; (setq bbdb-use-pop-up nil)
;; ;; my mail address
;; (setq bbdb-user-mail-names "ocha\\.awk@gmail\\.com")
;; (bbdb-initialize 'gnus 'message)
(provide 'mikio-gnus-gmail)
