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
;;(setq tabbar-auto-scroll-flag nil)
(setq tabbar-auto-scroll-flag t)

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

;;-----------------------------------------------------------------

;; バッファをフィルタする
;;(setq tabbar-buffer-list-function 'tabbar-buffer-list) ;; デフォルト関数
(setq my-tabbar-include-buffer-regex (format ".*%s.*" (regexp-opt '("*w3m*" "*eshell*"))))
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
(defun my-tabbar-buffer-groups ()
  (let ((group1 (tabbar-buffer-groups))
        (group2 (cond
                 ((memq major-mode
                        '(eshell-mode ;;まとめたい major-moode を羅列
                          ))
                  "Eshell") ;; グループ名
                 (t nil))))
    (if group2 (list group2) group1)))

;;(tabbar-buffer-groups)
;;(setq tabbar-buffer-groups-function 'tabbar-buffer-groups) ; default
(setq tabbar-buffer-groups-function 'my-tabbar-buffer-groups)
;;(setq tabbar-buffer-groups-function nil);;グループ化しない

;;-----------------------------------------------------------------

(provide 'mikio-tabbar)
