(require 'mikio-util)

(require 'newsticker)
;;-----------------------------------------------------------------
;; newsticker.el
;; M-x newsticker-show-news
;;-----------------------------------------------------------------
(setq newsticker-url-list
      '(("Slashdot" "http://rss.slashdot.org/Slashdot/slashdot")
        ("TechCrunch" "http://feeds.feedburner.com/TechCrunch")
        ("hatebu" "http://feeds.feedburner.com/hatena/b/hotentry"))
      )

;; emacs-w3mでフィードを表示する
(autoload 'w3m-region "w3m" nil t)
(setq newsticker-html-renderer 'w3m-region)

(provide 'mikio-newsticker)
