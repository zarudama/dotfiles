(require 'mikio-util)

(require 'evil)

(evil-mode 1)

(defun evil-undefine ()
 (interactive)
 (let (evil-mode-map-alist)
   (call-interactively (key-binding (this-command-keys)))))

(add-hook 'evil-normal-state-entry-hook (lambda () (set-face-background 'mode-line "White")))
(add-hook 'evil-insert-state-entry-hook (lambda () (set-face-background 'mode-line "Red")))
(add-hook 'evil-visual-state-entry-hook (lambda () (set-face-background 'mode-line "DarkRed")))
(add-hook 'evil-replace-state-entry-hook (lambda () (set-face-background 'mode-line "DarkRed")))
(add-hook 'evil-operator-state-entry-hook (lambda () (set-face-background 'mode-line "DarkRed")))
(add-hook 'evil-motion-state-entry-hook (lambda () (set-face-background 'mode-line "DarkRed")))

(evil-set-initial-state 'sdic-mode 'emacs)
(evil-set-initial-state 'moccur-grep-mode 'emacs)
(evil-set-initial-state 'jabber-mode 'emacs)

;;(require 'evil-leader)
;; (setq evil-leader/leader ","
;;       evil-leader/in-all-states t)

;;-----------------------------------------------------------------
;; global evil key bind
;;-----------------------------------------------------------------
(define-key evil-normal-state-map (kbd "C-t") 'switch-to-last-buffer-or-other-window)
(define-key evil-insert-state-map (kbd "C-e") 'move-end-of-line)
(define-key evil-insert-state-map (kbd "M-C-h") 'backward-kill-word)
(define-key evil-insert-state-map (kbd "C-k") 'kill-line)

;;-----------------------------------------------------------------
;; S Expression key bind
;;-----------------------------------------------------------------
(defun mikio/forward-sexp (&optional arg)
  "閉括弧で移動が止まってしまうのをなんとかする"
  (interactive)
  (let ((cur-point (point)))
    (save-excursion
      (forward-char)
      (paredit-forward)
      (setq cur-point (point)))
    (goto-char cur-point)))

(evil-define-key 'normal emacs-lisp-mode-map
  ",e" 'eval-last-sexp
  ",x" 'lispxmp)

(evil-define-key 'normal paredit-mode-map

  ;; slimv.vim 
  ;; (kbd ", W") 'paredit-wrap-round
  ;; (kbd ", w (") 'paredit-wrap-round
  ;; (kbd ", w [") 'paredit-wrap-round
  ;; (kbd ", w {") 'paredit-wrap-round
  ;; (kbd ", w \"") 'paredit-meta-doublequote
  ;; (kbd ", S") 'paredit-splice-sexp
  ;; (kbd ", I") 'paredit-raise-sexp

  ",w" 'paredit-wrap-round
  ",\"" 'paredit-meta-doublequote
  ",s" 'paredit-splice-sexp
  ",r" 'paredit-raise-sexp

  ",>" 'paredit-forward-slurp-sexp      ; (aaa|) bbb => (aaa bbb|)
  ",<" 'paredit-backward-slurp-sexp     ; (aaa bbb|) => (aaa|) bbb
  ",j" 'paredit-join-sexps              ; (aaa)| (bbb) => (aaa |bbb)
  
  "(" 'paredit-backward
  ")" 'mikio/forward-sexp
  "<" 'paredit-backward-up
  ">" 'paredit-forward-down

  "D" 'paredit-kill
  "x" 'paredit-forward-delete) 

(evil-define-key 'visual paredit-mode-map
  ", w" 'paredit-wrap-round
  ", \"" 'paredit-meta-doublequote)

;;-----------------------------------------------------------------
;; dired
;;-----------------------------------------------------------------
(when t
  (evil-declare-key 'normal dired-mode-map (kbd "j") 'dired-next-line)
  (evil-declare-key 'normal dired-mode-map (kbd "k") 'dired-previous-line)
  (evil-declare-key 'normal dired-mode-map (kbd "C-h") 'dired-up-directory)
  (evil-declare-key 'normal dired-mode-map (kbd "i") 'dired-maybe-insert-subdir)
  (evil-declare-key 'normal dired-mode-map (kbd "r") 'wdired-change-to-wdired-mode)
  (evil-declare-key 'normal dired-mode-map (kbd "q") 'quit-window))

;;-----------------------------------------------------------------
;; eshell
;;-----------------------------------------------------------------
(when t
  (defun my-eshell-goto-end ()
    (interactive)
    (when (eq major-mode 'eshell-mode)
      (goto-char eshell-last-output-end))
    )
  (defun my-eshell-return ()
    (interactive)
    (eshell-send-input)
    (goto-char eshell-last-output-end)
    )

  (evil-declare-key 'normal eshell-mode-map (kbd "G") 'my-eshell-goto-end)
  (evil-declare-key 'normal eshell-mode-map (kbd "<return>") 'my-eshell-return)
  (evil-declare-key 'normal eshell-mode-map (kbd "RET") 'my-eshell-return)

  (evil-declare-key 'insert eshell-mode-map (kbd "C-o") 'anything-eshell-history)
  (evil-declare-key 'insert eshell-mode-map (kbd "C-p") 'eshell-cmdline/C-p)
  (evil-declare-key 'insert eshell-mode-map (kbd "C-n") 'eshell-cmdline/C-n)
  (evil-declare-key 'insert eshell-mode-map (kbd "C-w") 'eshell-cmdline/C-w))

;;-----------------------------------------------------------------
;; gtags
;;-----------------------------------------------------------------
(when (executable-find "gtags")
  (evil-declare-key 'normal gtags-mode-map (kbd "C-c C-j") 'gtags-find-tag-from-here)
  (evil-declare-key 'normal gtags-mode-map (kbd "C-c C-b") 'gtags-pop-stack)
  )

;;-----------------------------------------------------------------
;; moccur
;;-----------------------------------------------------------------
;; (when (require 'color-moccur nil t)
;;   (evil-declare-key 'normal moccur-mode-map (kbd "<return>") 'moccur-grep-goto)
;;   (evil-declare-key 'normal moccur-mode-map (kbd "RET") 'moccur-grep-goto)
;;   (evil-declare-key 'normal moccur-mode-map (kbd "q") 'quit-window)
;;   (evil-declare-key 'normal moccur-mode-map (kbd "r") 'moccur-edit-mode-in)
;;   (evil-declare-key 'normal moccur-mode-map (kbd "C-j") 'moccur-next)
;;   (evil-declare-key 'normal moccur-mode-map (kbd "C-k") 'moccur-prev)
;;   )

;;-----------------------------------------------------------------
;; nrepl
;;-----------------------------------------------------------------
(when (require 'nrepl nil t)
  (add-hook 'evil-insert-state-entry-hook
            (lambda ()
              (when (eq major-mode 'nrepl-mode)
                (end-of-buffer)
                )))

  (evil-declare-key 'normal nrepl-mode-map (kbd "G")
                    (lambda ()
                      (end-of-buffer)))

  )

;;-----------------------------------------------------------------
;; org-mode
;;-----------------------------------------------------------------
(when t
  (defun my-org-meta-return (&optional prefix)
    (interactive "p") ; pは数引数(C-u)を受けとり、この場合はprefixに束縛される。
    (evil-insert 1)
    (move-end-of-line nil)          
    (message "arg:%s" (or prefix 0))
    (org-insert-heading-dwim prefix)
    ) 

  (evil-define-key 'normal org-mode-map
    (kbd "RET") 'org-open-at-point
    (kbd "C-i") 'org-cycle              ; 見出しの開閉をサイクルする
    ",e" 'org-export                    ; 別フィアルへのエクスポート
    ",t" 'org-todo
    ",l" 'org-insert-link
    (kbd "<C-return>") 'my-org-meta-return 
    (kbd "M-j") 'org-shiftleft
    (kbd "M-k") 'org-shiftright
    (kbd "M-h") 'org-metaleft
    (kbd "M-l") 'org-metaright
    (kbd "M-H") 'org-shiftmetaleft
    (kbd "M-L") 'org-shiftmetaright))

;;-----------------------------------------------------------------
;; skk
;;-----------------------------------------------------------------
(when (require 'skk nil t)
  (add-hook 'evil-normal-state-entry-hook
            (lambda ()
              (skk-mode -1))))

;;-----------------------------------------------------------------
;; slime
;;-----------------------------------------------------------------
(when (require 'evil nil t)

  (add-hook 'evil-insert-state-entry-hook
            (lambda ()
              (when (eq major-mode 'slime-repl-mode)
                (end-of-buffer)
                )))

  (evil-declare-key 'normal slime-repl-mode-map (kbd "G")
                    (lambda ()
                      (end-of-buffer)))

  )

;;-----------------------------------------------------------------
;; tabbar
;;-----------------------------------------------------------------
(when (require 'tabbar nil t)
  (define-key evil-normal-state-map (kbd "C-p") 'tabbar-backward-tab)
  (define-key evil-normal-state-map (kbd "C-n") 'tabbar-forward-tab)
  ;; (define-key evil-normal-state-map (kbd "C-P") '(lambda () (delete-other-windows) (tabbar-forward-group)))
  ;; (define-key evil-normal-state-map (kbd "C-N") '(lambda () (delete-other-windows) (tabbar-backward-group))))
  )

;;-----------------------------------------------------------------
;; twitter
;;-----------------------------------------------------------------
(when (require 'twittering-mode nil t)
  (define-key twittering-mode-map (kbd "C-p") 'tabbar-backward-tab)
  (define-key twittering-mode-map (kbd "C-n") 'tabbar-forward-tab)
  )


(provide 'mikio-evil)
