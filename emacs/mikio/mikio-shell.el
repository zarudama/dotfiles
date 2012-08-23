;;-----------------------------------------------------------------
;; shell
;;-----------------------------------------------------------------
;; (modify-coding-system-alist 'process "cmd" '(utf-8-unix . undecided-dos))

;; (w32-shell-execute)
(if (eq window-system 'w32)
    (progn
      (message "w32!")
      ;; (setq explicit-shell-file-name "bash.exe")
      ;; (setq shell-file-name "sh.exe")
      ;; (setq shell-command-switch "-c")
;;      (modify-coding-system-alist 'process "shell" '(undecided-dos . utf-8-unix))
      (add-hook 'shell-mode-hook
                (lambda ()
                  ;;(set-buffer-process-coding-system 'sjis-unix 'sjis-unix )
                  ;;(set-buffer-process-coding-system 'utf-8-unix 'utf-8-unix)
                  ;;(set-buffer-process-coding-system 'sjis-unix 'utf-8-unix)
                  ;;(set-buffer-process-coding-system 'utf-8-unix 'sjis-unix)
                  (set-buffer-process-coding-system 'utf-8-unix 'utf-8-unix)
                  ))
      
;;      (setenv "JAVA_HOME" "C:\\m-oono\\opt\\jdk1.6.0_24")
;;      (setenv "M2_HOME" "c:\\m-oono\\opt\\apache-maven-2.2.1")
;;      (setenv "MAVEN_OPTS" (concat "-Duser.home=" (getenv "HOME"))) 
;;      (setenv "PATH" 
;;              (concat
;;               "C:\\cygwin\\bin;"
;;               "C:\\cygwin\\usr\\local\\bin;"
;;               "C:\\m-oono\\bin;"
;;               (getenv "JAVA_HOME") "\\bin;"
;;               (getenv "MAVEN_HOME") "\\bin;"
;;;;               (getenv "USERPROFILE") "\\.lein\\bin;"
;;               ))
;;      (setq explicit-bash-args '("--noediting" "--rcfile" "~/.emacs.d/.bashrc" "-i"))
;;      (setq explicit-bash-args '("--noediting" "--rcfile" "~/.emacs.d/.bashrc" "-i"))
;;      (set-background-color "black")
;;      (set-foreground-color "#888888")
;;      (set-background-color "#dddddd")
      ))

