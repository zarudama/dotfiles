(require 'mikio-util)

(require 'evil)
(require 'paredit)
(require 'tabbar)
(evil-mode 1)

;;(define-key global-map (kbd "C-g") 'evil-force-normal-state)

(define-key evil-normal-state-map [escape] 'keyboard-quit)
(define-key evil-visual-state-map [escape] 'keyboard-quit)
(define-key minibuffer-local-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-ns-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-completion-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-must-match-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-isearch-map [escape] 'minibuffer-keyboard-quit)

;; (setq evil-default-state 'normal)

;; ;; メジャーモード毎にevilの初期状態を設定する。
;; (evil-set-initial-state 'eshell-mode 'emacs)
;; (evil-set-initial-state 'dired-mode 'emacs)
;; ;;(evil-set-initial-state 'ibuffer-mode 'emacs)
;; (evil-set-initial-state 'Buffer-menu-mode 'emacs)
;; (evil-set-initial-state 'undo-tree-mode 'emacs)
;; (evil-set-initial-state 'info-mode 'emacs)
;; (evil-set-initial-state 'twittering-mode 'emacs)
;; (evil-set-initial-state 'w3m-mode 'emacs)


;; (define-prefix-command 'evil-g-map)
;; (define-key global-map (kbd "g") 'evil-g-map)
;; (define-key global-map (kbd "g g") 'beginning-of-buffer)
;; (define-key global-map (kbd "G") 'end-of-buffer)
;; (define-key global-map (kbd "C-t") 'switch-to-last-buffer-or-other-window)

(define-key evil-normal-state-map (kbd "C-t") 'switch-to-last-buffer-or-other-window)

;; Insert時はemacsのキーバインドにする。
;; (setcdr evil-insert-state-map nil)
;; (define-key evil-insert-state-map
;;   (read-kbd-macro evil-toggle-key) 'evil-emacs-state)

; (add-hook 'evil-normal-state-entry-hook (lambda () (set-face-background 'mode-line "DarkRed")))
;; (add-hook 'evil-insert-state-entry-hook (lambda () (set-face-background 'mode-line "Red")))
;; (add-hook 'evil-visual-state-entry-hook (lambda () (set-face-background 'mode-line "DarkRed")))
;; (add-hook 'evil-replace-state-entry-hook (lambda () (set-face-background 'mode-line "DarkRed")))
;; (add-hook 'evil-operator-state-entry-hook (lambda () (set-face-background 'mode-line "DarkRed")))
;; (add-hook 'evil-motion-state-entry-hook (lambda () (set-face-background 'mode-line "DarkRed")))

;; ---------------------------------------------------------------
;; evil-declare-key と evil-define-key の違い。
;; どちらもほとんど同じだが、declareのほうは、keymapが存在しなくても定義できる。 
;; なのでほとんどの場合は、declareを使用したほうがよいと思われ。

(evil-declare-key 'motion completion-list-mode-map (kbd "<return>") 'choose-completion)
(evil-declare-key 'motion completion-list-mode-map (kbd "RET") 'choose-completion)
(evil-declare-key 'motion browse-kill-ring-mode-map (kbd "<return>") 'browse-kill-ring-insert-and-quit)
(evil-declare-key 'motion browse-kill-ring-mode-map (kbd "RET") 'browse-kill-ring-insert-and-quit)
(evil-declare-key 'motion occur-mode-map (kbd "<return>") 'occur-mode-goto-occurrence)
(evil-declare-key 'motion occur-mode-map (kbd "RET") 'occur-mode-goto-occurrence)

(evil-declare-key 'motion w3m-mode-map (kbd "<return>") 'w3m-view-this-url)
(evil-declare-key 'motion w3m-mode-map (kbd "RET") 'w3m-view-this-url)

;(defun my-elisp-eval ()
;  (interactive) 
;  (eval-last-sexp ((move-end-of-line 1)))

;; {count}{operate}{motion="s"} ;; s=simple-expression
;(evil-define-key 'normal emacs-lisp-mode-map
; ",e" 'eval-last-sexp       ;; C-M-f
; ",x" 'lispxmp              ;; C-M-f
; ",f" 'forward-sexp         ;; C-M-f
; ",b" 'backward-sexp        ;; C-M-b
; ",u" 'backward-up-list     ;; C-M-u
; ",d" 'down-list            ;; C-M-d 
; ",k" 'kill-sexp            ;; C-M-k 
; ",y" 'mark-sexp            ;; C-M-SPC 
; ",y" 'mark-sexp            ;; C-M-SPC 
; ",(" 'paredit-wrap-round   ;; M-( 
; ",s" 'paredit-splice-sexp
;) ;; M-s
;; (indent-pp-sexp &optional ARG) C-M-q
;; (evil-define-key 'normal emacs-lisp-mode-map
;;  ",u" 'backward-up-list     ;; C-M-u
;;  ",d" 'down-list            ;; C-M-d 
;;  ",e" 'eval-last-sexp       ;; C-M-f
;;  ",x" 'lispxmp              ;; C-M-f
;;  ",(" 'paredit-wrap-round   ;; M-( 
;;  ",s" 'paredit-splice-sexp  ;; M-s 
;; )
;; (indent-pp-sexp &optional ARG) C-M-q

;;(setq evil-want-visual-char-semi-exclusive t)

;; You may try the following motions for sexp-navigation.
;; The main difference to the Emacs ones is that (point) is that the closing ")" is
;; considered as the end of an sexp and point is placed there instead of the following character.
;; Note that this is only a quick hack and widely untested (there may very well be edge cases)!
;; (evil-define-motion evil-fwd-sexp (count)
;;   :type inclusive
;;   (setq count (or count 1))
;;   (unless (zerop count)
;;     (goto-char
;;      (save-excursion
;;        (condition-case err
;;            (let ((opoint (point)))
;;              (cond
;;               ((> count 0)
;;                (condition-case nil
;;                    (forward-sexp)
;;                  (error (forward-char))
;;                  )
;;                (when (> (point) (1+ opoint))
;;                  (setq count (1- count))
;;                  )
;;                forward-sexp count)
;;               backward-char)
;;              point))
;;        (t
;;         (setq count (- count))
;;         (forward-char)
;;         (condition-case nil
;;             (progn
;;               (backward-sexp)
;;               (setq count (1- count)))
;;           error (backward-char)))
;;        backward-sexp count)
;;      (point))))

;; (evil-define-motion evil-bwd-sexp (count)
;;    :type inclusive
;;    (evil-fwd-sexp (- (or count 1))))

;; (evil-define-motion evil-fwd-sexp (count)
;;   :type inclusive
;;   (progn
;;     (forward-char)
;;     (forward-sexp))
;;   )

;; (evil-define-motion evil-bwd-sexp (count)
;;   :type inclusive
;;   (backward-sexp))

;; (define-key evil-operator-state-map (kbd "C-M-f") 'evil-fwd-sexp)
;; (define-key evil-operator-state-map (kbd "C-M-b") 'evil-bwd-sexp)

;(org-meta-return &optional ARG)
; https://github.com/cofi/dotfiles/blob/master/emacs.d/config/cofi-evil.el 
(evil-define-key 'normal org-mode-map
  (kbd "RET") 'org-open-at-point
  (kbd "C-i") 'org-cycle ;; 見出しの開閉をサイクルする
  ",e" 'org-export       ;; 別フィアルへのエクスポート
  ",t" 'org-todo
  ",l" 'org-insert-link
  (kbd "M-m") 'org-meta-return
  (kbd "M-j") 'org-shiftleft
  (kbd "M-k") 'org-shiftright
  (kbd "M-h") 'org-metaleft
  (kbd "M-l") 'org-metaright
  (kbd "M-H") 'org-shiftmetaleft
  (kbd "M-L") 'org-shiftmetaright)

(evil-define-key 'insert org-mode-map
  (kbd "RET") 'org-open-at-point
  (kbd "C-i") 'org-cycle ;; 見出しの開閉をサイクルする
  "ze" 'org-export       ;; 別フィアルへのエクスポート
  "zt" 'org-todo
  "zl" 'org-insert-link
  (kbd "M-m") 'org-meta-return
  (kbd "M-j") 'org-shiftleft
  (kbd "M-k") 'org-shiftright
  (kbd "M-h") 'org-metaleft
  (kbd "M-l") 'org-metaright
  (kbd "M-H") 'org-shiftmetaleft
  (kbd "M-L") 'org-shiftmetaright)

;;;;(define-key evil-normal-state-map (kbd "H") (lambda () (progn (delete-other-windows) (tabbar-backward-group))))
;;(define-key evil-normal-state-map (kbd "L") (lambda () (progn (delete-other-windows) (tabbar-forward-group))))
(define-key evil-normal-state-map (kbd "C-p") 'tabbar-backward-tab)
(define-key evil-normal-state-map (kbd "C-n") 'tabbar-forward-tab)

;;;;;;;;;;;;;;;;
;; https://github.com/roman/emacs.d/tree/master/zoo
(defun zoo/turn-on-paredit ()
  (interactive)
  (paredit-mode 1))

(defun zoo/paredit-backward-edit (operation)
  (interactive
   (progn
     ;; abort the calling operator
     (setq evil-inhibit-operator t)
     (list (assoc-default evil-this-operator
                          '((evil-change . change)
                            (evil-delete . delete))))))
  (cond
   ((eq operation 'delete) (call-interactively 'paredit-backward-kill-word)
    ((eq operation 'change)
     (call-interactively 'paredit-backward-kill-word)
     (call-interactively 'evil-insert-state)))))

(defun zoo/paredit-forward-edit (operation)
  (interactive
   (progn
     ;; abort the calling operator
     (setq evil-inhibit-operator t)
     (list (assoc-default evil-this-operator
                          '((evil-change . change)
                            (evil-delete . delete))))))
  (cond
   ((eq operation 'delete) (call-interactively 'paredit-forward-kill-word))
   ((eq operation 'change)
      (call-interactively 'paredit-forward-kill-word)
      (call-interactively 'evil-insert-state))))

(evil-define-key 'normal paredit-mode-map
  (kbd ",>") 'paredit-forward-slurp-sexp ;; C-right => 括弧を広げる
  (kbd ",<") 'paredit-backward-slurp-sexp
  (kbd ";>") 'paredit-backward-barf-sexp ;; C-left => 括弧をせばめる
  (kbd ";<") 'paredit-forward-barf-sexp
  (kbd ",s") 'paredit-split-sexp
  (kbd ",j") 'paredit-join-sexps   ;; M-j 前後のS式どうしつなげる
  (kbd ",ks") 'paredit-splice-sexp ;; M-s
  (kbd ",kf") 'paredit-splice-sexp-killing-forward
  (kbd ",kb") 'paredit-splice-sexp-killing-backward
  (kbd ",ku") 'paredit-raise-sexp ;; M-r => 自分のまわりのS式を削除
  (kbd "(") 'paredit-backward
  (kbd ")") 'paredit-forward
  (kbd "<") 'paredit-backward
  (kbd ">") 'paredit-forward
  (kbd "D") 'paredit-kill)

(evil-define-key 'operator paredit-mode-map
  "w" 'zoo/paredit-forward-edit
  "b" 'zoo/paredit-backward-edit)
;;;;;;;;;;;;;;;;;
;; ESC extras
;;;;;;;;;;;;;;;;;

; Make <ESC> quit almost everything...
; As seen on:
; * http://stackoverflow.com/questions/8483182/emacs-evil-mode-best-practice
;; (define-key evil-normal-state-map [escape] 'keyboard-quit)
;; (define-key evil-visual-state-map [escape] 'keyboard-quit)
;; (define-key minibuffer-local-map [escape] 'minibuffer-keyboard-quit)
;; (define-key minibuffer-local-ns-map [escape] 'minibuffer-keyboard-quit)
;; (define-key minibuffer-local-completion-map [escape] 'minibuffer-keyboard-quit)
;; (define-key minibuffer-local-must-match-map [escape] 'minibuffer-keyboard-quit)
;; (define-key minibuffer-local-isearch-map [escape] 'minibuffer-keyboard-quit)


(defun evil-undefine ()
 (interactive)
 (let (evil-mode-map-alist)
   (call-interactively (key-binding (this-command-keys)))))

(provide 'mikio-evil)
