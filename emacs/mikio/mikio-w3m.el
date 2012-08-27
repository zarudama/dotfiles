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

    (eval-after-load "w3m-search"
      '(add-to-list 'w3m-search-engine-alist
                    '("google-ja"
                      "http://www.google.co.jp/search?num=100&hl=ja&q=%s&oe=utf-8&ie=utf-8"
                      utf-8))
      ;;(setq w3m-search-default-engin "google-ja")
    )

    ;; Hit a Hint
    ;; jaunte(ジョウントと読む)
    ;; (install-elisp "https://raw.github.com/kawaguchi/jaunte.el/master/jaunte.el")
    (when (require 'jaunte nil t)
      (define-key w3m-mode-map (kbd "F") 'jaunte))
    (define-key w3m-mode-map (kbd "f") 'w3m-go-to-linknum)

    (define-key w3m-mode-map (kbd "H") 'w3m-view-previous-page)
    (define-key w3m-mode-map (kbd "L") 'w3m-view-next-page)

    ;; タブ一覧
    (define-key w3m-mode-map (kbd "a") 'w3m-select-buffer)

    ;; タブを移動する
    (define-key w3m-mode-map (kbd "C-p") '(lambda () (interactive) (w3m-next-buffer -1)))
    (define-key w3m-mode-map (kbd "C-n") '(lambda () (interactive) (w3m-next-buffer 1)))
    
    ;; タブを閉じる
    (define-key w3m-mode-map (kbd "d") 'w3m-delete-buffer)
    (define-key w3m-mode-map (kbd "D") 'w3m-delete-other-buffers)

    ;; ページ移動
    (define-key w3m-mode-map (kbd "C-f") 'scroll-down-command)          ; 1画面上へ
    (define-key w3m-mode-map (kbd "C-b") 'scroll-up-command)            ; 1画面下へ

    (define-key w3m-mode-map (kbd "I") 'w3m-toggle-inline-images)       ; 画像表示のトグル
    (define-key w3m-mode-map (kbd "i") 'w3m-view-image)                 ; 画像表示

    (define-key w3m-mode-map (kbd "R") 'w3m-redisplay-this-page)        ; 再描画
    (define-key w3m-mode-map (kbd "r") 'w3m-reload-this-page)           ; 再読込

    (define-key w3m-mode-map (kbd "C-l") 'w3m-goto-url)                 ; URL指定
    (define-key w3m-mode-map (kbd "C-c t") 'w3m-goto-url-new-session)   ; タブを作成
    

    ;; ブックマークを表示
    (define-key w3m-mode-map (kbd "C-c b") 'w3m-bookmark-view-new-session)

    ;; ダウンロード
    (define-key w3m-mode-map (kbd "C-c d") 'w3m-download)

    ;; ページ情報表示
    (define-key w3m-mode-map (kbd "C-c p") 'w3m-view-header)

    ;; ソース表示
    (define-key w3m-mode-map (kbd "C-c s") 'w3m-view-source)

    ;; 外部ブラウザで開く
    (define-key w3m-mode-map (kbd "C-c o") 'w3m-view-url-with-external-browser)

    ;; いつでもgoogle検索
    (global-set-key (kbd "C-c g") 'w3m-search)

    (define-prefix-command 'w3m-g-map)
    (define-key w3m-mode-map (kbd "g") 'w3m-g-map)
    (define-key w3m-mode-map (kbd "g g") 'beginning-of-buffer)
    (define-key w3m-mode-map (kbd "G") 'end-of-buffer)
    (define-key w3m-mode-map (kbd "C-t") 'switch-to-last-buffer-or-other-window)

    ))

(provide 'mikio-w3m)
