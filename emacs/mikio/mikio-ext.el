(require 'mikio-util)
(require 'cl)

;;;-----------------------------------------------------------------
;;; 設定の少ない拡張(requireして終了なやつとか)
;;;-----------------------------------------------------------------

;;;-----------------------------------------------------------------
;;; カーソル位置を戻す
;;;-----------------------------------------------------------------
;; (when (require 'point-undo nil t)
;;   (define-key global-map (kbd "<f7>") 'point-undo)
;;   (define-key global-map (kbd "S-<f7>") 'point-undo))

;;;-----------------------------------------------------------------
;;; 最後の変更箇所にジャンプする
;;;-----------------------------------------------------------------
;; (when (require 'goto-chg nil t)
;;   (define-key global-map (kbd "<f8>") 'goto-last-change)
;;   (define-key global-map (kbd "S-<f8>") 'goto-last-change-reverse))

;;;-----------------------------------------------------------------
;;; 略語展開・補完をおこなうコマンドをまとめる
;;;-----------------------------------------------------------------
;; (setq hippie-expand-try-functions-list
;;       '(try-complete-file-name-partially ;ファイル名の一部
;;         try-complete-file-name           ;ファイル名全体
;;         try-expand-all-abbrevs          ;静的略語展開
;;         try-expand-dabbrev              ;動的略語展開(カレントバッファ)
;;         try-expand-dabbrev-all-buffers  ;動的略語展開(全バッファ)
;;         try-expand-dabbrev-from-kill    ;動的略語展開(killリング)
;;         try-complete-lisp-symbol-partially ;Lispシンボル名の一部
;;         try-complete-lisp-symbol           ;Lispシンボル名の全体
;;         ))
;; (define-key global-map (kbd "M-/") 'hippie-expand)

;;;-----------------------------------------------------------------
;;; 使い捨てのファイルを開く
;;;-----------------------------------------------------------------
;; (require 'open-junk-file)
;; (setq open-junk-file-format (mikio/elisp-home  "junk/%Y-%m-%d-%H%M%S"))
;; (global-set-key (kbd "C-x C-j") 'open-junk-file)

;;;-----------------------------------------------------------------
;;; ClipBoard
;;; http://www.eaflux.com/cygwin/tips/
;;;-----------------------------------------------------------------
;;(defun cb-copy ()
;;  (interactive)
;;  ;;(let ((coding-system-for-write 'shift_jis-dos))
;;  (let ((coding-system-for-write 'utf-8))
;;    (shell-command-on-region (region-beginning) (region-end) "cat > /dev/clipboard" nil nil nil))
;;  (message ""))
;;(defun cb-paste ()
;;  (interactive)
;;  ;;(let ((coding-system-for-read 'shift_jis-dos))
;;  (let ((coding-system-for-read 'utf-8))
;;    (goto-char
;;     (+ (point) (cadr (insert-file-contents "/dev/clipboard"))))))
;;(global-set-key (kbd "C-c w") 'cb-copy)
;;(global-set-key (kbd "C-c y") 'cb-paste)

;;;-----------------------------------------------------------------
;;; grep-edit: grep から直接置換
;;; (install-elisp "http://www.emacswiki.org/emacs/download/grep-edit.el")
;;;-----------------------------------------------------------------
;; (require 'grep-edit nil t)

;;-----------------------------------------------------------------
;; ブロックを折り畳む
;;(install-elisp "http://www.dur.ac.uk/p.j.heslin/Software/Emacs/Download/fold-dwim.el")
;;-----------------------------------------------------------------
;; (require 'hideshow)
;; (require 'fold-dwim)

;;-----------------------------------------------------------------
;; ファイル作成時にテンプレートを挿入する
;;-----------------------------------------------------------------
;;(auto-insert-mode)
;;;; 最後の'/'は必須
;;(setq auto-insert-directory (format "%s/insert" my-elisp-dir))
;;(define-auto-insert "\\.java$" "java-template.java")

;;;-----------------------------------------------------------------
;;; emacsclient
;;;-----------------------------------------------------------------
;;(server-start)
;;(global-set-key (kbd "C-x C-c") 'server-edit)
;;(defalias 'exit 'save-buffers-kill-emacs)

;;-----------------------------------------------------------------
;; emacsのなかでもsudoを使う
;; M-x install-elisp-from-emacswiki sudo-ext.el を実行してください。
;;-----------------------------------------------------------------
(require 'sudo-ext)

;;-----------------------------------------------------------------
;; hiwin.el
;; (install-elisp "http://github.com/tomoya/hiwin-mode/raw/master/hiwin.el")
;; M-x hiwin-mode
;;-----------------------------------------------------------------
;; gui版のみ有効にする。
;; (cond (window-system
;;        (require 'hiwin)
;;        (hiwin-mode));; 起動時から有効にしたい場合
;;       )

;;-----------------------------------------------------------------
;; ファイラ
;; (install-elisp "http://www.emacswiki.org/emacs/download/sunrise-commander.el")
;;-----------------------------------------------------------------
;;(require 'sunrise-commander)

;;-----------------------------------------------------------------
;; direx
;; (install-elisp "https://raw.github.com/m2ym/direx-el/master/direx.el")
;;-----------------------------------------------------------------
;; (require 'direx)
;; (global-set-key (kbd "C-c j") 'direx:jump-to-directory-other-window)


(provide 'mikio-ext)
