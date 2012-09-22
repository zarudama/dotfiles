(require 'mikio-util)
(require 'tabbar)

;;(add-to-list 'load-path (mikio/site-lisp-home "twittering-mode-2.0.0"))
(require 'twittering-mode)

;;-----------------------------------------------------------------
;; twittering-mode-2.0.0
;;-----------------------------------------------------------------
(setq twittering-auth-method 'oauth)
(setq twittering-use-master-password t)
(setq twittering-private-info-file (mikio/elisp-home  "twittering-mode.gpg"))
;;(setq twittering-convert-fix-size nil) 

;;
;; Twitter
;;
;; (install-elisp "http://github.com/hayamiz/twittering-mode/raw/master/twittering-mode.el")
; from http://masutaka.net/chalow/2009-06-07-5.html
;;

;; サーバ証明書の認証を無効化する
;; http://d.hatena.ne.jp/wadakei/20120211/1328968663
(setq twittering-allow-insecure-server-cert t)

(setq twittering-timer-interval 75)
(setq twittering-convert-fix-size 16)
(setq twittering-update-status-function 'twittering-update-status-from-pop-up-buffer)
(setq twittering-icon-mode nil)
(setq twittering-scroll-mode nil)
;; いくつかのTLをまとめて名前をつけることができる
(setq twittering-timeline-spec-alias
      `(("related-to" .
	 ,(lambda (username)
	    (if username
		(format ":search/to:%s OR from:%s OR @%s/"
			username username username)
	      ":home")))
	))
;; 起動時に以下のリストを読みこむ
(setq twittering-initial-timeline-spec-string
      '("$related-to(atauky)"
        "mikio_kun/geeks"
        "mikio_kun/geeks"
        "mikio_kun/bot"
        "mikio_kun/friend"
        ":search/clojure/"
        ":search/emacs/"
        ":search/タブレット/"
        ":search/#androidjp/"
        ":search/#shibuya_el/"
        ":search/lisp/"
        ":search/scala/"
        ":direct_messages"
        ":home"))

;; タイムラインのフォーマット
;; Documentation:
;; Format string for rendering statuses.
;; Ex. "%i %s,  %@:\n%FILL{  %T // from %f%L%r%R}
;;  "

;; Items:
;;  %s - screen_name
;;  %S - name
;;  %i - profile_image
;;  %d - description
;;  %l - location
;;  %L - " [location]"
;;  %r - " sent to user" (use on direct_messages{,_sent})
;;  %r - " in reply to user" (use on other standard timeline)
;;  %R - " (retweeted by user)"
;;  %RT{...} - strings rendered only when the tweet is a retweet.
;;             The braced strings are rendered with the information of the
;;             retweet itself instead of that of the retweeted original tweet.
;;             For example, %s for a retweet means who posted the original
;;             tweet, but %RT{%s} means who retweeted it.
;;  %u - url
;;  %j - user.id
;;  %p - protected?
;;  %c - created_at (raw UTC string)
;;  %C{time-format-str} - created_at (formatted with time-format-str)
;;  %@ - X seconds ago
;;  %T - raw text
;;  %t - text filled as one paragraph
;;  %' - truncated
;;  %FACE[face-name]{...} - strings decorated with the specified face.
;;  %FILL[prefix]{...} - strings filled as a paragraph. The prefix is optional.
;;                       You can use any other specifiers in braces.
;;  %FOLD[prefix]{...} - strings folded within the frame width.
;;                       The prefix is optional. This keeps newlines and does not
;;                       squeeze a series of white spaces.
;;                       You can use any other specifiers in braces.
;;  %f - source
;;  %# - id

(add-hook 'twittering-mode-hook
          (lambda ()
            (set-face-bold-p 'twittering-username-face t)
            (set-face-foreground 'twittering-username-face "DeepSkyBlue3")
            (set-face-foreground 'twittering-uri-face "gray60")
            ;;(setq twittering-status-format "%i %s/%S,  %@: %FILL{  %T [ %f ]%L%r%R}")
            (setq twittering-status-format "%i %S,  %@: %FILL{  %T [ %f ]%L%r%R}")
            (setq twittering-retweet-format " RT @%s: %t")
            ;; "F"でお気に入り
            ;; "R"でリツイートできるようにする
            (define-key twittering-mode-map (kbd "F") 'twittering-favorite)
            (define-key twittering-mode-map (kbd "R") 'twittering-native-retweet)
            (define-key twittering-mode-map (kbd "s") 'twittering-search)
            ;; "<"">"で先頭、最後尾にいけるように
))
;; ;; URL短縮サービスをj.mpに
;; ;; YOUR_USER_IDとYOUR_API_KEYを自分のものに置き換えてください
;; ;; from http://u.hoso.net/2010/03/twittering-mode-url-jmp-bitly.html
;; (add-to-list 'twittering-tinyurl-services-map
;; 	     '(jmp . "http://api.j.mp/shorten?version=2.0.1&login=YOUR_USER_ID&apiKey=YOUR_API_KEY&format=text&longUrl="))
;; (setq twittering-tinyurl-service 'jmp)

(define-key twittering-mode-map (kbd "C-h") 'tabbar-backward-tab)
(define-key twittering-mode-map (kbd "C-l") 'tabbar-forward-tab)

(provide 'mikio-twitter)
