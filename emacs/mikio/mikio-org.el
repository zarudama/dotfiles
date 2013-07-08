(require 'mikio-util)

;;(require 'org-install)
;;(require 'org-remember)
;;(require 'org-babel-init)
;;(require 'org-babel-perl)
;;(require 'ob-clojure)
;;(require 'ob-java)

;;(org-babel-load-library-of-babel)

(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
(global-set-key (kbd "C-c l") 'org-store-link)
(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c b") 'org-iswitchb)
(global-set-key (kbd "C-c c") 'org-capture)
;;(global-set-key (kbd "C-c r") 'org-remember)
;;(define-key org-mode-map (kbd "C-t") 'switch-to-last-buffer-or-other-window)

(add-hook 'org-mode-hook (lambda ()
                           (turn-on-font-lock)
                           (define-key org-mode-map (kbd "C-j") nil)))

;; コードブロックも色付け
(setq org-src-fontify-natively t)

;; (setq (org-export-language-setup (quote (("ja" "作者" "日付" "目次" "脚注")))))
;; (setq (org-export-with-toc t)))

(setq org-agenda-custom-commands
  '(("x" "Unscheduled TODO" tags-todo "-SCHEDULED>=\"<now>\"" nil)))
(setq org-stuck-projects
  '("+PROJECT/-DONE-SOMEDAY" ("TODO" "WAIT")))

(setq org-todo-keywords
      '((sequence "TODO" "WORKING" "|" "DONE" )))

(setq org-agenda-time-grid
  '((daily today require-timed)
    "----------------"
    (900 930 1000 1030 1100 1130 1200 1230
         1300 1330 1400 1430 1500 1530 1600 1630 1700 1730 1800 1830
         1900 1930 2000 2030 2100 2130 2200 2230 2300 2330 )))

;; 見出しの余分な"*"を消す
(setq org-hide-leading-stars t)

(setq org-directory (mikio/org-directory))
(require 'em-glob)
(setq org-agenda-files (eshell-extended-glob (concat org-directory "**/*.org")))

;;(setq org-agenda-include-diary t)
(setq org-agenda-include-diary nil)

;; auto-complete
(add-to-list 'ac-modes 'org-mode)
;; css定義を分離する
;;(setq org-export-htmlize-output-type 'css)

;; t:自動的にTODO項目にdoneの印をつける
(setq org-log-done t)

;; (org-remember-insinuate)
;; (setq org-default-notes-file (expand-file-name "index.org" org-directory))

;; (setq org-remember-templates
;;       '(("Note" ?n "** %?\n   %i\n   %a\n   %t" nil "Inbox")
;;         ("Todo" ?t "** TODO %?\n   %i\n   %a\n   %t" nil "Inbox")))

(setq org-capture-templates
      '(("t" "Todo" entry (file+headline (format "%sindex.org" org-directory) "Inbox")
         "* TODO %?\n  %i\n  %a\n   %t")))

;; --------------------------------------
;; from rubikitch mail
;; --------------------------------------

;; - C-RET で現在の階層の見出し
;; - C-u C-RET で現在より1階層深い見出し
;; - C-u C-u C-RET で現在より1階層浅い見出し
(require 'cl)
(defun org-insert-upheading (arg)
  (interactive "P")
  (org-insert-heading arg)
  (cond
   ((org-on-heading-p) (org-do-promote))
   ((org-at-item-p) (org-outdent-item))))
(defun org-insert-heading-dwim (arg)
  (interactive "p")
  (case arg
    (4  (org-insert-subheading nil))
    (16 (org-insert-upheading  nil))
    (t  (org-insert-heading nil))))
(define-key org-mode-map (kbd "<C-return>") 'org-insert-heading-dwim)

;;; 言語は日本語
(setq org-export-default-language "ja")
;;; 文字コードはUTF-8
(setq org-export-html-coding-system 'utf-8)
;;; 行頭の:は使わない BEGIN_EXAMPLE 〜 END_EXAMPLE で十分
(setq org-export-with-fixed-width nil)
;;; ^と_を解釈しない
(setq org-export-with-sub-superscripts nil)
;;; --や---をそのまま出力する
(setq org-export-with-special-strings nil)
;;; TeX・LaTeXのコードを解釈しない
(setq org-export-with-TeX-macros nil)
(setq org-export-with-LaTeX-fragments nil)

;;-----------------------------------------------------------------
;; agendaの日付フォーマットを日本語表記に変更。
;; http://valvallow.blogspot.com/2011/02/org-agenda-weekly-view.html
;;-----------------------------------------------------------------
(defadvice org-agenda (around org-agenda-around)
  (let ((system-time-locale "English"))
    ad-do-it))

(defadvice org-agenda-redo (around org-agenda-redo-around)
  (let ((system-time-locale "English"))
    ad-do-it))

(custom-set-variables
  '(org-agenda-format-date "%Y/%m/%d (%a)"))

(custom-set-faces
 '(org-agenda-date ((t :weight bold))))

;;-----------------------------------------------------------------
;; 後悔ファイル設定
;;-----------------------------------------------------------------
;; (setq org-publish-project-alist
;;       '(("org"
;;         :base-directory "~/Dropbox/org/public"
;;         :publishing-directory "~/dev/mikio.github.com"
;;         :section-numbers nil
;;         :makeindex "index.org"
;;         :style "<link rel=\"stylesheet\" href=\"css/org.css\" type=\"text/css\" \>")))
(setq org-publish-project-alist
      '(
        ("org-jekyll"
         ;; Path to your org files.
         :base-directory "~/Dropbox/org/public"
         :base-extension "org"

         ;; Path to your Jekyll project.
         :publishing-directory "~/dev/mikio.github.com/_posts"
         :recursive t
         :publishing-function org-publish-org-to-html
         :headline-levels 4 
         :html-extension "html"
         :body-only t ;; Only export section between <body> </body>
         :org-export-with-toc t
         )

        ("org-static-jekyll"
         :base-directory "~/Dropbox/org/public"
         :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|ogg\\|swf\\|php"
         :publishing-directory "~/dev/mikio.github.com/_posts/"
         :recursive t
         :publishing-function org-publish-attachment)

        ("jekyll" :components ("org-jekyll" "org-static-jekyll"))

        ("org-html"
         ;; Path to your org files.
         :base-directory "~/Dropbox/org/public"
         :base-extension "org"

         ;; Path to your Jekyll project.
         :publishing-directory "~/dev/html"
         :recursive t
         :publishing-function org-publish-org-to-html
         :headline-levels 4 
         :html-extension "html"
         ;;:body-only t ;; Only export section between <body> </body>
         :org-export-with-toc t
         :auto-index t ;;「nil」でないときに、「org-publish-current-project」または「org-publish-all」の中のインデックスを公開します。
         :index-filename "index.org"  ;;インデックスの出力用のファイルの名前です。デフォルトでは「index.org」となります。（これは「index.html」として公開されます。）
         :index-title   "front-page" ;;インデックスのページのタイトルです。デフォルトではファイル名となります。
         )
        ))

;; キーバインド
;; (eval-after-load "org"
;;   '(progn
;;      (smartrep-define-key
;;       org-mode-map "C-c"
;;       '(("C-n" . (lambda () (outline-next-visible-heading 1)))
;;         ("C-p" . (lambda () (outline-previous-visible-heading 1)))))))

;;-----------------------------------------------------------------
;; rss
;;-----------------------------------------------------------------
(defun org-feed-parse-rdf-feed (buffer)
  "Parse BUFFER for RDF feed entries.
Returns a list of entries, with each entry a property list,
containing the properties `:guid' and `:item-full-text'."
  (let (entries beg end item guid entry)
    (with-current-buffer buffer
      (widen)
      (goto-char (point-min))
      (while (re-search-forward "<item[> ]" nil t)
        (setq beg (point)
              end (and (re-search-forward "</item>" nil t)
                       (match-beginning 0)))
        (setq item (buffer-substring beg end)
              guid (if (string-match "<link\\>.*?>\\(.*?\\)</link>" item)
                       (org-match-string-no-properties 1 item)))
        (setq entry (list :guid guid :item-full-text item))
        (push entry entries)
        (widen)
        (goto-char end))
      (nreverse entries))))

; (setq org-feed-retrieve-method 'wget)
(setq org-feed-retrieve-method 'curl)

(setq org-feed-default-template "\n* %h\n  - %U\n  - %a  - %description")


(defun w3m-string (str)
  (with-temp-buffer
    (insert str)
    (goto-char 1)
    (w3m-buffer)
    (buffer-string)))
(defalias 'org-feed-html2str 'w3m-string)


(setq org-feed-alist
'(("2dgames.jp" "http://2dgames.jp/feed/" "~/Dropbox/org/rss.org" "2dgames.jp" :parse-feed org-feed-parse-rdf-feed) ("404 Blog Not Found" "http://blog.livedoor.jp/dankogai/index.rdf" "~/Dropbox/org/rss.org" "404 Blog Not Found" :parse-feed org-feed-parse-rdf-feed) ("?ab's Blog" "http://blog.ik.am/feed" "~/Dropbox/org/rss.org" "?ab's Blog" :parse-feed org-feed-parse-rdf-feed) ("ABAの日誌" "http://d.hatena.ne.jp/ABA/rss" "~/Dropbox/org/rss.org" "ABAの日誌" :parse-feed org-feed-parse-rdf-feed) ("An Agile Way" "http://blogs.itmedia.co.jp/hiranabe/index.rdf" "~/Dropbox/org/rss.org" "An Agile Way" :parse-feed org-feed-parse-rdf-feed) ("Chikirinの日記" "http://d.hatena.ne.jp/Chikirin/rss" "~/Dropbox/org/rss.org" "Chikirinの日記" :parse-feed org-feed-parse-rdf-feed) ("CodeZine：新着記事" "http://rss.rssad.jp/rss/codezine/new/20/index.xml" "~/Dropbox/org/rss.org" "CodeZine：新着記事" :parse-feed org-feed-parse-rdf-feed) ("Colorful Pieces of Game" "http://www.highriskrevolution.com/gamelife/?mode=rss" "~/Dropbox/org/rss.org" "Colorful Pieces of Game" :parse-feed org-feed-parse-rdf-feed) ("Common LISP users jp" "http://cl.cddddr.org/index.cgi?c=rss" "~/Dropbox/org/rss.org" "Common LISP users jp" :parse-feed org-feed-parse-rdf-feed) ("Emacs Advent Calendarの投稿 - Qiita" "http://qiita.com/advent-calendar/2012/emacs/feed.atom" "~/Dropbox/org/rss.org" "Emacs Advent Calendarの投稿 - Qiita" :parse-feed org-feed-parse-rdf-feed) ("Emacsタグが付けられた新着投稿 - Qiita" "http://qiita.com/tags/Emacs/feed.atom" "~/Dropbox/org/rss.org" "Emacsタグが付けられた新着投稿 - Qiita" :parse-feed org-feed-parse-rdf-feed) ("Engadget Japanese" "http://japanese.engadget.com/rss.xml" "~/Dropbox/org/rss.org" "Engadget Japanese" :parse-feed org-feed-parse-rdf-feed) ("Everyday JavaFX" "http://d.hatena.ne.jp/skrb/rss" "~/Dropbox/org/rss.org" "Everyday JavaFX" :parse-feed org-feed-parse-rdf-feed) ("Firefox Developers" "http://blog.mozilla.org/devtools/feed/" "~/Dropbox/org/rss.org" "Firefox Developers" :parse-feed org-feed-parse-rdf-feed) ("fladdict.net blog" "http://www.fladdict.net/blog-jp/atom.xml" "~/Dropbox/org/rss.org" "fladdict.net blog" :parse-feed org-feed-parse-rdf-feed) ("flashrod" "http://d.hatena.ne.jp/flashrod/rss" "~/Dropbox/org/rss.org" "flashrod" :parse-feed org-feed-parse-rdf-feed) ("flashゲーム作成記" "http://flash.polig.daa.jp/index.rdf" "~/Dropbox/org/rss.org" "flashゲーム作成記" :parse-feed org-feed-parse-rdf-feed) ("GAME NEVER SLEEPS" "http://d.hatena.ne.jp/IDA-10/rss" "~/Dropbox/org/rss.org" "GAME NEVER SLEEPS" :parse-feed org-feed-parse-rdf-feed) ("Game System Labs(技術関連掲載)" "http://ritaz.blog64.fc2.com/?xml" "~/Dropbox/org/rss.org" "Game System Labs(技術関連掲載)" :parse-feed org-feed-parse-rdf-feed) ("GIGAZINE" "http://gigazine.net/news/rss_1.0/" "~/Dropbox/org/rss.org" "GIGAZINE" :parse-feed org-feed-parse-rdf-feed) ("gihyo.jp：総合" "http://rss.rssad.jp/rss/gihyo/feed/rss1" "~/Dropbox/org/rss.org" "gihyo.jp：総合" :parse-feed org-feed-parse-rdf-feed) ("Google BloggerブログHacks Tips Tweaks" "http://blogger-customize-tips.blogspot.com/feeds/posts/default" "~/Dropbox/org/rss.org" "Google BloggerブログHacks Tips Tweaks" :parse-feed org-feed-parse-rdf-feed) ("Google Japan Blog" "http://googlejapan.blogspot.com/feeds/posts/default" "~/Dropbox/org/rss.org" "Google Japan Blog" :parse-feed org-feed-parse-rdf-feed) ("Google Japan Developer Relations Blog" "http://googledevjp.blogspot.com/feeds/posts/default" "~/Dropbox/org/rss.org" "Google Japan Developer Relations Blog" :parse-feed org-feed-parse-rdf-feed) ("HOME - [豆魂]" "http://blogwatcher.pi.titech.ac.jp/nandemorss/index.cgi?url=http%3A%2F%2Fwww.mamezou.net%2F&key=body%2Ftable%2Ftr%2Ftd%2Fdiv%2Fdiv%2Ftable%2Ftr%2Fth" "~/Dropbox/org/rss.org" "HOME - [豆魂]" :parse-feed org-feed-parse-rdf-feed) ("IGDA Japan chapter" "http://www.igda.jp/modules/rssj/rss.php" "~/Dropbox/org/rss.org" "IGDA Japan chapter" :parse-feed org-feed-parse-rdf-feed) ("InfoQ.com Japan" "http://www.infoq.com/jp/rss/rss.action?token=YHnPCmvexR9B6VeJnpZkkoGL6LSNCfgk" "~/Dropbox/org/rss.org" "InfoQ.com Japan" :parse-feed org-feed-parse-rdf-feed) ("iPhone'z" "http://iphonesbrog.blogspot.com/feeds/posts/default" "~/Dropbox/org/rss.org" "iPhone'z" :parse-feed org-feed-parse-rdf-feed) ("Island Life" "http://blog.practical-scheme.net/shiro?c=rss" "~/Dropbox/org/rss.org" "Island Life" :parse-feed org-feed-parse-rdf-feed) ("Javaゲーム制作記" "http://javaappletgame.blog34.fc2.com/?xml" "~/Dropbox/org/rss.org" "Javaゲーム制作記" :parse-feed org-feed-parse-rdf-feed) ("Java開発メモブログ" "http://d.hatena.ne.jp/shawshank99/rss" "~/Dropbox/org/rss.org" "Java開発メモブログ" :parse-feed org-feed-parse-rdf-feed) ("[ jogl ] のgooブログ/フィード記事検索結果（スコア1以上）" "http://blog.search.goo.ne.jp/search_goo/result/?MT=jogl&from=web&da=all&dc=10&st=time&tg=all&ts=all&rss=2&fs=all&rm=1" "~/Dropbox/org/rss.org" "[ jogl ] のgooブログ/フィード記事検索結果（スコア1以上）" :parse-feed org-feed-parse-rdf-feed) ("Kahua-web" "http://oss.timedia.co.jp/index.cgi/kahua-web/rss" "~/Dropbox/org/rss.org" "Kahua-web" :parse-feed org-feed-parse-rdf-feed) ("Keep Crazy;shi3zの日記" "http://d.hatena.ne.jp/shi3z/rss" "~/Dropbox/org/rss.org" "Keep Crazy;shi3zの日記" :parse-feed org-feed-parse-rdf-feed) ("Life is beautiful" "http://satoshi.blogs.com/life/rss.xml" "~/Dropbox/org/rss.org" "Life is beautiful" :parse-feed org-feed-parse-rdf-feed) ("[ lisp ] のgooブログ/フィード記事検索結果（スコア1以上）" "http://blog.search.goo.ne.jp/search_goo/result/?MT=lisp&dc=10&st=time&from=rss&ts=all&da=all&tg=all&rss=2&fs=all&rm=1" "~/Dropbox/org/rss.org" "[ lisp ] のgooブログ/フィード記事検索結果（スコア1以上）" :parse-feed org-feed-parse-rdf-feed) ("lucille development blog" "http://lucille.atso-net.jp/blog/?feed=rss2" "~/Dropbox/org/rss.org" "lucille development blog" :parse-feed org-feed-parse-rdf-feed) ("Matzにっき" "http://www.rubyist.net/~matz/index.rdf" "~/Dropbox/org/rss.org" "Matzにっき" :parse-feed org-feed-parse-rdf-feed) ("mieki256's diary" "http://blawat2015.no-ip.com/~mieki256/diary/rss.cgi" "~/Dropbox/org/rss.org" "mieki256's diary" :parse-feed org-feed-parse-rdf-feed) ("mixi Engineers' Blog" "http://alpha.mixi.co.jp/blog/?feed=atom" "~/Dropbox/org/rss.org" "mixi Engineers' Blog" :parse-feed org-feed-parse-rdf-feed) ("MOONGIFT" "http://feeds.feedburner.com/moongift" "~/Dropbox/org/rss.org" "MOONGIFT" :parse-feed org-feed-parse-rdf-feed) ("MOSAIC.WAV" "http://web.mosaicwav.com/index.rdf" "~/Dropbox/org/rss.org" "MOSAIC.WAV" :parse-feed org-feed-parse-rdf-feed) ("Mozilla Japan ブログ" "http://mozilla.jp/blog/feed/" "~/Dropbox/org/rss.org" "Mozilla Japan ブログ" :parse-feed org-feed-parse-rdf-feed) ("MozillaZine.jp" "http://mozillazine.jp/?feed=rss2" "~/Dropbox/org/rss.org" "MozillaZine.jp" :parse-feed org-feed-parse-rdf-feed) ("multiple-value-blog1" "http://multiple-value-blog1.blogspot.com/feeds/posts/default" "~/Dropbox/org/rss.org" "multiple-value-blog1" :parse-feed org-feed-parse-rdf-feed) ("MYCOMジャーナル" "http://journal.mycom.co.jp/haishin/rss/index.rdf" "~/Dropbox/org/rss.org" "MYCOMジャーナル" :parse-feed org-feed-parse-rdf-feed) ("nekopの日記" "http://d.hatena.ne.jp/nekop/rss2" "~/Dropbox/org/rss.org" "nekopの日記" :parse-feed org-feed-parse-rdf-feed) ("Publickey" "http://www.publickey1.jp/atom.xml" "~/Dropbox/org/rss.org" "Publickey" :parse-feed org-feed-parse-rdf-feed) ("(rubikitch loves (Emacs Ruby CUI Books))" "http://d.hatena.ne.jp/rubikitch/rss" "~/Dropbox/org/rss.org" "(rubikitch loves (Emacs Ruby CUI Books))" :parse-feed org-feed-parse-rdf-feed) ("Shibuya.lisp" "http://shibuya.lisp-users.org/feed/" "~/Dropbox/org/rss.org" "Shibuya.lisp" :parse-feed org-feed-parse-rdf-feed) ("Student magazine" "http://d.hatena.ne.jp/Paul3/rss" "~/Dropbox/org/rss.org" "Student magazine" :parse-feed org-feed-parse-rdf-feed) ("take a job-たけのおしごと-" "http://take-a-job.info/feed" "~/Dropbox/org/rss.org" "take a job-たけのおしごと-" :parse-feed org-feed-parse-rdf-feed) ("tech.kayac.com - KAYAC engineers' blog" "http://tech.kayac.com/atom.xml" "~/Dropbox/org/rss.org" "tech.kayac.com - KAYAC engineers' blog" :parse-feed org-feed-parse-rdf-feed) ("TechCrunch Japan" "http://feed.rssad.jp/rss/techcrunch/feed" "~/Dropbox/org/rss.org" "TechCrunch Japan" :parse-feed org-feed-parse-rdf-feed) ("Time Tripper Blog" "http://blogs.yahoo.co.jp/kai_yamamoto/rss.xml" "~/Dropbox/org/rss.org" "Time Tripper Blog" :parse-feed org-feed-parse-rdf-feed) ("TM Life" "http://feeds.feedburner.com/tmlife/feed" "~/Dropbox/org/rss.org" "TM Life" :parse-feed org-feed-parse-rdf-feed) ("tokyo-emacs Google Group" "http://groups.google.co.jp/group/tokyo-emacs/feed/rss_v2_0_msgs.xml" "~/Dropbox/org/rss.org" "tokyo-emacs Google Group" :parse-feed org-feed-parse-rdf-feed) ("torutkの日記" "http://d.hatena.ne.jp/torutk/searchdiary?word=*%5BJava%5D&mode=rss" "~/Dropbox/org/rss.org" "torutkの日記" :parse-feed org-feed-parse-rdf-feed) ("wise9" "http://wise9.jp/feed" "~/Dropbox/org/rss.org" "wise9" :parse-feed org-feed-parse-rdf-feed) ("Yahoo! JAPAN Tech Blog" "http://techblog.yahoo.co.jp/atom.xml" "~/Dropbox/org/rss.org" "Yahoo! JAPAN Tech Blog" :parse-feed org-feed-parse-rdf-feed) ("あどけない話" "http://d.hatena.ne.jp/kazu-yamamoto/rss" "~/Dropbox/org/rss.org" "あどけない話" :parse-feed org-feed-parse-rdf-feed) ("かみやんの技術者日記" "http://d.hatena.ne.jp/kamiyan2/rss" "~/Dropbox/org/rss.org" "かみやんの技術者日記" :parse-feed org-feed-parse-rdf-feed) ("きすねた(ん)" "http://keysnail.g.hatena.ne.jp/mooz/rss2" "~/Dropbox/org/rss.org" "きすねた(ん)" :parse-feed org-feed-parse-rdf-feed) ("ざる魂" "http://mikio.github.com/index.xml" "~/Dropbox/org/rss.org" "ざる魂") ("だらだらゲームプログラミング" "http://ockeysprogramming.blog42.fc2.com/?xml" "~/Dropbox/org/rss.org" "だらだらゲームプログラミング" :parse-feed org-feed-parse-rdf-feed) ("どう書く？org 新着お題" "http://ja.doukaku.org/feeds/challenges/" "~/Dropbox/org/rss.org" "どう書く？org 新着お題" :parse-feed org-feed-parse-rdf-feed) ("はてなブックマーク - 人気エントリー" "http://feedproxy.google.com/hatena/b/hotentry" "~/Dropbox/org/rss.org" "はてなブックマーク - 人気エントリー" :parse-feed org-feed-parse-rdf-feed) ("ひがやすを blog" "http://d.hatena.ne.jp/higayasuo/rss" "~/Dropbox/org/rss.org" "ひがやすを blog" :parse-feed org-feed-parse-rdf-feed) ("ひげぽん OSとか作っちゃうかMona-" "http://d.hatena.ne.jp/higepon/rss2" "~/Dropbox/org/rss.org" "ひげぽん OSとか作っちゃうかMona-" :parse-feed org-feed-parse-rdf-feed) ("ひろゆき日記＠オープンSNS。" "http://hiro.asks.jp/data/rss" "~/Dropbox/org/rss.org" "ひろゆき日記＠オープンSNS。" :parse-feed org-feed-parse-rdf-feed) ("やねうらお−よっちゃんイカを食べながら年収1億円稼げる(かも知れない)仕事術" "http://d.hatena.ne.jp/yaneurao/rss" "~/Dropbox/org/rss.org" "やねうらお−よっちゃんイカを食べながら年収1億円稼げる(かも知れない)仕事術" :parse-feed org-feed-parse-rdf-feed) ("わだばLisperになる" "http://cadr.g.hatena.ne.jp/g000001/rss2" "~/Dropbox/org/rss.org" "わだばLisperになる" :parse-feed org-feed-parse-rdf-feed) ("ウノウラボ Unoh Labs" "http://labs.unoh.net/atom.xml" "~/Dropbox/org/rss.org" "ウノウラボ Unoh Labs" :parse-feed org-feed-parse-rdf-feed) ("ギズモード・ジャパン" "http://www.gizmodo.jp/index.xml" "~/Dropbox/org/rss.org" "ギズモード・ジャパン" :parse-feed org-feed-parse-rdf-feed) ("フランスの日々" "http://mesetudesenfrance.blogspot.com/feeds/posts/default" "~/Dropbox/org/rss.org" "フランスの日々" :parse-feed org-feed-parse-rdf-feed) ("ブックマクロ開発に" "http://d.hatena.ne.jp/takuya_1st/rss2" "~/Dropbox/org/rss.org" "ブックマクロ開発に" :parse-feed org-feed-parse-rdf-feed) ("ライフハッカー［日本版］" "http://www.lifehacker.jp/index.xml" "~/Dropbox/org/rss.org" "ライフハッカー［日本版］" :parse-feed org-feed-parse-rdf-feed) ("作業記録" "http://d.hatena.ne.jp/kataho/rss" "~/Dropbox/org/rss.org" "作業記録" :parse-feed org-feed-parse-rdf-feed) ("八発白中" "http://d.hatena.ne.jp/nitro_idiot/rss" "~/Dropbox/org/rss.org" "八発白中" :parse-feed org-feed-parse-rdf-feed) ("分裂勘違い君劇場" "http://d.hatena.ne.jp/fromdusktildawn/rss" "~/Dropbox/org/rss.org" "分裂勘違い君劇場" :parse-feed org-feed-parse-rdf-feed) ("小野和俊のブログ" "http://blog.livedoor.jp/lalha/index.rdf" "~/Dropbox/org/rss.org" "小野和俊のブログ" :parse-feed org-feed-parse-rdf-feed) ("島国大和のド畜生" "http://dochikushow.blog3.fc2.com/?xml" "~/Dropbox/org/rss.org" "島国大和のド畜生" :parse-feed org-feed-parse-rdf-feed) ("技術日記＠kiwanami" "http://d.hatena.ne.jp/kiwanami/rss" "~/Dropbox/org/rss.org" "技術日記＠kiwanami" :parse-feed org-feed-parse-rdf-feed) ("教えて君.net" "http://www.oshiete-kun.net/atom.xml" "~/Dropbox/org/rss.org" "教えて君.net" :parse-feed org-feed-parse-rdf-feed) ("日刊サイゾー" "http://www.cyzo.com/atom.xml" "~/Dropbox/org/rss.org" "日刊サイゾー" :parse-feed org-feed-parse-rdf-feed) ("日曜プログラマー劇場～ブログ編～" "http://www.noids.tv/atom.xml" "~/Dropbox/org/rss.org" "日曜プログラマー劇場～ブログ編～" :parse-feed org-feed-parse-rdf-feed) ("柴田 芳樹 (Yoshiki Shibata)" "http://yshibata.blog.so-net.ne.jp/index.rdf" "~/Dropbox/org/rss.org" "柴田 芳樹 (Yoshiki Shibata)" :parse-feed org-feed-parse-rdf-feed) ("痛いニュース(ﾉ∀`)" "http://blog.livedoor.jp/dqnplus/index.rdf" "~/Dropbox/org/rss.org" "痛いニュース(ﾉ∀`)" :parse-feed org-feed-parse-rdf-feed) ("矢野勉のはてなブログ" "http://tyano.hatenablog.jp/feed" "~/Dropbox/org/rss.org" "矢野勉のはてなブログ" :parse-feed org-feed-parse-rdf-feed) ("＠IT Java Solutionフォーラム" "http://rss.rssad.jp/rss/itm/fjava/rss.xml" "~/Dropbox/org/rss.org" "＠IT Java Solutionフォーラム" :parse-feed org-feed-parse-rdf-feed) ("＠IT自分戦略研究所" "http://jibun.atmarkit.co.jp/rss/rss091.xml" "~/Dropbox/org/rss.org" "＠IT自分戦略研究所" :parse-feed org-feed-parse-rdf-feed))
      )

(add-hook 'write-file-hooks
	  (function (lambda ()
                      (if (eq buffer-file-coding-system 'undecided-unix)
                          (setq buffer-file-coding-system 'utf-8))
                      nil)))

;;-----------------------------------------------------------------
;; Mobile
;;-----------------------------------------------------------------
;; Dropboxで同期するMobileOrgフォルダへのパスを設定
(setq org-mobile-directory "~/Dropbox/MobileOrg")

;; MobileOrg側で新しく作成したノートを保存するファイルの名前を指定する。
(setq org-mobile-inbox-for-pull "~/Dropbox/org/mobile.org")

;; 同期するファイルを指定する。
(setq org-agenda-files (quote ("~/Dropbox/org/rss.org"
                               "~/Dropbox/org/index.org"
                               "~/Dropbox/org/account.org")))

(provide 'mikio-org)
