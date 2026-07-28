  ;; -*- lexical-binding: t -*-
  (doom!

   :completion
     ;; company
     (corfu +orderless)
     (vertico +icons)

   :ui
     doom
     dashboard
     hl-todo
     indent-guides
     modeline
     ophints
     (popup +all +defaults)
     smooth-scroll
     (vc-gutter +pretty)
     vi-tilde-fringe
     workspaces

   :editor
     (evil +everywhere)
     file-templates
     fold
     snippets

   :emacs
     (dired +icons)
     (electric)
     undo
     vc

   :term
     eshell

   :checkers
   << doom-checkers>>

   :tools
     ansible
     debugger
     ;; direnv
     ein
     ;;docker
     ;;editorconfig
     (eval +overlay)
     lookup
     (lsp +eglot)
     magit
     (pass +auth)
     pdf
     tree-sitter

   :os
     tty

   :lang
     ;;agda              ; types of types of types of types...
     ;;beancount         ; mind the GAAP
     ;;(cc +lsp)         ; C > C++ == 1
     ;;clojure           ; java with a lisp
     ;;common-lisp       ; if you've seen one lisp, you've seen them all
     ;;coq               ; proofs-as-programs
     ;;crystal           ; ruby at the speed of c
     ;;csharp            ; unity, .NET, and mono shenanigans
     ;;data              ; config/data formats
     ;;(dart +flutter)   ; paint ui and not much else
     ;;dhall
     ;;elixir            ; erlang done right
     ;;elm               ; care for a cup of TEA?
     emacs-lisp        ; drown in parentheses
     ;;erlang            ; an elegant language for a more civilized age
     ;;ess               ; emacs speaks statistics
     ;;factor
     ;;faust             ; dsp, but you get to keep your soul
     ;;fortran           ; in FORTRAN, GOD is REAL (unless declared INTEGER)
     ;;fsharp            ; ML stands for Microsoft's Language
     ;;fstar             ; (dependent) types and (monadic) effects and Z3
     ;;gdscript          ; the language you waited for
     ;;(go +lsp)         ; the hipster dialect
     ;;(graphql +lsp)    ; Give queries a REST
     ;;(haskell +lsp)    ; a language that's lazier than I am
     ;;hy                ; readability of scheme w/ speed of python
     ;;idris             ; a language you can depend on
     (json +lsp +treesitter) ;; requires npm install vscode-json-languageserver
     ;;(java +lsp)       ; the poster child for carpal tunnel syndrome
     ;;javascript        ; all(hope(abandon(ye(who(enter(here))))))
     ;;julia             ; a better, faster MATLAB
     ;;kotlin            ; a better, slicker Java(Script)
     latex             ; writing papers in Emacs has never been so fun
     ;;lean              ; for folks with too much to prove
     ;;ledger            ; be audit you can be
     ;;lua               ; one-based indices? one-based indices
     markdown          ; writing docs for people to ignore
     ;;nim               ; python + lisp at the speed of c
     nix               ; I hereby declare "nix geht mehr!"
     ;;ocaml             ; an objective camel
     (org                ; organize your plain life in plain text
      +roam2
      +pretty
      )
     ;;php               ; perl's insecure younger brother
     plantuml          ; diagrams for confusing people more
     graphviz          ; diagrams for confusing yourself even more
     ;;purescript        ; javascript, but functional
     (python             ; beautiful is better than ugly
      +lsp
      +treesitter
      +jupyter)
     ;;qt                ; the 'cutest' gui framework ever
     ;;racket            ; a DSL for DSLs
     ;;raku              ; the artist formerly known as perl6
     ;;rest              ; Emacs as a REST client
     ;;rst               ; ReST in peace
     ;;(ruby +rails)     ; 1.step {|i| p "Ruby is #{i.even? ? 'love' : 'life'}"}
     ;;(rust +lsp)       ; Fe2O3.unwrap().unwrap().unwrap().unwrap()
     ;;scala             ; java, but good
     ;;(scheme +guile)   ; a fully conniving family of lisps
     (sh +lsp)                ; she sells {ba,z,fi}sh shells on the C xor
     ;;sml
     ;;solidity          ; do you need a blockchain? No.
     ;;swift             ; who asked for emoji variables?
     ;;terra             ; Earth and Moon in alignment for performance.
     ;;web               ; the tubes
     yaml              ; JSON, but readable
     ;;zig               ; C, but simpler

   :email
     ;;(mu4e +org +gmail)
     (notmuch +org)
     ;;(wanderlust +gmail)

   :app
     calendar
     emms
     (rss +org)

   :config
     (default +bindings +smartparens)
   )
