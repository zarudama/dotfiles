(require 'mikio-util)
(require 'mikio-growl-win)


(require 'gnus)

(define-key gnus-summary-mode-map (kbd "C-t") 'switch-to-last-buffer-or-other-window)

;; gnus-summary-line-format
;; ディフォルトの文字列は ‘%U%R%z%I%(%[%4L: %-23,23f%]%) %s\n’ です。
;; ‘U’
;;     未読。See section 既読記事.
;; ‘R’
;;     この紛らわしい名前指定子は「第二の印」(the secondary mark) です。
;;     この印は記事がすでに返答済みのものか、キャッシュされたものか、
;;     あるいは保存されたものかを表します。See section 他の印.
;; ‘z’
;;     これは、zcore でディフォルトのレベルよりも上であれば ‘+’ で、
;;      ディフォルトのレベルよりも下であれば ‘-’ です。
;;      gnus-summary-default-score との差が gnus-summary-zcore-fuzz よりも小さいと、
;;      この仕様は使われません。
;; ‘I’
;;     スレッドのレベルによる字下げ (see section スレッドをカスタマイズする)。
;; ‘L’
;;     記事の行数。
;;  %-23,23f
;;     -: 左詰め
;;     23,23: 最小幅23文字、最大幅23文字 
;;     f: 名前、To 欄の内容、または Newsgroups 欄の内容のどれかです (see section To From Newsgroups)。
;; ‘%(’ と ‘%)’ の間にあるテキストは、そこにマウスがあるときに gnus-mouse-face で
;;      ハイライトされます。そういう領域は一つだけです。
;; ‘s’
;;     スレッド (thread) の元記事であるときか直前の記事が違う表題のときはその表題で、
;;     それ以外は gnus-summary-same-subject。 (gnus-summary-same-subject はディフォルトで ""。)
;; ‘D’
;;     Date.
;; ‘d’
;;     DD-MM 様式による Date。
;; ‘o’
;;     YYYYMMDDTHHMMSS 様式による Date。
;;   '\n'終端を表すために必要

;; %ucを使った場合、ユーザ定義のフォーマットを指定できる。
;; yyyy/mm/ddのフォーマット関数
;; http://osdir.com/ml/emacs.gnus.semi.japanese/2004-10/msg00352.html
(defun gnus-user-format-function-c (header)
  "Return a string like YYYY/MM/DD from a Date header."
  (condition-case ()
      (format-time-string "%Y/%m/%d %H:%M" (safe-date-to-time (mail-header-date header)))
    (error " - ")))

(add-hook
 'gnus-summary-mode-hook
          #'(lambda ()
              (message "gnus-summary-mode-hook....")
              (setq gnus-summary-line-format "%U%R%z%I%(%[%-23,23f%]%) %-80,80s <<%uc, %4L>>\n")))

(when mikio/office-type
  (cond
   ((equal :office mikio/office-type)
    (require 'mikio-gnus-office))
   ((equal :home mikio/office-type)
    (require 'mikio-gnus-gmail))))

(provide 'mikio-gnus)

