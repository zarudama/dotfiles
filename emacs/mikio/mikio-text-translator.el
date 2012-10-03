(require 'mikio-util)
;;-----------------------------------------------------------------
;; 言語を自動判別して複数のWeb翻訳サービスを同時に使う
;;-----------------------------------------------------------------
(when (require 'text-translator nil t)
  (setq text-translator-auto-selection-func
        'text-translator-translate-by-auto-selection-enja)
  ;;翻訳キー設定
  (global-set-key (kbd "C-x t") 'text-translator)
  (global-set-key (kbd "C-x T") 'text-translator-translate-last-string)
  )

(provide 'mikio-text-translator)
