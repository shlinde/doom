;;; init.el -*- lexical-binding: t; -*-

(doom! :input
       :completion
       (corfu +orderless +dabbrev +icons)
       (vertico +icons)

       :ui
       doom
       hl-todo
       modeline
       ophints
       (popup +defaults)
       (vc-gutter +pretty)

       :editor
       (evil +everywhere)
       fold
       (format +onsave)
       snippets

       :emacs
       dired
       electric
       undo
       vc

       :term
       eshell
       vterm

       :checkers
       (syntax +icons +childframe)

       :tools
       (eval +overlay)
       (lookup +docsets)
       magit
       pdf
       tree-sitter

       :os

       :lang
       emacs-lisp
       (python +lsp +tree-sitter +pyright)
       (org +pretty)

       :email

       :app
       calendar

       :config
       ;; literate
       (default +bindings +smartparens))
