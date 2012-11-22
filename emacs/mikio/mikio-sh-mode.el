(require 'mikio-util)

(add-hook 'sh-mode-hook
          '(lambda ()
             (setq sh-indentation 4)
             (setq sh-basic-offset 4)
             (setq sh-indent-for-case-alt 4)
             (setq sh-indent-for-case-label 0)
             (setq sh-indent-for-continuation 4)
             (setq sh-indent-for-do 0)
             (setq sh-indent-for-done 0)
             (setq sh-indent-for-else 0)
             (setq sh-indent-for-fi 0)
             (setq sh-indent-for-then 0)
             ))

(provide 'mikio-sh-mode)
