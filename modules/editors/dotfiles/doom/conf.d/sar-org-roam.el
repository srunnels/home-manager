;;; sar-org-roam.el --- Description -*- lexical-binding: t; -*-
;;
;; Copyright (C) 2025 Scott Runnels
;;
;; Author: Scott Runnels <scottrunnels@google.com>
;; Maintainer: Scott Runnels <scottrunnels@google.com>
;; Created: April 25, 2025
;; Modified: April 25, 2025
;; Version: 0.0.1
;; Keywords: abbrev bib c calendar comm convenience data docs emulations extensions faces files frames games hardware help hypermedia i18n internal languages lisp local maint mail matching mouse multimedia news outlines processes terminals tex tools unix vc wp
;; Homepage: https://github.com/scottrunnels/sar-org-roam
;; Package-Requires: ((emacs "24.3"))
;;
;; This file is not part of GNU Emacs.
;;
;;; Commentary:
;;
;;  Description
;;
;;; Code:

(defgroup sar-org-roam nil
  "Custom code for Org mode"
  :prefix "sar-org-roam"
  :tag "Scott's Org Roam")

(defcustom foo-alist
  '((key-a "value-a1" "value-a2")
    (key-b "value-b1" "value-b2"))
  "Each element is a list comprising (KEY \"VALUE1\" \"VALUE2\") ..."
  :type '(alist :key-type (symbol :tag "Key")
                :value-type (list (string :tag "Value 1")
                                  (string :tag "Value 2")))
  :group 'foo)

(defcustom sar-org-roam-templates nil
  ""
  :type '(alist :key-type (symbol :tag "Key")
          :value-type (string :tag "Value"))
  :group 'sar-org-roam
  )

;; (setq sar-org-roam-templates
;;         '((article . "#+title: ${title}\n#+created: %<%Y-%m-%dT%H%M%S>\n#+filetags: :article:\n- tags :: \n\n")
;;           (main . "#+title: ${title}\n#+created: %<%Y-%m-%dT%H%M%S>\n#+filetags: :main:\n- tags :: \n\n")
;;           (reference . "#+title: ${title}\n#+created: %<%Y-%m-%dT%H%M%S>\n#+published: %^{Published}\n#+filetags: :reference:\n- tags :: \n\n")
;;           (concept . "#+title: ${title}\n#+created: %<%Y-%m-%dT%H%M%S>\n#+filetags: :concept:\n- tags :: \n\n")))

(defun sar-org-roam-tag-new-node-as-draft ()
  "If the zettle being created is not a concept zettle, then tag it as a draft."
  (let* ((bfn (buffer-file-name))
         (path (when bfn
                 (file-name-directory bfn))))
    (unless (string-match "concept" path)
      (org-roam-tag-add '("draft"))
      )))

(cl-defmethod org-roam-node-scope ((node org-roam-node))
    (condition-case nil
        (directory-file-name
         (file-name-directory
          (directory-file-name
           (file-name-directory
            (file-name-directory (file-relative-name (org-roam-node-file node)
                                                     org-roam-directory))))))
      (error "")))

  (cl-defmethod org-roam-node-type ((node org-roam-node))
    "Return the TYPE of NODE."
    (condition-case nil
        (file-name-nondirectory
         (directory-file-name
          (file-name-directory
           (file-relative-name (org-roam-node-file node) org-roam-directory))))
      (error "")))

(provide 'sar-org-roam)
;;; sar-org-roam.el ends here
