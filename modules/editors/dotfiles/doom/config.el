;; -*- lexical-binding: t -*-

(setq auth-source-debug t)

  (setq doom-font (font-spec :family "FiraCode Nerd Font Mono" :size 14)
        doom-variable-pitch-font (font-spec :family "Iosevka Aile" :size 14))

  ;; ;; I install nerd-icons via nixos
  ;; (setq nerd-icons-font-names '("SymbolsNerdFontMono-Regular.ttf"))

  ;; Line numbers are pretty slow all around. The performance boost of disabling
  ;; them outweighs the utility of always keeping them on.
  (setq display-line-numbers-type nil)

  ;; (set-face-attribute 'default nil
  ;;   		  :family "FiraCode Nerd Font Mono"
  ;;   		  :weight 'light
  ;;                     :height 140)
  (set-face-attribute 'fixed-pitch nil
    		  :family "FiraCode Nerd Font Mono"
    		  :weight 'light)
  ;; (set-face-attribute 'variable-pitch nil
  ;;   		  :family "Iosevka Aile"
  ;;   		  :height 0.9
  ;;   		  :weight 'light)

(setq doom-theme 'doom-one)

(message "Loading mixed-pitch")
(use-package! mixed-pitch
  :hook
  (org-mode . mixed-pitch-mode))

(message "Loading spacious-padding")
(use-package! spacious-padding
  :config
  (setq spacious-padding-widths
        '( :internal-border-width 10
           :header-line-width 4
           :mode-line-width 6
           :tab-width 4
           :right-divider-width 1
           :left-fringe-width 0
           :right-fringe-width 0
           :scroll-bar-width 0))
  (spacious-padding-mode t))

(message "Loading hl-line")


(defface sar-hl-line-face
  '((t :background "#21242b" :extend t :underline (:color "#656e84" :position t) :overline "#656e84"))
  "My custom face for current line highlighting.")
;; (setq hl-line-face 'sar-hl-line-face)

(use-package! hl-line
  :custom (hl-line-face 'sar-hl-line-face))

  (after! doom-modeline
    (setq doom-modeline-persp-name t))

  (use-package! breadcrumb
    :config
    (breadcrumb-mode))

  (setq user-full-name "Scott Runnels"
        user-mail-address "srunnels@gmail.com")

  ;; (setq auth-sources '((:source "/home/scottrunnels/.authinfo.gpg")))

  (use-package! pinentry
    ;; :straight t
    ;; :defer nil
    :config
    (setf epa-pinentry-mode 'ask)
    (epa-file-enable)
    (pinentry-start))

  (use-package! auth-source-pass
    :init (setq auth-sources nil) (auth-source-pass-enable))

  (use-package! pass
    ;; :pin melpa
    ;; :ensure t
    :custom (password-store-password-length 25)
    ;;(setf epa-pinentry-mode 'loopback)
    )

(use-package! sar-identity
  :custom (sar-identity-identities '((:personal 
                                      (:name  "Scott Runnels"
                                       :email "srunnels@gmail.com"
                                       :gpg   (:encrypt     "0xA2A8C9FF810DF9DC"
                                               :sign        "0x69DD8D95BD8837D7"
                                               :autheticate "0x8ACA6091123EDE84"
                                               :certify     "0xA1E2C5C7A95F010D")
                                       :repos ((:host "github.com"
                                                :repositories (("srunnels/dotfiles" . "Personal Dotfiles")))
                                                ))))))

  ;; (map! "C-c C-w" #'backward-kill-word)
  (map! "C-x C-k" #'kill-region)
  ;; (map! "C-x b" #'switch-to-buffer) ;; a recent update to doom is causing +vertico/switch-workspace-buffer to throw errors.

;; source: https://docs.doomemacs.org/v21.12/modules/lang/org/#,code-1 
(after! evil-org
  (remove-hook 'org-tab-first-hook #'+org-cycle-only-currentu-subtree-h))

  (setq kill-whole-line t)
  (setq mouse-yank-at-point t)

  (setq save-interprogram-paste-before-kill t)

  (use-package! clipetty
    :hook (after-init . global-clipetty-mode))

  (fset 'yes-or-no-p 'y-or-n-p)
  (setq use-short-answers t)

  (blink-cursor-mode 0)

  (setq inhibit-splash-screen t)

  ;; (setq initial-buffer-choice (lambda () (get-buffer "*doom*")))

  (scroll-bar-mode 0)
  (tool-bar-mode 0)
  (menu-bar-mode -1)

  (setq window-combination-resize t)

(use-package ultra-scroll
  ;:vc (:url "https://github.com/jdtsmith/ultra-scroll") ; if desired (emacs>=v30)
  :init
  (setq scroll-conservatively 3 ; or whatever value you prefer, since v0.4
        scroll-margin 0)        ; important: scroll-margin>0 not yet supported
  :config
  (ultra-scroll-mode 1))

  (use-package! display-line-numbers
    :config
    (add-hook 'eshell-mode #'(lambda () (display-line-numbers-mode 0)))
    (add-hook 'org-mode #'(lambda () (display-line-numbers-mode 0)))
    (add-hook 'org-agenda-mode #'(lambda () (display-line-numbers-mode 0))))

(setq set-mark-command-repeat-pop t)

  (setq help-window-select t)

  (setq ffap-machine-p-known 'reject)

  (minibuffer-regexp-mode 1)

(message "Loading corfu")
(use-package! corfu
  :bind (:map corfu-mode-map
                ("C-g" . corfu-quit)
                )
  ;; Optional customizations
  ;;:custom
  ;; (corfu-cycle t)                ;; Enable cycling for `corfu-next/previous'
  ;;(corfu-auto t)                 ;; Enable auto completion
  ;;(corfu-separator ?\s)          ;; Orderless field separator
  ;; (corfu-quit-at-boundary nil)   ;; Never quit at completion boundary
  ;; (corfu-quit-no-match nil)      ;; Never quit, even if there is no match
  ;; (corfu-preview-current nil)    ;; Disable current candidate preview
  ;; (corfu-preselect 'prompt)      ;; Preselect the prompt
  ;; (corfu-on-exact-match nil)     ;; Configure handling of exact matches
  ;; (corfu-scroll-margin 5)        ;; Use scroll margin

  ;; Enable Corfu only for certain modes.
  ;; :hook ((prog-mode . corfu-mode)
  ;;        (shell-mode . corfu-mode)
  ;;        (eshell-mode . corfu-mode))
  ;;:custom
  ;; Hide commands in M-x which do not apply to the current mode.
  ;;(read-extended-command-predicate #'command-completion-default-include-p)
  ;; Disable Ispell completion function. As an alternative try `cape-dict'.
  ;; (text-mode-ispell-word-completion nil)
  ;; (tab-always-indent 'complete)
  ;; Recommended: Enable Corfu globally.  This is recommended since Dabbrev can
  ;; be used globally (M-/).  See also the customization variable
  ;; `global-corfu-modes' to exclude certain modes.
  ;; :init
  ;; (global-corfu-mode)
  )

(message "Loading treesit")
(use-package! treesit
  :mode ("\\.toml\\'" . toml-ts-mode))

;; As of yet untested
;; (with-eval-after-load 'eglot
;;   (add-to-list 'eglot-server-programs
;;                '((toml-ts-mode conf-toml-mode) . ("taplo" "lsp" "run"))))

;; ;; Automatically start LSP when opening TOML files
;; (add-hook 'toml-ts-mode-hook #'eglot-ensure)
;; (add-hook 'conf-toml-mode-hook #'eglot-ensure)

  (setenv "PATH"
          (concat "~/.local/bin/" ":"
                  (getenv "PATH")))

  (add-to-list 'exec-path (expand-file-name "~/.local/bin"))

  (require 'time-stamp)

(message "Loading exec-path-from-shell")
(use-package! exec-path-from-shell
  :hook (after-init . exec-path-from-shell-initialize)
  :custom
  (exec-path-from-shell-variables '("PATH" "SHELL"))
  )

  ;; Auto-revert in Emacs is a feature that automatically updates the
  ;; contents of a buffer to reflect changes made to the underlying file
  ;; on disk.
  ;; (add-hook 'after-init-hook #'global-auto-revert-mode)

  ;; recentf is an Emacs package that maintains a list of recently
  ;; accessed files, making it easier to reopen files you have worked on
  ;; recently.
  ;; (add-hook 'after-init-hook #'recentf-mode)

  ;; savehist is an Emacs feature that preserves the minibuffer history between
  ;; sessions. It saves the history of inputs in the minibuffer, such as commands,
  ;; search strings, and other prompts, to a file. This allows users to retain
  ;; their minibuffer history across Emacs restarts.
  ;; (add-hook 'after-init-hook #'savehist-mode)

  ;; save-place-mode enables Emacs to remember the last location within a file
  ;; upon reopening. This feature is particularly beneficial for resuming work at
  ;; the precise point where you previously left off.
  ;; (add-hook 'after-init-hook #'save-place-mode)

  (use-package! projectile
    :init
    (setq projectile-project-search-path '(("~/repos" . 1)))
    :config
    (projectile-mode +1))

  (use-package! sar-ide)

  (use-package! eglot
    :bind (:map eglot-mode-map
                ("C-c C-d" . eldoc)
                ("C-c C-e" . eglot-rename)
                ("C-c C-o" . python-sort-imports)
                ("C-c C-f" . eglot-format-buffer))
    :hook ((python-ts-mode . eglot-ensure)
           (python-ts-mode . flyspell-prog-mode)
           ;; (python-ts-mode . superword-mode)
           ;; (python-ts-mode . hs-minor-mode)
           ;; (python-mode . (lambda () (set-fill-column 88)))
           )
    :config
    ;; https://scripter.co/emacs-lisp-advice-combinators/#advice-combinators--around
    (advice-add 'eglot-ensure :around #'sar-ide-non-work-eglot-ensure-advice)
    (setq eglot-code-action-indicator "A")
    ;; I think I prefer to use .dir-locals.el on a project-by-project basis.
    ;; (setq-default eglot-workspace-configuration
    ;;               (lambda (&rest args)
    ;;                 (let ((venv-directory (string-trim (shell-command-to-string "pyenv prefix"))))
    ;;                   ;; pylsp otpions https://gist.github.com/doolio/8c1768ebf33c483e6d26e5205896217f
    ;;                   `((:pylsp . (:configurationSources ["flake8"]
    ;;                                :plugins (
    ;;                                          :mccabe (:enabled :json-false)
    ;;                                          :pylint (:enabled t
    ;;                                                   :python-path ,venv-directory
    ;;                                                   ;; :executable ".venv/bin/pylint"
    ;;                                                   )
    ;;                                          :pyflakes (:enabled :json-false)
    ;;                                          :flake8 (:enabled :json-false
    ;;                                                   :maxLineLength 140)
    ;;                                          :ruff (:enabled :json-false
    ;;                                                 :lineLength 140)
    ;;                                          :pydocstyle (:enabled t
    ;;                                                       :convention "google")
    ;;                                          :yapf (:enabled :json-false)
    ;;                                          :autopep8 (:enabled :json-false)
    ;;                                          :black (:enabled t
    ;;                                                  :line_length 100
    ;;                                                  :cache_config t))))))))
    )

  (use-package! eldoc-box
    :config (add-hook 'eglot-managed-mode-hook #'eldoc-box-hover-at-point-mode t)
    (setq eldoc-box-mouse-mode-idle-delay 3
          eldoc-box-only-multi-line t
          eldoc-box-lighter t)
    )

  ;; (use-package! dap-mode
  ;;   :after eglot
  ;;   :commands dap-debug
  ;;   :bind (("C-c <C-right>" . dap-next)
  ;; 	 ("C-c <C-down>" . dap-step-in)
  ;; 	 )

  ;;   :hook ((python-mode . dap-ui-mode)
  ;; 	 (python-mode . dap-mode)
  ;;          (python-ts-mode . dap-ui-mode)
  ;;          (python-ts-mode . dap-mode))
  ;;   :config

  ;;   (require 'dap-python)

  ;;   ;; Temporal fix
  ;;   (defun dap-python--pyenv-executable-find (command)
  ;;     (with-venv (executable-find "python3")))
  ;;   (dap-register-debug-template
  ;;    "Python :: MyProject Main"
  ;;    (list :type "python"
  ;;          :args ""
  ;;          :cwd "~/myproject/"
  ;; 	 :justMyCode :json-false
  ;;          :module nil
  ;; 	 :env '(("DEV" . "1"))
  ;;                                         ;:target-module (expand-file-name "~/src/myapp/.env/bin/myapp")
  ;;          :program "~/myproject/main.py"
  ;;          :request "launch"
  ;;          :name "Python :: MyProject Main")))

  (use-package! dape
    :after eglot
    (require 'dape)
    :hook ((python-mode . dap-ui-mode)
  	 (python-mode . dap-mode)
           (python-ts-mode . dap-ui-mode)
           (python-ts-mode . dap-mode))

    :config
    (add-to-list 'dape-configs
                 `(debugpy-flask
                   modes (python-mode jinja2-mode)
                   command "python"
                   command-args ["-m" "debugpy.adapter" "--host" "0.0.0.0" "--port" :autoport]
                   port :autoport
                   :type "python"
                   :request "launch"
                   :module "flask"
                   :args ["--app" "src" "run" "--no-debugger" "--no-reload"]
                   :console "integratedTerminal"
                   :showReturnValue t
                   :justMyCode nil
                   :jinja t
                   :cwd dape-cwd-fn)))

  (use-package! flymake
    :custom
    ;; (flymake-margin-indicators-string
    ;;  '((error " ⨂" compilation-error)
    ;;    (warning " ⚠" compilation-warning)
    ;;    (note " ℹ" compilation-info)))
    (help-at-pt-timer-delay 0.5)
    (help-at-pt-display-when-idle '(flymake-overlay))
    (flymake-auto-resize-margins nil)
    (flymake-show-diagnostic-at-end-of-line t)
    :config
    (setq flymake-error-icon "E"
          flymake-warning-icon "W"
          )
    )

  (use-package! flymake-popon
    :config
    (global-flymake-popon-mode)
    )

  (use-package! flymake-json
    :config
    (add-hook 'json-mode-hook 'flymake-json-load)
    (add-hook 'json-ts-mode-hook 'flymake-json-load)
    (global-flymake-popon-mode)
    (setenv "PATH" (concat (getenv "PATH") ":" (expand-file-name "~/node_modules/.bin")))
    (setq exec-path (append exec-path `(,(expand-file-name "~/node_modules/.bin"))))
    )

  (use-package! doom-snippets
    :after yasnippet
    ;; :straight (doom-snippets :type git :host github :repo "doomemacs/snippets" :files ("*.el" "*"))
        )

;; (message "Loading magit")
;; (after! magit
;;   :config
;;   (setq magit-repository-directories
;;         '(("~/repos" . 1))))

(message "Loading envrc")
(use-package! envrc
  :hook (after-init . envrc-global-mode))

;; (message "Loading direnv")
;; (use-package! direnv
;;   :config
;;   (direnv-mode))

    (use-package! mermaid-mode
      )

  (use-package! pytest)

    (use-package! python-coverage
      )

    (use-package! with-venv)

  (use-package! uv-mode
    ;; :hook (python-mode . uv-mode-auto-activate-hook)
    )

(message "Loading elisp-autofmt")
(use-package! elisp-autofmt
  :commands (elisp-autofmt-mode elisp-autofmt-buffer)
  :hook (emacs-lisp-mode . elisp-autofmt-mode))

(message "Loading agressive-indent")
(use-package! aggressive-indent
  :config (add-hook 'emacs-lisp-mode-hook #'aggressive-indent-mode))

(message "Loading Org section")

    (use-package! org
      :config
      (setq org-directory "~/Documents/orgmode/")
  )

    (use-package! sar-org
      ;;:after org
      :hook (org-after-note-stored-hook . sar-org-add-note-to-property)
      :config
      
      (advice-add 'org-clock-out :after 'sar-org-set-last-worked))

    ;; (use-package! org
    ;;   :config
    ;;   (set-face-attribute 'org-block nil :family "FiraCode Nerd Font Mono" :weight 'light))

    (after! org
      ;; Keybindings
      ;;
      (map! "C-c t" 'org-time-stamp-inactive)
      (map! "C-c l" 'org-store-link) 
      (map! "C-c c" 'org-capture)
      (require 'sar-org)
      (setq org-hide-emphasis-markers t
            org-insert-heading-respect-content nil
            org-log-into-drawer t
            org-use-sub-superscripts nil
            org-id-locations-file (expand-file-name "~/Documents/orgmode/.orgids")
            org-id-link-to-org-use-id 'create-if-interactive-and-no-custom-id
            org-todo-keywords '((sequence
                                 ;; A task that needs to be done
                                 "TODO(t)"
                                 ;; A task that is ready to be done
                                 "NEXT(n@/!)"
                                 ;; A task that has been started
                                 "STARTED(s!/@)"
                                 ;; A task that is waiting on something I cannot control
                                 "WAITING(w@/!)"
                                 ;; A task that is on hold due to something I can control. Basically a "blocked" state
                                 "HOLD(h@/!)"
                                 ;; A task I've delgated to another actor
                                 "DELEGATED(l@/!)" "|"
                                 ;; A task that was completed successfully
                                 "DONE(d@/!)"
                                 ;; A task that I or other decided was not worth doing
                                 "CANCELLED(c@/!)")
                    	    (sequence "APPOINTMENT(A)" "MEETING(M)" "|" "MET(m@/!)" )
                    	    (sequence
                                 ;; A thing I want to do
                                 "WANT" "|"
                                 ;; A WANT that has been completed
                                 "ACCOMPLISHED(a@/!)")
                    	    (sequence
                                 ;; An outstanding question
                                 "QUESTION(!)" "|"
                                 ;; A question that has been answered
                                 "ANSWERED(!)")
                    	    (sequence
                                 ;; A task that is an aggregate - often times for tracking sprint issues
                                 "AGGREGATE" "|"
                                 )
                    	    (sequence "WAITING(w@/!)" "HOLD(h@/!)" "|" "CANCELLED(c@/!)" "PHONE" ))
            ;; org-src-window-setup 'split-window-below

            ;; Placeholder Vars
            sar/billcode-projects ()
            sar/billcode-tasks ()
            sar/common-time-string '("<%%(memq (calendar-day-of-week date) '(1 2 3 4 5))>"
                    		 "<%%(memq (cadr date) '(15 30))>"
                    		 "<%%(diary-float t 2 3)>"
                    		 "<%%(diary-cyclic 14 4 15 2024)>")
            org-insert-heading-respect-content t ;; https://www.n16f.net/blog/org-mode-headline-tips/
            org-startup-indented t
            org-ellipsis " ▾"
            org-hide-emphasis-markers t
            org-pretty-entities t
            ;; C-e binding is pretty annoying to me
            ;; org-special-ctrl-a/e '(t . nil)
            ;; org-special-ctrl-k t
            org-src-fontify-natively t
            org-fontify-whole-heading-line t
            org-fontify-quote-and-verse-blocks t
            org-edit-src-content-indentation 2
            org-hide-block-startup nil
            org-src-tab-acts-natively t
            ;; Testing 2026/06/01` was nil
            org-src-preserve-indentation t
            ;;org-src-preserve-indentation nil
            org-adapt-indentation t
            org-indent-indentation-per-level 1
            org-startup-folded t
            org-cycle-separator-lines 2
            org-hide-leading-stars t
            org-highlight-latex-and-related '(native)
            ;; From https://www.n16f.net/blog/org-mode-headline-tips/
            org-goto-interface 'outline-path-completion
            ;; org-goto-auto-isearch nil

            ;; Capture Templates
                                ;;; This set of templates is just my basic templates rebuilt from doct
            sar/org-capture-template-strings-alist '(( meeting-once . "* MEETING %^{Group Description} :MEETING:%^g\nSCHEDULED: %^{Date}T\n:PROPERTIES:\n:CATEGORY: MEETING\n:DATE_CAPTURED:  %U\n:ID:  %(org-id-new)\n:END:\n:LOGBOOK:\n- State \"MEETING\"  from \"\"           %U\n:END:\n** Attendees\n - [[bbdb:Scott Runnels][Scott Runnels - Mandiant, Incident Response Function]]\n - %?\n** Discussion Topics\n** Action Items [/]\n** Post Meeting Notes\n\n" )
                                                     ( meeting-recur . "* %^{Group Description} %^{Time in 24h} :MEETING:%^g\n:PROPERTIES:\n:CATEGORY: RECURRING_MEETING\n:DATE_CAPTURED:  %U\n:ID:  %(org-id-new)\n:TIMESTRING:  %(car (completing-read-multiple \"> \" sar/common-time-string))\n:END:\n:LOGBOOK:\n- State \"MEETING\"  from \"\"           %U\n:END:\n\n\n%?")
                                                     ( todo-ticket . "* TODO %^{Description} %^g\n:PROPERTIES:\n:DATE_CAPTURED:  %U\n:ID:  %(org-id-new)\n:SOURCE: %^{SOURCE}\n:TICKET: %^{TICKET}p\n:END:\n:LOGBOOK:\n- State \"TODO\"  from \"\"           %U\n:END:\n\n\n%?" )
                                                     ( todo-nonticket . "* TODO %^{Description} %^g\n:PROPERTIES:\n:DATE_CAPTURED:  %U\n:ID:  %(org-id-new)\n:SOURCE:  %^{SOURCE}\n:END:\n:LOGBOOK:\n- State \"TODO\"  from \"\"           %U\n:END:\n%?" )
                                                     ( note . "* NOTE %^{Description} %^g\n:PROPERTIES:\n:DATE_CAPTURED:  %U\n:ID:  %(org-id-new)\n:SOURCE: %^{Origin of Content}\n:END:\n\n\n%?" )
                                                     ( note-want . "* WANT %^{What do you want} %^g\n:PROPERTIES:\n:DATE_CAPTURED:  %U\n:ID:  %(org-id-new)\n:END:\n\n\n%?" )
                                                     ( note-question . "* QUESTION %^{Question} %^g\n:PROPERTIES:\n:DATE_CAPTURED:  %U\n:ID:  %(org-id-new)\n:END:\n\n\n%?" )
                                                     ( note-brag . "* BRAG %^{What was accomplished} %^g\n:PROPERTIES:\n:DATE_CAPTURED:  %U\n:ID:  %(org-id-new)\n:END:\n\n\n%?" )
                                                     ( aggregate . "* AGGREGATE %^{Description} [/] %^g\nDEADLINE: %^{Deadline}t SCHEDULED: %^{Scheduled}t\n:PROPERTIES:\n:DATE_CAPTURED:  %U\n:ID:  %(org-id-new)\n:CATEGORY:  AGGREGATE_ITER\n:SOURCE:  %^{SOURCE}\n:TICKET:  %^{TICKET}p\n:END:\n%?" )
                                                     )
            org-capture-templates `(
                                    ("m" "Meetings")
                                    ("mp" "Personal Meetings")
                                    ("mpo" "Personal One-off Meeting" entry (file "personal/refile.org")
                                     ,(alist-get 'meeting-once
                                                 sar/org-capture-template-strings-alist)
                                     :clock-in t :empty-lines 1)
                                    ("mpr" "Personal Recurring Meeting" entry (file "personal/refile.org")
                                     ,(alist-get 'meeting-recur
                                                 sar/org-capture-template-strings-alist)
                                     :empty-lines 1)
                                    ("t" "Tasks")
                                    ;; ("tt" "Ticketed Task" entry (file "refile.org")
                                    ;;  ,(alist-get 'todo-ticket
                                    ;;              sar/org-capture-template-strings-alist)
                                    ;;  :clock-in t :empty-lines 1)
                                    ("tp" "Personal Task" entry (file "personal/refile.org")
                                     ,(alist-get 'todo-nonticket
                                                 sar/org-capture-template-strings-alist)
                                     :clock-in t :empty-lines 1)
                                    ("n" "Notes")
                                    ("np" "Personal Notes")
                                    ("npn" "Personal Note" entry (file "personal/notes.org")
                                     ,(alist-get 'note
                                                 sar/org-capture-template-strings-alist))
                                    ("npw" "Personal Want" entry (file "personal/notes.org")
                                     ,(alist-get 'note-want
                                                 sar/org-capture-template-strings-alist))
                                    ("npb" "Personal Brag" entry (file "personal/brag.org")
                                     ,(alist-get 'note-brag
                                                 sar/org-capture-template-strings-alist))
                                    ("npQ" "Personal Questions" entry (file "personal/notes.org")
                                     ,(alist-get 'note-question
                                                 sar/org-capture-template-strings-alist))
                                    ;; ("a" "Aggregate" entry (file+headline "refile.org" "Current Iteration Aggregates")
                                    ;;  ,(alist-get 'aggregate
                                    ;;              sar/org-capture-template-strings-alist))
                                    ("i" "In place insertion")
                                    ("in" "Note" entry (here)
                                     ,(alist-get 'note
                                                 sar/org-capture-template-strings-alist))
                                    ("iw" "Want" entry (here)
                                     ,(alist-get 'note-want
                                                 sar/org-capture-template-strings-alist))
                                    ("iQ" "Question" entry (here)
                                     ,(alist-get 'note-question
                                                 sar/org-capture-template-strings-alist)))


            ;; The default from Doom looks interesting
            ;; (("t" "Personal todo" entry
            ;;   (file+headline +org-capture-todo-file "Inbox")
            ;;   "* [ ] %?\n%i\n%a" :prepend t)
            ;;  ("n" "Personal notes" entry
            ;;   (file+headline +org-capture-notes-file "Inbox")
            ;;   "* %u %?\n%i\n%a" :prepend t)
            ;;  ("j" "Journal" entry
            ;;   (file+olp+datetree +org-capture-journal-file)
            ;;   "* %U %?\n%i\n%a" :prepend t)
            ;;  ("p" "Templates for projects")
            ;;  ("pt" "Project-local todo" entry
            ;;   (file+headline +org-capture-project-todo-file "Inbox")
            ;;   "* TODO %?\n%i\n%a" :prepend t)
            ;;  ("pn" "Project-local notes" entry
            ;;   (file+headline +org-capture-project-notes-file "Inbox")
            ;;   "* %U %?\n%i\n%a" :prepend t)
            ;;  ("pc" "Project-local changelog" entry
            ;;   (file+headline +org-capture-project-changelog-file "Unreleased")
            ;;   "* %U %?\n%i\n%a" :prepend t)
            ;;  ("o" "Centralized templates for projects")
            ;;  ("ot" "Project todo" entry #'+org-capture-central-project-todo-file "* TODO %?\n %i\n %a" :heading "Tasks" :prepend nil)
            ;;  ("on" "Project notes" entry #'+org-capture-central-project-notes-file "* %U %?\n %i\n %a" :heading "Notes" :prepend t)
            ;;  ("oc" "Project changelog" entry #'+org-capture-central-project-changelog-file "* %U %?\n %i\n %a" :heading "Changelog" :prepend t))
            org-refile-targets (quote ((nil :maxlevel . 9)
                    		   (org-agenda-files :maxlevel . 9)))
            org-refile-use-outline-path 'file
            org-refile-allow-creating-parent-nodes (quote confirm)
            org-refile-use-cache t
            org-outline-path-complete-in-steps nil ;; Needed for partial completing of org-refile
            org-overriding-columns-format "%TODO %7EFFORT %PRIORITY     %100ITEM 100%BILLCODE_PROJECT 100%BILLCODE_TASK 100%TAGS"
            org-src-fontify-natively t
            org-confirm-babel-evaluate nil)

      ;; Save all org buffers when I refile
      (advice-add 'org-refile :after 'org-save-all-org-buffers)

      ;; Make it so I can C-c C-o on sqlite: links to open sqlite files using sqlite-mode-open-file
      (org-link-set-parameters "sqlite" :follow #'sqlite-mode-open-file)

      ;; Add custom structure templates
      (add-to-list 'org-structure-template-alist '("Q" . "question"))
      (add-to-list 'org-structure-template-alist '("i" . "info"))
      (add-to-list 'org-structure-template-alist '("w" . "warning"))
      (add-to-list 'org-structure-template-alist '("x" . "example"))
      (add-to-list 'display-buffer-alist '("\\*\\(Org \\(Select\\|Note\\)\\|Agenda Commands\\)\\*" ; the `org-capture' key selection and `org-add-log-note'
                                           (display-buffer-in-side-window)
                                           (dedicated . t)
                                           (side . bottom)
                                           (slot . 0)
                                           (window-parameters . ((mode-line-format . none)))))
      (add-hook! org-mode :append
                 #'visual-line-mode
                 ;; #'variable-pitch-mode
                 #'(lambda () (set-face-attribute 'org-block nil :family "FiraCode Nerd Font Mono" :weight 'light))
                 #'(lambda () (set-face-attribute 'org-table nil :family "FiraCode Nerd Font Mono" :weight 'light))
                 #'(lambda () (setq-local fill-column 120)))
      (add-hook! 'org-after-todo-state-change-hook #'sar-org-clock-in-if-starting)
      (add-hook! 'org-after-todo-state-change-hook #'sar-org-update-heirarchy-times)
      ;; Apply IDs to all items which have a state change.
      (add-hook! 'org-after-todo-state-change-hook #'org-id-get-create)
      (add-hook! 'org-capture-prepare-finalize-hook #'org-id-get-create)
      (add-hook! 'org-after-todo-state-change-hook #'sar-org-clock-out-if-waiting)
      (set-face-attribute 'org-block nil :family "FiraCode Nerd Font Mono" :weight 'light)
      (when (file-exists-p (expand-file-name "~/.local/share/emacs-lisp/libraryofbabel.org"))
        (org-babel-lob-ingest "~/.local/share/emacs-lisp/libraryofbabel.org")
        ))

  (after! org
    ;; (setq org-agenda-files (list (expand-file-name "~/Documents/orgmode/personal/")))
    (setq org-agenda-files (list (expand-file-name "~/Documents/orgmode/")))
    (advice-add 'org-agenda :after (lambda (&optional arg keys restriction)
                                     (persp-switch "Agenda")
                                     (persp-add-buffer "*Org Agenda*")))
    (add-to-list 'special-display-buffer-names "*Org Agenda*")
    (setq org-agenda-category-icon-alist `(("diary" (list "")  nil nil :ascent center :mask heuristic)
                                           ("meeting" (list "") nil nil :ascent center :mask heuristic)
                                           ("note" (list "")  nil nil :ascent center :mask heuristic)
                                           ("irtaskflow" (list "")  nil nil :ascent center :mask heuristic)
                                           ("irfunction" (list "") nil nil :ascent center :mask heuristic)
                                           ("migration" (list "") nil nil :ascent center :mask heuristic)
                                           ("overhead" (list "")  nil nil :ascent center :mask heuristic)
                                           ("refile" (list "")  nil nil :ascent center :mask heuristic)
                                           ("mtrends2023" (list "")  nil nil :ascent center :mask heuristic)
                                           ("emacs" (list "")  nil nil :ascent center :mask heuristic)
                                           ("google" (list "")  nil nil :ascent center :mask heuristic)
                                           ;; Default value
                                           ("" (list "") nil nil :ascent center :mask heuristic)))
    )

  (use-package org-transclusion
    :after org
    :init
    :config
    (map!
     :after org
     :map org-transclusion-minor-mode-map
     :prefix "C-c n T"
     "a" #'org-transclusion-add
     "d" #'org-transclusion-remove
     "m" #'org-transclusion-mode
     "l" #'org-transclusion-make-from-link
     "o"  #'org-transclusion-open-source)
    (with-eval-after-load 'org-transclusion
      (add-to-list 'org-transclusion-extensions 'org-transclusion-indent-mode)
      (require 'org-transclusion-indent-mode)))

  (use-package! org-super-agenda
    :defer t
    :commands org-super-agenda
    :config
    (setq org-agenda-skip-scheduled-if-done t
          org-agenda-skip-deadline-if-done t
          org-agenda-include-deadlines t
          org-agenda-block-separator nil
          org-agenda-tags-column 100 ;; from testing this seems to be a good value
          org-agenda-compact-blocks t
          org-agenda-custom-commands '(("o" "Overview"
                                        ((agenda "" ((org-agenda-span 'day)
                                                     (org-agenda-start-day nil)
                                                     (org-super-agenda-groups
                                                      '((:name "Today"
                                                         :time-grid t
                                                         :date today
                                                         :todo "TODO"
                                                         :scheduled today
                                                         :order 1)))))
                                         (alltodo "" ((org-agenda-overriding-header "")
                                                      (org-super-agenda-groups
                                                       '((:name "Next to do"
                                                          :todo "NEXT"
                                                          :order 1)
                                                         (:name "Important"
                                                          :tag "Important"
                                                          :priority "A"
                                                          :order 6)
                                                         (:name "Due Today"
                                                          :deadline today
                                                          :order 2)
                                                         (:name "Due Soon"
                                                          :deadline future
                                                          :order 8)
                                                         (:name "Overdue"
                                                          :deadline past
                                                          :face error
                                                          :order 7)
                                                         (:name "Emacs"
                                                          :tag "Emacs"
                                                          :order 13)
                                                         (:name "Waiting"
                                                          :todo "WAITING"
                                                          :order 20)
                                                         (:name "Trivial"
                                                          :priority<= "E"
                                                          :tag ("Trivial" "Unimportant")
                                                          :todo ("SOMEDAY" )
                                                          :order 90)
                                                         (:discard (:tag ("Chore" "Routine" "Daily")))))))))
                                       ("n" "Agenda and all TODOs"
                                        ((agenda "")
                                         (alltodo "")))
                                       ("k" "Open Ticket Items"
                                        ((tags "TICKET={[\"cl\"b][\"/\"][0-9]+}"
                                               ((org-agenda-overriding-header "Open Tickets") ;; Non-empty string
                                                (org-agenda-remove-tags t)
                                                (org-agenda-span 'day)
                                                (org-agenda-time-grid nil)
                                                (org-agenda-start-day "+0d")
                                                (org-agenda-sorting-strategy (quote ((agenda time-up priority-down tag-up))))
                                                (org-agenda-prefix-format " %i ")
                                                ;; Do not include scheduled, due or overdue items here
                                                (org-deadline-warning-days 0)
                                                (org-scheduled-past-days 0)
                                                (org-deadline-past-days 0)
                                                (org-agenda-skip-function '(org-agenda-skip-entry-if 'todo 'done))
                                                (org-agenda-skip-scheduled-if-done t)
                                                (org-agenda-skip-timestamp-if-done t)
                                                (org-agenda-skip-deadline-if-done t)))))
                                       ("d" "Daily Action List"
                                        ( (agenda "" ((org-agenda-overriding-header "Today") ;; Non-empty string
                                                      (org-agenda-remove-tags t)
                                                      (org-agenda-span 'day)
                                                      (org-agenda-time-grid nil)
                                                      (org-agenda-start-day "+0d")
                                                      (org-agenda-sorting-strategy (quote ((agenda time-up priority-down tag-up))))
                                                      (org-agenda-prefix-format " %i %-12t %-6e ")
                                                      ;; Do not include scheduled, due or overdue items here
                                                      (org-deadline-warning-days 0)
                                                      (org-scheduled-past-days 0)
                                                      (org-deadline-past-days 0)
                                                      (org-agenda-skip-scheduled-if-done t)
                                                      (org-agenda-skip-timestamp-if-done t)
                                                      (org-agenda-skip-deadline-if-done t)))
                                          (agenda "" ((org-agenda-overriding-header "\n Tomorrow\n")
                                                      (org-agenda-remove-tags t)
                                                      (org-agenda-prefix-format " %i %-6t ")
                                                      (org-agenda-start-on-weekday nil)
                                                      (org-agenda-time-grid nil)
                                                      (org-agenda-start-day "+1d")
                                                      (org-agenda-span 1)
                                                      (org-deadline-warning-days 0)
                                                      (org-agenda-block-separator 9472)
                                                      (org-agenda-skip-function '(org-agenda-skip-entry-if 'todo 'done))))
                                          (agenda "" ((org-agenda-overriding-header "\nOverdue")
                                                      (org-agenda-remove-tags t)
                                                      (org-agenda-prefix-format " %i ")
                                                      ;;(org-agenda-prefix-format " %i %?-12t")
                                                      (org-agenda-time-grid nil)
                                                      (org-agenda-start-on-weekday nil)
                                                      (org-agenda-show-all-dates nil)
                                                      (org-scheduled-delay-days 1)
                                                      (org-agenda-format-date "")  ;; Skip the date
                                                      (org-agenda-span 5)
                                                      (org-agenda-use-tag-inheritance t)
                                                      (org-agenda-skip-function 'sar/skip-personal-agenda)
                                                      ;;(org-agenda-skip-function '(org-agenda-skip-entry-if 'todo 'done))
                                                      (org-agenda-entry-types '(:deadline :scheduled))
                                                      (org-scheduled-past-days 999)
                                                      (org-deadline-past-days 999)
                                                      (org-scheduled-delay-days 1)
                                                      (org-deadline-warning-days 0)))
                                          (agenda "" ((org-agenda-overriding-header "\nUpcoming deadlines (+14d)\n")
                                                      (org-agenda-remove-tags t)
                                                      (org-agenda-time-grid nil)
                                                      (org-agenda-prefix-format " %i %-6t ")
                                                      (org-agenda-start-on-weekday nil)
                                                      ;; We don't want to replicate the previous section's
                                                      ;; three days, so we start counting from the day after.
                                                      (org-agenda-start-day "+1d")
                                                      (org-agenda-span 20)
                                                      (org-agenda-show-all-dates nil)
                                                      (org-agenda-time-grid nil)
                                                      (org-deadline-warning-days 0)
                                                      (org-agenda-block-separator nil)
                                                      (org-agenda-entry-types '(:deadline))
                                                      (org-agenda-skip-function '(org-agenda-skip-entry-if 'done))))

                                          (tags-todo "TODO=\"NEXT\"-focus"
                                                     ((org-agenda-overriding-header "Pull: Next Actions") ;; (ct/iconified-header "tasks" "Pull: Next Actions"))
                                                      (org-agenda-remove-tags t)
                                                      (wrap-prefix "       ")
                                                      (org-agenda-use-tag-inheritance t)
                                                      (org-agenda-skip-function 'sar/skip-personal-agenda)
                                                      (org-tags-match-list-sublevels nil)
                                                      (org-agenda-todo-ignore-scheduled 'future)))))
                                       ("w" "Waiting items"
                                        ((tags-todo "TODO=\"WAITING\""
                                                    ((org-agenda-overriding-header "Waiting Items") ;; Non-empty string
                                                     (org-agenda-remove-tags nil)
                                                     (org-agenda-span 'day)
                                                     (org-agenda-time-grid nil)
                                                     (org-agenda-start-day "+0d")
                                                     (org-agenda-prefix-format " %i ")
                                                     (org-agenda-skip-function (lambda () (sar-org-skip-non-waiting-for-N 5)))
                                                     ;;(org-agenda-skip-function (lambda () (sar-org-skip-non-waiting)))
                                                     ;;(org-agenda-skip-function 'sar-org-skip-non-waiting)
                                                     )))))))

  (after! org-agenda
    (let ((inhibit-message t))
      (org-super-agenda-mode)))

  (use-package! org-crypt
    :custom
    (org-crypt-key "Scott Runnels <srunnels@gmail.com>") ;; KEYID=A1E2C5C7A95F010D
    (org-tags-exclude-from-inheritance (quote ("crypt")))
    :config
    (org-crypt-use-before-save-magic))

  (use-package! sar-org-modern)
  (use-package! org-modern
    :custom ((org-modern-todo t)
             (org-modern-table nil)
             (org-modern-variable-pitch nil)
             (org-modern-block-fringe nil)
             (org-modern-star 'fold)
             ;; Pulled from https://www.nerdfonts.com/cheat-sheet
             (org-modern-fold-stars
              ' (("◉" . "◯")
                 ("│" . "└")
                 (" │" . " └")
                 (" │" . " └")))
             ;; (org-modern-fold-stars '(("󰼎" . "󰎣")
             ;;                          ("󰼏" . "󰎦")
             ;;                          ("󰼐" . "󰎩")
             ;;                          ("󰼑" . "󰎬")
             ;;                          ("󰼒" . "󰎮")
             ;;                          ("󰼓" . "󰎰")
             ;;                          ("󰼔" . "󰎵")
             ;;                          ("󰼕" . "󰎸")
             ;;                          ("󰼖" . "󰎻")
             ;;                          ("󰼗" . "󰎾")
             ;;                          ("󰼘" . "󰏁")))
             )
    :config
    (advice-add 'org-modern--make-font-lock-keywords :around #'sar-org-modern-append-font-lock-keywords))

  (use-package! org-wild-notifier
    :config
    (setq org-wild-notifier-keyword-whitelist '("TODO" "NEXT" "WAITING" "MEETING")
          ;; org-wild-notifier-keyword-whitelist nil
          org-wild-notifier-alert-time '(10 5 1 0)
          org-wild-notifier--alert-severity 'high
          alert-default-style 'libnotify
          alert-fade-time 50)
    (org-wild-notifier-mode))

  (use-package! ox-gfm)

  (use-package! ox-reveal
    :config
    (setq org-reveal-root "file:///home/scottrunnels/Documents/reveal.js"))

  (use-package! ox-timeline)

  (use-package! ox-latex
    :config
    (setq org-latex-pdf-process '("pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
                                  "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
                                  "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f")
          org-latex-listings 'minted

          )
    
    ;; Additional latex and beamer export settings
    (add-to-list 'org-latex-packages-alist '("" "minted" "tabularx"))  

    (when (file-exists-p "~/repos/dotfiles/latex_classes/sar-assign/sar-assign.sty")
      (add-to-list 'org-latex-classes
                   `("sar-assign"
                     ,(with-temp-buffer
                        (insert-file-contents "~/repos/dotfiles/latex_classes/sar-assign/sar-assign.sty")
                        (buffer-string)) 
                     ("\\section{%s}" . "\\section*{%s}")
                     ("\\subsection{%s}" . "\\subsection*{%s}")
                     ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
                     ("\\paragraph{%s}" . "\\paragraph*{%s}")
                     ("\\subparagraph{%s}" . "\\subparagraph*{%s}"))))
    (add-to-list 'org-babel-load-languages '(latex . t))
    ;;  Let's set some better mappings of languages to lexers
    (add-to-list 'org-latex-minted-langs '(dot "c"))
    (add-to-list 'org-latex-minted-langs '(r "splus"))
    
    )

    (after! ox-latex 
      (add-to-list 'org-latex-classes
                   `("sar-assign"
                     ,(with-temp-buffer
                        (insert-file-contents "~/repos/dotfiles/latex_classes/sar-assign/sar-assign.sty")
                        (buffer-string)) 
                     ("\\section{%s}" . "\\section*{%s}")
                     ("\\subsection{%s}" . "\\subsection*{%s}")
                     ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
                     ("\\paragraph{%s}" . "\\paragraph*{%s}")
                     ("\\subparagraph{%s}" . "\\subparagraph*{%s}"))))

    (after! ox-latex
      (add-to-list 'org-latex-classes
                   `("resume"
                     ,(with-temp-buffer
                        (insert-file-contents "~/repos/dotfiles/latex_classes/resume/resume-template.sty")
                        (buffer-string))
                     ("\\cvsection{%s}" . "\\cvsection*{%s}")
                     ("\\cvevent{%s}" . "\\cvevent*{%s}"))))

(message "Loading ox-pandoc")
(use-package! ox-pandoc)

(after! org
  (setq org-babel-load-languages
        '((emacs-lisp . t)
          (shell      . t)
          (plantuml   . t)
          (json       . t)
          (python     . t)
          (jq         . t)))

  (add-hook! org-babel-after-execute-hook 'org-redisplay-inline-images)
  ;; I haven't been able to figure out why ob-shell isn't autoloading just yet,
  ;; so for the time being I'll manually load it on start.
  (require 'ob-shell)
  )

  (use-package! ob-python
    :config
    ;; By setting this I can configure individual arguments
    ;; eg. to use asyncio in a REPL (setq python-shell-interpreter-args "-m asyncio -i")
    (setq org-babel-python-command 'auto
          org-babel-python-command-nonsession "python3")
    )

  (use-package! jq-mode
    :config
    (autoload 'jq-mode "jq-mode.el")
    (add-to-list 'auto-mode-alist '("\\.jq$" . jq-mode))
    (with-eval-after-load "json-mode"
      (define-key json-mode-map (kbd "C-c C-j") #'jq-interactively))
    (add-to-list 'org-babel-load-languages '(jq . t))
    ;; (org-babel-do-load-languages 'org-babel-load-languages
    ;;                              '((jq . t)))
    :mode ("\\.\\(jq\\)$" . jq-mode) ;; TODO Figure out how you do this in Doom.
    )

  (after! org
    (use-package! ob-jq))

    (use-package! restclient
      :config
      (add-hook! 'restclient-mode-hook #'(lambda ()
                                         (require 'js)
                                         (setq-local indent-line-function 'js-indent-line)
                                         (setq restclient-inhibit-cookies t)))
      :mode ("\\.\\(http\\|rest\\)$" . restclient-mode) ;; TODO Figure out how you do this in Doom.
      )

    (after! org
      (use-package! ob-restclient))

  (after! org
    (use-package! ob-json
      :config
      (add-to-list 'org-babel-load-languages '(json . t)))
    )

  (after! org
    (use-package! ob-mermaid
      :config
      (add-to-list 'org-babel-load-languages '(mermaid . t))
      (setq ob-mermaid-cli-path (expand-file-name "~/node_modules/.bin/mmdc"))))

(message "Loading ob-async")
(use-package! ob-async
  :config
  (setq ob-async-no-async-languages-alist '("ipython"))
  )

  (use-package! sar-org-roam)

  ;; (use-package! org-roam
  ;;   :custom
  ;;   (sar-org-roam-templates
  ;;    '((article . "#+title: ${title}\n#+created: %<%Y-%m-%dT%H%M%S>\n#+filetags: :article:\n- tags :: \n\n")
  ;;      (main . "#+title: ${title}\n#+created: %<%Y-%m-%dT%H%M%S>\n#+filetags: :main:\n- tags :: \n\n")
  ;;      (reference . "#+title: ${title}\n#+created: %<%Y-%m-%dT%H%M%S>\n#+published: %^{Published}\n#+filetags: :reference:\n- tags :: \n\n")
  ;;      (concept . "#+title: ${title}\n#+created: %<%Y-%m-%dT%H%M%S>\n#+filetags: :concept:\n- tags :: \n\n")))
  ;;   )

  (use-package! org-roam
    ;; :hook ((org-roam-mode . turn-on-visual-line-mode)
    ;;        (org-roam-capture-new-node . sar-org-roam-tag-new-node-as-draft))
    :custom
    (sar-org-roam-templates
     '((article   . "#+title: ${title}\n#+created: %<%Y-%m-%dT%H%M%S>\n#+filetags: :article:\n- tags :: \n\n")
       (main      . "#+title: ${title}\n#+created: %<%Y-%m-%dT%H%M%S>\n#+filetags: :main:\n- tags :: \n\n")
       (reference . "#+title: ${title}\n#+created: %<%Y-%m-%dT%H%M%S>\n#+published: %^{Published}\n#+filetags: :reference:\n- tags :: \n\n")
       (concept   . "#+title: ${title}\n#+created: %<%Y-%m-%dT%H%M%S>\n#+filetags: :concept:\n- tags :: \n\n")))
    :config
    (setq org-roam-completion-everywhere nil
          org-roam-directory (file-truename "~/org-roam")
          org-roam-dailies-directory "work/daily/"
          org-roam-dailies-capture-templates '(("d" "default" entry "* %U\n %?"
                                                :if-new (file+head "%<%Y-%m-%d>.org" "#+title: Journal for %<%Y-%m-%d>\n#+filetags: :journal:\n"))
                                               ("p" "private" entry "* %U :private:crypt:\n %?"
        					      :if-new (file+head "%<%Y-%m-%d>.org" "#+title: Journal for %<%Y-%m-%d>\n#+filetags: :journal:\n")))
          org-roam-database-connector 'sqlite-builtin
          org-roam-db-location (file-truename "~/.config/emacs/org-roam-db.sqlite")
          org-roam-capture-templates
          `(("m" "Main zettles")
            ("mp" "Main Personal zettle" plain
             "%?"
             :if-new (file+head "personal/main/${title}.org"
      		              ,(alist-get 'main sar-org-roam-templates))
             :immediate-finish t
             :unnarrowed t)
            ("r" "Reference zettles")
            ("rp" "Reference Personal zettle" plain
             "%?"
             :if-new (file+head "personal/reference/${title}.org"
      		              ,(alist-get 'reference sar-org-roam-templates))
             :immediate-finish t
             :unnarrowed t)
            ("a" "Article zettles")
            ("ap" "Article Personal zettle" plain
             "%?"
             :if-new (file+head "personal/article/${title}.org"
      		              ,(alist-get 'article sar-org-roam-templates))
             :immediate-finish t
             :unnarrowed t)
            ("c" "Concept zettle" plain
             "%?"
             :if-new (file+head "concept/${title}.org"
      		              ,(alist-get 'concept sar-org-roam-templates))
             :immediate-finish t
             :unnarrowed t))
          org-roam-node-display-template (concat "${scope:10} ${type:15} ${title:*} "
                                                 (propertize "${tags:10}"
                                                             'face
                                                             'org-tag)))

    (setq org-roam-capture-ref-templates
          '(("R" "ref" plain "* Read ${title}\n${link}\n${body}\n%?" :target (here) :unnarrowed t)))
    (setq org-roam-list-files-commands '(fdfind fd rg find))
    (add-hook! 'org-roam-mode-hook #'turn-on-visual-line-mode)
    (add-hook! 'org-roam-capture-new-node-hook #'sar-org-roam-tag-new-node-as-draft)
    (if (getenv "EMACSLOCAL")
      (setq org-roam-db-autosync-mode nil)
    (setq org-roam-db-autosync-mode +1))
    (add-to-list 'display-buffer-alist
                 '("\\*org-roam\\*"
                   (display-buffer-in-direction)
                   (direction . right)
                   (window-width . 0.33)
                   (window-height . fit-window-to-buffer)))
    (require 'org-roam-export)
    ;; (dir-locals-set-class-variables 'org-roam
    ;;                                 '((org-mode . ((fill-column . 120)
    ;;                                                (org-yank-image-save-method . ".attach")
    ;;                                                (subdirs . t)))))
    ;; (dir-locals-set-directory-class "~/org-roam/" 'org-roam)
    )

  ;; (after! org-roam
  ;;   (add-hook! org-roam-mode #'turn-on-visual-line-mode)
  ;;   (add-hook! org-roam-capture-new-node #'sar-tag-new-node-as-draft)
  ;;   ;; :hook ((org-roam-mode . turn-on-visual-line-mode)
  ;;   ;;        (org-roam-capture-new-node . sar/tag-new-node-as-draft)
  ;;   ;;        )
  ;;   ;; :bind (("C-c n l" . org-roam-buffer-toggle)
  ;;   ;;        ("C-c n f" . org-roam-node-find)
  ;;   ;;        ("C-c n g" . org-roam-graph)
  ;;   ;;        ("C-c n i" . org-roam-node-insert)
  ;;   ;;        ("C-c n c" . org-roam-capture)
  ;;   ;;        ("C-c n j" . org-roam-dailies-capture-today))
  ;;   ;; :config
  ;;   (setq org-roam-completion-everywhere nil
  ;;         org-roam-directory (file-truename "~/org-roam")
  ;;         org-roam-dailies-directory "journal/"
  ;;         org-roam-dailies-capture-templates '(("d" "default" entry "* %U\n %?"
  ;;                                               :if-new (file+head "%<%Y-%m-%d>.org" "#+title: Journal for %<%Y-%m-%d>\n#+filetags: :journal:\n"))
  ;;   					     ("p" "private" entry "* %U :private:crypt:\n %?"
  ;;     					      :if-new (file+head "%<%Y-%m-%d>.org" "#+title: Journal for %<%Y-%m-%d>\n#+filetags: :journal:\n")))
  ;;         org-roam-database-connector 'sqlite-builtin
  ;;         org-roam-db-location (file-truename "~/.config/emacs/org-roam-db.sqlite"))
  ;;   (cl-defmethod org-roam-node-scope ((node org-roam-node))
  ;;     (condition-case nil
  ;;         (directory-file-name
  ;;          (file-name-directory
  ;;           (directory-file-name
  ;;            (file-name-directory
  ;;             (file-name-directory (file-relative-name (org-roam-node-file node)
  ;;                                                      org-roam-directory))))))
  ;;       (error "")))
  ;;   (cl-defmethod org-roam-node-type ((node org-roam-node))
  ;;     "Return the TYPE of NODE."
  ;;     (condition-case nil
  ;;         (file-name-nondirectory
  ;;          (directory-file-name
  ;;           (file-name-directory
  ;;            (file-relative-name (org-roam-node-file node) org-roam-directory))))
  ;;       (error "")))
  ;;   (org-roam-db-autosync-mode +1)
  ;;   (setq org-roam-capture-templates
  ;;         `(("m" "Main zettles")
  ;;           ("mp" "Main Personal zettle" plain
  ;;            "%?"
  ;;            :if-new (file+head "personal/main/${title}.org"
  ;;   		              ,(alist-get 'main sar-org-roam-templates))
  ;;            :immediate-finish t
  ;;            :unnarrowed t)
  ;;           ("r" "Reference zettles")
  ;;           ("rp" "Reference Personal zettle" plain
  ;;            "%?"
  ;;            :if-new (file+head "personal/reference/${title}.org"
  ;;   		              ,(alist-get 'reference sar-org-roam-templates))
  ;;            :immediate-finish t
  ;;            :unnarrowed t)
  ;;           ("a" "Article zettles")
  ;;           ("ap" "Article Personal zettle" plain
  ;;            "%?"
  ;;            :if-new (file+head "personal/article/${title}.org"
  ;;   		              ,(alist-get 'article sar-org-roam-templates))
  ;;            :immediate-finish t
  ;;            :unnarrowed t)
  ;;           ("c" "Concept zettle" plain
  ;;            "%?"
  ;;            :if-new (file+head "concept/${title}.org"
  ;;   		              ,(alist-get 'concept sar-org-roam-templates))
  ;;            :immediate-finish t
  ;;            :unnarrowed t))
  ;;         org-roam-node-display-template (concat "${scope:10} ${type:15} ${title:*} "
  ;;                                                (propertize "${tags:10}"
  ;;                                                            'face
  ;;                                                            'org-tag)))
  ;;   (add-to-list 'display-buffer-alist
  ;;                '("\\*org-roam\\*"
  ;;                  (display-buffer-in-direction)
  ;;                  (direction . right)
  ;;                  (window-width . 0.33)
  ;;                  (window-height . fit-window-to-buffer)))
  ;;   (require 'org-roam-export)
  ;;   (dir-locals-set-class-variables 'org-roam
  ;;                                   '((org-mode . ((fill-column . 120)
  ;;                                                  (org-yank-image-save-method . ".attach")
  ;;                                                  (subdirs . t)))))
  ;;   (dir-locals-set-directory-class "~/org-roam/" 'org-roam))

(message "Loading org-node")
(use-package org-mem
  :config
  (setq org-mem-watch-dirs
        (list "~/org-roam/")) ;; Your org-roam-directory here
  (org-mem-updater-mode))

(use-package org-node
  :init
  ;; Optional key bindings
  ;; Tip: Try changing these to just "M-o"!
  (keymap-global-set "M-o n" org-node-global-prefix-map)
  (with-eval-after-load 'org
    (keymap-set org-mode-map "M-o n" org-node-org-prefix-map))
  :config
  (org-node-cache-mode)
  (org-node-roam-accelerator-mode)
  (setq org-node-creation-fn #'org-node-new-via-roam-capture)
  (setq org-node-file-slug-fn #'org-node-slugify-like-roam-default)
  (setq org-node-file-timestamp-format "%Y%m%d%H%M%S-"))

  (use-package! org-archive-subtree-hierarchical
    :config
    (setq org-archive-default-command 'org-archive-subtree-hierarchical))

  (after! org-mime
    (setq org-mime-export-options '(:with-latex dvipng
                                    :section-numbers nil
                                    :with-author nil
                                    :with-toc nil)))

  (use-package! clocktable-by-property)

(message "Loading org-noter")
(use-package! org-noter)

(message "Loading org-tempo")
(use-package! org-tempo
  :after org)

  (org-babel-do-load-languages 'org-babel-load-languages)

(message "Loading Vundo section")

  (use-package! vundo
    ;; :ensure t
    ;; :bind (("C-x u" . vundo)
    ;;        ("C-S-z" . undo-redo)
    ;;        ("C-z" . undo)
    ;;        (:map vundo-mode-map
    ;;     	 ("l" . vundo-forward)
    ;;     	 ("h" . vundo-backward)
    ;;     	 ("j" . vundo-next)
    ;;     	 ("k" . vundo-previous)
    ;;     	 ("q" . vundo-quit)))
    :config
    (set-face-attribute 'vundo-default nil :family "Symbola")
    (setq vundo-glyph-alist vundo-unicode-symbols)
    ;; :custom-face
    ;; (vundo-node ((t (:foreground "#808080"))))
    ;; (vundo-stem ((t (:foreground "#808080"))))
    ;; (vundo-highlight ((t (:foreground "#FFFF00"))))

    )

(message "Loading flyspell section")

  (use-package! flyspell
    :custom
    (ispell-program-name "aspell")
    ;; Default dictionary. To change do M-x ispell-change-dictionary RET.
    ;; (aspell-dictionary "en_GB-ise-wo_accents")
    (aspell-program-name "/usr/bin/aspell")
    ;; (ispell-dictionary "en_GB-ise-wo_accents")
    (ispell-program-name "/usr/bin/aspell")
    ;; :hook ((org-mode . flyspell-mode)
    ;;        (org-mode . flyspell-mode)
    ;;        ;; Enable Flyspell program mode for emacs lisp mode, which highlights all misspelled words in comments and strings.
    ;;        (emacs-lisp-mode . flyspell-prog-mode))
    ;; :bind (:map flyspell-mode-map
    ;;             ([down-mouse-3] . flyspell-correct-word)))

    (use-package! flyspell-correct
      :bind ("C-;" . flyspell-correct-wrapper))
)

(message "Loading Specific Text Formats section")

  (use-package! ssh-config-mode
    :config
    (add-to-list 'auto-mode-alist '("/\\.ssh/config\\(\\.d/.*\\.conf\\)?\\'" . ssh-config-mode))
    (add-to-list 'auto-mode-alist '("/sshd?_config\\(\\.d/.*\\.conf\\)?\\'"  . ssh-config-mode)))

(use-package! csv-mode)

(message "Loading protobuf-mode")
(use-package! protobuf-mode
  :mode ("\\.\\(txtpb\\|textproto\\|proto\\)$" . protobuf-mode))

(message "Loading Elfeed section")

  (use-package! elfeed
    :custom
    (elfeed-db-directory
     (expand-file-name "elfeed" user-emacs-directory))
    (elfeed-show-entry-switch 'display-buffer)
    :init
    (elfeed-protocol-enable)
    (advice-add 'elfeed :before (lambda ()
                                  (persp-switch "elfeed")))
    :config
    (setq elfeed-db-directory "~/.local/share/rss/elfeed")
    ;; https://github.com/skeeto/elfeed/issues/169#issuecomment-244515556
    (add-hook! 'elfeed-db-update-hook #'elfeed-db-save)
    )

  (use-package! elfeed-protocol
    :config
    ;; curl recommend
    (setq elfeed-use-curl t)
    (elfeed-set-timeout 36000)
    (setq elfeed-curl-extra-arguments '("--insecure")) ;necessary for https without a trust certificate

    ;; setup feeds
    (setq elfeed-protocol-feeds '(("ttrss+http://srunnels@192.168.1.25:8280/tt-rss/"
  		                 :password (password-store-get "personal/home/tt-rss/srunnels"))))
    ;; enable elfeed-protocol
    (setq elfeed-protocol-enabled-protocols '(ttrss))
    (elfeed-protocol-enable)
    )

  (use-package! elfeed-goodies
    :init
    (elfeed-goodies/setup)
    :config
    (setq elfeed-goodies/entry-pane-size 0.6))

  ;; (use-package! elfeed-org
  ;;     :config
  ;;     (setq rmh-elfeed-org-files (list "~/.local/share/rss/elfeed.org"))
  ;;     (elfeed-org))

  (use-package! elfeed-summary
    :config
    (setq elfeed-summary-settings '((group (:title . "Woodworking")
                                     (:elements
                                      (query . woodworking)))
    				  (group (:title . "Pins")
                                           (:elements
    					  (query . (url . "pinboard.in"))
    					  (group . ((:title . "To Read")
                                                      (:elements
                                                       (query . (and (url . "pinboard.in")
                                                                     toread)))))
    					  (group . ((:title . "To Zettle")
                                                      (:elements
                                                       (query . (and (url . "pinboard.in")
                                                                     tozettle))))))))))

  (use-package! elfeed-score
     :config
     (elfeed-score-enable))

  ;; (use-package! elfeed-sync
  ;;   ;; :after elfeed
  ;;   :config
  ;;   (elfeed-sync-mode))

;; (message "Loading Native Byte Compilation section")

  ;; (use-package! compile-angel
  ;;   :custom
  ;;   (compile-angel-verbose nil)
  ;;   :config
  ;;   (compile-angel-on-load-mode)
  ;;   (add-hook 'emacs-lisp-mode-hook #'compile-angel-on-save-local-mode)
  ;;   )

(message "Loading Aggressive Indent Mode section")

  (use-package! aggressive-indent
    :config
    (add-hook 'emacs-lisp-mode-hook #'aggressive-indent-mode))

(message "Loading Folding based on indent section")

  (use-package! outline-indent
    :custom
    (outline-indent-ellipsis " ▼ ")
    :config
    (add-hook 'python-mode-hook #'outline-indent-minor-mode)
    (add-hook 'python-ts-mode-hook #'outline-indent-minor-mode)
    (add-hook 'yaml-mode-hook #'outline-indent-minor-mode)
    (add-hook 'yaml-ts-mode-hook #'outline-indent-minor-mode)
    (map! :map outline-indent-minor-mode-map
          "M-o" #'outline-indent-open-fold
          "M-c" #'outline-indent-close-fold))

(message "Loading TRAMP section")

  (use-package! tramp
    :custom
    (tramp-use-ssh-controlmaster-options nil)
    ;; (tramp-ssh-controlmaster-options "-o ControlMaster=auto -o ControlPath=~/.ssh/tramp-%%C -o ControlPersist=8h -o ServerAliveInterval 60")
    ;; (tramp-ssh-controlmaster-options "-o ControlPath=/home/scottrunnels/.ssh/cons/ssh-%%r@%%h:%%p -o ControlPersist=yes -o ControlMaster=auto" )
    :config
    (add-to-list 'backup-directory-alist
                 (cons tramp-file-name-regexp nil))
    (setq enable-remote-dir-locals t))

(message "Loading Eshell section")

  (use-package! eshell
    :config
    (require 'pyvenv)
    (setq eshell-prompt-function
          (lambda ()
            (concat
                 (propertize "┌─[" 'face `(:foreground "#2aa198"))
                 (propertize (user-login-name) 'face `(:foreground "#dc322f"))
                 (propertize "@" 'face `(:foreground "#2aa198"))
                 (propertize (system-name) 'face `(:foreground "#268bd2"))
                 (propertize "]──[" 'face `(:foreground "#2aa198"))
                 (propertize (format-time-string "%H:%M" (current-time)) 'face `(:foreground "#b58900"))
                 (propertize "]──[" 'face `(:foreground "#2aa198"))
                 (propertize (concat (eshell/pwd)) 'face `(:foreground "#93a1a1"))
                 (propertize "]\n" 'face `(:foreground "#2aa198"))
                 (propertize "└─>" 'face `(:foreground "#2aa198"))
                 (propertize (if pyvenv-virtual-env-name (concat " (" pyvenv-virtual-env-name ")")  "") 'face `(:foreground "#00dc00"))
                 (propertize (if (= (user-uid) 0) " # " " $ ") 'face `(:foreground "#2aa198"))
                 )))
      )

(message "Loading Mail section")

(message  "Configuring notmuch...")
(use-package! notmuch
  :config
  (bbdb-initialize 'notmuch)
  (add-to-list 'display-buffer-alist '("\\*notmuch\\*" (display-buffer-pop-up-frame)))
  (setq notmuch-identities '("Scott Runnels <srunnels@gmail.com")
        ;; notmuch-fcc-dirs '(("srunnels@gmail.com" . "srunnels.gmail/Sent"))
        mail-user-agent 'notmuch-user-agent
        notmuch-show-logo nil
        notmuch-column-control 1.0
        notmuch-hello-auto-refresh t
        notmuch-hello-recent-searches-max 20
        notmuch-hello-thousands-separator ""
        notmuch-hello-sections '(notmuch-hello-insert-saved-searches)
        notmuch-message-replied-tags '("+replied")
        notmuch-message-forwarded-tags '("+forwarded")
        notmuch-show-mark-read-tags '("-unread" "-new" "-important")
        notmuch-draft-tags '("+draft")
        notmuch-draft-folder "drafts"
        notmuch-draft-save-plaintext 'ask
        notmuch-show-all-tags-list t
        notmuch-tag-formats '(("unread" (propertize tag 'face 'notmuch-tag-unread))
                              ("flag" (propertize tag 'face 'notmuch-tag-flagged)
                               (concat tag "🚩")))
        notmuch-tag-deleted-formats '(("unread" (notmuch-apply-face bare-tag 'notmuch-tag-deleted)
                                       (concat "👁️‍🗨️" tag))
                                      (".*" (notmuch-apply-face tag 'notmuch-tag-deleted)
                                       (concat "🚫" tag)))
        notmuch-tag-added-formats '(("del" (notmuch-apply-face tag 'notmuch-tag-added)
                                     (concat "💥" tag))
                                    (".*" (notmuch-apply-face tag 'notmuch-tag-added)
                                     (concat "🏷️" tag)))
        
        notmuch-saved-searches `((:name "📥 inbox"
                                  :key ,(kbd "i")
                                  :sort-order newest-first
                                  :query "tag:inbox")
                                 (:name "To Me"
                                  :key ,(kbd "m")
                                  :sort-order newest-first
                                  :query "tag:\"To Me\" and tag:unread and -tag:/Auto.*/"
                                  )
                                 (:name "💬 all unread (inbox)"
                                  :query "tag:unread and tag:inbox"
                                  :sort-order newest-first
                                  :key ,(kbd "u"))
                                 (:name "🤖 automated"
                                  :key "a"
                                  :query "tag:Automated AND tag:inbox")
                                 (:name "📰 to-read"
                                  :key "r"
                                  :query "tag:Read!")
                                 (:name "📤 sent"
                                  :key "s"
                                  :query "tag:sent")
                                 (:name "✏️ drafts"
                                  :key "d"
                                  :query "tag:draft")
                                 (:name "🚨 p0"
                                  :key "0"
                                  :query "tag:p0"))
        sendmail-program "gmi"
        message-sendmail-extra-arguments '("send" "--quiet" "-t" "-C" "~/mail/scottrunnels.google")
        +notmuch-home-function 'notmuch;; (lambda()
        ;; (notmuch-search "tag:inbox"))
        notmuch-archive-tags '("-important" "-unread" "-Read!" "-inbox" "-new")
        notmuch-search-line-faces '(("Read!"  . '(:foreground "magenta"))
                                    ("p0" . '(:foreground "red"))))
  ;; Email Composition
  (setq notmuch-mua-compose-in 'current-window
        notmuch-mua-hidden-headers nil
        notmuch-address-command 'internal
        notmuch-address-use-company nil
        notmuch-always-prompt-for-sender t
        notmuch-mua-cite-function 'message-cite-original-without-signature
        notmuch-mua-reply-insert-header-p-function 'notmuch-show-reply-insert-header-p-never
        notmuch-mua-user-agent-function nil
        notmuch-maildir-use-notmuch-insert t
        notmuch-crypto-process-mime t
        notmuch-crypto-get-keys-asynchronously t
        notmuch-mua-attachment-regexp   ; see `notmuch-mua-send-hook'
        (concat "\\b\\(attache\?ment\\|attached\\|attach\\|"
                "pi[èe]ce\s+jointe?\\|"
                "συνημμ[εέ]νο\\|επισυν[αά]πτω\\)\\b"))
  ;; Reading Messages
  (setq notmuch-show-relative-dates t     
        notmuch-show-all-multipart/alternative-parts nil
        notmuch-show-indent-messages-width 0
        notmuch-show-indent-multipart nil
        notmuch-show-part-button-default-action 'notmuch-show-view-part
        notmuch-show-text/html-blocked-images "." ; block everything
        notmuch-wash-wrap-lines-length 120
        notmuch-unthreaded-show-out nil
        notmuch-message-headers '("To" "Cc" "Subject" "Date")
        notmuch-message-headers-visible t
        )
  ;; Hooks and Keybindgs
  (add-hook 'notmuch-mua-send-hook #'notmuch-mua-attachment-check) ; also see `notmuch-mua-attachment-regexp'
  (add-hook 'notmuch-show-hook (lambda () (setq-local header-line-format nil)))
  ;;(remove-hook 'notmuch-show-hook #'notmuch-show-turn-on-visual-line-mode)
  ;;(remove-hook 'notmuch-search-hook #'notmuch-hl-line-mode) ; Check my `lin' package

  ;; (prot-emacs-keybind global-map
  ;;                     "C-c m" #'notmuch
  ;;                     "C-x m" #'notmuch-mua-new-mail) ; override `compose-mail'

  ;; (with-eval-after-load 'notmuch
  ;;   (prot-emacs-keybind notmuch-search-mode-map ; I normally don't use the tree view, otherwise check `notmuch-tree-mode-map'
  ;;                       "a" nil ; the default is too easy to hit accidentally and I do not archive stuff
  ;;                       "A" nil
  ;;                       "/" #'notmuch-search-filter ; alias for l
  ;;                       "r" #'notmuch-search-reply-to-thread ; easier to reply to all by default
  ;;                       "R" #'notmuch-search-reply-to-thread-sender)

  ;;   (prot-emacs-keybind notmuch-show-mode-map
  ;;                       "a" nil ; the default is too easy to hit accidentally and I do not archive stuff
  ;;                       "A" nil
  ;;                       "r" #'notmuch-show-reply ; easier to reply to all by default
  ;;                       "R" #'notmuch-show-reply-sender)

  ;;   (define-key notmuch-hello-mode-map (kbd "C-<tab>")  nil))
  )

(defun sar-notmuch-capture-follow-up-mail()
  "Capture mail to org mode"
  (interactive)
  (org-store-link nil)
  (org-capture nil "ef"))

(after! notmuch
  (add-hook! 'message-mode-hook 'turn-off-auto-fill)
  (add-hook! 'message-mode-hook 'visual-line-mode)
  )

  (message "Configuring ol-notmuch....")
  (use-package! ol-notmuch
    :bind ("C-c l" . org-store-link))

(message "Loading bbdb")
(use-package! bbdb
  :custom (bbdb-file "~/.config/doom/bbdb"))

  (message "Configuring sar-bbdb....")
  (use-package! sar-bbdb
    :bind
    (("C-c n b l" . sar-bbdb-insert-bbdb-link-completing)
     ("C-c n b r" . sar-bbdb-insert-bbdb-link-from-region)
     )
    :config
    ;; This is usually symlinked to my dotfiles repo
    (setq bbdb-file "~/.config/doom/bbdb")
    (bbdb-initialize 'org)
    (add-hook 'mail-setup-hook 'bbdb-mail-aliases)
    (add-hook 'message-setup-hook 'bbdb-mail-aliases)
    )

(message "Configuring notmuch-notify...")
(use-package! notmuch-notify
  :hook (notmuch-hello-refresh . notmuch-notify-hello-refresh-status-message)
  :config
  ;; (Recommended) activate system-wise notification timer
  ;;(setq notmuch-notify-excluded-tags '("Org-Mode" "FromMe"))
  (setq notmuch-notify-refresh-interval 150)
  (setq notmuch-notify-alert-profiles
        `((:name "To Read Emails"
           :search-term "tag:Read!"
           :severity urgent
           :title "Notmuch Read!:"
           ;;:icon ,(expand-file-name "img/inbox.jpg" user-emacs-directory)
           :icon ,(expand-file-name "~/.config/emacs/.local/straight/repos/notmuch-notify/notmuch-logo.png")
           ;; :audio ,(expand-file-name "audio/inbox.mp3" user-emacs-directory)
           ;; :audio "/usr/share/sounds/gnome/default/alerts/string.ogg"
           :audio ,(expand-file-name "~/.config/emacs/.local/straight/repos/notmuch-notify/emailreceived.wav")
           )
          (:name "default"))
        )
  (notmuch-notify-set-refresh-timer)
  )

  (message "Configuring message-templ...")

    ;; Debian package elpa-message-templ

    (use-package! message-templ
      ;; Source https://gitlab.com/anarcat/emacs-d/-/blob/main/notmuch-config.el?ref_type=heads#:~:text=%3B%3B%20Debian%20package%20elpa%2Dmessage%2Dtempl,)))))
      ;; :bind (("C-c s" . message-templ-select))
      ;;:config
      )
  (message "Done configuring message-templ...")

(message "Loading Media section")

(use-package! pinboard
  :defer t)

(after! pinboard
  (message "Querying pass for pinboard.in apikey")
  (setq pinboard-api-token (password-store-get "personal/pinboard.in/apikey")))

  (use-package! emms
    :config
    (require 'emms-setup)
    (emms-all)
    (setq emms-source-file-default-directory (expand-file-name "~/Music/")
          emms-player-mpd-server-name "localhost"
          emms-player-mpd-server-port "6600"
          emms-player-mpd-music-directory "~/Music/")
    (add-to-list 'emms-info-functions 'emms-info-mpd)
    (add-to-list 'emms-player-list 'emms-player-mpd)
    (add-hook 'emms-playlist-cleared-hook 'emms-player-mpd-clear))

(use-package! nov
  :config
  ;; https://emacs.stackexchange.com/questions/75281/search-whole-ebook-in-nov
  (defun nov-search (pattern)
    (interactive "sEnter search pattern: ")
    (let ((version nov-epub-version)
          (index 1)
          results)
      (while (< index (1- (length nov-documents)))
        (seq-let (id &rest path) (aref nov-documents index)
          (let (;; HACK: this should be looked up in the manifest
                (imagep (seq-find (lambda (item) (string-match-p (car item) path))
                                  image-type-file-name-regexps))
                ;; NOTE: allows resolving image references correctly
                (default-directory (file-name-directory path)))
            (unless imagep
              (with-temp-buffer
                (if (and (version< version "3.0") (eq id nov-toc-id))
                    (insert (nov-ncx-to-html path))
                  (insert (nov-slurp path)))
                (goto-char (point-min))
                (when (search-forward pattern nil t)
                  (nov-render-html)
                  (goto-char (point-min))
                  (while (search-forward pattern nil t)
                    (push (list (format "%d %s" index
                                        (replace-regexp-in-string "\n" " "
                                                                  (thing-at-point 'line)))
                                index (point))
                          results)))))
            (setq index (1+ index)))))
      ;; (print results)))
      (seq-let (index point) (alist-get (completing-read "Jump to: " (reverse results)) results
                                        nil nil #'string=)
        (nov-goto-document index)
        (goto-char point))))
  (add-to-list 'auto-mode-alist '("\\.epub\\'" . nov-mode)))

(message "Loading Performance section")

  (use-package! esup)

(message "Loading Modes section")

  (use-package! woman
    :config
    ;; Set woman buffer to pop to the right.
    ;; Previously it was set to
    ;;   ("^\\*\\(?:Wo\\)?Man " (+popup-buffer) (actions) (side . bottom) (size . 0.45)
    ;; (window-width . 40) (window-height . 0.45) (slot) (vslot . -6)
    ;; (window-parameters (ttl . 0) (quit . t) (select . t) (modeline) (autosave)
    ;;                    (transient . t) (no-other-window . t)))
    (add-to-list 'display-buffer-alist 
                 '((or . ((derived-mode . Man-mode)
                          (derived-mode . woman-mode)
                          "\\*\\(Man\\|woman\\).*"))
                   (display-buffer-same-window))))

(use-package! so-long
  :config
  :hook (so-long-mode-hook . (lambda ()
                               (when (derived-mode-p 'org-mode)
                                 (so-long-revert))))
  ;; (add-hook 'so-long-mode-hook
  ;;         (lambda ()
  ;;           (when (derived-mode-p 'org-mode)
  ;;             (so-long-revert))))
  )

(message "Instantiating the AI apocalypse")

  (use-package! gptel
    :defer t
    ;; :ensure t
    :config
    ;; (require 'gptel-gemini)
    )
  (after! gptel
    (gptel-make-gemini "Gemini"
    :key (gptel-api-key-from-auth-source "generativelanguage.googleapis.com")
    :stream t))

(message "Loading ob-nix")
(use-package! ob-nix)

(message "Loading Work Branch section")

  (unless (getenv "EMACS_LOCAL_ONLY")
    ;; Work stuff - lifted from cashweaver
    (setq sar/work-config-dir "~/.config/emacs-work")
    (message "Tangling %s/config.el" sar/work-config-dir)
    (when (file-directory-p sar/work-config-dir)
        (load (concat sar/work-config-dir "/config.el"))))

;; (require 'persp-mode)
;; (add-hook 'after-init-hook (lambda ()
;;                              (let ((configspace "Configs"))
;;                                (persp-switch configspace)
;;                                (find-file (expand-file-name "~/.config/doom/doom-emacs.org"))
;;                                (magit-status)
;;                                (persp-switch "main")
;;                                )))
