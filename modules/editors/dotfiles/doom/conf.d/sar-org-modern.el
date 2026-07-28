;;; sar-org-modern.el -*- lexical-binding: t; -*-
;;
;; Copyright (C) 2025 Scott Runnels
;;
;; Author: Scott Runnels <srunnels@gmail.com>
;; Maintainer: Scott Runnels <srunnels@gmail.com>
;; Created: April 28, 2025
;; Modified: April 28, 2025
;; Version: 0.0.1
;; Keywords: Symbol’s value as variable is void: finder-known-keywords
;; Homepage: https://github.com/srunnels/sar-org-modern
;; Package-Requires: ((emacs "24.3"))
;;
;; This file is not part of GNU Emacs.
;;
;;; Commentary:
;;
;;
;;
;;; Code:

(defface sar-org-modern-note
  '((((background light)) :background "gray90" :foreground "black")
    (t :weight semibold
       :box (:color "#151d2c" ;; "#3f3f3f"
             :line-width (-1 . -2))
       :background "#6598be" ;; https://www.colorhexa.com/6598be
       :foreground "#ffffff"
       ;; :inverse-video t
       :inherit (org-modern-label)))
  "Face used for note labels.")

(defun sar-org-modern--note ()
  "Prettify headline note keywords."
  (let ((todo (match-string 1))
        (beg (match-beginning 1))
        (end (match-end 1)))
    (put-text-property beg (1+ beg) 'display
                       (format #(" %c" 1 3 (cursor t)) (char-after beg)))
    (put-text-property (1- end) end 'display (string (char-before end) ?\s))
    (put-text-property beg end 'face 'sar-org-modern-note)))

;; Moved to sar-org.el
(defface sar-org-modern-question
  '((((background light)) :background "gray90" :foreground "black")
    (t :weight semibold
       :box (:color  "#151d2c"
             :line-width (-1 . -2))
       :background "#be8b65" ;; https://www.colorhexa.com/be8b65
       :foreground "#ffffff"
       ;; :inverse-video t
       :inherit (org-modern-label)))
  "Face used for note labels.")
;; Moved to sar-org.el

(defun sar-org-modern--question ()
  "Prettify headline note keywords."
  (let ((todo (match-string 1))
        (beg (match-beginning 1))
        (end (match-end 1)))
    (put-text-property beg (1+ beg) 'display
                       (format #(" %c" 1 3 (cursor t)) (char-after beg)))
    (put-text-property (1- end) end 'display (string (char-before end) ?\s))
    (put-text-property beg end 'face 'sar-org-modern-question)))

(defface sar-org-modern-answer
  '((((background light)) :background "gray90" :foreground "black")
    (t :weight semibold
       :box (:color "#151d2c"
             :line-width (-1 . -2))
       :background "#e1c9b8" ;; https://www.colorhexa.com/e1c9b8
       :foreground "#ffffff"
       ;; :inverse-video t
       :inherit (org-modern-label)))
  "Face used for note labels.")
;; Moved to sar-org.el

(defun sar-org-modern--answer ()
  "Prettify headline note keywords."
  (let ((todo (match-string 1))
        (beg (match-beginning 1))
        (end (match-end 1)))
    (put-text-property beg (1+ beg) 'display
                       (format #(" %c" 1 3 (cursor t)) (char-after beg)))
    (put-text-property (1- end) end 'display (string (char-before end) ?\s))
    (put-text-property beg end 'face 'sar-org-modern-answer)))

(defface sar-org-modern-want
  '((((background light)) :background "gray90" :foreground "black")
    (t :weight semibold
       :box (:color "#151d2c"
             :line-width (-1 . -2))
       :background "#be6598" ;; https://www.colorhexa.com/be6598
       :foreground "#ffffff"
       ;; :inverse-video t
       :inherit (org-modern-label)))
  "Face used for note labels.")

(defun sar-org-modern--want ()
  "Prettify headline note keywords."
  (let ((todo (match-string 1))
        (beg (match-beginning 1))
        (end (match-end 1)))
    (put-text-property beg (1+ beg) 'display
                       (format #(" %c" 1 3 (cursor t)) (char-after beg)))
    (put-text-property (1- end) end 'display (string (char-before end) ?\s))
    (put-text-property beg end 'face 'sar-org-modern-want)))

(defface sar-org-modern-accomplish
  '((((background light)) :background "gray90" :foreground "black")
    (t :weight semibold
       :box (:color "#3f3f3f"
             :line-width (-1 . -3))
       :background "#dbaac6" ;; https://www.colorhexa.com/dbaac6
       :foreground "#ffffff"
       ;; :inverse-video t
       :inherit (org-modern-label)))
  "Face used for note labels.")

(defun sar-org-modern--accomplish ()
  "Prettify headline note keywords."
  (let ((todo (match-string 1))
        (beg (match-beginning 1))
        (end (match-end 1)))
    (put-text-property beg (1+ beg) 'display
                       (format #(" %c" 1 3 (cursor t)) (char-after beg)))
    (put-text-property (1- end) end 'display (string (char-before end) ?\s))

        (put-text-property beg end 'face 'sar-org-modern-accomplish)))

(defun sar-org-modern-append-font-lock-keywords (orig)
  "Add the custom keywords from sar-org-custom-keywords"
  (let ((full-list (funcall orig)))
    (cl-loop for (delimiter . face) in sar-org-custom-keywords
             do
             (nconc full-list
                    (list
                     `(,(format "^\\*+ +%s\\(?: \\|$\\)" (regexp-opt (list delimiter) t))
                       (0 (funcall ,face))))))
    full-list))

(defvar sar-org-custom-keywords
  '(("NOTE" . #'sar-org-modern--note)
    ("QUESTION" . #'sar-org-modern--question)
    ("ANSWERED" . #'sar-org-modern--answer)
    ("WANT" . #'sar-org-modern--want)
    ("ACCOMPLISHED" . #'sar-org-modern--accomplish)))

(provide 'sar-org-modern)
;;; sar-org-modern.el ends here
