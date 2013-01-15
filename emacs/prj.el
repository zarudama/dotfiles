(jde-project-file-version "1.0")
(jde-set-variables
 ;; ファイル単体でコンパイル(C-c C-v C-c )した時の.classの出力先
 '(jde-compile-option-directory "./build/classes")

 ;; プロジェクトがJUnit4を使っている場合のみ必要
 '(jde-junit-testrunner-type "org.junit.runner.JUnitCore")

 '(jde-global-classpath (quote (
                                "./target/classes"
                                "./target/test-classes"
                                "/usr/local/resin/lib"
                                "./src/main/webapp/WEB-INF/lib"
                                )))

 '(jde-lib-directory-names (quote ("lib")))
 '(jde-expand-classpath-p t)

 '(jde-sourcepath (quote (
                          "./src/main/java"
                          "./src/test/java"
                          )))


 '(jde-quick-junit-project-root-dir (expand-file-name "~/dev/wsrch/web/websearch/"))
 '(jde-quick-junit-main-class-dir "./target/classes")
 '(jde-quick-junit-test-class-dir "./target/test-classes")
 '(jde-quick-junit-main-source-dir "./src/main/java")
 '(jde-quick-junit-test-source-dir "./src/test/java")

 )
