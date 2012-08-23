;;-----------------------------------------------------------------
;; svn(psvn)
;;-----------------------------------------------------------------
(when (require 'psvn nil t)
  (define-key svn-status-mode-map "q" 'egg-self-insert-command)
  (define-key svn-status-mode-map "Q" 'svn-status-bury-buffer)
  (define-key svn-status-mode-map "p" 'svn-status-previous-line)
  (define-key svn-status-mode-map "n" 'svn-status-next-line)
  (define-key svn-status-mode-map "<" 'svn-status-examine-parent)
)

;;-----------------------------------------------------------------
;; svn(dsvn)
;;-----------------------------------------------------------------
;;(autoload 'svn-status "dsvn" "Run `svn status'." t)
;;(autoload 'svn-update "dsvn" "Run `svn update'." t)

