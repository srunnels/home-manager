;;; sar-org_test.el ---  -*- lexical-binding: t -*-

;; Copyright (C) 2025 Scott Runnels

;; Author:  Scott Runnels<srunnels@gmail.com>
;; URL:
;; Version: 0.0
;; Package-Requires: ((emacs "30.1"))
;; Keywords: org test

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

(require 'sar-org)

(ert-deftest sar/better-archive-returns-original-on-error ()
             "`sar/better-archive` should return the original ARGS value when the car of ARGS cannot be evaluated."
             (let* ((s "%s_archive.org::")
                    (want '("%s_archive.org::"))
                    (got (sar/better-archive (list s))))
               (should (equal got want))))

(ert-deftest sar/better-archive-returns-calculated-value ()
             "`sar/better-archive` should return the computed string of a valid form found in the car of ARGS."
             (let* ((s "(concat \"%s-\" (format-time-string \"%Y-Q%q\" (current-time)) \"_archive.org::\")")
                   (want '("%s-2025-Q2_archive.org::"))
                   (got (sar/better-archive (list s))))
               (should (equal got want))))

(ert-deftest sar/better-archive-returns-calculated-value-with-headline ()
             "`sar/better-archive` should return the computed string of a valid form found in the car of ARGS when it includes a headline."
             (let* ((s "(concat \"%s-\" (format-time-string \"%Y-Q%q\" (current-time)) \"_archive.org:: * Foo\")")
                   (want '("%s-2025-Q2_archive.org:: * Foo"))
                   (got (sar/better-archive (list s))))
               (should (equal got want))))

(provide 'sar-org_test)
;;; sar-org_test.el ends here
