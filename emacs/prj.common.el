(jde-project-file-version "1.0")
(jde-set-variables

 '(jde-expand-classpath-p t)

 '(jde-build-function 'jde-ant-build) ; ビルドにantを利用する
 '(jde-ant-read-target t)             ; targetを問い合わせる
 '(jde-ant-enable-find t)             ; antに-findオプションを指定する(要らないかも)
 '(jde-ant-working-directory "./")

 ;; import文のソート
 ;; jde-import-all,jde-import-find-and-import時に勝手にソートする用に設定している
 ;; => なぜか効かない
 '(jde-import-auto-sort t)
  
 ;; コンパイルなどbeanShell経由のコマンドメッセージを英語にする
 '(bsh-vm-args (quote ("-Duser.language=en")))

 ;; 単体コンパイル時にデバッグ情報を埋め込む
 '(jde-compile-option-command-line-args (quote (
                                                "-g"
                                                )))
 '(jde-compile-option-vm-args nil)

 ;; デバッガ(jdb)のメッセージを英語にする
 '(jde-db-option-vm-args (quote ("-J-Duser.language=en")))
 '(jde-debugger (quote ("jdb")))

 '(jde-jdk-registry (quote (("1.6" . "/usr/local/java/"))))
 '(jde-jdk (quote ("1.6")))
 '(jde-jdk-doc-url "http://docs.oracle.com/javase/jp/6/api/")
 '(jde-help-use-frames nil)
 '(jde-help-docsets (quote (
                            ("JDK API" "http://docs.oracle.com/javase/jp/6/api/" nil)
                            )))
 )

