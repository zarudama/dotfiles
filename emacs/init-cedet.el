(savehist-mode 1)
(define-key global-map (kbd "C-h") 'delete-backward-char)
(define-key global-map (kbd "M-C-h") 'backward-kill-word)

(load-file "~/site-lisp/cedet/cedet-devel-load.el")
(add-to-list 'Info-directory-list "~/site-lisp/cedet/doc/info")

;; (add-to-list 'semantic-default-submodes 'global-semantic-idle-summary-mode t)
;; (add-to-list 'semantic-default-submodes 'global-semantic-idle-completions-mode t)
;; (add-to-list 'semantic-default-submodes 'global-cedet-m3-minor-mode t)


;; ;; Enable Semantic
;; (semantic-mode 1)

;; ;; Enable EDE (Project Management) features
;; (global-ede-mode 1)

;; via
;; https://github.com/alexott/emacs-configs/blob/master/rc/emacs-rc-cedet.el
(defun alexott/cedet-hook ()                                                                            
  (local-set-key [(control return)] 'semantic-ia-complete-symbol-menu)                                  
  (local-set-key "\C-c?" 'semantic-ia-complete-symbol)                                                  
  ;;                                                                                                    
  (local-set-key "\C-c>" 'semantic-comsemantic-ia-complete-symbolplete-analyze-inline)                  
  (local-set-key "\C-c=" 'semantic-decoration-include-visit)                                            
                                                                                                          
  (local-set-key "\C-cj" 'semantic-ia-fast-jump)                                                        
  (local-set-key "\C-cq" 'semantic-ia-show-doc)                                                         
  (local-set-key "\C-cs" 'semantic-ia-show-summary)                                                     
  (local-set-key "\C-cp" 'semantic-analyze-proto-impl-toggle)                                           
  ;; (local-set-key (kbd "C-c <left>") 'semantic-tag-folding-fold-block)                                 
  ;; (local-set-key (kbd "C-c <right>") 'semantic-tag-folding-show-block)          
  
                                                                                                          
;;  (add-to-list 'ac-sources 'ac-source-semantic)                                                         
  )                                                                                                     

;; helper for boost setup...
(defun recur-list-files (dir re)
  "Returns list of files in directory matching to given regex"
  (when (file-accessible-directory-p dir)
    (let ((files (directory-files dir t))
          matched)
      (dolist (file files matched)
        (let ((fname (file-name-nondirectory file)))
          (cond
           ((or (string= fname ".")
                (string= fname "..")) nil)
           ((and (file-regular-p file)
                 (string-match re fname))
            (setq matched (cons file matched)))
           ((file-directory-p file)
            (let ((tfiles (recur-list-files file re)))
              (when tfiles (setq matched (append matched tfiles)))))))))))


(add-hook 'java-mode-hook 'alexott/cedet-hook)                                                        
                                                                                                          


(global-semanticdb-minor-mode 1)                  ;; Инициализировать semanticdb
;; Загрузить поддержку авто-дополнения
(semantic-load-enable-gaudy-code-helpers)
(custom-set-variables             ;; Инициализация переменных, указывающих, где 
 ;; установлена java
 '(cedet-java-jdk-root "c:/Program Files/Java/jdk1.7.0_09/")

 ;; Сюда нужно добавить все jar-ки, из
 ;; которых необходимо импортировать символы
 '(semanticdb-javap-classpath '("c:/Program Files/Java/jdk1.7.0_09/jre/lib/rt.jar"))
 )



;;;;;;;;;;;;;;;;;;;;;;;;
;; java
;; (ede-java-root-project "SOMENAME"
;;                        :file "/dir/to/some/file"
;;                        :local-variables
     ;;                        '((grep-command . "grep -nHi -e ")
;;                          (compile-command . "ant")))


;; example of java-root project

;; (ede-java-root-project "Lucene"
;; :file "~/work/lucene-solr/lucene-4.0.0/build.xml"
;; :srcroot '("core/src")
;; :localclasspath '("core/lucene-core-4.0.0.jar")
;; ;; :classpath (recur-list-files "~/work/lucene-solr/lucene-4.0.0/" ".*\.jar$")
;; )

;; (require 'semantic/db-javap)
;; (global-ede-mode 1) ;; Enable EDE


;; (setq cedet-java-classpath-extension '("c:/Program Files/Java/jdk1.7.0_09/jre/lib/rt.jar"))
;; ;; (setq semanticdb-javap-classpath ) 

;; (ede-java-root-project "TestProject"
;;                        :file "~/dev/sample-java-project/build.xml"
;;                        :srcroot '("src" "test")
;;                        :localclasspath '("lib")
;;                        :classpath '("c:/Program Files/Java/jdk1.7.0_09/jre/lib/rt.jar")
;; ;;                       :classpath '("c:/Users/m-oono/dev/sample-java-project/")
;;                        )
