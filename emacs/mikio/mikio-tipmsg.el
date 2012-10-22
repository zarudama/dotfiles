(require 'mikio-util)

;; (install-elisp "http://homepage3.nifty.com/mi24/linux/tipmsg/tipmsg.el")
(require 'tipmsg)
(setq tipmsg-command (expand-file-name "~/bin/tipmsg.exe"))

(provide 'mikio-tipmsg)
