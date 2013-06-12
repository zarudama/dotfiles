(require 'mikio-util)

;; evilの設定において下記は必読
;;   http://d.hatena.ne.jp/tarao/20130304/evil_config

(require 'evil)

(evil-mode 1)
;;(require 'evil-mode-line)
(setq evil-esc-delay 0.001)

;; CUI環境だと、auto-completeが効いてるときにESCを押下しても
;; NormalStateに移行しないのでその対策。
(when (locate-library "auto-complete")
  (require 'auto-complete)
  (defun my-ac-stop ()
    (interactive)
    (ac-stop)
    (evil-normal-state 1))
  (define-key ac-menu-map (kbd "ESC") 'my-ac-stop))

;;; paredit.elをevilから使用する
;; ...自分が期待する動きをしてくれない。。。
(when (require 'evil-paredit nil t)
  (add-hook 'nrepl-mode-hook 'evil-paredit-mode)
  (add-hook 'emacs-lisp-mode-hook 'evil-paredit-mode)
  (add-hook 'slime-repl-mode-hook 'evil-paredit-mode))

;-----------------------------------------------------------------
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

;;-----------------------------------------------------------------
;; skk
;; ノーマルステート時に状態遷移した時に、skkが起動している場合、
;; 自動的にアスキーモードにする。
;;-----------------------------------------------------------------
(when (locate-library "skk")
  (require 'skk)
  (defun my-skk-control ()
    (when skk-mode
      (skk-latin-mode 1)))
  (add-hook 'evil-normal-state-entry-hook 'my-skk-control))

;;-----------------------------------------------------------------
;; tabbar
;;-----------------------------------------------------------------
(when (and (locate-library "tabbar") (locate-library "smartrep"))
  (require 'tabbar)
  (require 'smartrep)
  ;; d でバッファを即時削除
  (smartrep-define-key evil-normal-state-map "C-c"
    '(
      ("n" . 'tabbar-forward-tab)
      ("p" . 'tabbar-backward-tab)
      ("P" . (lambda () (progn (delete-other-windows) (tabbar-forward-group))))
      ("N" . (lambda () (progn (delete-other-windows) (tabbar-backward-group))))
      ;;("d" . '(lambda () (interactive) (kill-buffer (buffer-name (current-buffer)))))
      )))

;;-----------------------------------------------------------------
;; 基本方針として、移動系のよく使用するコマンドとコピーコマンド以外は
;; emacsのメジャーモードのキーバインドを優先させる。
;;
;;  [N] normalはノーマルステート
;;  [I] insertは挿入ステート
;;  [V] visualはビジュアルステート(範囲選択中のステート)
;;  [O] operatorはオペレータ待機ステート(オペレータを入力してから後続のキーを入力するまでのステート)
;;  [R] replaceは置換ステート(Rしたときのステート)
;;  [M] motionは編集を伴わない状態を表すためのステートです
;;  motionステートで定義されたキーはnormalやvisualでも使えます
;;  normalで定義されたキーはvisualでも使えます.
;;
;; lookup-keyによるコマンドの上書きは、そのコマンドの定義してあるステートで記述しなければならない。
;; https://bitbucket.org/lyro/evil/src/master/evil-maps.el
;;
;; evil-make-overriding-map
;;   特定のメージャーモードのキーマップをevilより優先させる
;; evil-add-hjkl-bindings
;;   emacsを優先させつつも hjkl に限り優先させる
;;
;; 特定のメージャーモードをemacs互換に指定する
;; (add-to-list 'evil-emacs-state-modes 'eshell-mode)
;-----------------------------------------------------------------
(defmacro my-evil-add-hjkl-bindings (mode-map state &rest bindings)
"hjklについてはvimコマンドを利用。
あとは足りないコマンドを付けたしていく。" 
  (declare (indent defun))
  `(progn (evil-make-overriding-map ,mode-map ,state)
          (evil-add-hjkl-bindings ,mode-map ,state
            ;; ノーマルステートで0押下時は、motions-steteの０コマンドを使用する。
            "0" (lookup-key evil-motion-state-map "0")
            "$" (lookup-key evil-motion-state-map "$")
            "w" (lookup-key evil-motion-state-map "w")
            "b" (lookup-key evil-motion-state-map "b")
            "n" (lookup-key evil-motion-state-map "n")
            "N" (lookup-key evil-motion-state-map "N")
            "G" (lookup-key evil-motion-state-map "G")
            "g" (lookup-key evil-motion-state-map "g")
            "y" (lookup-key evil-normal-state-map "y")
            "v" (lookup-key evil-motion-state-map "v")
            "V" (lookup-key evil-motion-state-map "V")
            "C-e" (lookup-key evil-normal-state-map "C-e")
            ,@bindings
            )))

(evil-set-initial-state 'dired-mode 'normal)
(eval-after-load 'dired
  '(progn
     (my-evil-add-hjkl-bindings dired-mode-map 'normal)
     (evil-declare-key 'normal dired-mode-map (kbd "C-c C-c") 'revert-buffer)))

(when (locate-library "w3m")
  (evil-set-initial-state 'w3m-mode 'normal)
  (eval-after-load 'w3m
    '(progn
       (my-evil-add-hjkl-bindings w3m-mode-map 'normal
;;         "C-e" (lookup-key evil-normal-state-map "C-e")
         "f" (lookup-key w3m-mode-map "e")
         "F" (lookup-key w3m-mode-map "E")
         "H" (lookup-key w3m-mode-map "B")
         "L" (lookup-key w3m-mode-map "F")))))

(when (locate-library "howm")
  (eval-after-load 'howm
    '(progn
       (my-evil-add-hjkl-bindings howm-menu-mode-map 'normal)
       (my-evil-add-hjkl-bindings howm-remember-mode-map 'normal)
       (my-evil-add-hjkl-bindings howm-view-contents-mode-map 'normal)
       (my-evil-add-hjkl-bindings howm-view-summary-mode-map 'normal))))

(delq 'gnus-group-mode evil-emacs-state-modes)
(delq 'gnus-summary-mode evil-emacs-state-modes)
(delq 'gnus-article-mode evil-emacs-state-modes)
(eval-after-load 'gnus
  '(progn
     (my-evil-add-hjkl-bindings gnus-group-mode-map 'normal)
     (my-evil-add-hjkl-bindings gnus-article-mode-map 'normal)
     (my-evil-add-hjkl-bindings gnus-summary-mode-map 'normal)
     (evil-declare-key 'normal gnus-article-mode-map (kbd "q") 'gnus-article-read-summary-keys)
     (evil-declare-key 'normal gnus-group-mode-map (kbd "C-c C-c") 'gnus-group-get-new-news)
     (evil-declare-key 'normal gnus-summary-mode-map (kbd "C-t") 'switch-to-last-buffer-or-other-window)))

(when (locate-library "twittering-mode")
  (delq 'twittering-mode evil-emacs-state-modes)
  (eval-after-load 'twittering-mode
    '(progn
       (my-evil-add-hjkl-bindings twittering-mode-map 'normal
         "j" (lookup-key twittering-mode-map "j"))
       (evil-declare-key 'normal twittering-mode-map (kbd "C-c v") 'twittering-other-user-timeline))))

(when (locate-library "sdic")
  (require 'sdic)
  (add-to-list 'evil-emacs-state-modes 'sdic-mode))

(when (locate-library "color-moccur")
  (require 'color-moccur)
  (add-to-list 'evil-emacs-state-modes 'moccur-grep-mode))

(when (locate-library "nrepl")
  (evil-set-initial-state 'nrepl-mode 'insert)
  (add-to-list 'evil-emacs-state-modes 'nrepl-popup-buffer-mode))

(add-to-list 'evil-emacs-state-modes 'navi2ch-list-mode)
(add-to-list 'evil-emacs-state-modes 'navi2ch-board-mode)
(add-to-list 'evil-emacs-state-modes 'navi2ch-article-mode)

(evil-define-key 'insert eshell-mode-map (kbd "C-a") 'eshell-bol)

;;-----------------------------------------------------------------
;; org-mode
;;-----------------------------------------------------------------
(defun my-org-meta-return (&optional prefix)
  (interactive "p") ; pは数引数(C-u)を受けとり、この場合はprefixに束縛される。
  (evil-insert 1)
  (move-end-of-line nil)
  (message "arg:%s" (or prefix 0))
  (org-insert-heading-dwim prefix))

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
  (kbd "M-L") 'org-shiftmetaright)

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


(provide 'mikio-evil)

