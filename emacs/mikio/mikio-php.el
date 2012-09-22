(require 'mikio-util)

;;-----------------------------------------------------------------
;; php-mode
;;-----------------------------------------------------------------
(when (require 'php-mode nil t)
  (add-hook 'php-mode-hook
            '(lambda ()
               (define-abbrev php-mode-abbrev-table "ex" "extends")
               (setq tab-width 4
                     c-basic-offset 4
                     c-hanging-comment-ender-p nil
                     indent-tabs-mode nil)
               (c-set-offset 'statement-cont 0)
               )))

(provide 'mikio-php)
