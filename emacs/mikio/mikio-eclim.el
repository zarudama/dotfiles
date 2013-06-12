(require 'mikio-util)

(custom-set-variables
 '(eclim-eclipse-dirs
   '("~/apps/pleiades-e3.7-java-jre_20110704/eclipse/")
  ;; '("c:/pleiades/eclipse")
   ))

(require 'eclim)
(setq eclim-auto-save nil)
(global-eclim-mode)

;; Displaying compilation error messages in the echo area
(setq help-at-pt-display-when-idle t)
(setq help-at-pt-timer-delay 0.1)
(help-at-pt-set-timer)

;; Control eclimd from emacs
;;(require 'eclimd)


;; add the emacs-eclim source
(require 'ac-emacs-eclim-source)
(ac-emacs-eclim-config)

(provide 'mikio-eclim)
