;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-
;;;

;;;; Better Defaults
(setq-default delete-by-moving-to-trash t
              window-combination-resize t
              x-stretch-cursor t)

(setq undo-limit 80000000                          ; Raise undo-limit to 80 Mb
      evil-want-fine-undo t                        ; By default while in insert all changes are one big blob, be more granular
      auto-save-default t                          ; Nobody likes to loose work
      truncate-string-ellipsis "…"                ; Unicode ellispis are nicer than "...", and also save /precious/ space
      password-cache-expiry nil                    ; I can trust my computers ... can't I?
      scroll-preserve-screen-position 'always      ; Don't have `point' jump around
      scroll-margin 2                              ; It's nice to maintain a little margin
      display-time-default-load-average nil)       ; I don't think I've ever found this useful

(global-subword-mode 1)                            ; Iterate through CamelCase words

;;;; Appearance
;; When working on a device with a battery, show the percentage.
(require 'battery)
(if (and battery-status-function
         (not (equal (alist-get ?L (funcall battery-status-function))
                     "N/A")))
    (prin1-to-string `(display-battery-mode 1))
  "")

;; Time in modeline
(display-time-mode 1)                              ; Enable time in mode-line

;; Line Numbers
(setq display-line-numbers-type `relative)

;; Splash Image
(defvar fancy-splash-image-directory
  (expand-file-name "misc/splash-images/" doom-user-dir)
  "Directory in which to look for splash image templates.")
(setq fancy-splash-image (expand-file-name "Mx-butterfly-template.svg" fancy-splash-image-directory))

;; Font
(setq doom-font (font-spec :family "JetBrainsMono Nerd Font" :size 12 :weight 'semi-bold)
      doom-variable-pitch-font (font-spec :family "JetBrainsMono Nerd Font" :size 12))

;; Theme
(setq doom-theme 'doom-vibrant)

;;; Python
;; Virtual environment
(defun shl-python-hook ()
  "Activate virtual environment and start LSP."
  (let* ((venv_path (concat (locate-dominating-file "." "pyproject.toml") ".venv/")))
    (with-eval-after-load 'pyvenv
      (pyvenv-activate venv_path))
    (with-eval-after-load 'lsp-mode
      (require 'lsp-pyright)
      (lsp))))

(use-package! python
  :config
  (setopt python-check-command "ruff")
  (add-hook 'python-mode-hook #'flymake-mode))

(use-package! pyvenv
  :hook (python-base-mode . shl-python-hook))


;; FIX: Errors with gif as unkwown error format
;; (use-package! lsp-pyright
;;   :custom (lsp-pyright-langserver-command "basedpyright"))
(require 'compile)
(add-to-list 'compilation-error-regexp-alist-alist
             '(pyright "^[[:blank:]]+\\(.+\\):\\([0-9]+\\):\\([0-9]+\\).*$" 1 2 3))
(add-to-list 'compilation-error-regexp-alist 'pyright)

;;;; AI
(use-package! gptel
  :commands (gptel gptel-send)
  :config
  (setq gptel-default-mode 'org-mode)
  (setq gptel-model 'claude-3-7-sonnet-20250219
        gptel-backend (gptel-make-anthropic "Claude"          ;Any name you want
                        :stream t                             ;Streaming responses
                        :key (getenv "ANTHROPIC_API_KEY"))))

(add-hook 'ef-themes-post-load-hook #'shl--ef-themes-mode-line)

(map! :leader
      (:prefix ("l" . "LLM")
       :desc "Send to Gptel" "l" #'gptel-send
       :desc "Gptel Menu" "m" #'gptel-menu))


(setq org-directory "~/home/data/org")
(setq org-roam-directory "~/home/data/org")

(use-package aidermacs
  :bind (("C-c p" . aidermacs-transient-menu))
  :config
                                        ; Enable minor mode for Aider files
  (aidermacs-setup-minor-mode)
  ;; Use vterm backend (default is comint)
  (setq aidermacs-backend 'vterm)
  :custom
                                        ; See the Configuration section below
  (aidermacs-auto-commits t)
  (aidermacs-use-architect-mode t)
  (aidermacs-default-model "sonnet"))
