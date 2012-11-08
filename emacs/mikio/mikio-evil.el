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

(add-to-list 'evil-emacs-state-modes 'sdic-mode)
(add-to-list 'evil-emacs-state-modes 'moccure-grep-mode)
(add-to-list 'evil-emacs-state-modes 'jaber-mode)
(add-to-list 'evil-emacs-state-modes 'howm-menu-mode)
;;(add-to-list 'evil-emacs-state-modes 'howm-mode)
(add-to-list 'evil-emacs-state-modes 'howm-remember-mode)
(add-to-list 'evil-emacs-state-modes 'howm-view-contents-mode)
(add-to-list 'evil-emacs-state-modes 'howm-view-summary-mode)
(add-to-list 'evil-emacs-state-modes 'helm-map)

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
(evil-set-toggle-key (kbd "C-c C-z"))

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
  (evil-declare-key 'normal dired-mode-map (kbd "q") 'quit-window)
  (evil-declare-key 'normal dired-mode-map (kbd "C-t") 'switch-to-last-buffer-or-other-window)
  (evil-declare-key 'normal dired-mode-map (kbd "g g") 'evil-goto-first-line)
  (evil-declare-key 'normal dired-mode-map (kbd "G") 'evil-goto-line)
  (if (eq window-system 'w32)
      (evil-declare-key 'normal dired-mode-map (kbd "z") 'uenox-dired-winstart)))

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
  (evil-set-initial-state 'twittering-mode 'normal)
  (evil-declare-key 'normal twittering-mode-map (kbd "<return>") 'twittering-enter)
  (evil-declare-key 'normal twittering-mode-map (kbd "C-m")  'twittering-enter)
  (define-key twittering-mode-map (kbd "C-p") 'tabbar-backward-tab)
  (define-key twittering-mode-map (kbd "C-n") 'tabbar-forward-tab)
  (evil-declare-key 'normal twittering-mode-map (kbd "^") 'beginning-of-line-text)
  (evil-declare-key 'normal twittering-mode-map (kbd "a") 'twittering-toggle-activate-buffer)
  ;;(evil-declare-key 'normal twittering-mode-map (kbd "b") 'twittering-switch-to-previous-timeline)
  (evil-declare-key 'normal twittering-mode-map (kbd "d") 'twittering-direct-message)
  ;;(evil-declare-key 'normal twittering-mode-map (kbd "f") 'twittering-switch-to-next-timeline)
  (evil-declare-key 'normal twittering-mode-map (kbd "g") 'twittering-current-timeline)
  (evil-declare-key 'normal twittering-mode-map (kbd "h") 'backward-char)
  (evil-declare-key 'normal twittering-mode-map (kbd "i") 'twittering-icon-mode)
  (evil-declare-key 'normal twittering-mode-map (kbd "j") 'twittering-goto-next-status)
  (evil-declare-key 'normal twittering-mode-map (kbd "k") 'twittering-goto-previous-status)
  (evil-declare-key 'normal twittering-mode-map (kbd "l") 'forward-char)
  (evil-declare-key 'normal twittering-mode-map (kbd "n") 'twittering-goto-next-status-of-user)
  (evil-declare-key 'normal twittering-mode-map (kbd "p") 'twittering-goto-previous-status-of-user)
  (evil-declare-key 'normal twittering-mode-map (kbd "r") 'twittering-toggle-show-replied-statuses)
  (evil-declare-key 'normal twittering-mode-map (kbd "s") 'twittering-search)
  (evil-declare-key 'normal twittering-mode-map (kbd "t") 'twittering-toggle-proxy)
  (evil-declare-key 'normal twittering-mode-map (kbd "u") 'twittering-update-status-interactive)
  ;;(evil-declare-key 'normal twittering-mode-map (kbd "v") 'twittering-other-user-timeline)
 )


;;-----------------------------------------------------------------
;; w3m
;;-----------------------------------------------------------------
(when t
  (evil-set-initial-state 'w3m-mode 'normal)
  (evil-declare-key 'normal w3m-mode-map (kbd "<return>") 'w3m-view-this-url)
  (evil-declare-key 'normal w3m-mode-map (kbd "C-m") 'w3m-view-this-url)
  ;; タブ一覧
  (evil-declare-key 'normal w3m-mode-map (kbd "a") 'w3m-select-buffer)

  ;; タブを閉じる
  (evil-declare-key 'normal w3m-mode-map (kbd "d") 'w3m-delete-buffer)
  (evil-declare-key 'normal w3m-mode-map (kbd "D") 'w3m-delete-other-buffers)

  (evil-declare-key 'normal w3m-mode-map (kbd "C-M-i") 'w3m-toggle-inline-images) ; 画像表示のトグル
  (evil-declare-key 'normal w3m-mode-map (kbd "C-i") 'w3m-view-image) ; 画像表示

  (evil-declare-key 'normal w3m-mode-map (kbd "R") 'w3m-redisplay-this-page) ; 再描画
  (evil-declare-key 'normal w3m-mode-map (kbd "r") 'w3m-reload-this-page) ; 再読込

  (evil-declare-key 'normal w3m-mode-map (kbd "C-l") 'w3m-goto-url) ; URL指定
  (evil-declare-key 'normal w3m-mode-map (kbd "C-c t") 'w3m-goto-url-new-session) ; タブを作成

  ;; タブを移動する
  (evil-declare-key 'normal w3m-mode-map (kbd "C-n") '(lambda () (interactive) (w3m-next-buffer 1)))
  (evil-declare-key 'normal w3m-mode-map (kbd "C-p") '(lambda () (interactive) (w3m-next-buffer -1)))

  (evil-declare-key 'normal w3m-mode-map (kbd "H") 'w3m-view-previous-page)
  (evil-declare-key 'normal w3m-mode-map (kbd "L") 'w3m-view-next-page)

  (when (require 'jaunte nil t)
    (evil-declare-key 'normal w3m-mode-map (kbd "F") 'jaunte)
    (evil-declare-key 'normal w3m-mode-map (kbd "f") 'w3m-go-to-linknum)))


(provide 'mikio-evil)
