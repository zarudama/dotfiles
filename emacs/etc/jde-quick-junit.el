;;; helm-jdee-method.el --- JDEE method complation for helm.
;; Filename: helm-jdee-method.el
;; Description: JDEE method complation for helm.
;; URL: https://github.com/mikio/emacs-helm-jdee-method
;; Author: mikio_kun https://twitter.com/mikio_kun
;; Maintainer: mikio_kun
;; Copyright (C) :2012 mikio_kun all rights reserved.
;; Created: :2012-12-22
;; Version: 0.1.0
;; Package-Requires: ()
;; Package-Requires: ((helm "20120811")(yasnippet "20120822"))
;; Keywords: convenience

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3, or (at your option)
;; any later version.

;; This file is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING. If not, write to
;; the Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
;; Boston, MA 0:110-1301, USA.

;;; Commentary:

;; Installation:
;; Put the helm-jdee-method.el to your load-path.
;; And add to .emacs:
;;  (require 'helm-jdee-method) 
;;  (define-key jde-mode-map (kbd "C-c C-v C-i") 'helm-jdee-method)

;;; Changelog:



(require 'jde)

(defcustom jde-quick-junit-project-root-dir (expand-file-name "~/dev/wsrch/web/websearch/")
  ""
  :group 'jde-quick-junit
  :type 'string)
(defcustom jde-quick-junit-main-class-dir "./target/classes"
  ""
  :group 'jde-quick-junit
  :type 'string)
(defcustom jde-quick-junit-test-class-dir "./target/test-classes"
  ""
  :group 'jde-quick-junit
  :type 'string)
(defcustom jde-quick-junit-main-source-dir "./src/main/java"
  ""
  :group 'jde-quick-junit
  :type 'string)
(defcustom jde-quick-junit-test-source-dir "./src/test/java"
  ""
  :group 'jde-quick-junit
  :type 'string)

(defun jqj-main-src-dir? ()
  "カレントバッファのファイルがメインソースのディレクトリかどうか？"
  (let* ((bfname (buffer-file-name)))
    (if (string-match jde-quick-junit-main-source-dir bfname)
        t
      nil)))

(defun jqj-test-src-dir? ()
  "カレントバッファのファイルがテストソースのディレクトリかどうか？"
  (let* ((bfname (buffer-file-name)))
    (if (string-match jde-quick-junit-test-source-dir bfname)
        t
      nil)))

(defun jqj-get-abs-main-dir-name ()
  (expand-file-name (concat jde-quick-junit-project-root-dir jde-quick-junit-main-source-dir))) 

(defun jqj-get-abs-test-dir-name ()
  (expand-file-name (concat jde-quick-junit-project-root-dir jde-quick-junit-test-source-dir))) 

(defun jqj-get-main-file-name (bfname)
  (message "jqj-get-main-file-name")
  (let* ((mdir (jqj-get-abs-main-dir-name))
         (tdir (jqj-get-abs-test-dir-name))
         (basename (replace-regexp-in-string tdir mdir bfname)))
    (concat (substring basename 0 -4) ".java")))

(defun jqj-get-test-file-name (bfname)
  (message "jqj-get-test-file-name")
  (let* ((mdir (jqj-get-abs-main-dir-name))
         (tdir (jqj-get-abs-test-dir-name))
         (basename (replace-regexp-in-string mdir tdir bfname)))
    (concat basename "Test.java")))

(defun jqj-make-class-dir ()
  "クラスファイル出力ディレクトリを作成する。"
  (message "jqj-make-class-dir")
  (let* ((mclass-dir (concat jde-quick-junit-project-root-dir jde-quick-junit-main-class-dir))
         (tclass-dir (concat jde-quick-junit-project-root-dir jde-quick-junit-test-class-dir)))
    (if (not (file-exists-p mclass-dir))
        (make-directory mclass-dir t))
    (if (not (file-exists-p tclass-dir))
        (make-directory tclass-dir t))))

(defadvice jde-compile (before jqj-compile activate)
  "対象の.javaが*Testであればテストクラス用のディレクトリに.classファイルを出力する"
  (princ "jde-compile before")
  (jqj-make-class-dir)
  (if (jqj-test-src-dir?)
      (setq jde-compile-option-directory jde-quick-junit-test-class-dir)
    (setq jde-compile-option-directory jde-quick-junit-main-class-dir)))

;; (defadvice compilation-handle-exit (after jqj-compilation-handle-exit activate)
;;   (message "jqj-compile-status:%s" exit-status)
;;   (setq jqj-compile-status exit-status))

(defun jde-quick-junit-toggle-main-test ()
  "メインクラスとテストクラスのソースを切り替えます。"
  (interactive)
  (let* ((bfname (file-name-sans-extension (buffer-file-name)))
         (filename (if (jqj-test-src-dir?)
                       (jqj-get-main-file-name bfname)
                     (jqj-get-test-file-name bfname))))
    (condition-case err
        (find-file filename)
      (error (message "Could not find source file for \"%s\"." filename)))
    ))

;; (defun jde-quick-junit-run ()
;;   ""
;;   (interactive)
;;   (jde-compile)
;;   (message "after jqj-status:%s" jqj-compile-status)
;;   (when (= "0" jqj-compile-status)
;;     (jde-junit-run)))

(provide 'jde-quick-junit)
