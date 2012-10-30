(require 'mikio-util)

(require 'yasnippet-config)
(require 'dropdown-list)
(yas/global-mode 1)
;; snippetsの保存ディレクトリ
(yas/load-directory (format "%s/snippets" mikio/elisp-directory)) ;; personal snippets)
;; (setq yas-snippet-dirs
;;       (list (format "%s/snippets" mikio/elisp-directory) ;; personal snippets
;;             (format "%s/el-get/yasnippet/snippets" mikio/elisp-directory) ;; the default collection
;;             ))

(call-interactively 'yas/reload-all)    ;workaround
;; anything-complete.elを使っているなら yas/completing-prompt のみでもよい
(setq yas/prompt-functions
      '(yas/dropdown-prompt yas/completing-prompt yas/ido-prompt yas/no-prompt))

;; (require 'yasnippet) ;; not yasnippet-bundle
;; (yas/global-mode 1)


(when (require 'auto-complete-config nil t)
  (yas/set-ac-modes)
  (yas/enable-emacs-lisp-paren-hack)
 ;; (add-to-list 'ac-sources 'ac-source-yasnippet)
  (setq-default ac-sources '(ac-source-yasnippet))
;; (ac-config-default)
;; (setq-default ac-sources '(ac-source-yasnippet))
;;(setq ac-delay 0.8);;, ac-complete will show a shadow auto-complete tips,

  )


;; (when (require 'anything-c-yasnippet-2 nil t)
;;   (global-set-key (kbd "C-x a y") 'anything-yasnippet-2)
;;   )

(provide 'mikio-yasnippet)

