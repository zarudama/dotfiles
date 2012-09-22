(require 'mikio-util)
(require 'tabbar)

;;-----------------------------------------------------------------
;; tabbar
;; (install-elisp "http://www.emacswiki.org/emacs/download/tabbar.el")
;;-----------------------------------------------------------------

;; これがないと、cui版でエラーになってしまう
(setq mouse-wheel-mode nil)

(tabbar-mode 1)

;;タブ上でマウスホイール操作無効
(tabbar-mwheel-mode -1)

;; タブがはみ出た時はスクロール(初期値t・nilで省略表示)
;; 横方向にスクロールする。
(setq tabbar-auto-scroll-flag nil)

;; バッファをフィルタする
;;(setq tabbar-buffer-list-function 'tabbar-buffer-list) ;; デフォルト関数
(setq my-tabbar-include-buffer-regex (regexp-opt '("*w3m*" "*eshell*")))
(setq my-tabbar-exclude-buffer-regex (format "%s.*" (regexp-opt '(" *" "*"))))
(setq tabbar-buffer-list-function
      (lambda ()
        (remove-if
         (lambda (buffer)
           (and (not (string-match my-tabbar-include-buffer-regex (buffer-name buffer)))
                (string-match my-tabbar-exclude-buffer-regex (buffer-name buffer)))
           )
         (buffer-list))))

;; バッファをグループ化する
;; (defun tabbar-buffer-groups ()
;;       "Return the list of group names the current buffer belongs to.
;; Return a list of one element based on major mode."
;;       (list
;;        (cond
;;         ((or (get-buffer-process (current-buffer))
;;              ;; Check if the major mode derives from `comint-mode' or
;;              ;; `compilation-mode'.
;;              (tabbar-buffer-mode-derived-p
;;               major-mode '(comint-mode compilation-mode)))
;;          "Process"
;;          )
;;         ((member (buffer-name)
;;                  '("*scratch*" "*Messages*"))
;;          "Common"
;;          )
;;         ((eq major-mode 'dired-mode)
;;          "Dired"
;;          )
;;         ((memq major-mode
;;                '(help-mode apropos-mode Info-mode Man-mode))
;;          "Help"
;;          )
;;         ((memq major-mode
;;                '(rmail-mode
;;                  rmail-edit-mode vm-summary-mode vm-mode mail-mode
;;                  mh-letter-mode mh-show-mode mh-folder-mode
;;                  gnus-summary-mode message-mode gnus-group-mode
;;                  gnus-article-mode score-mode gnus-browse-killed-mode
;;                  mew-message-mode mew-summary-mode ;; mikio
;;                  ))
;;          "Mail"
;;          )
;;         ((memq major-mode
;;                '(navi2ch-list-mode
;;                  navi2ch-board-mode
;;                  navi2ch-article-mode
;;                  ))
;;          "Navi2ch"
;;          )

;;         ((memq major-mode
;;                '(newsticker-treeview-list-mode
;;                  newsticker-treeview-item-mode
;;                  ))
;;          "NewsTicker"
;;          )

;;         (t
;;          ;; Return `mode-name' if not blank, `major-mode' otherwise.
;;          (if (and (stringp mode-name)
;;                   ;; Take care of preserving the match-data because this
;;                   ;; function is called when updating the header line.
;;                   (save-match-data (string-match "[^ ]" mode-name)))
;;              mode-name
;;            (symbol-name major-mode))
;;          ))))

(setq tabbar-buffer-groups-function 'tabbar-buffer-groups)
;;(setq tabbar-buffer-groups-function nil);;グループ化しない

;;左に表示されるボタンを無効化
(dolist (btn '(tabbar-buffer-home-button
               tabbar-scroll-left-button
               tabbar-scroll-right-button))
  (set btn (cons (cons "" nil)
                 (cons "" nil))))

;;タブの仕切りの幅
(setq tabbar-separator '(0.7))

(set-face-attribute
 'tabbar-default nil
 :background "black"
 :height 1.0)
(set-face-attribute
 'tabbar-unselected nil
 :background "white"
 :foreground "black"
 :box nil)
(set-face-attribute
 'tabbar-selected nil
 :background "yellow"
 :foreground "black"
 :box nil)
(set-face-attribute
 'tabbar-button nil
 :box nil)
(set-face-attribute
 'tabbar-separator nil
 :height 1.0)

(when (require 'smartrep nil t)
  (defvar ctl-z-map (make-keymap))
  (define-key global-map (kbd "C-z") ctl-z-map)
  (smartrep-define-key global-map (kbd "C-z")
    '(
      ("n" . 'tabbar-forward-tab)
      ("p" . 'tabbar-backward-tab)

      ("P" . (lambda () (progn (delete-other-windows) (tabbar-forward-group))))
      ("N" . (lambda () (progn (delete-other-windows) (tabbar-backward-group))))
      ("C-z" . 'suspend-emacs)
      ))
  )

(provide 'mikio-tabbar)
