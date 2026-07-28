;; -*- lexical-binding: t -*-

(package! mixed-pitch)

(package! spacious-padding)

;;(package! hl-line)

  (package! breadcrumb)

  (package! pinentry)

  (package! pass)

  (package! sar-identity :recipe (:local-repo "~/.config/doom/conf.d/" :files ("sar-identity.el")))

(package! clipetty)

  (package! ultra-scroll)

;; (package! corfu) ;; Loaded via init

;;(package! treesit)

(package! exec-path-from-shell)

  (package! sar-ide :recipe (:local-repo "~/.config/doom/conf.d/" :files ("sar-ide.el")))

  (package! eldoc-box)

  ;; (package! dap-mode)

    (package! dape)

  (package! flymake-popon)

  (package! flymake-json)

(package! doom-snippets :recipe
    (:host github :repo "doomemacs/snippets"))

(package! envrc)

;;(package! direnv)

  (package! mermaid-mode)

  (package! pytest)

  (package! python-coverage)

  (package! with-venv)

  (package! uv-mode)

(package! elisp-autofmt)

(package! aggressive-indent)

  (package! sar-org :recipe (:local-repo "~/.config/doom/conf.d/" :files ("sar-org.el")))
  ;; (package! solaire-mode :disable t)

  (package! org-transclusion)
  ;; (package! org-transclusion-indent-mode)

(package! org-super-agenda)

(package! sar-org-modern :recipe (:local-repo "~/.config/doom/conf.d/"))

 (package! org-wild-notifier)

  (package! ox-gfm)

  (package! ox-reveal)

  (package! ox-timeline)

(package! ox-pandoc)

  (package! jq-mode)

  (package! restclient)
  (package! ob-restclient)

  (package! ob-json :recipe (:local-repo "~/.config/doom/conf.d/"))

  (package! ob-mermaid)

(package! ob-async)

  (package! sar-org-roam :recipe (:local-repo "~/.config/doom/conf.d/" :files ("sar-org-roam.el")))

(package! org-mem)
(package! org-node)

  (package! org-archive-subtree-hierarchical :recipe (:local-repo "~/.local/share/emacs-lisp/"))

  (package! clocktable-by-property :recipe (:local-repo "~/.local/share/emacs-lisp/"))

(package! org-noter)

;;(package! org-tempo)

  (package! vundo)

  ;; (package! flyspell-correct)

  (package! ssh-config-mode)

  (package! csv-mode)

(package! protobuf-mode)

  (package! elfeed-protocol)

  (package! elfeed-goodies)

  ;; (package! elfeed-org)

  (package! elfeed-summary)

    (package! efleed-score
      :recipe (:host github :repo "sp1ff/elfeed-score"))

  ;; (package! elfeed-sync

  ;;   :recipe (:host github :repo "SqrtMinusOne/elfeed-sync"))

;;  (package! compile-angel)

  (package! aggressive-indent)

  (package! outline-indent)

  (package! ol-notmuch)

(package! bbdb)

  (package! sar-bbdb :recipe (:local-repo "~/.config/doom/conf.d/" :files ("sar-bbdb.el")))

  (package! notmuch-notify :recipe
    (:host github :repo "firmart/notmuch-notify"))

(package! pinboard)

(package! emms)

  (package! nov)

  (package! esup)

  (package! gptel)

(package! ob-nix)

  (unless (getenv "EMACS_LOCAL_ONLY")
    ;; Work stuff - lifted from cashweaver
    (setq sar/work-config-dir "~/.config/emacs-work")
    (message "Tangling %s/config.el" sar/work-config-dir)
    (when (file-directory-p sar/work-config-dir)
        (load (concat sar/work-config-dir "/packages.el"))))
