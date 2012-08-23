;;-----------------------------------------------------------------
;; malabar-mode
;;-----------------------------------------------------------------
(mikio/add-to-load-path "site-lisp/malabar-1.5-SNAPSHOT/lisp")
(when (require 'malabar-mode nil t)
  (setq semantic-default-submodes '(global-semantic-idle-scheduler-mode
                                    global-semanticdb-minor-mode
                                    global-semantic-idle-summary-mode
                                    global-semantic-mru-bookmark-mode))
  (semantic-mode 1)
  (setq malabar-groovy-lib-dir "~/.emacs.d/site-lisp/malabar-1.5-SNAPSHOT/lib/")
  (setq malabar-groovy-java-options '("-Duser.language=en")) ; 日本語だとコンパイルエラーメッセージが化けるので
  (add-to-list 'auto-mode-alist '("\\.java\\'" . malabar-mode))

  (add-hook 'malabar-mode-hook
            (lambda ()
              (require 'auto-complete)
              ;; (add-hook 'after-save-hook 'malabar-compile-file-silently nil t)
              (add-to-list 'ac-sources 'ac-source-semantic))))


