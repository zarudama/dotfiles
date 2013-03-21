(require 'mikio-util)
(require 'emamux)

(defun tmux-paste ()
  (interactive)
  (let ((tmpfile (make-temp-file "tmux-paste-"))) ; 一時ファイル作成
    (emamux:tmux-run-command (concat "save-buffer " tmpfile)) ; ペーストバッファを一時ファイルに書き込む
    (insert-file tmpfile)    ; 一時ファイルの内容をバッファに挿入
    (delete-file tmpfile))   ; 一時ファイルを削除
  (exchange-point-and-mark)) ; 末尾までカーソルを移動

;; 仮想端末のウィンドウに切り替える
(defun select-rxvt ()
  (interactive)
  (call-process "xwit" nil nil nil "-names" "rxvt" "-raise" "-focus"))

;;  6. tmuxにコマンド文字列を送り、実行させる
;; http://www.rubyist.net/~rubikitch/archive/tmux-doit.el
(global-set-key (kbd "C-q") 'tmux-doit)
(global-set-key (kbd "C-x C-q") 'abort-recursive-edit)
(load "tmux-doit.el")

(provide 'mikio-emamux)

