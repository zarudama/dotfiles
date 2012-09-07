(jde-project-file-version "1.0")
(jde-set-variables

 '(jde-sourcepath (quote ("./src/main/java" "./src/test/java")))
 '(jde-global-classpath (quote ("./target/classes" "./target/test-classes" "./libs")))
 '(jde-lib-directory-names '("libs"))
 '(jde-expand-classpath-p t)

 '(jde-build-function (quote jde-ant-build))
 '(jde-ant-enable-find t)
 '(jde-ant-read-target t)
 '(jde-ant-working-directory "./"))


