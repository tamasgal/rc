;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; refresh' after modifying this file!


;; These are used for a number of things, particularly for GPG configuration,
;; some email clients, file templates and snippets.
(setq user-full-name "Tamas Gal"
      user-mail-address "tamas.gal@fau.de")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
(setq doom-font (font-spec :family "JuliaMono" :weight 'light :size 12))
(setq doom-big-font (font-spec :family "JuliaMono" :weight 'light :size 26))
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
(setq doom-variable-pitch-font (font-spec :family "Cantarell" :size 19))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. These are the defaults.
;; (setq doom-theme 'doom-vibrant)
(use-package doom-themes
  :config
  ;; Global settings (defaults)
  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
        doom-themes-enable-italic t) ; if nil, italics is universally disabled
  (load-theme 'doom-peacock t)

  ;; Enable flashing mode-line on errors
  ;; (doom-themes-visual-bell-config)

  ;; Enable custom neotree theme (all-the-icons must be installed!)
  ;; (doom-themes-neotree-config)
  ;; or for treemacs users
  (setq doom-themes-treemacs-theme "doom-colors") ; use the colorful treemacs theme
  (doom-themes-treemacs-config)

  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config))


;; Setting the GC threshold to 32MB (Doom default is 16MB) to avoid hangs
(setq gcmh-high-cons-threshold 33554432)

;; If you intend to use org, it is recommended you change this!

;; If you want to change the style of line numbers, change this to `relative' or
;; `nil' to disable it:
(setq display-line-numbers-type 'relative)

;;(setq python-shell-completion-native-enable nil)

;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', where Emacs
;;   looks when you load packages with `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c g k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c g d') to jump to their definition and see how
;; they are implemented.

;; (setq +workspaces-switch-project-function #'ignore)

(setq projectile-project-search-path '("~/Dev" "~/Dropbox")
      projectile-enable-caching nil)

(map! (:when (featurep! :lang latex)    ; local conditional
        (:map LaTeX-mode-map
          :localleader                  ; Use local leader
          :desc "View" "v" #'TeX-view ; Add which-key description
          :desc "Preview pane" "p" #'latex-preview-pane-mode
          :desc "Update preview" "u" #'latex-preview-pane-update
          ))
      )

;; from https://www.ianjones.us/variable-spaced-fonts
(use-package mixed-pitch
  :hook
  ;; If you want it in all text modes:
  (text-mode . mixed-pitch-mode)
  :config
  (setq mixed-pitch-set-heigth t)
  (set-face-attribute 'variable-pitch nil :height 180)
  ) ;; or org-mode


(after! org
  (map! :map org-mode-map
        :n "J" #'org-metadown
        :n "K" #'org-metaup
        :n "H" #'org-metaleft
        :n "L" #'org-metaright
        )
  (setq org-directory "~/Dropbox/org/"
        org-agenda-files '("~/Dropbox/org")
        org-archive-location (concat org-directory "archive/%s::")
        org-tags-column -80
        org-priority-faces '((?A :foreground "#e45649")
                             (?B :foreground "#da8548")
                             (?C :foreground "#0098dd"))
        org-bullets-bullet-list '("❖")
        org-ellipsis " ▼ "
        org-todo-keywords '((sequence "TODO(t)" "PROG(p)" "WAIT(w)" "|" "DONE(d)" "CANC(c)"))
        org-todo-keyword-faces
        '(
          ("TODO" :foreground "#ff0000" :weight normal :underline f)
          ("PROG" :foreground "#666600" :weight normal :underline f)
          ("WAIT" :foreground "#0000ff" :weight normal :underline f)
          ("DONE" :foreground "#00ff00" :weight normal :underline f)
          ("CANC" :foreground "#666666" :weight normal :underline f)
         )
        org-re-reveal-script-files '("js/reveal.js")
        org-latex-packages-alist '(("margin=2cm" "geometry" nil))
        )
  (dolist (face '((org-level-1 . 1.3)
                  (org-level-2 . 1.2)
                  (org-level-3 . 1.1)
                  (org-level-4 . 1.05)
                  (org-level-5 . 1.0)
                  (org-level-6 . 1.0)
                  (org-level-7 . 1.0)
                  (org-level-8 . 1.0)))
    ;; (set-face-attribute (car face) nil :font "Cantarell" :weight 'regular :height (cdr face))
    )
  )

(after! org-archive
  (advice-add #'org-archive-subtree-default :after #'org-save-all-org-buffers)
  (advice-add #'org-archive-subtree :after #'org-save-all-org-buffers)
  )

(setq evil-snipe-scope 'buffer)
(setq avy-all-windows t)

(setq mu4e-maildir "~/.mail"
      ;; mu4e-sent-folder "/Sent"
      ;; mu4e-drafts-folder "/Drafts"
      ;; mu4e-trash-folder "/Trash"
      ;; mu4e-spam-folder "/Junk"
      mu4e-get-mail-command "true"
      user-mail-address "tamas.gal@fau.de"
      user-full-name "Tamas Gal"
      mu4e-show-images t
      mu4e-change-filenames-when-moving t
      smtpmail-queue-mail nil  ;; start in normal mode
      smtpmail-queue-dir   "~/.mail/queue/cur"
      )

(setq company-idle-delay nil)
(map!
      :i "C-," #'+company/complete)

(advice-add #'evil-ex-search-next :after #'evil-scroll-line-to-center)

;; Custom keybindings
;; (map! :leader
;;       (:prefix-map ("a" . "arbitrary")
;;        (:prefix ("f" . "journal")
;;         :desc "New journal entry" "j" #'org-journal-new-entry
;;         :desc "Search journal entry" "s" #'org-journal-search)))
(map! :leader
      (:prefix-map ("a" . "arbitrary")
       :desc "Fill paragraph" "f" #'fill-paragraph
       ))
(map! :leader
      :desc "Auto fill mode"
      "t a" #'auto-fill-mode)


;; (setq lsp-julia-package-dir nil)
(setq lsp-julia-default-environment "~/.julia/environments/v1.4")
