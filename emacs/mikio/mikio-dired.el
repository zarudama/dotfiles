(require 'mikio-util)

(require 'dired)
(require 'dired-x)
;;-----------------------------------------------------------------
;; ディレクトリ内のファイル名を自由自在に編集する。
;;-----------------------------------------------------------------
(define-key dired-mode-map "r" 'wdired-change-to-wdired-mode)

;; 2画面ファイラ化。
(setq dired-dwim-target t)

(define-key dired-mode-map (kbd "j") 'dired-next-line)
(define-key dired-mode-map (kbd "k") 'dired-previous-line)
(define-key dired-mode-map (kbd "h") 'dired-up-directory)
(define-key dired-mode-map (kbd "C-t") 'switch-to-last-buffer-or-other-window)
;;(define-key dired-mode-map (kbd "S") 'eshell-cd-default-directory)

;;-----------------------------------------------------------------
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


(provide 'mikio-dired)
