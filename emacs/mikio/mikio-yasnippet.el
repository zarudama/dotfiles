(require 'mikio-util)

(require 'yasnippet-config)
(require 'dropdown-list)
(yas/global-mode 1)
(call-interactively 'yas/reload-all)    ;workaround
;; anything-complete.elを使っているなら yas/completing-prompt のみでもよい
(setq yas/prompt-functions
      '(yas/dropdown-prompt yas/completing-prompt yas/ido-prompt yas/no-prompt))

;; ;; snippetsの保存ディレクトリ
;; (setq yas-snippet-dirs
;;       (list (format "%s/snippets" my-elisp-dir) ;; personal snippets
;;             (format "%s/el-get/yasnippet/snippets" my-elisp-dir) ;; the default collection
;;             ))

(when (require 'auto-complete-config nil t)
  (yas/set-ac-modes)
  (yas/enable-emacs-lisp-paren-hack)
;; いろいろな情報源を使いたいならば (ac-config-default) にする
;;(setq-default ac-sources '(ac-source-yasnippet))
  )

(when (require 'anything-c-yasnippet-2 nil t)
  (global-set-key (kbd "C-x a y") 'anything-yasnippet-2)
  )

(provide 'mikio-yasnippet)

