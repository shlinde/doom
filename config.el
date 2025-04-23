;;; Personal Information
(setq user-full-name "Sebastian Hempel Linde"
      user-mail-address "sebastian@hempellinde.com")

;;;; Theme
(setq doom-theme 'modus-vivendi
      doom-font (font-spec :family "RobotoMono Nerd Font" :size 13 :weight 'semi-bold)
      doom-variable-pitch-font (font-spec :family "RobotoMono Nerd Font" :size 13)
      display-line-numbers-type nil)

(use-package! lsp-pyright
  :config (setopt lsp-pyright-langserver-command "basedpyright"))

(setq org-directory "~/data/org/")
