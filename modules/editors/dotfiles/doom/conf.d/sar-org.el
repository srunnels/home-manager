;;; sar-org.el ---  -*- lexical-binding: t -*-

;; Copyright (C) 2025 Scott Runnels

;; Author:  Scott Runnels<srunnels@google.com>
;; URL: https://github.com/srunnels
;; Version: 0.0
;; Package-Requires: ((emacs "30.1"))
;; Keywords: org

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <https://www.gnu.org/licenses/>.

;;; Commentary:
;; This is code related to additional functionality in Org mode.

;;; Code:

(defgroup sar-org nil
  "Custom code for Org mode"
  :prefix "sar-org-"
  :tag "Scott's Org"
  :group 'org)

(defcustom sar-org-better-archive-offset nil
  "Number of quarters to subtract from the current quarter."
  :type 'number
  :group 'sar-org)

(defcustom sar-org-billcode-projects nil
  ""
  :type '(repeat string)
  :group 'sar-org
  )

(defcustom sar-org-billcode-tasks nil
  ""
  :type '(repeat string)
  :group 'sar-org
  )

(defcustom sar-org-shadow-agenda-file nil
  ""
  :type 'string
  :group 'sar-org)

(defun sar-org-better-archive (args)
  "This function is used as an :filter-args advice for archiving.

It allows the user to dynamically assign the ARCHIVE property for
\\=`org-archive-location\\=`.

The function takes a list ARGS, checks the car of ARGS to eval
and either returns the calculated value as a list or the original
ARGS if the string cannot be evaluated.

To apply as an advice use:
\(advice-add #\\='org-archive--compute-location :filter-args #\\='sar-better-archive\)"
  (condition-case
      nil
      (list (eval (car (read-from-string (car args)))))
    (void-variable args)))

(defun sar-org-clock-in-if-starting ()
  "Clock in when the task is marked STARTED."
  (when (and (string= org-state "STARTED")
             (not (string= org-last-state org-state)))
    (org-clock-in)))

(defun sar-org-clock-out-if-waiting ()
  "Clock out when the task is marked WAITING."
  (when (and (or (string= org-state "WAITING")
   	         (string= org-state "NEXT"))
   	     (equal (marker-buffer org-clock-marker) (current-buffer))
   	     (< (point) org-clock-marker)
   	     (> (save-excursion (outline-next-heading) (point))
   	        org-clock-marker)
   	     (not (string= org-last-state org-state)))
    (org-clock-out)))


(defun sar-org-taskworked-today-p (date)
  "Lets me use TIMESTRINGS like where I check the state of LAST_WORKED
        e.g.<%%(and (not (sar-org-taskworked-today?))
                    (memq (calendar-day-of-week date) \\='(1 2 3 4 5)))>"
  (let* ((prop (org-entry-get (point) "LAST_WORKED"))
         (lastworked (when prop (substring (org-entry-get (point) "LAST_WORKED") 1 11)))
         (teststring (format "%02d-%02d-%02d"
                             (caddr date)
                             (car date)
                             (cadr date)))
         (_ (message (format "%s vs %s" lastworked teststring))))
    (if lastworked
        (string= teststring
                 lastworked)
      nil)))

(defun sar-set-last-worked ()
  "Set the LAST_WORKED property on the current org-entry.

Often used with advice to add property on clock-out"
  (org-entry-put (point)
                 "LAST_WORKED"
                 (concat "["
                         (format-time-string "%F %a %H:%M"
                                             (current-time))
                         "]")))

(defun sar-org-set-last-worked ()
  "Set the LAST_WORKED property on the item at point.

If the item at point is not a todo-keyword headline or the current
headline is not a RECURRING_MEETING type then move upwards until that
check fails"
  (interactive)
  (save-excursion
    (let* ((element (org-element-at-point))
           (update_time (format-time-string "[%F %a %H:%M]"
    				            (current-time))))
      ;; First, ensure I'm at the heading of current item...
      (while (not (eq (org-element-type element) 'headline))
        (setq element (org-element-property :parent element)))
      
      (while (and
              ;; If the element is _not_ a todo-keyword headline we jump upwards to the parent
              (not (org-element-property :todo-keyword element))
              ;; We don't update the specific entry of a recurring_meeting entry just the meeting itself.
              (not (string= "RECURRING_MEETING"
                            ;; If it's an RECURRING_ENTRY type jump to the parent
                            (org-element-property :CATEGORY element)))
              )
        (setq element (org-element-property :parent element))
        (org-up-heading-safe)
        )
      ;; Set the LAST_WORKED timestamp
      (org-set-property "LAST_WORKED" update_time))))



(defun sar-clock-out-advice ()
  "Used with defavice on org-clock-out to set the LAST_WORKED property"
  (org-entry-put (point-min)
                 "LAST_WORKED"
                 (concat "["
                         (format-time-string "%F %a %H:%M"
                                             (current-time))
                         "]")))

(defun sar-org-add-date-captured ( &optional N )
  ""
  (interactive)
  (unless (org-entry-get (point)
			 "DATE_CAPTURED")
    (org-set-property "DATE_CAPTURED"
		      (format-time-string "[%F %a %H:%M]"
					  (current-time)))))

(defun sar-org-add-date-captured ( &optional N )
  "If DATE_CAPTURED property does not exist, insert it with the current
time."
  (interactive)
  (unless (org-entry-get (point)
			 "DATE_CAPTURED")
    (org-set-property "DATE_CAPTURED"
		      (format-time-string "[%F %a %H:%M]"
					  (current-time)))))
(defun sar-org-completing-read-select-nested (first second list)
  (let* ((proj (completing-read first list))
         (task (completing-read second (alist-get proj list nil nil #'string=))))
    (format "%s - %s" proj task)))

(defun sar-org-update-heirarchy-times ()
  "When run on a headline, update the LAST_UPDATE property and
  LAST_UPDATE_ID property of the current headline and every headline in
  the heirarchy of the tree which has a LAST_UPDATE property."
  (interactive)
  (save-excursion
    (let* ((element (org-element-at-point))
           (ID (or (org-element-property :ID element)
                   (org-id-get-create)))
           (update_time (format-time-string "[%F %a %H:%M]"
    				            (current-time))))
      ;; First, ensure I'm at the heading of current item...
      (while (not (eq (org-element-type element) 'headline))
        (setq element (org-element-property :parent element)))
      ;; Set the LAST_UPDATE timestamp
      (org-set-property "LAST_UPDATE" update_time)
      ;; Set the LAST_UPDATE_ID to the element ID
      (org-set-property "LAST_UPDATE_ID" ID)
      (while (and element
                  (eq (org-element-type element) 'headline)
                  (org-element-property :LAST_UPDATE
                                        (org-element-property :parent element)))
        (org-up-heading-safe)
        (setq element (org-element-property :parent element))
        (org-set-property "LAST_UPDATE" update_time)
        (org-set-property "LAST_UPDATE_ID" ID)))))


;;(customize-set-value sar-org-shadow-agenda-file "~/Documents/orgmode/personal/shadow_agenda.org")q
(defun sar-org-shadow-agenda ()
  "For a given org element at point, strip all children and copy it to the shadow agenda."
  (interactive)
  (save-excursion
    (let* ((element (org-element-at-point)) 
           (shadow-element (org-copy-subtree element)))
      ;; If the SHADOW property of the element at POINT is not set, exit.
      (when (org-element-property :SHADOW element)
        (with-temp-buffer
          (org-mode)
          (insert shadow-element)
          (goto-char (point-min))
          (cl-loop do (org-promote)
                   while (> (car (org-heading-components)) 1))
          (org-delete-property "ID")
          (when (org-goto-first-child)
            (org-cut-subtree )
            (cl-loop do (org-cut-subtree)
                     while (save-excursion (org-get-next-sibling)))
            (org-cut-subtree))
          (write-region (point-min)
                        (point-max)
                        "~/Documents/orgmode/personal/shadow_agenda.org"
                        t))))))

(defun sar-org-N-days-since-update-p (N agenda-item)
  (message (format "DEBUG: %s" agenda-item))
  ;;(message (format "DEBUG GTP: %s" (get-text-property 0 'tags agenda-item)))
  ;; see https://github.com/alphapapa/org-super-agenda/issues/11#issuecomment-323501886 for sample list of text-properties
  
  ;;(message (format "DEBUG GTP: %s" (text-properties-at 0 agenda-item)))
  (message (format "DEBUG GTP: %S" agenda-item ))
  
  nil
  )

;; (defun sar-org-skip-non-waiting ()
;;   "Skip trees that are not waiting for a specific amount of time"
;;   (let* ((subtree-end (save-excursion (org-end-of-subtree t)))
;;          (element (org-element-at-point))
;;          (firstchild-pos (org-goto-first-child element))
;;          (firstchild (org-element-at-point))
;;          )
;;     (if (not (string= (org-element-property :todo-keyword
;;                                             firstchild)
;;                       "WAITING"))
;;         ;; Not a waiting task skip it
;;         subtree-end
;;       (if (and (eq (org-element-type firstchild) 'headline)
;;                (org-element-property :LAST_UPDATE
;;                                      firstchild))
;;           (progn 
;;             (message (format "DEBUG FOO: %s"
;;                              (org-element-property :LAST_UPDATE
;;                                                    firstchild)))
;;             nil)
;;         subtree-end
;;         )
;;       )

;;     ))

(defun sar-org-skip-non-waiting-for-N (n)
  "Skip trees that are not waiting for a specific amount of time"
  (let* ((n-days-ago (org-read-date nil nil "-5d"))
         (subtree-end (save-excursion (org-end-of-subtree t)))
         (element (org-element-at-point))
         (firstchild-pos (org-goto-first-child element))
         (firstchild (org-element-at-point))
         (_ (message (format "DEBUG PROP: %s"
                             (org-element-property :LAST_UPDATE
                                                   firstchild))))
         )
    (if (and (eq (org-element-type firstchild) 'headline)
             (org-element-property :LAST_UPDATE
                                   firstchild)
             ;; Compare the dates
             (> (- (org-time-string-to-absolute (org-element-property :LAST_UPDATE
                                                                      firstchild))
                   (org-time-string-to-absolute n-days-ago)
                   )
                0)
             )
        (progn 
          (message (format "DEBUG FOO: %s"
                           (org-element-property :LAST_UPDATE
                                                 firstchild)))
          nil)
      subtree-end)))

(defun sar-org-logbook-drawer-header-p ()
  "Return true if point is on a LOGBOOK drawer start entry."
  (s-starts-with? ":LOGBOOK:" (string-trim (buffer-substring-no-properties
                                            (line-beginning-position)
                                            (line-end-position)))))
(defun sar-org-logbook-drawer-footer-p ()
  "Return true if point is on a END drawer entry."
  (s-starts-with? ":END:" (string-trim (buffer-substring-no-properties
                                        (line-beginning-position)
                                        (line-end-position)))))

(defun sar-org-report-line (offset)
  (message "Point is %d. On character %d of line '%s'"
           (point)
           (- (point) (line-beginning-position))
           (buffer-substring-no-properties (- (line-beginning-position) offset)
                                           (+ (line-end-position) offset))))

(defun sar-org-add-note-to-property (&optional prop)
  "Hook function for org-after-note-stored-hook to add the note to a given property. If prop is not provided, it adds to LAST_NOTE"
  (let ((end-of-note (if (sar-org-logbook-drawer-footer-p)
                         (progn 
                           (beginning-of-line)
                           (backward-char)
                           (point))
                       (point)))
        (prop (if prop
                  prop
                "LAST_NOTE")))
    
    
    ;; (when (sar-org-logbook-drawer-footer-p)
    ;;   (beginning-of-line)
    ;;   (backward-char))
    ;; (setq end-of-note (point))
    
    (save-excursion
      (goto-char (org-log-beginning))
      (beginning-of-line)
      (backward-char)
      
      (dotimes (i (1+ (if (sar-org-logbook-drawer-header-p)
                          1
                        2)))
        (if (not (eobp))
            (progn
              (end-of-line)
              (forward-char))))

      (if (not (bolp))
          (beginning-of-line))
      (org-set-property prop (string-replace "\n"
                                             ""
                                             (string-trim (buffer-substring-no-properties (point)
                                                                                          end-of-note)))))))
    

(provide 'sar-org)
;;; sar-org.el ends here
