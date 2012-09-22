(require 'mikio-util)
;;-----------------------------------------------------------------
;; redo
;;-----------------------------------------------------------------
;; (when (require 'redo+ nil t)
;;   (global-set-key (kbd "C-M-/") 'redo)
;;   (setq undo-no-redo t)
;;   (setq undo-limit 60000)
;;   (setq undo-strong-limit 90000))

;;-----------------------------------------------------------------
;; undo-tree
;; (install-elisp "http://www.dr-qubit.org/undo-tree/undo-tree-0.3.3.el")
;;-----------------------------------------------------------------
(when (require 'undo-tree nil t)
   (global-undo-tree-mode)

   ;; アンドゥの限界値を上げておく。                                    
   (setq undo-limit 100000)                                             
   (setq undo-strong-limit 130000)                                         
   )


(provide 'mikio-undo)
