(require '_util)
(require 'popwin)
;;-----------------------------------------------------------------
;; popwin
;;-----------------------------------------------------------------
;; for anything
(setq anything-samewindow nil)
(push '("*anything*" :height 20) popwin:special-display-config)
(push '("*anything buffers*" :height 20) popwin:special-display-config)
(push '("*anything recentf*" :height 20) popwin:special-display-config)
(push '("*anything imenu*" :height 20) popwin:special-display-config)
(push '("*anything complete*" :height 20) popwin:special-display-config)
(push '("*anything apropos*" :height 20) popwin:special-display-config)
(push '("CAPTURE-index.org" :height 20) popwin:special-display-config)
(push '("CAPTURE-office.org" :height 20) popwin:special-display-config)
(push '("*Org Select*" :height 20) popwin:special-display-config)
(push '(" *Org todo*" :height 20) popwin:special-display-config)
;;(push '("* window list *" :height 20) popwin:special-display-config)
(push '(" * window list *" :height 20) popwin:special-display-config)
;;(push '("window selection" :height 20) popwin:special-display-config)
;;(push '("window selection mode" :height 20) popwin:special-display-config)
(push '("*Eshell history*" :height 20) popwin:special-display-config)


(push '(" *auto-async-byte-compile*" :height 20) popwin:special-display-config)
(push '("*Backtrace*" :height 20) popwin:special-display-config)
(push '("*Process List*" :height 20) popwin:special-display-config)

;; for dired
(push '(dired-mode :position top :height 20) popwin:special-display-config)

;; direx:direx-modeのバッファをウィンドウ左辺に幅25でポップアップ
;; :dedicatedにtを指定することで、direxウィンドウ内でのバッファの切り替えが
;; ポップアップ前のウィンドウに移譲される
(push '(direx:direx-mode :position left :width 25 :dedicated t)
      popwin:special-display-config)
