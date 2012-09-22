(require 'mikio-util)
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

;; より下に記述した物が PATH の先頭に追加されます
(dolist (dir (list
              "/sbin"
              "/usr/sbin"
              "/bin"
              "/usr/bin"
              "/opt/local/bin"
              "/sw/bin"
              "/usr/local/bin"
              (expand-file-name "~/bin")
              (expand-file-name "~/.emacs.d/bin")
              ))
 ;; PATH と exec-path に同じ物を追加します
 (when (and (file-exists-p dir) (not (member dir exec-path)))
   (setenv "PATH" (concat dir ":" (getenv "PATH")))
   (setq exec-path (append (list dir) exec-path))))

(setenv "MANPATH" (concat "/usr/local/man:/usr/share/man:/Developer/usr/share/man:/sw/share/man" (getenv "MANPATH")))

;; shell の存在を確認
(defun skt:shell ()
  (or ;;(executable-find "zsh")
      ;;(executable-find "bash")
      (executable-find "f_zsh") ;; Emacs + Cygwin を利用する人は Zsh の代りにこれにしてください
      (executable-find "f_bash") ;; Emacs + Cygwin を利用する人は Bash の代りにこれにしてください
      (executable-find "cmdproxy")
      (error "can't find 'shell' command in PATH!!")))

;; Shell 名の設定
(setq shell-file-name (skt:shell))
(setenv "SHELL" shell-file-name)
(setq explicit-shell-file-name shell-file-name)


(if (eq window-system 'w32)
    (progn
      (setq file-name-coding-system 'utf-8)
      (setq locale-coding-system 'utf-8)
      ;; もしコマンドプロンプトを利用するなら sjis にする
      ;; (setq file-name-coding-system 'sjis)
      ;; (setq locale-coding-system 'sjis)
      ;; 古い Cygwin だと EUC-JP にする
      ;; (setq file-name-coding-system 'euc-jp)
      ;; (setq locale-coding-system 'euc-jp)

      )
  )

(global-set-key (kbd "C-c t") '(lambda ()
                                (interactive)
                                (term shell-file-name)))

(provide 'mikio-shell)
