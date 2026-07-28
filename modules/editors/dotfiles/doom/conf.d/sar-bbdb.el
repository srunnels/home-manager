;;; sar-bbdb.el --- Description -*- lexical-binding: t; -*-
;;
;; Copyright (C) 2026 Scott Runnels
;;
;; Author: Scott Runnels <scottrunnels@google.com>
;; Maintainer: Scott Runnels <scottrunnels@google.com>
;; Created: May 13, 2026
;; Modified: May 13, 2026
;; Version: 0.0.1
;; Keywords: Symbol’s value as variable is void: finder-known-keywords
;; Homepage: https://github.com/scottrunnels/sar-bbdb
;; Package-Requires: ((emacs "30.1") bbdb)
;;
;; This file is not part of GNU Emacs.
;;
;;; Commentary:
;;
;;  Description
;;
;;; Code:
(require 'bbdb-com)
;;(require 'bbdb)
(require 'dash)
(require 's)
;;;(require 'org-bbdb)
(defgroup sar-bbdb nil
  "Custom code for Org mode"
  :prefix "sar-bbdb-"
  :tag "Scott's BBDB"
  :group 'applications)

(defun sar-bbdb--link-format-name-org (record)
  "Given a record produce a bbdb link in the format Full Name - Organization"
  (let* ((n (s-join " " (cl-subseq record 0 2)))
         (o (elt record 4))
         (o-string (if o
                       (s-join ", " (elt record 4))
		     "Not Recorded")))
    (format "[[bbdb:%s][%s - %s]]" n n o-string)))

(defun sar-bbdb-insert--bbdb-candidates-orgs ()
  "Produce a list of unique organizations based on BBDB records"
  (-filter (lambda (x)
	     (not (string= "" x)))
           (delete-dups (-map (lambda (x) (s-join ", "
						  (elt x 4) ))
                              (bbdb-search (bbdb-records)
                                           :organization ".*")))))

(defun sar-bbdb-insert--bbdb-candidates-names ()
  "Produce a list of names based on BBDB records"
  (-map (lambda (x) (s-join " "
			    (cl-subseq x 0 2)))
        (bbdb-search (bbdb-records)
		     :name ".*")))

(defun sar-bbdb-link-completing ()
  "Generate a BBDB org-style link at (point) using a text-completing
lookup. If no contact found, create the contact."
  (interactive)
  (let* ((candidates (-map (lambda (x) (s-join " " (cl-subseq x 0 2)))
                           (bbdb-search (bbdb-records) :name ".*")))
         (selection (car (completing-read-multiple "> " candidates)))
         (record (bbdb-search (bbdb-records) :name selection)))
    (if record
        (sar-bbdb--link-format-name-org (car record))
      (sar-bbdb--link-format-name-org (bbdb-create-internal :name selection
							    :organization (car (completing-read-multiple "Org: "
                                                                                                         (sar-bbdb-insert--bbdb-candidates-orgs))))))))


(defun sar-bbdb-insert-bbdb-link-completing ()
  "Helper function for the insertion of a link into a buffer"
  (interactive)
  (insert (sar-bbdb-link-completing)))
(defun sar-bbdb-insert-bbdb-link-from-region ()
  "Replaces region with with the appropos BBDB link if name found"
  (interactive)
  (unless (use-region-p)
    (user-error "You didn't select a region"))
  (let* ((region-string (buffer-substring-no-properties (region-beginning) (region-end)))
         (record (bbdb-search (bbdb-records) :name region-string)))
    (if record
        (progn
          (kill-region (region-beginning) (region-end))
          (insert (sar-bbdb--link-format-name-org (car record))))
      (user-error "No BBDB record for user"))))


(provide 'sar-bbdb)
;;; sar-bbdb.el ends here
