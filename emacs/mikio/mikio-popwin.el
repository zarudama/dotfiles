(require 'mikio-util)

(require 'popwin)
(setq display-buffer-function 'popwin:display-buffer)
(global-set-key (kbd "C-x p") popwin:keymap)
(push '("*org.junit.runner.JUnitCore*" :height 0.4 :noselect t :stick t) popwin:special-display-config)

(add-to-list 'special-display-buffer-names "*sdic*")
(push '("*sdic*" :position bottom) popwin:special-display-config)

;; (when (require 'popwin nil t)
;;   (setq display-buffer-function 'popwin:display-buffer)
;;   (setq anything-samewindow nil)
;;   (let ((popwin-lists
;;          '(
;;            "*anything*"
;;            "*anything buffers*"
;;            "*anything M-x*"
;;            "*anything recentf*"
;;            "*anything imenu*"
;;            "*anything complete*"
;;            "*anything apropos*"
;;            "*anything bookmarks*"
;;            "*anything-yasnippet-2*"
;;            "*anything kill-ring*"
;;            "CAPTURE-index.org"
;;            "CAPTURE-office.org"
;;            "*Org Select*"
;;            " *Org todo*"
;;            "*Org Links*"
;; ;           " *Agenda Commands*"
;;            "*Org Agenda*"
;;            ;;"* window list *" 
;;            ;;"window selection"
;;            "*Eshell history*"

;;            "*helm M-x*"
;;            "*helm*"
;;            "*helm buffers*"
;;            "*helm M-x*"
;;            "*helm recentf*"
;;            "*helm imenu*"
;;            "*helm complete*"
;;            "*helm apropos*"
;;            "*helm bookmarks*"
;;            "*helm-yasnippet-2*"
;;            "*helm kill-ring*"

;;            "*Local Variables*"
;;            "*JDEE bsh*"

;;            " *auto-async-byte-compile*"
;;            "*Backtrace*"
;;            "*Process List*"
;;            ;;"*Compile-Log*"

;;            "*slime-apropos*"            ; Apropos
;;            "*slime-macroexpansion*"     ; Macroexpand
;;            "*slime-description*"        ; Help
;;            "*slime-compilation*"        ; Compilation
;;            "*slime-xref*"               ; Cross-reference

;;            "nREPL error*"

;;            " widget choose"
;;            )))
;;     (dolist (bf popwin-lists)
;;       ;; height -> 行数
;;       (add-to-list 'popwin:special-display-config (list bf :height 20))))

;;   (let ((popwin-lists
;;          '(
;;            "*Help*"
;;            )))
;;     (dolist (bf popwin-lists)
;;       (add-to-list 'popwin:special-display-config (list bf :height 50))))


;;     (push '(sldb-mode :stick t) popwin:special-display-config)         ; Debugger
;;     (push '(slime-repl-mode) popwin:special-display-config)            ; REPL
;;     (push '(slime-connection-list-mode) popwin:special-display-config) ; Connections
;;   )

(provide 'mikio-popwin)
