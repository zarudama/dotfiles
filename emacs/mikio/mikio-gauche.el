;;(require 'swank-gauche)

;;-----------------------------------------------------------------
;; gauche
;;-----------------------------------------------------------------

(defun scheme-other-frame ()
  "Run scheme on other frame"
  (interactive)
  (switch-to-buffer-other-frame
   (get-buffer-create "*scheme*"))
  (run-scheme scheme-program-name))

(defun scheme-other-window ()
  "Run scheme on other window"
  (interactive)
  (switch-to-buffer-other-window
   (get-buffer-create "*scheme*"))
  (run-scheme scheme-program-name))

(defun gauche-info ()
  (interactive)
  (switch-to-buffer-other-frame
   (get-buffer-create "*info*"))
  (info
   "/usr/local/info/gauche-refj.info.gz"))

(when (executable-find "gosh")
    (setq scheme-program-name "/usr/local/bin/gosh -i")
    (define-key global-map (kbd "C-x S") 'scheme-other-frame)
    (define-key global-map (kbd "C-c S") 'scheme-other-window)
    (define-key global-map (kbd "C-c I") 'gauche-info)

    (put 'and-let* 'scheme-indent-function 1)
    (put 'begin0 'scheme-indent-function 0)
    (put 'call-with-client-socket 'scheme-indent-function 1)
    (put 'call-with-input-conversion 'scheme-indent-function 1)
    (put 'call-with-input-file 'scheme-indent-function 1)
    (put 'call-with-input-process 'scheme-indent-function 1)
    (put 'call-with-input-string 'scheme-indent-function 1)
    (put 'call-with-iterator 'scheme-indent-function 1)
    (put 'call-with-output-conversion 'scheme-indent-function 1)
    (put 'call-with-output-file 'scheme-indent-function 1)
    (put 'call-with-output-string 'scheme-indent-function 0)
    (put 'call-with-temporary-file 'scheme-indent-function 1)
    (put 'call-with-values 'scheme-indent-function 1)
    (put 'dolist 'scheme-indent-function 1)
    (put 'dotimes 'scheme-indent-function 1)
    (put 'if-match 'scheme-indent-function 2)
    (put 'let*-values 'scheme-indent-function 1)
    (put 'let-args 'scheme-indent-function 2)
    (put 'let-keywords* 'scheme-indent-function 2)
    (put 'let-match 'scheme-indent-function 2)
    (put 'let-optionals* 'scheme-indent-function 2)
    (put 'let-syntax 'scheme-indent-function 1)
    (put 'let-values 'scheme-indent-function 1)
    (put 'let/cc 'scheme-indent-function 1)
    (put 'let1 'scheme-indent-function 2)
    (put 'letrec-syntax 'scheme-indent-function 1)
    (put 'make 'scheme-indent-function 1)
    (put 'match 'scheme-indent-function 1)
    (put 'match-lambda 'scheme-indent-function 1)
    (put 'match-let 'scheme-indent-fucntion 1)
    (put 'match-let* 'scheme-indent-fucntion 1)
    (put 'match-letrec 'scheme-indent-fucntion 1)
    (put 'match-let1 'scheme-indent-function 2)
    (put 'match-define 'scheme-indent-fucntion 1)
    (put 'multiple-value-bind 'scheme-indent-function 2)
    (put 'parameterize 'scheme-indent-function 1)
    (put 'parse-options 'scheme-indent-function 1)
    (put 'receive 'scheme-indent-function 2)
    (put 'rxmatch-case 'scheme-indent-function 1)
    (put 'rxmatch-cond 'scheme-indent-function 0)
    (put 'rxmatch-if  'scheme-indent-function 2)
    (put 'rxmatch-let 'scheme-indent-function 2)
    (put 'syntax-rules 'scheme-indent-function 1)
    (put 'unless 'scheme-indent-function 1)
    (put 'until 'scheme-indent-function 1)
    (put 'when 'scheme-indent-function 1)
    (put 'while 'scheme-indent-function 1)
    (put 'with-builder 'scheme-indent-function 1)
    (put 'with-error-handler 'scheme-indent-function 0)
    (put 'with-error-to-port 'scheme-indent-function 1)
    (put 'with-input-conversion 'scheme-indent-function 1)
    (put 'with-input-from-port 'scheme-indent-function 1)
    (put 'with-input-from-process 'scheme-indent-function 1)
    (put 'with-input-from-string 'scheme-indent-function 1)
    (put 'with-iterator 'scheme-indent-function 1)
    (put 'with-module 'scheme-indent-function 1)
    (put 'with-output-conversion 'scheme-indent-function 1)
    (put 'with-output-to-port 'scheme-indent-function 1)
    (put 'with-output-to-process 'scheme-indent-function 1)
    (put 'with-output-to-string 'scheme-indent-function 1)
    (put 'with-port-locking 'scheme-indent-function 1)
    (put 'with-string-io 'scheme-indent-function 1)
    (put 'with-time-counter 'scheme-indent-function 1)
    (put 'with-signal-handlers 'scheme-indent-function 1)
    )

;;;;-----------------------------------------------------------------
;;;; swank gauche
;;;;-----------------------------------------------------------------
;;;;(slime-setup
;;;; '(slime-fancy
;;;;   slime-scheme))
;;;;
;;;; swank-gauche.scmが格納されているディレクトリへのパスを設定して下さい。
;;;;(setq swank-gauche-path "<path-to-swank-gauche-dir>")
;;(setq swank-gauche-path (mikio/elisp-home  "site-lisp/swank-gauche"))
;;
;;
;;;; Gaucheのソースを持っていて、かつ、コンパイル済の場合、ソースのトップ
;;;; ディレクトリへのパスを設定して下さい。Gaucheのマニュアルに記載されている
;;;; オペレータの引数名がルックアップ出来るようになります。
;;(setq swank-gauche-gauche-source-path nil)
;;
;;(push swank-gauche-path load-path)
;;
;;(setq slime-lisp-implementations
;;      '((gauche ("gosh") :init gauche-init :coding-system utf-8-unix)))
;;
;;;; バッファのモジュールを決定するための設定
;;(setq slime-find-buffer-package-function 'find-gauche-package)
;;;; c-p-c補完に設定
;;(setq slime-complete-symbol-function 'slime-complete-symbol*)
;;;; web上のGaucheリファレンスマニュアルを引く設定
;;(define-key slime-mode-map (kbd "C-c C-d H") 'gauche-ref-lookup)
