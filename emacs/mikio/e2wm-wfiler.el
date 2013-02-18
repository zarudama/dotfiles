(require 'e2wm)
 
;; 2画面ファイラ化。
(setq dired-dwim-target t)
 
;;; wfiler / Wfiler column editing perspective
;;;--------------------------------------------------
 
(defvar e2wm:c-wfiler-recipe
  '(- (:upper-size-ratio 0.8)
      (| (:left-size-ratio 0.5) left right)
      sub))
 
(defvar e2wm:c-wfiler-winfo
  '((:name left )
    (:name right )
    (:name sub :buffer "*Help*" :default-hide t)
    ))
 
(defvar e2wm:c-wfiler-right-default 'left) ; left, prev
 
(e2wm:pst-class-register
 (make-e2wm:$pst-class
  :name 'wfiler
  :extend 'base
  :title "Wfiler Columns"
  :init 'e2wm:dp-wfiler-init
  :main 'left
  :switch 'e2wm:dp-wfiler-switch
  :popup 'e2wm:dp-wfiler-popup
  :keymap 'e2wm:dp-wfiler-minor-mode-map))
 
;; パースペクティブを切り替える度に呼ばれる
(defun e2wm:dp-wfiler-init ()
  (let*
      ((wfiler-wm
        (wlf:no-layout
         e2wm:c-wfiler-recipe
         e2wm:c-wfiler-winfo))
       (buf (or prev-selected-buffer
                (e2wm:history-get-main-buffer))))
    ;; diredを起動させる
    ;; 前回の2画面バッファがあれば、それを復元したいが、現在未対応
    (wlf:set-buffer wfiler-wm 'left (dired default-directory))
    (wlf:set-buffer wfiler-wm 'right (dired default-directory))
    wfiler-wm))
 
;; バッファを切り替える度に呼ばれる
;; (ファイルを開く、ディレクトリを切り替えるなど)
(defun e2wm:dp-wfiler-switch (buf)
  (e2wm:message "#DP WFILER switch : %s" buf)
  (with-current-buffer buf
    (let ((wm (e2wm:pst-get-wm))
          (curwin (selected-window)))
      (message (format "major-mode:%s" major-mode))
      (cond
       ((not (eq major-mode 'dired-mode))
        ;; bufがdiredバッファでなければ、パースペクティブを切り替える。
        ;; (将来的には直前のパースペクティブに戻りたい。いまはcode固定)
        (e2wm:dp-code)
        nil)
 
       ((eql curwin (wlf:get-window wm 'left))
        ;; left画面の場合
        (e2wm:pst-buffer-set 'left buf)
        nil)
 
       ((eql curwin (wlf:get-window wm 'right))
        ;; right画面の場合
        (e2wm:pst-buffer-set 'right buf)
        nil)
       (t nil)))
    )
  )
 
(defun e2wm:dp-wfiler-popup (buf)
  ;;記録バッファ以外はsubで表示してみる
  (e2wm:message "#DP WFILER popup : %s" buf)
  (let ((buf-name (buffer-name buf)))
    (cond
     ((e2wm:document-buffer-p buf)
      (e2wm:pst-buffer-set 'right buf)
      t)
 
     (t
      (e2wm:dp-wfiler-popup-sub buf)
      t))))
 
(defun e2wm:dp-wfiler-popup-sub (buf)
  (let ((wm (e2wm:pst-get-wm))
        (not-minibufp (= 0 (minibuffer-depth))))
    (e2wm:with-advice
     (e2wm:pst-buffer-set 'sub buf t not-minibufp))))
 
;; Commands / Keybindings
 
(defun e2wm:dp-wfiler ()
  (interactive)
  (e2wm:pst-change 'wfiler))
 
(defun e2wm:dp-wfiler-navi-left-command ()
  (interactive)
  (e2wm:pst-window-select 'left))
(defun e2wm:dp-wfiler-navi-right-command ()
  (interactive)
  (e2wm:pst-window-select 'right))
(defun e2wm:dp-wfiler-navi-sub-command ()
  (interactive)
  (e2wm:pst-window-select 'sub))
 
(defun e2wm:dp-wfiler-sub-toggle-command ()
  (interactive)
  (wlf:toggle (e2wm:pst-get-wm) 'sub)
  (e2wm:pst-update-windows))
 
(defun e2wm:dp-wfiler-move-buffers-command ()
  "片方のバッファに移動する"
  (interactive)
  (let ((wm (e2wm:pst-get-wm))
        (curwin (selected-window))
        (left (e2wm:pst-buffer-get 'left))
        (right (e2wm:pst-buffer-get 'right)))
    (cond
     ((eql curwin (wlf:get-window wm 'left))
      (windmove-right)
      )
 
     ((eql curwin (wlf:get-window wm 'right))
      (windmove-right)
      )
     (t nil))
    )
  )
 
(defun e2wm:dp-wfiler-sync-buffers-command ()
  "左右のバッファを同じディレクトリにする"
  (interactive)
  (let ((wm (e2wm:pst-get-wm))
        (curwin (selected-window))
        (left (e2wm:pst-buffer-get 'left))
        (right (e2wm:pst-buffer-get 'right)))
    (cond
     ((eql curwin (wlf:get-window wm 'left))
      (e2wm:pst-buffer-set 'right left)
      nil)
 
     ((eql curwin (wlf:get-window wm 'right))
      (e2wm:pst-buffer-set 'left right)
      nil)
     (t nil))
    ))
 
(defvar e2wm:dp-wfiler-minor-mode-map
  (e2wm:define-keymap
   '(("C-t" . e2wm:dp-wfiler-move-buffers-command)
     ("M-p" . e2wm:dp-wfiler-sync-buffers-command))
   e2wm:prefix-key))
 
;; (Defvar e2wm:dp-wfiler-minor-mode-map
;;   (e2wm:define-keymap
;;    '()
;;    e2wm:prefix-key))
 
 
 
(provide 'e2wm-wfiler)
