;; Currently sar/clock-out-advice is screwy because it jumps to point-min which
;; is insane to do. It's jumping all the way to the start of an org file. What
;; idiot wrote this?

;;; sar/clock-out-advice should be a series of functions
;; First, I need a function to act as a predicate for "Is this org headline a task?"
;; (defun sar/org-headline-is-task-p)
;; Second I need a function to act as a predicate for "Does this headline have a TIMESTRING property?"
;;(defun sar/org-headline-has-timestring-p)
;; Next I need a function that will walk from the current POINT up the tree of headlines - parent by parent - to find any entry that resolves as true for either of the aforementioned predicates
;;(defun sar/org-find-master-task-for-last-worked)

;;; Test Cases:
;;; 2. A task type headline where there are no child headlines
;;; 3. A task type headline where there are child headlines

(setq sar-misk/org-test-doc-01 "#+title: Test Document
#+author: Scott Runnels
#+email: srunnels@gmail.com

* Heading 0

** Heading 01

*** Heading 02

*** Meeting Occurring at 12:45
:PROPERTIES:
:LAST_REPEAT: [2024-04-10 Wed 13:42]
:Effort:   0:30
:TIMESTRING: <%%(unless (sar/org-taskworked-today-p date) (diary-cyclic 14 03 26 2025))>
:LAST_WORKED: [2024-09-25 Wed 13:46]
:CATEGORY: MEETING
:END:
Added: [2025-03-26 Wed 12:40]
**** [2025-03-26 Wed 12:45]
:LOGBOOK:
CLOCK: [2025-03-26 Wed 12:45]--[2025-03-26 Wed 13:15] =>  0:30
:END:
***** Attendees
- [[bbdb:Scott Runnels][Scott Runnels - Mandiant, Incident Response Function]]
-
***** Discussion Topics

***** Action Items
***** Post Meeting Notes
")

(load-file "~/.config/emacs/lisp/sar-misc.el")
(ert-deftest test-taskflow-iteration-dates ()
             "Foo"
             (let* ((iterations '((2 . ("2025-01-06" "2025-01-19"))
                                  (4 . ("2025-01-20" "2025-02-02"))
                                  (6 . ("2025-02-03" "2025-02-16"))
                                  (8 . ("2025-02-17" "2025-03-02")))))
               ;; (should (taskflow-iteration-dates 0))
               (dolist (iter iterations)
                 (should (equal (taskflow-iteration-dates (car iter))
                          (cdr iter))))))
