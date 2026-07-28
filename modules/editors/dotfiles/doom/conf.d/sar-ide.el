;;; sar-ide.el --- Code for IDE usage  -*- lexical-binding: t -*-

;; Copyright (C) 2025 Scott Runnels

;; Author:  Scott Runnels<srunnels@gmail.com>
;; URL: https://github.com/srunnels/dotfiles
;; Version: 0.0
;; Package-Requires: ((emacs "30.1"))
;; Keywords: emacs, project, eglot

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
;; 

;;; Code:
(defun sar-ide-non-work-eglot-ensure-advice (orig &rest args)
  "Emacs function eglot-ensure advice."
  (when (not (s-starts-with? "/google" default-directory))
    (funcall orig))
  )

(defun sar-ide-in-work-project-p ()
  (or
   (if (s-starts-with? "/google/src/"
                       (buffer-file-name))
       t
     nil)
   (if (s-matches? "^/ssh:[A-Za-z0-9]+:/google/src/."
                   (buffer-file-name))
       t
     nil)))

(provide 'sar-ide)
;;; sar-ide.el ends here
