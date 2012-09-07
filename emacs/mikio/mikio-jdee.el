(require 'mikio-util)
;;-----------------------------------------------------------------
;; jdee
;;-----------------------------------------------------------------
(add-to-list 'load-path (mikio/site-lisp-home "jdee/dist/jdee-2.4.1/lisp"))

;; load autoloads file
(load "jde-autoload")
;;(require 'jde)

;; jde-modeでauto-completeを有効にする。-> add-hookのタイミングでは駄目
;; で、このタイミングでglobal変数のac-modesに登録しておく必要がある。
(add-to-list 'ac-modes 'jde-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; auto-complete
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; TODO 型ごとのメソッド一覧を、バッファローカルの連想リストに保存して再利用するようにする。
(defun ac-source-jdee-candidates ()
  (setq bsh-eval-timeout 5)
   (message "auto-complete ...")
  (let ((l
         (my-jde-complete-generic)
         ;;'("setHoge" "setFuga" "setPiyo")
         ))

   (message "%s" l)
   l
    ))

(defvar ac-source-jdee
  '((candidates . ac-source-jdee-candidates)
    (prefix . "[a-zA-Z_]+\\.\\(.*\\)")
    ;;(cache)
    ))

;; (defvar ac-source-jdee
;;   '((candidates . ac-source-jdee-candidates)
;;     ))

(defun my-jde-complete ()
  (interactive)
  (message "%s" (my-jde-complete-generic))
  )

(defun my-jde-complete-generic ()
  "Generic implementation for jde-complete methods"
  (let* ((pair (jde-parse-java-variable-at-point)))
    (if pair
        (condition-case err
            (my-jde-complete-pair (jde-complete-get-pair pair nil) )
          (error (condition-case err
                     (my-jde-complete-pair (jde-complete-get-pair pair t)))
                 (error (message "%s" (error-message-string err)))))
      (message "No completion at this point"))))

(defun my-jde-complete-pair (pair)
  (let ((access (jde-complete-get-access pair)) ; this. なのか super. なのかでアクセスレベルを取得する(定数)
        completion-list)
    (progn
      (if access
          (setq completion-list
                (my-jde-complete-find-completion-for-pair pair nil access)) ; private, protecteのとき
        (setq completion-list (my-jde-complete-find-completion-for-pair pair))) ; publicレベルのとき

      ;;if the completion list is nil check if the method is in the current
      ;;class(this)
      (if (null completion-list)
          (setq completion-list (my-jde-complete-find-completion-for-pair
                                 (list (concat "this." (car pair)) "")
                                 nil jde-complete-private)))
      ;;if completions is still null check if the method is in the
      ;;super class
      (if (null completion-list)
          (setq completion-list (my-jde-complete-find-completion-for-pair
                                 (list (concat "super." (car pair)) "")
                                 nil jde-complete-protected)))

      (if completion-list
          completion-list
        (error "No completion at this point")))))

(defun my-jde-complete-find-completion-for-pair (pair &optional exact-completion
                                                      access-level)
  (let ((type (jde-parse-eval-type-of (car pair))))
    (if type
        (cond ((member type jde-parse-primitive-types)
               (error "Cannot complete primitive type: %s" type))
              ((string= type "void")
               (error "Cannot complete return type of %s is void." (car pair)))
              (t
               (let (l
                     (method-list (jde-complete-get-classinfo type access-level)))
                 (dolist (v method-list)
                   ;;(setq l (cons (format "\"%s\"" (cdr v)) l))
                   (setq l (cons (cdr v) l)))
                 l)
               )
              )
      nil)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 参考
;; - http://epian-wiki.appspot.com/wiki/Emacs/JDEE#i1C861AE907CB2F41F9C71F925BC21092
(defun my-jde-mode-hook ()
  (progn
    (require 'jde)
    ;; スニペットを有効にする。
    ;;(jde-abbrev-mode) ; yasnippetで代替するので不要。

    ;; Ant
    ;;(require 'jde-ant)
    (setq jde-build-function 'jde-ant-build) ; ビルドにantを利用する
    (setq jde-ant-read-target t)               ; targetを問い合わせる
    (setq jde-ant-enable-find t) ; antに-findオプションを指定する(要らないかも)
    ;;(setq jde-ant-enable-find nil) ; antに-findオプションを指定する(要らないかも)

    ;; (require 'jde-flymake)
    ;; (setq jde-flymake-jikes-app-name "javac")
    ;; (push '(".+\\.java$"
    ;;         flymake-jde-jikes-java-init
    ;;         flymake-simple-java-cleanup
    ;;         flymake-get-real-file-name)
    ;;       flymake-allowed-file-name-masks)
    ;; (flymake-mode)
    (setq ac-sources '(ac-source-jdee))

    (define-key jde-mode-map (kbd "C-c C-SPC") 'jde-complete-minibuf)
    (define-key jde-mode-map (kbd "C-c C-.") 'my-jde-complete)

   ))


(add-hook 'jde-mode-hook 'my-jde-mode-hook)

(provide 'mikio-jdee)
