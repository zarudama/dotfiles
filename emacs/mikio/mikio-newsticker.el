(require 'mikio-util)

(require 'newsticker)
;;-----------------------------------------------------------------
;; newsticker.el
;; M-x newsticker-show-news
;;-----------------------------------------------------------------
(setq newsticker-url-list
      '(("Slashdot" "http://rss.slashdot.org/Slashdot/slashdot")
        ("TechCrunch" "http://feeds.feedburner.com/TechCrunch")
        ("hatebu" "http://feeds.feedburner.com/hatena/b/hotentry")
        ("must" "http://www.google.com/reader/public/atom/user%2F00237818735906353794%2Fbundle%2F%23must")))

;; emacs-w3mでフィードを表示する
(autoload 'w3m-region "w3m" nil t)
(setq newsticker-html-renderer 'w3m-region)

(provide 'mikio-newsticker)
