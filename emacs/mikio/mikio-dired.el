(require 'mikio-util)

(require 'dired)
(require 'dired-x)

;; 2画面ファイラ化。
;;(setq dired-dwim-target t)

(define-key dired-mode-map (kbd "j") 'dired-next-line)
(define-key dired-mode-map (kbd "k") 'dired-previous-line)
(define-key dired-mode-map (kbd "h") 'dired-up-directory)
(define-key dired-mode-map (kbd "C-t") 'switch-to-last-buffer-or-other-window)
;;(define-key dired-mode-map (kbd "S") 'eshell-cd-default-directory)

;; ディレクトリ内のファイル名を自由自在に編集する。
(define-key dired-mode-map "r" 'wdired-change-to-wdired-mode)

;; ディレクトリバッファの抑制
(require 'joseph-single-dired)
(eval-after-load 'dired '(require 'joseph-single-dired))

;-----------------------------------------------------------------
;; diredでWindowsに関連付けられたアプリを起動する
;; http://k4zmblog.dtiblog.com/blog-entry-153.html
;;-----------------------------------------------------------------
(defun uenox-dired-winstart ()
  "Type '[uenox-dired-winstart]': win-start the current line's file."
  (interactive)
  (if (eq major-mode 'dired-mode)
      (let ((fname (dired-get-filename)))
        (w32-shell-execute "open" fname)
        (message "win-started %s" fname))))

;; dired のキー割り当て追加
(if (eq window-system 'w32)
    (add-hook 'dired-mode-hook
               (lambda ()
                 (define-key dired-mode-map "z" 'uenox-dired-winstart))))


;;-----------------------------------------------------------------
;; diredからeshell起動
;;-----------------------------------------------------------------
(defun dired-start-eshell (arg)
 "diredで選択されたファイル名がペーストされた状態で、eshellを起動する。"
 (interactive "P")
 (let ((files (mapconcat 'shell-quote-argument
                         (dired-get-marked-files (not arg))
                         " ")))
   (if (fboundp 'shell-pop) (shell-pop) (eshell t))
   (save-excursion (insert " " files))))
(define-key dired-mode-map [remap dired-do-shell-command] 'dired-start-eshell)

;;-----------------------------------------------------------------
;; dired で複数のファイルの文字コードを一括変換
;; - http://d.hatena.ne.jp/gan2/20070705/1183640419
;;-----------------------------------------------------------------

;;; dired を使って、一気にファイルの coding system (漢字) を変換する
;; m でマークして T で一括変換
(require 'dired-aux)
(add-hook 'dired-mode-hook
          (lambda ()
            (define-key (current-local-map) "T"
              'dired-do-convert-coding-system)))

(defvar dired-default-file-coding-system nil
  "*Default coding system for converting file (s).")

(defvar dired-file-coding-system 'no-conversion)

(defun dired-convert-coding-system ()
  (let ((file (dired-get-filename))
        (coding-system-for-write dired-file-coding-system)
        failure)
    (condition-case err
        (with-temp-buffer
          (insert-file file)
          (write-region (point-min) (point-max) file))
      (error (setq failure err)))
    (if (not failure)
        nil
      (dired-log "convert coding system error for %s:\n%s\n" file failure)
      (dired-make-relative file))))

(defun dired-do-convert-coding-system (coding-system &optional arg)
  "Convert file (s) in specified coding system."
  (interactive
   (list (let ((default (or dired-default-file-coding-system
                            buffer-file-coding-system)))
           (read-coding-system
            (format "Coding system for converting file (s) (default, %s): "
                    default)
            default))
         current-prefix-arg))
  (check-coding-system coding-system)
  (setq dired-file-coding-system coding-system)
  (dired-map-over-marks-check
   (function dired-convert-coding-system) arg 'convert-coding-system t))


(provide 'mikio-dired)
