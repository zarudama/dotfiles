(require 'mikio-util)
;;-----------------------------------------------------------------
;; scala-mode
;;-----------------------------------------------------------------
(when (require 'scala-mode-auto nil t))

;; ;;-----------------------------------------------------------------
;; ;; scala ensime
;; ;; https://github.com/aemoncannon/ensime/downloads
;; ;;-----------------------------------------------------------------
;; (mikio/add-to-load-path "site-lisp/ensime_2.8.1-0.3.9")
;; (when (require 'ensime nil t)
;;   ;; This step causes the ensime-mode to be started whenever
;;   ;; scala-mode is started for a buffer. You may have to customize this step
;;   ;; if you're not using the standard scala mode.
;;   (add-hook 'scala-mode-hook 'ensime-scala-mode-hook))


;; (if (eq window-system 'w32)
;;     (custom-set-faces
;;   ;; custom-set-faces was added by Custom.
;;   ;; If you edit it by hand, you could mess it up, so be careful.
;;   ;; Your init file should contain only one such instance.
;;   ;; If there is more than one, they won't work right.
;;  '(default ((t (:inherit nil :stipple nil :background "Black" :foreground "LightGray" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 98 :width normal :foundry "outline" :family #("ＭＳ ゴシック" 0 7 (charset cp932-2-byte)))))))

;;     (custom-set-faces
;;   ;; custom-set-faces was added by Custom.
;;   ;; If you edit it by hand, you could mess it up, so be careful.
;;   ;; Your init file should contain only one such instance.
;;   ;; If there is more than one, they won't work right.
;;      '(default ((t (:inherit nil :stipple nil :background "Black" :foreground "LightGray" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 98 :width normal :foundry "unknown" :family "Takaoゴシック")))))

;; )

;
(provide 'mikio-scala)
