(require 'mikio-util)
;;; anything-*.elは、依存している拡張がある場合は、そちらの定義ファイルに記述する。
;;; たとえば、anything-c-moccurは、moccurに依存しているので、mikio-moccur.elに記述している。

(require 'cl)
(require 'anything-startup)


;;-----------------------------------------------------------------
;; キーバインド
;;-----------------------------------------------------------------
(define-key anything-map (kbd "C-h") 'delete-backward-char)
(define-key anything-map (kbd "M-C-h") 'backward-kill-word)

;; 過去のkillリングの内容を表示する。
(define-key global-map (kbd "M-y") 'anything-show-kill-ring)

;;-----------------------------------------------------------------
;; anything-document
;;-----------------------------------------------------------------
;; manやinfoを調べるコマンドを作成してみる
;; anything-for-document 用のソースを定義
(setq anything-for-document-sources
      (list anything-c-source-man-pages
            anything-c-source-info-cl
            anything-c-source-info-pages
            anything-c-source-info-elisp
            anything-c-source-apropos-emacs-commands
            anything-c-source-apropos-emacs-functions
            anything-c-source-apropos-emacs-variables))
;; anything-for-document コマンドを作成
(defun anything-for-document ()
  "Preconfigured `anything' for anything-for-document."
  (interactive)
  (anything anything-for-document-sources (thing-at-point 'symbol) nil nil nil "*anything for document*"))

;;-----------------------------------------------------------------
;; anything-project
;;-----------------------------------------------------------------
(require 'anything-project)
(setq ap:project-files-filters
      (list
       (lambda (files)
         (remove-if 'file-directory-p files)
         (remove-if '(lambda (file) (string-match-p "~$" file)) files))))

;; (ap:add-project
;;  :name 'java
;;  :look-for '("build.xml")
;; ;; :include-regexp '("\\.java$" "\\.jsp$" "\\.css$" "\\.js$") ;or
;;  :exclude-regexp '("\\.class$" "/target" "/tmp")
;;  )

(setq ap:global-exclude-regexp '("\\.class$" "/target" "/tmp"))
;; (ap:add-project
;; :name 'perl
;; :look-for '("Makefile.PL" "Build.PL") ; or
;; :include-regexp '("\\.pm$" "\\.t$" "\\.pl$" "\\.PL$") ;or
;; )


;;-----------------------------------------------------------------
;; anything hatebu
;; (install-elisp "https://raw.github.com/wakaran/anything-hatena-bookmark/master/anything-hatena-bookmark.el")
;; (install-elisp "http://stuff.mit.edu/afs/sipb/contrib/emacs/packages/flim-1.14.7/sha1-el.el")
;;-----------------------------------------------------------------
(require 'sha1-el) ;; 本来必要ないが、emacs24では必要っぽい。
(require 'anything-hatena-bookmark)
(setq anything-hatena-bookmark-samewindow t)

;;-----------------------------------------------------------------
;; 起動コマンド
;;-----------------------------------------------------------------
(global-set-key (kbd "M-x") 'anything-M-x)
(global-set-key (kbd "C-x b") 'anything-buffers-list)
(global-set-key (kbd "C-x a r") 'anything-recentf)
(global-set-key (kbd "C-x a h b") 'anything-hatena-bookmark)
(global-set-key (kbd "C-x a b") 'anything-bookmarks)
(global-set-key (kbd "C-x a i") 'anything-imenu)
(global-set-key (kbd "C-x a g") 'anything-google-suggest)
(global-set-key (kbd "C-x a p") 'anything-project)
(global-set-key (kbd "C-x a d") 'anything-for-document)

(provide 'mikio-anything)
