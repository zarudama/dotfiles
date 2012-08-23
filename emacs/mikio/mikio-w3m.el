(require 'mikio-util)
;;-----------------------------------------------------------------
;; w3m
;; (require 'w3m)
;;-----------------------------------------------------------------

(when (executable-find "w3m")
  ;; w3m-command
  ;; これがないと、windows環境の実行パスが/usr/bin/w3mになってしまい、起動できない！はまった！
  ;; 参考
  ;;  http://sohda.net/cygwin/treebbs/treebbs.cgi?kako=1&log=1347
  (setq w3m-command (executable-find "w3m"))
  (add-to-list 'load-path (mikio/site-lisp-home "w3m"))
  (when (require 'w3m nil t)

    ;; 標準ブラウザをw3mにする。
    (setq browse-url-browser-function 'w3m-browse-url)

    ;; (setq w3m-key-binding 'info) ;; なぜか効かない。

    ;; 画像の背景色
    (setq w3m-image-default-background "white")

    (setq w3m-home-page "http://www.google.co.jp/") ;起動時に開くページ
    (setq w3m-use-cookies t) ;クッキーを使う
    (setq w3m-bookmark-file (mikio/elisp-home ".w3m/bookmark.html")) ;ブックマークを保存するファイル
    (setq w3m-use-tab t)

    ;; favicon のキャッシュを消さない
    (setq w3m-favicon-cache-expire-wait nil)

    ;; Hit a Hint
    ;; jaunte(ジョウントと読む)
    ;; (install-elisp "https://raw.github.com/kawaguchi/jaunte.el/master/jaunte.el")
    (when (require 'jaunte nil t)
      (define-key w3m-mode-map (kbd "f") 'jaunte))

    ;; タブを移動する
    (define-key w3m-mode-map (kbd "C-l") '(lambda () (interactive) (w3m-next-buffer 1)))
    (define-key w3m-mode-map (kbd "C-h") '(lambda () (interactive) (w3m-next-buffer -1)))
    (define-key w3m-mode-map (kbd "L") 'w3m-view-prev-page)
    (define-key w3m-mode-map (kbd "H") 'w3m-view-next-page)
    
    ;; タブを閉じる
    (define-key w3m-mode-map (kbd "K") 'w3m-delete-buffer)
    ;; 次のリンクに飛ぶ
    (define-key w3m-mode-map (kbd "i") 'w3m-next-anchor)
    ;; ;; リンクを新しいタブで開く
    ;; (define-key w3m-mode-map ";" 'w3m-view-this-url-new-session)
    ;; ;; リンクを普通に開く
    ;; (define-key w3m-mode-map "'" 'w3m-view-this-url)
    ;; ;; カーソル下にある画像を表示
    ;; (define-key w3m-mode-map "n" 'w3m-toggle-inline-image)
    ;; ;; ブックマークを表示
    ;; (define-key w3m-mode-map "m" 'w3m-bookmark-view-new-session))

    (eval-after-load "w3m-search"
      '(add-to-list 'w3m-search-engine-alist
                    '("google-ja"
                      "http://www.google.co.jp/search?num=100&hl=ja&q=%s&oe=utf-8&ie=utf-8"
                      utf-8))
      ;;(setq w3m-search-default-engin "google-ja")
    )

    ;; いつでもgoogle検索
    (global-set-key (kbd "C-c g") 'w3m-search)

    ;; 外部ブラウザで開く
    (define-key w3m-mode-map (kbd "C-c C-o") 'w3m-view-url-with-external-browser)

    (define-key w3m-mode-map (kbd "C-a") 'seq-home)
    (define-key w3m-mode-map (kbd "C-e") 'seq-end)

    ))



(provide 'mikio-w3m)
