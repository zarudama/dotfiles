;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 必要最低限の設定たち
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;-----------------------------------------------------------------
;; keybind
;;-----------------------------------------------------------------

(define-key global-map (kbd "C-h") 'delete-backward-char)
(define-key global-map (kbd "M-C-h") 'backward-kill-word)
(define-key global-map (kbd "C-j") nil)

(global-set-key (kbd "C-c a")   'align)
(global-set-key (kbd "C-c M-a") 'align-regexp)
;;(global-set-key (kbd "C-h")     'backward-delete-char)
;;(global-set-key (kbd "C-c d")   'delete-indentation)
;;(global-set-key (kbd "C-S-i")   'indent-region)
;;(global-set-key (kbd "C-m")     'newline-and-indent)
;;(global-set-key (kbd "C-t")     'next-multiframe-window)
;;(global-set-key (kbd "M-<RET>") 'ns-toggle-fullscreen)
(global-set-key (kbd "C-S-t")   'previous-multiframe-window)
(global-set-key (kbd "C-m")  'newline-and-indent)
(define-key isearch-mode-map (kbd "C-h") 'isearch-del-char)
;;(define-key isearch-mode-map (kbd "C-q") 'isearch-exit)
(global-set-key (kbd "M-P") 'backward-paragraph)
(global-set-key (kbd "M-N") 'forward-paragraph)

;; カレントバッファをすぐに削除する
(global-set-key (kbd "C-x k") '(lambda () (interactive) (kill-buffer (buffer-name (current-buffer)))))

;; 別ウィンドウの逆スクロール
(global-set-key (kbd "C-M-y") 'scroll-other-window-down)

(global-set-key (kbd "C-x C-d") 'dired)

(defvar mikio-map (make-keymap))
(define-key global-map (kbd "C-z") mikio-map)
(global-set-key (kbd "C-z C-r") 'recenter-top-bottom)
(global-set-key (kbd "C-z r") 'query-replace)
(global-set-key (kbd "C-z R") 'query-replace-regexp)
(global-set-key (kbd "C-z C-z") 'suspend-emacs)

;; (require 'misc)
;; (global-set-key "\M-f" 'forward-to-word)
;; (global-set-key "\M-b" 'backward-to-word)

(define-key global-map (kbd"C-c f")
  (lambda ()
    (interactive)
    (delete-other-windows)
    (split-window-right)
    (follow-mode)
    ))

;;-----------------------------------------------------------------
;; 基本設定
;;-----------------------------------------------------------------
;;(global-hl-line-mode 1)
;;(set-face-background 'hl-line "darkolivegreen")
(savehist-mode 1)
(setq-default save-place t)
(show-paren-mode 1)
(line-number-mode 1)
(setq linum-format "%3d ")
(column-number-mode 1)
(transient-mark-mode 1)
(setq gc-cons-threshold (* 10 gc-cons-threshold))
(setq message-log-max 10000)
(setq enable-recursive-minibuffers t)
(setq use-dialog-box nil)
(defalias 'message-box 'message)
(setq history-length 1000)
(setq echo-keystrokes 0.1)
(setq large-file-warning-threshold (* 25 1024 1024))
(defadvice abort-recursive-edit (before minibuffer-save activate)
  (when (eq (selected-window) (active-minibuffer-window))
	(add-to-history minibuffer-history-variable (minibuffer-contents))))
(defalias 'yes-or-no-p 'y-or-n-p)

(setq scroll-conservatively 1)
(global-font-lock-mode t)

(display-time)
(setq display-time-day-and-date t)

;; 最近開いたファイルの保存数
(setq recentf-max-saved-items 512)

;;;; C-/が効かない端末対策
;;(define-key key-translation-map (kbd "C-_") (kbd "C-/"))

(set-background-color "Black")
(set-foreground-color "LightGray")
(set-cursor-color "Gray")

(cond (window-system
       (setq initial-frame-alist '((width . 80) (height . 30)))
       ;;(set-background-color "RoyalBlue4")

       ;; スクロールバーは右に
       (set-scroll-bar-mode 'right)

       ;; ツールバーは出さない
       (tool-bar-mode 0)

       (scroll-bar-mode 0)

       ;; メニューバーは出さない
       ;;(menu-bar-mode 0)
       ;;(menu-bar-mode 1)

       ;; クリップボードを有効
       (setq x-select-enable-clipboard t)
       ))

;; ファイル名補完時の大文字小文字は無視
(setq read-file-name-completion-ignore-case t)

;; バッファ補完時の大文字小文字は無視
(setq read-buffer-completion-ignore-case t)

;; ミニバッファからミニバッファを開けるように
(setq enable-recurslve-m1nﾔbuffers t)


;;;; 以下anythinggがない時用
;;;; C-xbをisswitchbにする
;;(iswitchb-mode 1)
;;
;;;; C-xC-bをibijfferにする
;;(global-set-key (kbd "C-x C-b") 'ibuffer)

;; lisp再帰呼び出し？などのエラー防止。
;; - http://d.hatena.ne.jp/a666666/20100221/1266695355
(setq max-lisp-eval-depth 5000)
(setq max-specpdl-size 12000)

;; tab4, no tabcode
(setq default-tab-width 4)
(setq tab-width 4)
(setq-default indent-tabs-mode nil)
(setq indent-tabs-mode nil)

;; no beep, no bell
(setq visible-bell t)
(setq ring-bell-function 'ignore)

;; backup settings
(setq make-backup-files nil)
(setq auto-save-default nil)

;; search settings
(setq-default case-fold-search t)
;; 補完時の大文字小文字は無視
(setq completion-ignore-case t)
(put 'upcase-region 'disabled nil)

;; save時に無駄な行末の空白を削除する
;;(add-hook 'before-save-hook 'delete-trailing-whitespace)

;;-----------------------------------------------------------------
;; buffer-list
;;-----------------------------------------------------------------
;; 標準のバッファリストだとカーソルが移動しないので
;; カーソルが移動するコマンドを定義
(global-set-key (kbd "C-x C-b")   'buffer-menu)
(define-key Buffer-menu-mode-map (kbd "j") 'next-line)
(define-key Buffer-menu-mode-map (kbd "k") 'previous-line)

;;-----------------------------------------------------------------
;; バッファ切り替えを強化する
;;-----------------------------------------------------------------
(iswitchb-mode t)
;; バッファ読み取り関数をiswitchbにする
(setq read-buffer-function 'iswitchb-read-buffer)
;; 部分文字列の代わりに正規表現を使う場合はtにする
(setq iswitchb-regexp nil)
;; 新しいバッファを作成するときにいちいち聞いてこない
(setq iswitchb-propmt-newbuffer nil)

;;;-----------------------------------------------------------------
;;; ファイル名がかぶった場合にバッファ名をわかりやすくする
;;;-----------------------------------------------------------------
(when (require 'uniquify nil t)
  ;; filename <dir>形式のバッファ名にする。
  (setq uniquify-buffer-name-style 'post-forward-angle-brackets)
  ;; *で囲まれたバッファ名は対象外にする
  (setq uniquify-ignore-buffers-re "*[^*]+*"))


;;-----------------------------------------------------------------
;; 日本語設定
;;-----------------------------------------------------------------
(set-language-environment "Japanese")
(cond
 ((eq window-system 'w32)
  (prefer-coding-system 'utf-8)
  (setq file-name-coding-system 'sjis)
  (setq locale-coding-system 'sjis)
  ;;(process-coding-system 'sjis)
  )
 (t
  (prefer-coding-system 'utf-8)
  (setq file-name-coding-system 'utf-8)
  (setq locale-coding-system 'utf-8)))


;; 設定ファイルをよしなに。
(require 'generic-x)


(provide 'mikio-basic)
