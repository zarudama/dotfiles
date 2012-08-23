(require 'mikio-util)
(require 'tramp)
;;-----------------------------------------------------------------
;; tramp設定
;;-----------------------------------------------------------------
;;(setq tramp-shell-prompt-pattern "^[ $]+")
;;(add-to-list 'tramp-remote-path "/opt/local/bin")
;;(modify-coding-system-alist 'process "plink" 'euc-japan-unix)

(cond
 ;; windowsの場合
 ((eq system-type 'windows-nt)
  (setq tramp-default-method "plink")
  (add-to-list 'tramp-default-proxies-alist
               '("dev12-psrch" "at-m-oono" "/plink:at-m-oono@218.213.143.144"))
  )
 ;; linuxなど
 (t
  (setq tramp-default-method "ssh")
  ))

(provide 'mikio-tramp)
