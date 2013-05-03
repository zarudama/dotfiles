{:user
 {:plugins [
            [lein-ritz "0.7.0"]
            [lein-newnew "0.3.4"] 
            ]
  :jvm-opts [
             "-Duser.language=en"
             ;;"-Dfile.separator=/"
             ;;"-Dline.separator=\r\n"
             ;;"-Duser.home=c:\\Users\\m-oono"
             ]
  :dependencies [
                 [clojure-complete "0.2.2"]
                 [ritz/ritz-nrepl-middleware "0.7.0"]
                 [org.clojure/tools.nrepl "0.2.2"]
                 ]

  :repl-options {:nrepl-middleware
                 [ritz.nrepl.middleware.javadoc/wrap-javadoc
                  ritz.nrepl.middleware.simple-complete/wrap-simple-complete]
                 }
  :hooks [
          ;;ritz.add-sources
          ]}}

;; {:user {:plugins [[lein-droid "0.1.0-preview2"]
;;                   ]
;;         :dependencies []
;;          :android {:sdk-path "c:/android-sdk-windows"}}
;;  }
 
