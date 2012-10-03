(require 'mikio-util)
(require 'flymake)
(require 'popup)

;;-----------------------------------------------------------------
;; flymake
;;-----------------------------------------------------------------
(when (require 'flymake nil t)
  (set-face-background 'flymake-errline "red4")
  (set-face-background 'flymake-warnline "dark slate blue")
  (global-set-key "\C-cd" 'flymake-display-err-menu-for-current-line)
  ;;(global-set-key (kbd "C-c d") 'credmp/flymake-display-err-minibuf)

  ;; PHP
  (when (not (fboundp 'flymake-php-init))
    (defun flymake-php-init ()
      (let* ((temp-file (flymake-init-create-temp-buffer-copy
                         'flymake-create-temp-inplace))
             (local-file (file-relative-name
                          temp-file
                          (file-name-directory buffer-file-name))))
        (list "php" (list "-f" local-file "-l"))))
    (setq flymake-allowed-file-name-masks
          (append
           flymake-allowed-file-name-masks
           '(("\.php[345]?$" flymake-php-init))))
    (setq flymake-err-line-patterns
          (cons
           '("\(\(?:Parse error\|Fatal error\|Warning\): .*\) in \(.*\) on line \([0-9]+\)" 2 3 nil 1)
           flymake-err-line-patterns)))
  (add-hook 'php-mode-hook
            '(lambda () (flymake-mode t)))

  ;; Ruby
  (when (not (fboundp 'flymake-ruby-init))
    (defun flymake-ruby-init ()
      (let* ((temp-file   (flymake-init-create-temp-buffer-copy
                           'flymake-create-temp-inplace))
             (local-file  (file-relative-name
                           temp-file
                           (file-name-directory buffer-file-name))))
        (list "ruby" (list "-c" local-file))))
    )
  (push '(".+\\.rb$" flymake-ruby-init) flymake-allowed-file-name-masks)
  (push '("Rakefile$" flymake-ruby-init) flymake-allowed-file-name-masks)
  (push '("^\\(.*\\):\\([0-9]+\\): \\(.*\\)$" 1 2 nil 3) flymake-err-line-patterns)
  (add-hook 'ruby-mode-hook
            (lambda () 
              (flymake-mode)
              )))

;;-----------------------------------------------------------------
;; flaymake tool tip popup
;; - http://d.hatena.ne.jp/syohex/20111102/1320250444
;;-----------------------------------------------------------------

(defun my-flymake-mode-fook ()
  (progn
    (global-set-key (kbd "M-g M-n") 'flymake-goto-next-error)
    (global-set-key (kbd "M-g M-p") 'flymake-goto-prev-error)
    (global-set-key (kbd "C-c d")  'flymake-display-err-menu-for-current-line)
    ))
(add-hook 'flymake-mode-hook 'my-flymake-mode-fook)

;; Show error message under current line
(defun flymake-display-err-menu-for-current-line ()
  (interactive)
  (let* ((line-no (flymake-current-line-no))
         (line-err-info-list (nth 0 (flymake-find-err-info flymake-err-info line-no))))
    (when line-err-info-list
      (let* ((count (length line-err-info-list))
             (menu-item-text nil))
        (while (> count 0)
          (setq menu-item-text (flymake-ler-text (nth (1- count) line-err-info-list)))
          (let* ((file (flymake-ler-file (nth (1- count) line-err-info-list)))
                 (line (flymake-ler-line (nth (1- count) line-err-info-list))))
            (if file
                (setq menu-item-text (concat menu-item-text " - " file "(" (format "%d" line) ")"))))
          (setq count (1- count))
          (if (> count 0) (setq menu-item-text (concat menu-item-text "\n")))
          )
        (popup-tip menu-item-text)))))

;; If you don't set :height, :bold face parameter of 'pop-tip-face,
;; then seting those default values
(if (eq 'unspecified (face-attribute 'popup-tip-face :height))
    (set-face-attribute 'popup-tip-face nil :height 1.0))
(if (eq 'unspecified (face-attribute 'popup-tip-face :weight))
    (set-face-attribute 'popup-tip-face nil :weight 'normal))

(defun my/display-error-message ()
  (let ((orig-face (face-attr-construct 'popup-tip-face)))
    (set-face-attribute 'popup-tip-face nil
                        :height 1.5 :foreground "firebrick"
                        :background "LightGoldenrod1" :bold t)
    (unwind-protect
        (flymake-display-err-menu-for-current-line)
      (while orig-face
        (set-face-attribute 'popup-tip-face nil (car orig-face) (cadr orig-face))
        (setq orig-face (cddr orig-face))))))

(defadvice flymake-goto-prev-error (after flymake-goto-prev-error-display-message)
  (my/display-error-message))
(defadvice flymake-goto-next-error (after flymake-goto-next-error-display-message)
  (my/display-error-message))

(ad-activate 'flymake-goto-prev-error 'flymake-goto-prev-error-display-message)
(ad-activate 'flymake-goto-next-error 'flymake-goto-next-error-display-message)


(provide 'mikio-flymake)
