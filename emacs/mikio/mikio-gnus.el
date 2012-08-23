(require 'mikio-util)
(cond
  ((string-match "m-oono" (getenv "USERPROFILE"))
   (require 'mikio-gnus-office)
   )
 ((string-match "miki" (getenv "USERPROFILE"))
  (require 'mikio-gnus-gmail)
   )
 (t
  ))

(provide 'mikio-gnus)
