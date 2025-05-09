;;; Personal Information
(setq user-full-name "Sebastian Hempel Linde"
      user-mail-address "sebastian@hempellinde.com")

;;;; Theme
(setq doom-theme 'modus-vivendi-deuteranopia
      doom-font (font-spec :family "RobotoMono Nerd Font" :size 13 :weight 'semi-bold)
      doom-variable-pitch-font (font-spec :family "RobotoMono Nerd Font" :size 13)
      display-line-numbers-type nil)

(setq display-time-day-and-date t
      display-time-24hr-format t)

(display-time-mode 1)

(require 'battery)
(if (and battery-status-function
         (not (equal (alist-get ?L (funcall battery-status-function))
                     "N/A")))
    (prin1-to-string `(display-battery-mode 1))
  "")

(setq-default delete-by-moving-to-trash t  ; Delete files to trash
              window-combination-resize t  ; Take new window space from all other windows not just current
              x-stretch-cursor t)          ; Stretch cursor to the glyph width


(setq undo-limit (* 1024 1000 80)          ; 80 Mb undo limit
      evil-want-fine-undo t                ; Be more granular about undos
      auto-save-default t                  ; Turn on autosave
      password-cache-expiry nil            ; Don't make passwords entered expire
      scroll-margin 10)                    ; Always preserve 10 lines.

(global-subword-mode 1)                    ; Iterate through CamelCase words.
(global-set-key [remap dabbrev-expand]
                #'hippie-expand)           ; Replace dabbrev with hippie

(map! "M-," #'embark-act)

(use-package! gptel
  :commands gptel gptel-menu gptel-mode gptel-send
  :config
  (gptel-make-gemini "Gemini" :key (getenv "GEMINI_API_KEY") :stream t)
  (setq
   gptel-model 'gemini-2.0-flash-thinking-exp-01-21
   gptel-backend (gptel-make-gemini "Gemini"
                   :key (getenv "GEMINI_API_KEY")
                   :stream t))
  (setq gptel-default-mode #'org-mode))

(use-package! lsp-pyright
  :config (setopt lsp-pyright-langserver-command "basedpyright"))

(setq org-directory "~/data/org/")
