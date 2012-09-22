(require 'mikio-util)

;;-----------------------------------------------------------------
;; slime
;;-----------------------------------------------------------------
(when (require 'nrepl nil t)
  (require 'clojure-mode)

  ;; SLIMEからの入力をUTF-8に設定
  ;; windowsの場合、下記をlein.batの先頭に記述
  ;; set JAVA_OPTS=-Dswank.encoding=utf-8-unix

  (when (require 'ac-nrepl nil t)
    (add-hook 'nrepl-mode-hook 'ac-nrepl-setup)
    (add-hook 'nrepl-interaction-mode-hook 'ac-nrepl-setup)
    (eval-after-load "auto-complete"
      '(add-to-list 'ac-modes 'nrepl-mode)))

  ;;-----------------------------------------------------------------
  ;; カッコの対応を取りながらS式を編集する。
  ;; (install-elisp "http://mumble.net/~campbell/emacs/paredit.el")
  ;;-----------------------------------------------------------------
  (when (require 'paredit nil t)
    (add-hook 'nrepl-mode-hook (lambda () (paredit-mode))))
  )

(provide 'mikio-nrepl)
