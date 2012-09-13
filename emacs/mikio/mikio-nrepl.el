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

  )

(provide 'mikio-nrepl)
