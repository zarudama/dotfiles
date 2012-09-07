(require 'mikio-util)

;;-----------------------------------------------------------------
;; slime
;;-----------------------------------------------------------------
(when (require 'nrepl nil t)
  (require 'clojure-mode)

  ;; SLIMEからの入力をUTF-8に設定
  ;; windowsの場合、下記をlein.batの先頭に記述
  ;; set JAVA_OPTS=-Dswank.encoding=utf-8-unix

 ;;  ;;-----------------------------------------------------------------
 ;;  (require 'ac-slime)
 ;; (add-hook 'slime-mode-hook 'set-up-slime-ac)
 ;;  (add-hook 'slime-repl-mode-hook 'set-up-slime-ac)
 ;;  (eval-after-load "auto-complete"
 ;;    '(add-to-list 'ac-modes 'slime-repl-mode))

  ;;-----------------------------------------------------------------
  ;; カッコの対応を取りながらS式を編集する。
  ;; (install-elisp "http://mumble.net/~campbell/emacs/paredit.el")
  ;;-----------------------------------------------------------------
  (add-hook 'nrepl-mode-hook (lambda () (paredit-mode)))

  ;;-----------------------------------------------------------------
  ;; vim(evil) キーバインド
  ;;-----------------------------------------------------------------
  (when (require 'evil nil t)
   ;;-----------------------------------------------------------------
  ;; eshell を通常のシェルの挙動に近づける。
  ;;-----------------------------------------------------------------
  ;; (progn
  ;;   (defun eshell-in-command-line-p ()
  ;;     (<= eshell-last-output-end (point)))
  ;;   (defmacro defun-eshell-cmdline (key &rest body)
  ;;     (let ((cmd (intern (format "eshell-cmdline/%s" key))))
  ;;       `(progn
  ;;          (add-hook 'eshell-mode-hook
  ;;                    (lambda () (define-key eshell-mode-map (read-kbd-macro ,key) ',cmd)))
  ;;          (defun ,cmd ()
  ;;            (interactive)
  ;;            (if (not (eshell-in-command-line-p))
  ;;                (call-interactively (lookup-key (current-global-map) (read-kbd-macro ,key)))
  ;;              ,@body)))))
  ;;   (defun eshell-history-and-bol (func)
  ;;     (delete-region eshell-last-output-end (point-max))
  ;;     (funcall func 1)
  ;;     (goto-char eshell-last-output-end)))

  ;; ;; C-wの挙動を拡張
  ;; (defun-eshell-cmdline "C-w"
  ;;   (if (eq (point-max) (point))
  ;;       (backward-kill-word 1)
  ;;     (kill-region (region-beginning) (region-end))))

  ;; ;; コマンドライン上で押されたときは履歴操作
  ;; (defun-eshell-cmdline "C-p"
  ;;   (let ((last-command 'eshell-previous-matching-input-from-input))
  ;;     (eshell-history-and-bol 'eshell-previous-matching-input-from-input)))

  ;; ;; コマンドライン上で押されたときは履歴操作
  ;; (defun-eshell-cmdline "C-n"
  ;;   (let ((last-command 'eshell-previous-matching-input-from-input))
  ;;     (eshell-history-and-bol 'eshell-next-input)))

   (add-hook 'evil-insert-state-entry-hook
              (lambda ()
                (when (eq major-mode 'nrepl-mode)
                  (end-of-buffer)
                  )))

    (evil-declare-key 'normal nrepl-mode-map (kbd "G")
                      (lambda ()
                        (end-of-buffer)))

    ;;   (evil-declare-key 'insert slime-repl-mode-map (kbd "C-o") 'anything-eshell-history)
    ;;   (evil-declare-key 'insert slime-repl-mode-map (kbd "C-p") 'eshell-cmdline/C-p)
    ;;   (evil-declare-key 'insert slime-repl-mode-map (kbd "C-n") 'eshell-cmdline/C-n)
    ;;   (evil-declare-key 'insert slime-repl-mode-map (kbd "C-w") 'eshell-cmdline/C-w))
    )
  )

(provide 'mikio-nrepl)
