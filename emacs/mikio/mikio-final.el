(require 'sequential-command-config)
(require 'org)
;;(require 'popwin)

;;-----------------------------------------------------------------
;; 同じコマンドを連続実行したときの振る舞いを変更する
;;-----------------------------------------------------------------
(sequential-command-setup-keys)
  
;; (define-sequential-command org-seq-home
;;   org-beginning-of-line beginning-of-buffer seq-return)
;; (define-sequential-command org-seq-end2
;;   org-end-of-line end-of-buffer seq-return)
(define-key org-mode-map "\C-a" 'org-seq-home)
(define-key org-mode-map "\C-e" 'org-seq-end)

;; (add-hook 'eshell-mode-hook
;;           (lambda ()
;;             (define-sequential-command eshell-seq-home
;;               'eshell-bol beginning-of-buffer seq-return)
;;             (define-sequential-command eshell-seq-end
;;               'end-of-line end-of-buffer seq-return)))
;; (add-hook 'eshell-mode-hook
;;           (lambda ()
;;             (define-key eshell-mode-map (kbd "C-a") 'eshell-seq-home)
;;             (define-key eshell-mode-map (kbd "C-e") 'eshell-seq-end)))

;; (add-hook 'js2-mode-hook
;;           (lambda ()
;;             (progn
;;               (define-sequential-command js2-seq-home
;;                 js2-beginning-of-line beginning-of-buffer seq-return)
;;               (define-sequential-command js2-seq-end
;;                 js2-end-of-line end-of-buffer seq-return)
;;               (define-key js2-mode-map (kbd "C-a") 'js2-seq-home)
;;               (define-key js2-mode-map (kbd "C-e") 'js2-seq-end))))


;;-----------------------------------------------------------------
;; hs-mode
;;-----------------------------------------------------------------
;;(load-library "hideshow")
(add-hook 'java-mode-hook 'hs-minor-mode)
(add-hook 'perl-mode-hook 'hs-minor-mode)
(add-hook 'php-mode-hook 'hs-minor-mode)
(add-hook 'clojure-mode-hook 'hs-minor-mode)
(add-hook 'ruby-mode-hook 'hs-minor-mode)
(add-hook 'emacs-lisp-mode-hook 'hs-minor-mode)
(add-hook 'nxml-mode-hook 'hs-minor-mode)
(define-key hs-minor-mode-map (kbd "C-c C-t") 'hs-toggle-hiding)

;;-----------------------------------------------------------------
;; 行番号指定
;;-----------------------------------------------------------------
(add-hook 'java-mode-hook 'linum-mode)
(add-hook 'perl-mode-hook 'linum-mode)
(add-hook 'php-mode-hook 'linum-mode)
(add-hook 'clojure-mode-hook 'linum-mode)
(add-hook 'ruby-mode-hook 'linum-mode)
(add-hook 'emacs-lisp-mode-hook 'linum-mode)
(add-hook 'nxml-mode-hook 'linum-mode)
(define-key hs-minor-mode-map (kbd "C-c C-t") 'hs-toggle-hiding)


