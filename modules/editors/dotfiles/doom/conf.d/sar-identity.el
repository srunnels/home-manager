;;; sar-identity.el --- Description -*- lexical-binding: t; -*-
;;
;; Copyright (C) 2026 Scott Runnels
;;
;; Author: Scott Runnels <srunnels@gmail.com>
;; Maintainer: Scott Runnels <srunnels@gmail.com>
;; Created: May 28, 2026
;; Modified: May 28, 2026
;; Version: 0.0.1
;; Keywords: Symbol’s value as variable is void: finder-known-keywords
;; Homepage: https://github.com/srunnels/sar-identity
;; Package-Requires: ((emacs "24.3"))
;;
;; This file is not part of GNU Emacs.
;;
;;; Commentary:
;;
;;  Description
;;
;;; Code:

(defgroup sar-identity nil
  "Identity functions"
  :prefix "sar-identity-"
  :tag "Scott's Identity"
  :group 'appilcations)

(defcustom sar-identity-identities nil
  "Identities plist."
  :type '(plist :key-type symbol
          :options (:personal :professional)
          :value-type string) 
  :group 'sar-identity)

(defun sar-identity-get (type field)
  (plist-get (plist-get sar-identity-identities type) field))

(defun sar-identity-save (identity filepath)
  "Save Identity PLIST locally"
  (with-temp-file filepath
    (prin1 identity (current-buffer))))

(defun sar-identity-load (filepath)
  "Load a saved identity PLIST from filepath"
  (when (file-exists-p filepath)
    (with-temp-buffer
      (insert-file-contents filepath)
      (read (current-buffer)))))

;; Find specific repo host
(cl-find "github.com" (sar-identity-get :personal :repos)
         :test #'string=
         :key (lambda (repo) (plist-get repo :host)))

(provide 'sar-identity)
;;; sar-identity.el ends here
