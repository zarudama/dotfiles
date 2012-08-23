;;-----------------------------------------------------------------
;; load-pathの設定
;;-----------------------------------------------------------------

(defun mikio/elisp-home (path)
  "elispのパス文字列を生成する。
ex. (mikio/elisp-home 'hoge'  => 'c:/Users/mikio/Dropbox/dotfiles/emacs/hoge'"
  (format "%s/%s" my-elisp-dir path)
  )

(defun mikio/site-lisp-home (path)
  "site-lispのパス文字列を生成する。
ex. (mikio/elisp-home 'hoge') => 'c:/Users/mikio/Dropbox/dotfiles/emacs/hoge'"
       (format "%s/%s" my-site-lisp-dir path))

(defun mikio/add-to-load-path (&rest paths)
  (let (path)
    (dolist (path paths paths)
;;      (let ((default-directory (expand-file-name (concat user-emacs-directory path))))
      (let ((default-directory (format "%s/%s" my-elisp-dir path)))
          (add-to-list 'load-path default-directory)
          (if (fboundp 'normal-top-level-add-subdirs-to-load-path)
              (normal-top-level-add-subdirs-to-load-path))))))

;;-----------------------------------------------------------------
;; 画面分割を抑止する
;; http://d.hatena.ne.jp/rubikitch/20111211/smalldisplay
;;-----------------------------------------------------------------
(setq pop-up-windows t)

;;なお、popwin.elなどでdisplay-buffer-functionを
;;設定している場合は一時的にnilにしてください。
;;(setq display-buffer-function nil)

;; この状態でC-x 1で1ウィンドウにして
;; 以下の式を評価してください。
;; (display-buffer (other-buffer))

;; --------------------------------------------------------------
;; ひとつ前のバッファに戻る
;;   一番安直な実装はこうなります。
;; (defun switch-to-last-buffer ()
;;   (interactive)
;;   (switch-to-buffer (other-buffer)))
;; (global-set-key (kbd "C-t") 'switch-to-last-buffer)

;; --------------------------------------------------------------
;; ひとつ前のバッファに戻る
(defun switch-to-last-buffer-or-other-window ()
  (interactive)
  (if (one-window-p t)
      (switch-to-last-buffer)
    (other-window 1)))

;; --------------------------------------------------------------
;;; last-buffer
(defvar last-buffer-saved nil)
;; last-bufferで選択しないバッファを設定
(defvar last-buffer-exclude-name-regexp
  (rx (or "*mplayer*" "*Completions*" "*Org Export/Publishing Help*"
          (regexp "^ "))))
(defun record-last-buffer ()
  (when (and (one-window-p)
             (not (eq (window-buffer) (car last-buffer-saved)))
             (not (string-match last-buffer-exclude-name-regexp
                                (buffer-name (window-buffer)))))
    (setq last-buffer-saved
          (cons (window-buffer) (car last-buffer-saved)))))
(add-hook 'window-configuration-change-hook 'record-last-buffer)
(defun switch-to-last-buffer ()
  (interactive)
  (condition-case nil
      (switch-to-buffer (cdr last-buffer-saved))
    (error (switch-to-buffer (other-buffer)))))



(define-key global-map (kbd "C-t") 'switch-to-last-buffer-or-other-window)

(provide 'mikio-util)
