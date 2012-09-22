(require 'mikio-util)

(require 'org-install)
;;;(require 'org-babel-init)
;;(require 'org-babel-perl)
;;(require 'ob-clojure)
;;(require 'ob-java)

;;(org-babel-load-library-of-babel)

(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
(global-set-key (kbd "C-c l") 'org-store-link)
(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c b") 'org-iswitchb)
(global-set-key (kbd "C-c c") 'org-capture)
(global-set-key (kbd "C-c r") 'org-remember)

;; --------------------------------------
;; from rubikitch mail
;; --------------------------------------
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
;; --------------------------------------


(setq org-agenda-custom-commands
  '(("x" "Unscheduled TODO" tags-todo "-SCHEDULED>=\"<now>\"" nil)))
(setq org-stuck-projects
  '("+PROJECT/-DONE-SOMEDAY" ("TODO" "WAIT")))

;; (setq org-agenda-time-grid
;;   '((daily today require-timed)
;;     "----------------"
;;     (900 930 1000 1030 1100 1130 1200 1230
;;          1300 1330 1400 1430 1500 1530 1600 1630 1700 1730 1800 1830
;;          1900 1930 2000 2030 2100 2130 2200 2230 2300 2330 2400 2430)))
(setq org-agenda-time-grid
  '((daily today require-timed)
    "----------------"
    (900 930 1000 1030 1100 1130 1200 1230
         1300 1330 1400 1430 1500 1530 1600 1630 1700 1730 1800 1830
         1900 1930 2000 2030 2100 2130 2200 2230 2300 2330 )))


(add-hook 'org-mode-hook 'turn-on-font-lock)
;; 見出しの余分な*を消す
(setq org-hide-leading-stars t)

(setq org-directory "~/Dropbox/org/")
(setq org-agenda-files '("~/Dropbox/org/index.org" "~/docs/office.org" "~/Dropbox/org/blog.org"))


(setq org-agenda-include-diary t)
;(setq org-agenda-include-diary nil)

;; auto-complete
(add-to-list 'ac-modes 'org-mode)
;; css定義を分離する
;;(setq org-export-htmlize-output-type 'css)

;; t:自動的にTODO項目にdoneの印をつける
(setq org-log-done t)

(org-remember-insinuate)
(setq org-default-notes-file (expand-file-name "index.org" org-directory))

(setq org-remember-templates
      '(("Note" ?n "** %?\n   %i\n   %a\n   %t" nil "Inbox")
        ("Todo" ?t "** TODO %?\n   %i\n   %a\n   %t" nil "Inbox")))

(setq org-capture-templates
 '(("o" "Office Todo" entry (file+headline "~/docs/office.org" "Inbox")
        "* TODO %?\n  %i\n  %a\n   %t")
   ("t" "Todo" entry (file+headline "~/Dropbox/org/index.org" "Inbox")
        "* TODO %?\n  %i\n  %a\n   %t")))

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

;; (custom-set-variables
;;  '(org-export-language-setup (quote (("ja" "作者" "日付" "目次" "脚注"))))
;;  '(org-export-with-toc t)
;;  )

;; キーバインド
;; (eval-after-load "org"
;;   '(progn
;;      (smartrep-define-key
;;       org-mode-map "C-c"
;;       '(("C-n" . (lambda () (outline-next-visible-heading 1)))
;;         ("C-p" . (lambda () (outline-previous-visible-heading 1)))))))

;;-----------------------------------------------------------------
;; - C-RET で現在の階層の見出し
;; - C-u C-RET で現在より1階層深い見出し
;; - C-u C-u C-RET で現在より1階層浅い見出し
;;-----------------------------------------------------------------
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

(provide 'mikio-org)
