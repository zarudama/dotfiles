(when (require 'view nil t)
  (setq view-read-only t)
  (setq pager-keybind
        `( ;; vi-like
          ("h" . backward-char)
          ("l" . forward-char)
          ("j" . next-line)
          ("k" . previous-line)
          ("b" . scroll-down)
          (" " . scroll-up)
          ("w" . forward-word)
          ("e" . backward-word)
          ("J" . ,(lambda () (interactive) (scroll-up 1)))
          ("K" . ,(lambda () (interactive) (scroll-down 1)))
          ))
  (defun define-many-keys (keymap key-table &optional includes)
    (let (key cmd)
      (dolist (key-cmd key-table)
        (setq key (car key-cmd)
              cmd (cdr key-cmd))
        (if (or (not includes) (member key includes))
          (define-key keymap key cmd))))
    keymap)
  (defun view-mode-hook--pager ()
    (define-many-keys view-mode-map pager-keybind))
  (add-hook 'view-mode-hook 'view-mode-hook--pager)
  (global-set-key [f11] 'view-mode)
  )

(when (require 'viewer nil t)
  ;; 書き込み不能なファイルでview-modeから抜けないようにする
  (viewer-stay-in-setup)
  ;; view-modeのときにモードラインに色をつける。
  (setq viewer-modeline-color-unwritable "Blue")
  (setq viewer-modeline-color-view "DarkRed")
  (setq viewer-modeline-color-default "black")
  (viewer-change-modeline-color-setup)
  ;; 特定のファイルをview-modeで開く
  ;;(setq view-mode-by-default-regexp "\\.java$")
  ;; すべてのファイルをview-modeで開く
  (viewer-aggressive-setup 'force)
  (setq viewer-aggressive-minimum-size 0) ;; 文字数が指定値以下の場合のみ読み込み専用
)

