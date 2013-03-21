(require 'mikio-util)

;; evilの設定において下記は必読
;;   http://d.hatena.ne.jp/tarao/20130304/evil_config

(require 'evil)

(evil-mode 1)
;;(require 'evil-mode-line)
(setq evil-esc-delay 0.001)

;;-----------------------------------------------------------------
;; key bind
;;-----------------------------------------------------------------
(define-key evil-normal-state-map (kbd "C-t") 'switch-to-last-buffer-or-other-window)
(define-key evil-insert-state-map (kbd "C-t") 'switch-to-last-buffer-or-other-window)

;; インサートステートでemacsとして足りないキーバインドを追加する。
(define-key evil-insert-state-map (kbd "C-e") 'move-end-of-line)
(define-key evil-insert-state-map (kbd "C-d") 'delete-char)
(define-key evil-insert-state-map (kbd "M-C-h") 'backward-kill-word)
(define-key evil-insert-state-map (kbd "C-k") 'kill-line)
;;(evil-set-toggle-key (kbd "C-c C-z"))

;; paredit.elをevilから使用する
(when (require 'evil-paredit nil t)
  (add-hook 'emacs-lisp-mode-hook 'evil-paredit-mode)
  (add-hook 'slime-repl-mode-hook 'evil-paredit-mode))

;;-----------------------------------------------------------------
;; skk
;; ノーマルステート時に状態遷移した時に、skkが起動している場合、
;; 自動的にアスキーモードにする。
;;-----------------------------------------------------------------
(when (require 'skk nil t)
  (defun my-skk-control ()
    (when skk-mode
      (skk-latin-mode 1))) 
  (add-hook 'evil-normal-state-entry-hook 'my-skk-control))

;;-----------------------------------------------------------------
;; tabbar
;;-----------------------------------------------------------------
(when (and (require 'tabbar nil t) (require 'smartrep nil t))
  (smartrep-define-key evil-normal-state-map "C-c"
    '(
      ("n" . 'tabbar-forward-tab)
      ("p" . 'tabbar-backward-tab)
      ("P" . (lambda () (progn (delete-other-windows) (tabbar-forward-group))))
      ("N" . (lambda () (progn (delete-other-windows) (tabbar-backward-group)))))))

;;-----------------------------------------------------------------
;; evil-make-overriding-map
;;   特定のメージャーモードのキーマップをevilより優先させる
;; evil-add-hjkl-bindings
;;   emacsを優先させつつも hjkl に限り優先させる
;;-----------------------------------------------------------------
(when (require 'howm nil t)
  (eval-after-load 'howm
    '(progn
       (evil-make-overriding-map howm-menu-mode-map 'normal)
       (evil-add-hjkl-bindings howm-menu-mode-map 'normal)
       (evil-make-overriding-map howm-remember-mode-map 'normal)
       (evil-add-hjkl-bindings howm-remember-mode-map 'normal)
       (evil-make-overriding-map howm-view-contents-mode-map'normal)
       (evil-add-hjkl-bindings howm-view-contents-mode-map 'normal)
       (evil-make-overriding-map howm-view-summary-mode-map'normal)
       (evil-add-hjkl-bindings howm-view-summary-mode-map 'normal))))

(when (require 'twittering-mode nil t)
  (delq 'twittering-mode evil-emacs-state-modes)
  (eval-after-load 'twittering-mode
    '(progn
       (evil-make-overriding-map twittering-mode-map 'normal)
       (evil-add-hjkl-bindings twittering-mode-map 'normal
         "j" (lookup-key twittering-mode-map "j")
         "G" (lookup-key evil-motion-state-map "G")
         "g" (lookup-key evil-motion-state-map "g")
         "v" (lookup-key evil-motion-state-map "v")
         "V" (lookup-key evil-motion-state-map "V")
         "b" (lookup-key evil-motion-state-map "b")))))

(when (require 'w3m nil t)
  (evil-set-initial-state 'w3m-mode 'normal)
  (eval-after-load 'w3m
    '(progn
       (evil-make-overriding-map w3m-mode-map 'normal)
       (evil-add-hjkl-bindings w3m-mode-map 'normal
         "G" (lookup-key evil-motion-state-map "G")
         "g" (lookup-key evil-motion-state-map "g")
         "v" (lookup-key evil-motion-state-map "v")
         "V" (lookup-key evil-motion-state-map "V")
         "b" (lookup-key evil-motion-state-map "b")))))

(evil-set-initial-state 'dired-mode 'motion)
(eval-after-load 'dired
  '(progn
     (evil-make-overriding-map dired-mode-map 'motion)
     (evil-add-hjkl-bindings dired-mode-map 'motion
       "G" (lookup-key evil-motion-state-map "G")
       "g" (lookup-key evil-motion-state-map "g")
       "v" (lookup-key evil-motion-state-map "v")
       "V" (lookup-key evil-motion-state-map "V")
       "b" (lookup-key evil-motion-state-map "b"))))


;; (when (require 'sdic nil t)
;;   (add-to-list 'evil-emacs-state-modes 'sdic-mode)
;;   (evil-set-initial-state 'sdic-mode 'motion)
;;   (eval-after-load 'sdic
;;     '(progn
;;        (evil-make-overriding-map sdic-mode-map 'motion)
;;        (evil-add-hjkl-bindings sdic-mode-map 'motion
;;          "G" (lookup-key evil-motion-state-map "G")
;;          "g" (lookup-key evil-motion-state-map "g")))))

;; TODO summary-modeで C-t できない。
(delq 'gnus-group-mode evil-emacs-state-modes)
(delq 'gnus-summary-mode evil-emacs-state-modes)
(delq 'gnus-article-mode evil-emacs-state-modes)
(eval-after-load 'gnus
  '(progn
     (evil-make-overriding-map gnus-group-mode-map 'normal)
     (evil-add-hjkl-bindings gnus-group-mode-map 'normal)

     (evil-make-overriding-map gnus-summary-mode-map 'normal)
     (evil-add-hjkl-bindings gnus-summary-mode-map 'normal)
     (define-key gnus-summary-mode-map (kbd "C-t") 'switch-to-last-buffer-or-other-window)

     (evil-make-overriding-map gnus-article-mode-map 'normal)
     (evil-add-hjkl-bindings gnus-article-mode-map 'normal)))

(when (require 'newsticker t)
  (add-to-list 'evil-emacs-state-modes 'newsticker-treeview-mode)
  (add-to-list 'evil-emacs-state-modes 'newsticker-treeview-list-mode)
  (evil-set-initial-state 'newsticker-item-mode 'motion)
  (eval-after-load 'w3m
    '(progn
       (evil-make-overriding-map newsticker-treeview-item-mode-map 'normal)
       (evil-add-hjkl-bindings newsticker-treeview-item-mode-map 'normal
         "G" (lookup-key evil-motion-state-map "G")
         "g" (lookup-key evil-motion-state-map "g")
         "v" (lookup-key evil-motion-state-map "v")
         "V" (lookup-key evil-motion-state-map "V")
         "b" (lookup-key evil-motion-state-map "b")))))

;;-----------------------------------------------------------------
;; 特定のメージャーモードをemacs互換に指定する
;;-----------------------------------------------------------------
;;(add-to-list 'evil-emacs-state-modes 'eshell-mode)

;; ;;-----------------------------------------------------------------
;; ;; S Expression key bind
;; ;;-----------------------------------------------------------------
;; (defun mikio/forward-sexp (&optional arg)
;;   "閉括弧で移動が止まってしまうのをなんとかする"
;;   (interactive)
;;   (let ((cur-point (point)))
;;     (save-excursion
;;       (forward-char)
;;       (paredit-forward)
;;       (setq cur-point (point)))
;;     (goto-char cur-point)))

;; (evil-define-key 'normal emacs-lisp-mode-map
;;   ",e" 'eval-last-sexp
;;   ",x" 'lispxmp)

;; (evil-define-key 'normal paredit-mode-map

;;   ;; slimv.vim 
;;   ;; (kbd ", W") 'paredit-wrap-round
;;   ;; (kbd ", w (") 'paredit-wrap-round
;;   ;; (kbd ", w [") 'paredit-wrap-round
;;   ;; (kbd ", w {") 'paredit-wrap-round
;;   ;; (kbd ", w \"") 'paredit-meta-doublequote
;;   ;; (kbd ", S") 'paredit-splice-sexp
;;   ;; (kbd ", I") 'paredit-raise-sexp

;;   ",w" 'paredit-wrap-round
;;   ",\"" 'paredit-meta-doublequote
;;   ",s" 'paredit-splice-sexp
;;   ",r" 'paredit-raise-sexp

;;   ",>" 'paredit-forward-slurp-sexp      ; (aaa|) bbb => (aaa bbb|)
;;   ",<" 'paredit-backward-slurp-sexp     ; (aaa bbb|) => (aaa|) bbb
;;   ",j" 'paredit-join-sexps              ; (aaa)| (bbb) => (aaa |bbb)
  
;;   "(" 'paredit-backward
;;   ")" 'mikio/forward-sexp
;;   "<" 'paredit-backward-up
;;   ">" 'paredit-forward-down

;;   "D" 'paredit-kill
;;   "x" 'paredit-forward-delete) 

;; (evil-define-key 'visual paredit-mode-map
;;   ", w" 'paredit-wrap-round
;;   ", \"" 'paredit-meta-doublequote)


;; ;;-----------------------------------------------------------------
;; ;; eshell
;; ;;-----------------------------------------------------------------
;; (when t
;;   (defun my-eshell-goto-end ()
;;     (interactive)
;;     (when (eq major-mode 'eshell-mode)
;;       (goto-char eshell-last-output-end))
;;     )
;;   (defun my-eshell-return ()
;;     (interactive)
;;     (eshell-send-input)
;;     (goto-char eshell-last-output-end)
;;     )

;;   (evil-declare-key 'normal eshell-mode-map (kbd "G") 'my-eshell-goto-end)
;;   (evil-declare-key 'normal eshell-mode-map (kbd "<return>") 'my-eshell-return)
;;   (evil-declare-key 'normal eshell-mode-map (kbd "RET") 'my-eshell-return)

;;   (evil-declare-key 'insert eshell-mode-map (kbd "C-o") 'anything-eshell-history)
;;   (evil-declare-key 'insert eshell-mode-map (kbd "C-p") 'eshell-cmdline/C-p)
;;   (evil-declare-key 'insert eshell-mode-map (kbd "C-n") 'eshell-cmdline/C-n)
;;   (evil-declare-key 'insert eshell-mode-map (kbd "C-w") 'eshell-cmdline/C-w))

;; ;;-----------------------------------------------------------------
;; ;; moccur
;; ;;-----------------------------------------------------------------
;; ;; (when (require 'color-moccur nil t)
;; ;;   (evil-declare-key 'normal moccur-mode-map (kbd "<return>") 'moccur-grep-goto)
;; ;;   (evil-declare-key 'normal moccur-mode-map (kbd "RET") 'moccur-grep-goto)
;; ;;   (evil-declare-key 'normal moccur-mode-map (kbd "q") 'quit-window)
;; ;;   (evil-declare-key 'normal moccur-mode-map (kbd "r") 'moccur-edit-mode-in)
;; ;;   (evil-declare-key 'normal moccur-mode-map (kbd "C-j") 'moccur-next)
;; ;;   (evil-declare-key 'normal moccur-mode-map (kbd "C-k") 'moccur-prev)
;; ;;   )

;; ;;-----------------------------------------------------------------
;; ;; org-mode
;; ;;-----------------------------------------------------------------
;; (when t
;;   (defun my-org-meta-return (&optional prefix)
;;     (interactive "p") ; pは数引数(C-u)を受けとり、この場合はprefixに束縛される。
;;     (evil-insert 1)
;;     (move-end-of-line nil)          
;;     (message "arg:%s" (or prefix 0))
;;     (org-insert-heading-dwim prefix)
;;     ) 

;;   (evil-define-key 'normal org-mode-map
;;     (kbd "RET") 'org-open-at-point
;;     (kbd "C-i") 'org-cycle              ; 見出しの開閉をサイクルする
;;     ",e" 'org-export                    ; 別フィアルへのエクスポート
;;     ",t" 'org-todo
;;     ",l" 'org-insert-link
;;     (kbd "<C-return>") 'my-org-meta-return 
;;     (kbd "M-j") 'org-shiftleft
;;     (kbd "M-k") 'org-shiftright
;;     (kbd "M-h") 'org-metaleft
;;     (kbd "M-l") 'org-metaright
;;     (kbd "M-H") 'org-shiftmetaleft
;;     (kbd "M-L") 'org-shiftmetaright))

(provide 'mikio-evil)
