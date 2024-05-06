;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "Jose Maldonado"
      user-mail-address "josemald89@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
(setq doom-font (font-spec :family "CaskaydiaCove Nerd Font" :size 12 :weight 'regular)
     doom-variable-pitch-font (font-spec :family "CaskaydiaCove Nerd Font" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.


;; =========================================================================
;; Flycheck config
;; =========================================================================

(after! flycheck
  ;; Flycheck for Clang
  (setq-default flycheck-c/c++-clang-executable "/usr/bin/clang")
  (setq-default flycheck-clang-language-standard "c11")
  (setq-default flycheck-c++-clang-language-standard "c++11")
)

;; =========================================================================
;; Flyspell config
;; =========================================================================

;; Grammar
;; Flyspell 
(after! flyspell
  (setq ispell-program-name "aspell")
  (setq ispell-extra-args '("--sug-mode=ultra" "--lang=en_US"))
  (setq flyspell-lazy-idle-seconds 5))

;; =========================================================================
;; LSP Mode config
;; =========================================================================

(after! lsp-mode
  (setq lsp-log-io nil) 
  (setq lsp-print-performance t)
  ;; auto detect workspace and start lang server
  (setq lsp-auto-guess-root t) 
  ;; display all of the info returned by document/onHover on bottom, only the symbol if nil.
  (setq lsp-eldoc-render-all t)) 

;; LSP MODE
;; Clangd LSP
(after! lsp-clangd
  (setq lsp-clangd-binary-path "/usr/bin/clangd")
  (setq lsp-clients-clangd-args
        '("-j=4"
          "--background-index"
          "--clang-tidy"
          "--completion-style=detailed"
          "--header-insertion=never"
          "--header-insertion-decorators=0"))
  (set-lsp-priority! 'clangd 2))

;; LSP UI mods
(after! lsp-ui
  (setq lsp-ui-doc-max-height 25
        lsp-ui-doc-max-width 150
        lsp-ui-doc-enable t
        lsp-ui-doc-delay 0.3
	lsp-ui-doc-show-with-cursor t
	lsp-ui-doc-frame-mode t
	lsp-ui-doc-use-childframe t
        lsp-ui-sideline-show-code-actions t))


;; =========================================================================
;; Python
;; =========================================================================

;; Python3 configuration
(setq python-shell-interpreter "/usr/bin/python3")
(setq flycheck-python-pycompile-executable "/usr/bin/python3")
(setq python-shell-exec-path "/usr/bin/python3")

;; Python MS Stubs (Sync for Git)
(setq lsp-pyright-use-library-code-for-types t) 
(setq lsp-pyright-stub-path (concat (getenv "HOME") ".local/share/python-stubs"))

;; Config for ipython and jupyter
(setq +python-ipython-repl-args '("-i" "--simple-prompt" "--no-color-info"))
(setq +python-jupyter-repl-args '("--simple-prompt"))

;; DAP mode for python
(after! dap-mode
  (setq dap-python-debugger 'debugpy))

;; =========================================================================
;; Magit config
;; =========================================================================

;; Gravatar support for magit-commits
(after! magit
  (setq magit-revision-show-gravatars '("^Author:     " . "^Commit:     ")))

;; =========================================================================
;; Dash config
;; =========================================================================

(after! dash-docs
  (setq dash-docs-docsets-path "/home/yukiteru/.local/share/Zeal/Zeal/docsets"))


;; =========================================================================
;; Performance config
;; =========================================================================

;; Garbage collector
(after! gcmh
  (setq gcmh-high-cons-threshold 268435456)
  (setq gc-cons-threshold 268435456))

;; Better lsp performance
(setq read-process-output-max (* 1024 1024))


;; =========================================================================
;; GUI config
;; =========================================================================

;; Maximus 80 columns of text
(add-hook 'prog-mode-hook (lambda ()
	(setq fill-column 80)
	(setq display-fill-column-indicator t)
	(setq display-fill-column-indicator-column t)
	;; (display-fill-column-indicator-mode)
	(global-display-fill-column-indicator-mode)))

;; THEMES
;; Catpuccin
(setq doom-theme 'catppuccin)
(setq catppuccin-flavor 'mocha)

;; UI Tweaks
;; Splash screen personalized
(defun my-weebery-is-always-greater ()
  (let* ((banner '("⢸⣿⣿⣿⣿⠃⠄⢀⣴⡾⠃⠄⠄⠄⠄⠄⠈⠺⠟⠛⠛⠛⠛⠻⢿⣿⣿⣿⣿⣶⣤⡀⠄"
                   "⢸⣿⣿⣿⡟⢀⣴⣿⡿⠁⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⣸⣿⣿⣿⣿⣿⣿⣿⣷"
                   "⢸⣿⣿⠟⣴⣿⡿⡟⡼⢹⣷⢲⡶⣖⣾⣶⢄⠄⠄⠄⠄⠄⢀⣼⣿⢿⣿⣿⣿⣿⣿⣿⣿"
                   "⢸⣿⢫⣾⣿⡟⣾⡸⢠⡿⢳⡿⠍⣼⣿⢏⣿⣷⢄⡀⠄⢠⣾⢻⣿⣸⣿⣿⣿⣿⣿⣿⣿"
                   "⡿⣡⣿⣿⡟⡼⡁⠁⣰⠂⡾⠉⢨⣿⠃⣿⡿⠍⣾⣟⢤⣿⢇⣿⢇⣿⣿⢿⣿⣿⣿⣿⣿"
                   "⣱⣿⣿⡟⡐⣰⣧⡷⣿⣴⣧⣤⣼⣯⢸⡿⠁⣰⠟⢀⣼⠏⣲⠏⢸⣿⡟⣿⣿⣿⣿⣿⣿"
                   "⣿⣿⡟⠁⠄⠟⣁⠄⢡⣿⣿⣿⣿⣿⣿⣦⣼⢟⢀⡼⠃⡹⠃⡀⢸⡿⢸⣿⣿⣿⣿⣿⡟"
                   "⣿⣿⠃⠄⢀⣾⠋⠓⢰⣿⣿⣿⣿⣿⣿⠿⣿⣿⣾⣅⢔⣕⡇⡇⡼⢁⣿⣿⣿⣿⣿⣿⢣"
                   "⣿⡟⠄⠄⣾⣇⠷⣢⣿⣿⣿⣿⣿⣿⣿⣭⣀⡈⠙⢿⣿⣿⡇⡧⢁⣾⣿⣿⣿⣿⣿⢏⣾"
                   "⣿⡇⠄⣼⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠟⢻⠇⠄⠄⢿⣿⡇⢡⣾⣿⣿⣿⣿⣿⣏⣼⣿"
                   "⣿⣷⢰⣿⣿⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⢰⣧⣀⡄⢀⠘⡿⣰⣿⣿⣿⣿⣿⣿⠟⣼⣿⣿"
                   "⢹⣿⢸⣿⣿⠟⠻⢿⣿⣿⣿⣿⣿⣿⣿⣶⣭⣉⣤⣿⢈⣼⣿⣿⣿⣿⣿⣿⠏⣾⣹⣿⣿"
                   "⢸⠇⡜⣿⡟⠄⠄⠄⠈⠙⣿⣿⣿⣿⣿⣿⣿⣿⠟⣱⣻⣿⣿⣿⣿⣿⠟⠁⢳⠃⣿⣿⣿"
                   "⠄⣰⡗⠹⣿⣄⠄⠄⠄⢀⣿⣿⣿⣿⣿⣿⠟⣅⣥⣿⣿⣿⣿⠿⠋⠄⠄⣾⡌⢠⣿⡿⠃"
                   "⠜⠋⢠⣷⢻⣿⣿⣶⣾⣿⣿⣿⣿⠿⣛⣥⣾⣿⠿⠟⠛⠉⠄⠄          "))
         (longest-line (apply #'max (mapcar #'length banner))))
    (put-text-property
     (point)
     (dolist (line banner (point))
       (insert (+doom-dashboard--center
                +doom-dashboard--width
                (concat line (make-string (max 0 (- longest-line (length line))) 32)))
               "\n"))
     'face 'doom-dashboard-banner)))

;; Init new splash screen
(setq +doom-dashboard-ascii-banner-fn #'my-weebery-is-always-greater)

;; Append new message in init dashboard 
(add-hook! '+doom-dashboard-functions :append
  (insert "\n" (+doom-dashboard--center +doom-dashboard--width "Powered by Emacs!")))
	(remove-hook '+doom-dashboard-functions #'doom-dashboard-widget-shortmenu)

;; Hook for rainbow-mode
(add-hook! 'rainbow-mode-hook
  (hl-line-mode (if rainbow-mode -1 +1)))

;; Company backends
(after! company
  (setq company-backends '(company-tabnine company-capf)))

;; xterm mouse support
(setq xterm-mouse-mode 1)

;; =========================================================================
;; Keymap
;; =========================================================================

;; Pipenv 
(global-set-key (kbd "C-c P a") 'pipenv-activate)
(global-set-key (kbd "C-c P d") 'pipenv-deactivate)
