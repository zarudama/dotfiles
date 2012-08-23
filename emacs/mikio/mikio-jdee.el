(require 'mikio-util)
;;-----------------------------------------------------------------
;; jdee
;;-----------------------------------------------------------------
(add-to-list 'load-path (mikio/site-lisp-home "jdee/dist/jdee-2.4.1/lisp"))

;; load autoloads file
(load "jde-autoload")
;;(require 'jde)

;; 参考
;; - http://epian-wiki.appspot.com/wiki/Emacs/JDEE#i1C861AE907CB2F41F9C71F925BC21092
(defun my-jde-mode-hook ()
  (progn
    (require 'jde)
    (define-key jde-mode-map (kbd "C-c C-SPC") 'jde-complete-minibuf);; メソッド補完をminibuff(Anything)で。
    ;;(define-key jde-mode-map (kbd "C-c C-v C-.") 'jde-complete-minibuf) ;; gui

    ;; スニペットを有効にする。
    ;;(jde-abbrev-mode)

    (require 'jde-flymake)
    (setq jde-flymake-jikes-app-name "javac")
    (push '(".+\\.java$"
            flymake-jde-jikes-java-init
            flymake-simple-java-cleanup
            flymake-get-real-file-name)
          flymake-allowed-file-name-masks)
    (flymake-mode)

    (require 'auto-complete)
    (auto-complete-mode 1)
    ;;(auto-complete-mode)
    ;;(auto-complete)
    (add-to-list 'ac-sources 'ac-source-semantic)

    ;; Ant
    ;;(require 'jde-ant)
    (setq jde-build-function 'jde-ant-build) ; ビルドにantを利用する
    (setq jde-ant-read-target t)               ; targetを問い合わせる
    (setq jde-ant-enable-find t) ; antに-findオプションを指定する(要らないかも)
    ;;(setq jde-ant-enable-find nil) ; antに-findオプションを指定する(要らないかも)
    ))

(add-hook 'jde-mode-hook 'my-jde-mode-hook)

(provide 'mikio-jdee)
