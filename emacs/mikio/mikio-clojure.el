(require 'mikio-util)
(require 'clojure-mode)

;-----------------------------------------------------------------
;; カッコの対応を取りながらS式を編集する。
;; (install-elisp "http://mumble.net/~campbell/emacs/paredit.el")
;;-----------------------------------------------------------------
(require 'paredit)
(add-hook 'clojure-mode-hook 'enable-paredit-mode)

(provide 'mikio-clojure)
