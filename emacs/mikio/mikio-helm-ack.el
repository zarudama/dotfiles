(require 'mikio-util)

(require 'helm-ack)

(when (eq window-system 'w32)
  (setq helm-c-ack-base-command "perl ack --nocolor --nogroup"))

(provide 'mikio-helm-ack)
