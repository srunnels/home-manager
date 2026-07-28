(load-file "~/.config/emacs/lisp/sar-ide.el")
(ert-deftest sar/in-work-project-p-finds-google ()
    "Tests that sar/in-work-project-p returns true for monorepos inclusive of TRAMP"
  (with-mock
      (stub buffer-file-name => "/google/src/blah/blah/foo/bar/flam.py")
    (should (sar/in-work-project-p)))
  (with-mock
      (stub buffer-file-name => "/ssh:remoteserver:/home/srunnels/repos/foo/flam.py")
    (should (not (sar/in-work-project-p))))
  (with-mock
      (stub buffer-file-name => "/ssh:remoteserver:/google/src/blah/blah/foo/bar/flam.py")
    (should (sar/in-work-project-p)))
  (with-mock
      (stub buffer-file-name => "/home/srunnels/repos/foo/flam.py")
    (should (not (sar/in-work-project-p)))))
