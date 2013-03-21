(require 'mikio-util)

;;-----------------------------------------------------------------
;; IDEのような入力支援をする
;; URL
;; http://cx4a.org/software/auto-complete/index.ja.html
;; インストール方法
;; $ cd ~/src
;; $ wget http://cx4a.org/pub/auto-complete/auto-complete-1.3.1.zip
;; $ zip auto-complete-1.3.1.zip
;; M-x ~/src/auto-complete-1.3.1/etc/install.el
;; インストール先には次を指定する
;;    ~/.emacs.d/site-lisp
;;-----------------------------------------------------------------
(require 'auto-complete-config)
;;(add-to-list 'ac-dictionary-directories (format "%s/ac-dict" mikio/elisp-directory))
(ac-config-default)
(global-auto-complete-mode t)
(setq ac-use-menu-map t)
(define-key ac-menu-map (kbd "C-n") 'ac-next)
(define-key ac-menu-map (kbd "C-p") 'ac-previous)
(define-key ac-menu-map (kbd "ESC") 'ac-stop)
(setq ac-auto-start 1)

;;  (define-key ac-menu-map (kbd "C-v") 'a)
;;  (define-key ac-menu-map (kbd "M-p") 'ac-previous)

;;  (setq ac-auto-start nil) ;; 自動補完を禁止
;;(global-set-key "\M-/" 'auto-complete) ;; これで起動
;;  (global-set-key (kbd "C-i") 'auto-complete) ;; これで起動

(provide 'mikio-auto-complete)
