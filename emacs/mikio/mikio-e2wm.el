(require 'mikio-util)

;;-----------------------------------------------------------------
;; e2wm
;; (auto-install-from-url "https://github.com/kiwanami/emacs-window-manager/raw/master/e2wm.el")
;; (auto-install-from-url "https://raw.github.com/kiwanami/emacs-window-manager/master/e2wm-config.el")
;; (auto-install-from-url "https://github.com/kiwanami/emacs-window-manager/raw/master/e2wm-vcs.el")
;;-----------------------------------------------------------------
;; 最小の e2wm 設定例
;;  2011/04/19 現在、max-depth-...とかいうエラーが出て常用できない。
(when (require 'e2wm nil t)
;;  (require 'e2wm-config)
;;  (require 'e2wm-vcs)
;;  (require 'e2wm-wfiler)

  (defun e2wm:my-toggle-sub ()          ; Subをトグルする関数
    (interactive)
    (e2wm:pst-window-toggle 'sub t 'main))

  (global-set-key (kbd "M-+") 'e2wm:start-management)

  ;; (when (require 'smartrep nil t)
  ;;   (smartrep-define-key e2wm:pst-minor-mode-keymap "C-c"
  ;;     '(
  ;;       ("k" . 'e2wm:pst-history-forward-command)
  ;;       ("j" . 'e2wm:pst-history-back-command)
  ;;       )))

  ;; 1行100文字程度までとする。
  ;; http://www.textdrop.net/android/code-style-ja.html#linelen
  (setq e2wm:c-code-recipe
        '(| (:left-max-size 45)
            (- (:upper-size-ratio 0.7)
               files history)
            (- (:upper-size-ratio 0.7)
               (| (:right-max-size 45)
                  main imenu)
               sub)))

  ;; (global-set-key (kbd "C-c 1") 'e2wm:dp-code)
  ;; (global-set-key (kbd "C-c 2") 'e2wm:dp-two)
  ;; (global-set-key (kbd "C-c 3") 'e2wm:dp-doc)
  ;; (global-set-key (kbd "C-c 4") 'e2wm:dp-wfiler)
  ;; (global-set-key (kbd "C-c 5") 'e2wm:dp-magit)
  ;; (global-set-key (kbd "C-c 6") 'e2wm:dp-dashboard)
  ;; (global-set-key (kbd "C-c 7") 'e2wm:dp-array)

  ;; (global-set-key (kbd "C-c m") 'e2wm:pst-window-select-main-command) ; メインウインドウを選択する
  ;; (global-set-key (kbd "C-c I") 'info)    ; infoを起動する
  ;; (global-set-key (kbd "C-c L") 'ielm) ; ielm を起動する（subで起動する）
  ;; (global-set-key (kbd "C-c s") 'e2wm:my-toggle-sub) ; subの表示をトグルする
  )


(provide 'mikio-e2wm)
