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
;;(make-variable-buffer-local 'mikio/lvar-methods)
(defvar mikio/lvar-methods nil)

(defun ac-source-jdee-candidates ()
  (setq bsh-eval-timeout 5)
  (let ((l (mikio/jde-get-methods)))
    (message "end..%s" l)
    l

;; '(
;;     "wait(long, int)"
;;     "wait(long)"
;;     "wait()"
;;     "trimToSize()"
;;     "toString()"
;;     "substring(int, int)"
;;     "substring(int)"
;;     "subSequence(int, int)"
;;     "setLength(int)"
;;     "setCharAt(int, char)"
;;     "reverse()"
;;     "reverse()"
;;     "replace(int, int, java.lang.String)"
;;     "replace(int, int, java.lang.String)"
;;     "offsetByCodePoints(int, int)"
;;     "notifyAll()"
;;     "notify()"
;;     "length()"
;;     "lastIndexOf(java.lang.String, int)"
;;     "lastIndexOf(java.lang.String)"
;;     "insert(int, long)"
;;     "insert(int, long)"
;;     "insert(int, java.lang.String)"
;;     "insert(int, java.lang.String)"
;;     "insert(int, java.lang.Object)"
;;     "insert(int, java.lang.Object)"
;;     "insert(int, java.lang.CharSequence, int, int)"
;;     "insert(int, java.lang.CharSequence, int, int)"
;;     "insert(int, java.lang.CharSequence)"
;;     "insert(int, java.lang.CharSequence)"
;;     "insert(int, int)"
;;     "insert(int, int)"
;;     "insert(int, float)"
;;     "insert(int, float)"
;;     "insert(int, double)"
;;     "insert(int, double)"
;;     "insert(int, char[], int, int)"
;;     "insert(int, char[], int, int)"
;;     "insert(int, char[])"
;;     "insert(int, char[])"
;;     "insert(int, char)"
;;     "insert(int, char)"
;;     "insert(int, boolean)"
;;     "insert(int, boolean)"
;;     "indexOf(java.lang.String, int)"
;;     "indexOf(java.lang.String)"
;;     "hashCode()"
;;     "getClass()"
;;     "getChars(int, int, char[], int)"
;;     "equals(java.lang.Object)"
;;     "ensureCapacity(int)"
;;     "deleteCharAt(int)"
;;     "deleteCharAt(int)"
;;     "delete(int, int)"
;;     "delete(int, int)"
;;     "codePointCount(int, int)"
;;     "codePointBefore(int)"
;;     "codePointAt(int)"
;;     "charAt(int)"
;;     "capacity()"
;;     "appendCodePoint(int)"
;;     "appendCodePoint(int)"
;;     "append(long)"
;;     "append(long)"
;;     "append(java.lang.StringBuffer)"
;;     "append(java.lang.StringBuffer)"
;;     "append(java.lang.String)"
;;     "append(java.lang.String)"
;;     "append(java.lang.Object)"
;;     "append(java.lang.Object)"
;;     "append(java.lang.CharSequence, int, int)"
;;     "append(java.lang.CharSequence, int, int)"
;;     "append(java.lang.CharSequence, int, int)"
;;     "append(java.lang.CharSequence)"
;;     "append(java.lang.CharSequence)"
;;     "append(java.lang.CharSequence)"
;;     "append(int)"
;;     "append(int)"
;;     "append(float)"
;;     "append(float)"
;;     "append(double)"
;;     "append(double)"
;;     "append(char[], int, int)"
;;     "append(char[], int, int)"
;;     "append(char[])"
;;     "append(char[])"
;;     "append(char)"
;;     "append(char)"
;;     "append(char)"
;;     "append(boolean)"
;;     "append(boolean)"
;;     "StringBuilder()"
;;     "StringBuilder()"
;;     "StringBuilder()"
;;     "StringBuilder()")

    )) 


(defvar ac-source-jdee
  '((candidates . ac-source-jdee-candidates)
    (prefix . "[a-zA-Z_]+\\.\\([a-zA-Z_]+\\)")
    ;;(prefix . "[a-zA-Z_()]+\\.\\([a-zA-Z_()]+\\)")
    (cache)
    ))

(defun mikio/jde-debug ()
  (interactive)
  (message "%s" (mikio/jde-get-methods))
  )

(defun mikio/get-methods-from-cache (type)
  (unless mikio/lvar-methods
    (setq mikio/lvar-methods (make-hash-table :test 'equal)))
  (gethash type mikio/lvar-methods)
  )

(defun mikio/jde-get-methods ()
  (let* ((pair (mikio/jde-get-pair-))
         (type (jde-parse-eval-type-of (car pair)))
         (methods (mikio/get-methods-from-cache type)))
    (if methods
        (progn
          (message "auto-complete ...cache")
          methods
          )
      (message "auto-complete ...no cache")
      (setq methods (mikio/jde-get-methods- type pair))
      (puthash type methods mikio/lvar-methods)
      (message "hoge")
      )
    methods))

(defun mikio/jde-get-pair- ()
  (let* ((pair (jde-parse-java-variable-at-point)))
    (if pair
        (condition-case err
            (setq pair (jde-complete-get-pair pair nil))
          (error (condition-case err
                     (setq pair (jde-complete-get-pair pair t)))
                 (error (message "%s" (error-message-string err)))))
      (message "No completion at this point"))
    pair))

(defun mikio/jde-get-methods- (type pair)
  (let ((access (jde-complete-get-access pair)) ; this. なのか super. なのかでアクセスレベルを取得する(定数)
        (obj (car pair))
        completion-list)
    (progn
      (if access
          (setq completion-list
                (miki/jde-get-methods2- type access)) ; private, protecteのとき
        (setq completion-list (miki/jde-get-methods2- type))) ; publicレベルのとき

      ;;if the completion list is nil check if the method is in the current
      ;;class(this)
      (if (null completion-list)
          (setq completion-list (miki/jde-get-methods2-
                                 (list (concat "this." obj) "")
                                 jde-complete-private)))
      ;;if completions is still null check if the method is in the
      ;;super class
      (if (null completion-list)
          (setq completion-list (miki/jde-get-methods2-
                                 (list (concat "super." obj) "")
                                 jde-complete-protected)))

      (if completion-list
          completion-list
        (error "No completion at this point")))))

(defun miki/jde-get-methods2- (type &optional access-level)
  (if type
      (cond ((member type jde-parse-primitive-types)
             (error "Cannot complete primitive type: %s" type))
            ((string= type "void")
             (error "Cannot complete return type of %s is void." type))
            (t
             (let (l
                   (method-list (jde-complete-get-classinfo type access-level)))
               (dolist (v method-list)
                 ;;(setq l (cons (format "\"%s\"" (cdr v)) l))
                 ;; (setq l (cons (cdr v) l)))
                 (setq l (cons (car v) l)))
               l)
             )
            )
    nil))

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

    ;;(define-key jde-mode-map (kbd "C-c C-SPC") 'jde-complete-minibuf)
    (define-key jde-mode-map (kbd "C-c C-SPC") 'mikio/jde-debug)

   ))


(add-hook 'jde-mode-hook 'my-jde-mode-hook)

(provide 'mikio-jdee)
