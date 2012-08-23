(require 'mikio-util)

;;-----------------------------------------------------------------
;; java-mode
;;-----------------------------------------------------------------
(defun java-lineup-arglist (langelem)
  (save-excursion
    (goto-char (c-langelem-pos langelem))
    (vector (+ (current-column) c-basic-offset))))

(defun java-lineup-annotated-method (langelem)
  (save-excursion
    (goto-char (c-langelem-pos langelem))
    (when (looking-at "@")
      (vector (current-column)))))

(defun java-lineup-enum-entry (langelem)
  (save-excursion
    (if (looking-at "}")
        (vector (- (current-column) c-basic-offset))
      (while (eq (c-langelem-sym langelem) 'statement-cont)
        (goto-char (c-langelem-pos langelem))
        (setq langelem (car (c-guess-basic-syntax))))
      (when (and (eq (c-langelem-sym langelem) 'defun-block-intro)
                 (save-excursion
                   (re-search-backward "\\<enum\\>"
                                       (c-langelem-pos langelem) t)))
        (vector (current-column))))))

(c-add-style
 "java2"
 '("java"
   (c-offsets-alist
    ;; 引数の調整
    (arglist-intro . +)
    (arglist-close . 0)
    (arglist-cont-nonempty . java-lineup-arglist)
    ;; 無名クラスの調整
    (inexpr-class . 0)
    ;; enumの調整
    (statement-cont . (first java-lineup-annotated-method
                             java-lineup-enum-entry
                             +))
    ;; アノテーションの調整
    (topmost-intro-cont .(first java-lineup-annotated-method
                                0))
    )))

(add-hook 'java-mode-hook
          (lambda ()
            (define-key java-mode-map (kbd "M-C-h") 'backward-kill-word)
            (c-set-style "java2")
            (set (make-local-variable 'compile-command)
                 (format "javac %s" (file-name-nondirectory buffer-file-name)))))



;;-----------------------------------------------------------------
;; ant-run
;;-----------------------------------------------------------------
;;(when (require 'antrun nil t))

;;-----------------------------------------------------------------
;; ajc-java-complete
;;-----------------------------------------------------------------
;;(mikio/add-to-load-path "site-lisp/ajc-java-complete")
;;(require 'ajc-java-complete-config)
;;(add-hook 'java-mode-hook 'ajc-java-complete-mode)
;;(add-hook 'find-file-hook 'ajc-4-jsp-find-file-hook)

(provide 'mikio-java)
