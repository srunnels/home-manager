;;; sar-misc.el --- Custom code snippets -*- lexical-binding: t -*-

;; Copyright (C) 2024  Scott Runnels

;; Author: Scott Runnels <srunnels@gmail.com>
;; URL: https://github.com/srunnels/dotfiles
;; Version: 0.0
;; Package-Requires: ((emacs "30.1"))

;;; Commentary:
;;;;
;;; Code:


(require 'dash)

(defun sar/parse-csv-file (file)
  "Consume FILE and produce a list of lists by parsing the lines like CSV."
  (interactive
   (list (read-file-name "CSV file: ")))
  (let ((buf (find-file-noselect file))
        (result nil))
    (with-current-buffer buf
      (goto-char (point-min))
      (while (not (eobp))
             (let ((line (buffer-substring-no-properties
                          (line-beginning-position) (line-end-position))))
               (push (split-string line ",") result))
             (forward-line 1)))
    (reverse result)))

(defun sar/parse-csv-file-to-plist (file &optional limit)
  "Parse FILE as a CSV before converting the entries to a plist.

If LIMIT is provided, only parse the the first LIMIT columns."
  (let* ((csvdata (sar/parse-csv-file file))
         (headers (car csvdata))
         (data (cdr csvdata)))
    (cl-loop for d in data
             collect
             (-flatten (-zip-lists (cl-map 'list
                                           (lambda (x)
                                             (intern (format ":%s" (downcase x))))
                                           headers)
                                   (if limit
                                       (cl-subseq d 0 limit)
                                       d))))))

;; (--map (plist-get it :age)
;; 	      (cl-map 'list
;; 		      (lambda (x)
;; 			(sar/row-to-plist x
;; 					  '("Name" "Age" "Date")
;; 					  '(:age string-to-number
;; 						 :date (lambda (x)
;; 							 (format-time-string "YYYY/mm/dd" x)))))
;; 		      '(("Scott Runnels" "45" "1979/08/26")
;; 			("Amanda Gilbert" "50" "1975/06/25"))))
(defun sar/row-to-plist (row headers &optional funcs)
  "Create a keyword plist using HEADERS applied to ROW.

If FUNCS is provided, apply each function to its corresponding index."
  (cl-reduce (lambda (x y)
	       (let* ((kword (intern (format ":%s" (s-replace " " "_" (downcase (car y))))))
		      (func (plist-get funcs kword))
		      (value (if func
				 (apply (list func (cdr y)))
				 (cdr y))))
		 (append x (list kword value))))
	     (-zip headers
		   row)
	     :initial-value '()))

(provide 'sar-misc)

;;; Functions related to tickets and taskflow
(defun sar/get-current-iteration ()
  "Return a string that predicts the current Taskflow iteration.

Based on the IR Function taskflow iteration of two weeks."
  (let ((week (string-to-number (format-time-string "%U"
						    (current-time))))
	(year (string-to-number (format-time-string "%Y"
						    (current-time)))))
    (format "%d.W%02d" year (if (= 0 (% week 2))
				week
				(1+ week)))))

(defun taskflow-iteration-dates (iteration)
  (let* ((day0 (parse-time-string "2025-01-01T00:00:00Z"))
  	 (open-offset (make-decoded-time :day (-  (* (- iteration 1) 7) 1)))
  	 (close-offset (make-decoded-time :day (-  (* (+ 1 iteration) 7) 2))))
    (list  (format-time-string "%F"  (encode-time (decoded-time-add day0 open-offset)))
  	   (format-time-string "%F"  (encode-time (decoded-time-add day0 close-offset))))))

;;; sar-misc.el ends here
