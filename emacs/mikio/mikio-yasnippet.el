(require 'mikio-util)

;; 参考
;; http://fukuyama.co/yasnippet
(when (require 'yasnippet nil t)

  ;; ユーザ定義のスニペット保存ディレクトリ
  (setq my-snippets-directory (mikio/elisp-home "snippets"))
  (mikio/make-directory my-snippets-directory)
  (add-to-list 'yas-snippet-dirs my-snippets-directory)

  (yas-global-mode 1)
  (call-interactively 'yas/reload-all)

  ;; 単語展開キーバインド (ver8.0から明記しないと機能しない)
  ;; (setqだとtermなどで干渉問題ありでした)
  ;; もちろんTAB以外でもOK 例えば "C-;"とか
  (custom-set-variables '(yas-trigger-key "TAB"))

  ;; 既存スニペットを挿入する
  (define-key yas-minor-mode-map (kbd "C-x y i") 'yas-insert-snippet)
  ;; 新規スニペットを作成するバッファを用意する
  (define-key yas-minor-mode-map (kbd "C-x y n") 'yas-new-snippet)
  ;; 既存スニペットを閲覧・編集する
  (define-key yas-minor-mode-map (kbd "C-x y v") 'yas-visit-snippet-file)

  ;; for interface                                                                        
  (when t
    (eval-after-load "helm-config"                                                           
      '(progn                                                                                    
         (defun my-yas/prompt (prompt choices &optional display-fn)                              
           (let* ((names (loop for choice in choices                                             
                               collect (or (and display-fn (funcall display-fn choice))          
                                           choice)))                                             
                  (selected (helm-other-buffer                                               
                             `(((name . ,(format "%s" prompt))                                   
                                (candidates . names)                                             
                                (action . (("Insert snippet" . (lambda (arg) arg))))))           
                             "*helm yas/prompt*")))                                          
             (if selected                                                                        
                 (let ((n (position selected names :test 'equal)))                               
                   (nth n choices))                                                              
               (signal 'quit "user quit!"))))                                                    
         (custom-set-variables '(yas/prompt-functions '(my-yas/prompt)))                         
         (define-key helm-command-map (kbd "y") 'yas/insert-snippet)))                       
                                                                                             
    ;; snippet-mode for *.yasnippet files                                                        
    (add-to-list 'auto-mode-alist '("\\.yasnippet$" . snippet-mode)))                             

  ;; for auto-complete
  ;; (when (require 'auto-complete-config nil t)
  ;;   (setq-default ac-sources '(ac-source-yasnippet)))

  )

(provide 'mikio-yasnippet)

