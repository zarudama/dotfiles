(require 'helm-config)
(require 'helm-git)

(global-set-key (kbd "C-x a p") 'helm-git-find-files)

(provide 'mikio-helm-git)
