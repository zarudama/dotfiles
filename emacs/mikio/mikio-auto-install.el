(require 'mikio-util)

(require 'auto-install)

;;-----------------------------------------------------------------
;; 自動インストーラー
;; for auto-install
;; cd .emacs.d
;; mkdir auto-install
;; cd auto-install
;; wget http://www.emacswiki.org/emacs/download/auto-install.el
;; emacs --batch -Q -f batch-byte-compile auto-install.el
;; (setq auto-install-directory (format "%s/elisp" my-elisp-dir))
;;-----------------------------------------------------------------

(setq auto-install-directory (mikio/elisp-home  "auto-install/")) ;; 末尾に"/"を忘れないこと
(add-to-list 'load-path (mikio/elisp-home "auto-install"))

(auto-install-update-emacswiki-package-name t)
(auto-install-compatibility-setup)
(setq ediff-window-setup-function 'ediff-setup-windows-plain)

(provide 'mikio-auto-install)
