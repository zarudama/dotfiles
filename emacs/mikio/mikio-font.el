(require 'mikio-util)

;;-----------------------------------------------------------------
;; font
;; 0123456789
;; あいうえお
;; 800heigth == 8PT
;; 現在利用できるフォント一覧
;; (insert (prin1-to-string (x-list-fonts "*")))
;;-----------------------------------------------------------------

(cond (window-system
       (cond
        ;; windowsの場合
        ((eq system-type 'windows-nt)
         ;; 英字フォントの設定
         (set-face-attribute 'default nil
                             :family "Migu 1M"
                             :height 120)

         (set-fontset-font "fontset-default"
                           'japanese-jisx0208
                           '("Migu 1M" . "jisx0208.*"))

         (set-fontset-font "fontset-default"
                           'katakana-jisx0201
                           '("Migu 1M" . "jisx0201.*"))

         ;; 英字フォントの設定
         ;; (set-face-attribute 'default nil
         ;;                     :family "MigMix 1M"
         ;;                     :height 120)

         ;; (set-fontset-font "fontset-default"
         ;;                   'japanese-jisx0208
         ;;                   '("MigMix 1M" . "jisx0208.*"))

         ;; (set-fontset-font "fontset-default"
         ;;                   'katakana-jisx0201
         ;;                   '("MigMix 1M" . "jisx0201.*"))

         ;; ;; 英字フォントの設定
         ;; (set-face-attribute 'default nil
         ;;                     :family "ＭＳ ゴシック"
         ;;                     :height 120)

         ;; (set-fontset-font "fontset-default"
         ;;                   'japanese-jisx0208
         ;;                   '("ＭＳ ゴシック" . "jisx0208-sjis"))

         ;; (set-fontset-font "fontset-default"
         ;;                   'katakana-jisx0201
         ;;                   '("ＭＳ ゴシック" . "jisx0201-sjis"))

         )


        ;; linuxなど
        (t
         ;; (set-face-attribute 'default nil
         ;;                     :family "Takaoゴシック"
         ;;                     :height 110)

         ;; (set-fontset-font "fontset-default"
         ;;                   'japanese-jisx0208
         ;;                   '("Takaoゴシック" . "jisx0208.*"))

         ;; (set-fontset-font "fontset-default"
         ;;                   'katakana-jisx0201
         ;;                   '("Takaoゴシック" . "jisx0201.*"))

         
         ;; MigMix 1M
         ;; (set-face-attribute 'default nil
         ;;                     :family "MigMix 1M"
         ;;                     :height 120)

         ;; (set-fontset-font "fontset-default"
         ;;                   'japanese-jisx0208
         ;;                   '("MigMix 1M" . "jisx0208.*"))

         ;; (set-fontset-font "fontset-default"
         ;;                   'katakana-jisx0201
         ;;                   '("MigMix 1M" . "jisx0201.*"))

         ;; Migu 1M
         (set-face-attribute 'default nil
                             :family "Migu 1M"
                             :height 120)

         (set-fontset-font "fontset-default"
                           'japanese-jisx0208
                           '("Migu 1M" . "jisx0208.*"))

         (set-fontset-font "fontset-default"
                           'katakana-jisx0201
                           '("Migu 1M" . "jisx0201.*"))
         
         ))))


(provide 'mikio-font)
