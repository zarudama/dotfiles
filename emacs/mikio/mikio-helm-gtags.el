(require 'mikio-util)

(require 'helm-config)
(require 'helm-gtags)

(add-hook 'c-mode-hook (lambda () (helm-gtags-mode)))
(add-hook 'java-mode-hook (lambda () (helm-gtags-mode)))
(add-hook 'jde-mode-hook (lambda () (helm-gtags-mode)))

;; customize
(setq helm-c-gtags-path-style 'relative)
(setq helm-c-gtags-ignore-case t)
(setq helm-c-gtags-read-only t)

;; key bindings
(add-hook 'helm-gtags-mode-hook
          '(lambda ()
             (local-set-key (kbd "C-c t j") 'helm-gtags-find-tag)    ; 関数の定義元へ移動
             (local-set-key (kbd "C-c t r") 'helm-gtags-find-rtag)   ; 関数を参照元の一覧を表示．RET で参照元へジャンプできる
             ;;(local-set-key (kbd "C-c t s") 'helm-gtags-find-symbol) ; 変数の定義元と参照元の一覧を表示．RET で該当箇所へジャンプできる．
             (local-set-key (kbd "C-c t s") 'helm-gtags-select)      ; すべてのシンボルから選択する
             (local-set-key (kbd "C-c t b") 'helm-gtags-pop-stack))  ; 元にもどる
          )

(provide 'mikio-helm-gtags)
