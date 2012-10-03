(require 'mikio-util)

;;-----------------------------------------------------------------
;; slime
;;-----------------------------------------------------------------
(when (require 'slime nil t)
  (require 'clojure-mode)

  ;; SLIMEからの入力をUTF-8に設定
  ;; windowsの場合、下記をlein.batの先頭に記述
  ;; set JAVA_OPTS=-Dswank.encoding=utf-8-unix
  (setq slime-net-coding-system 'utf-8-unix
        slime-protocol-version 'ignore)

  ;; set for default common lisp
  ;;(setq inferior-lisp-program "clj")
  ;;(setq inferior-lisp-program "sbcl")
  ;;(setq inferior-lisp-program "gosh")

  ;;(slime-setup '(slime-repl slime-fancy slime-banner))
  (slime-setup '(slime-repl))
  ;;(slime-setup '(slime-repl slime-js))
  ;;(slime-setup '(slime-repl slime-scheme))
  ;;(slime-setup '(slime-fancy slime-asdf))

  ;; slimeをカラフルに
                                        ;(add-hook 'slime-repl-mode-hook (lambda () (clojure-mode-font-lock-setup)))
  (add-hook 'slime-repl-mode-hook
            (lambda ()
              (clojure-mode-font-lock-setup)
              (font-lock-mode)
              (font-lock-mode)))
  ;; (add-hook 'slime-repl-mode-hook
  ;;           (defun clojure-mode-slime-font-lock ()
  ;;             (require 'clojure-mode)
  ;;             (let (font-lock-mode)
  ;;               (clojure-mode-font-lock-setup))))

  ;;-----------------------------------------------------------------
  (require 'ac-slime)
  ;;
  ;; ac-slime
  ;;(install-elisp "https://github.com/purcell/ac-slime/raw/master/ac-slime.el")
  ;;  or
  ;;(auto-install-from-url "https://github.com/purcell/ac-slime/raw/master/ac-slime.el")
  ;; configure auto complete to work in slime
  (add-hook 'slime-mode-hook 'set-up-slime-ac)
  (add-hook 'slime-repl-mode-hook 'set-up-slime-ac)
  (eval-after-load "auto-complete"
    '(add-to-list 'ac-modes 'slime-repl-mode))


  ;; slime key bind
  (define-key slime-repl-mode-map (kbd "M-r") nil)
  (define-key slime-repl-mode-map (kbd "M-s") nil)

  (define-key slime-repl-mode-map (kbd "C-c C-s") 'slime-repl-next-matching-input)
  (define-key slime-repl-mode-map (kbd "C-c C-r") 'slime-repl-previous-matching-input)

  (if (eq window-system 'w32)
      (progn
        (defun cyg-slime-to-lisp-translation (filename)
          (replace-regexp-in-string "\n" "" 
                                    (shell-command-to-string
                                     (format "cygpath.exe --windows %s" filename))))

        (defun cyg-lisp-to-slime-translation (filename)
          (replace-regexp-in-string "\n" "" (shell-command-to-string
                                             (format "cygpath.exe --unix %s" filename))))

        (setq slime-to-lisp-filename-function #'cyg-slime-to-lisp-translation)
        (setq lisp-to-slime-filename-function #'cyg-lisp-to-slime-translation)))

  ;;-----------------------------------------------------------------
  ;; カッコの対応を取りながらS式を編集する。
  ;; (install-elisp "http://mumble.net/~campbell/emacs/paredit.el")
  ;;-----------------------------------------------------------------
  (add-hook 'slime-repl-mode-hook (lambda () (paredit-mode)))

  )

(provide 'mikio-slime)
