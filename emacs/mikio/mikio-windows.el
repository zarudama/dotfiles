(require 'mikio-util)
;;-----------------------------------------------------------------
;; windows.el
;; (install-elisp "http://www.gentei.org/~yuuji/software/windows.el")
;; (install-elisp "http://www.gentei.org/~yuuji/software/revive.el")
;;-----------------------------------------------------------------
(require 'windows)
(win:startup-with-window)
(define-key ctl-x-map "C" 'see-you-again)
(setq win:use-frame nil);; 新規にフレームを作らない

;; revive.el
(autoload 'save-current-configuration "revive" "Save status" t)
(autoload 'resume "revive" "Resume Emacs" t)
(autoload 'wipe "revive" "Wipe emacs" t)

;; キーバインドを変更．
;; デフォルトは C-c C-w
;; 変更しない場合」は，以下の 3 行を削除する
(setq win:switch-prefix "\C-\\")
(define-key global-map win:switch-prefix nil)
(define-key global-map "\C-\\1" 'win-switch-to-window)

;;(define-key global-map (kbd "C-x w l") 'win-switch-menu)

;; 直前のウィンドウ構成に戻す(winner.el)
(winner-mode 1)
;;(global-set-key (kbd "C-l C-u") 'winner-undo)

(global-set-key (kbd "C-M-,") 'win-prev-window)
(global-set-key (kbd "C-M-.") 'win-next-window)

;; M-数字で窓を選択する
(setq win:switch-prefix [esc])
(loop for i from 1 to 9 do
     (define-key esc-map (number-to-string i) 'win-switch-to-window))

(provide 'mikio-windows)
