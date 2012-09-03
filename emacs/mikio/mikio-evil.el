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


(provide 'mikio-evil)
