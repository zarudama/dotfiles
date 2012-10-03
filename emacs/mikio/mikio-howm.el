(require 'mikio-util)

(add-to-list 'load-path (mikio/site-lisp-directory "howm-1.4.0"))
       
(setq howm-menu-lang 'ja)
(global-set-key "\C-c,," 'howm-menu)
(autoload 'howm-menu "howm-mode" "Hitori Otegaru Wiki Modoki" t)


(if (equal mikio/office-type :office)
    (setq mikio/howm-dirctory "~/docs")
  (setq mikio/howm-dirctory "~/Dropbox")) 

(setq howm-directory (mikio/org-directory))
(setq howm-history-file (format "%s/.howm-history" howm-directory))
(setq howm-keyword-file (format "%s/.howm-keys" howm-directory))

;; 1日1ファイルに。
;; メモ置き場/年/月/年_月_日.howm に
(setq howm-file-name-format "%Y/%m/%Y_%m_%d.org")

;; タイトル(メモ区切り)
;; "=" => "*" org-modeに併せる。
(setq howm-view-title-header "# =")

;; 新しくメモを作る時は、先頭の「*タイトル」だけ挿入。
(setq howm-template "# =%title%cursor\n\n")

(add-hook 'howm-after-save-hook
          (function (lambda ()
                      ;; 内容が空の場合はファイルを削除する。
                      (if (= (point-min) (point-max))
                          (delete-file (buffer-file-name (current-buffer)))))))

;; 完了済みのtodoを未完了に戻す。
;; (fset 'howm-revive-todo
;;       (lambda (&optional arg) "Keyboard macro." (interactive "p") (kmacro-exec-ring-item (quote ([1 19 46 13 6 23 19 58 13 backspace 2 2] 0 "%d")) arg)))

(add-to-list 'auto-mode-alist '("~/Dropbox/org/.+\\.org$" . howm-mode))
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))

(provide 'mikio-howm)
