(require 'mikio-util)

;;(setq scheme-program-name "C:\Program Files\Racket\Racket.exe")
(setq scheme-program-name "Racket.exe")

(autoload 'run-scheme "cmuscheme" "Run an inferior Scheme process." t)
;;(define-key global-map (kbd "C-c s") 'run-scheme)

(require 'paredit)
(add-hook 'scheme-mode-hook 'enable-paredit-mode)

(provide 'mikio-scheme)
