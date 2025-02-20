;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; refresh' after modifying this file!

;; workaround for large title bar on macOS Sonoma
;; see https://github.com/doomemacs/doomemacs/issues/7532
(add-hook 'doom-after-init-hook (lambda () (tool-bar-mode 1) (tool-bar-mode 0)))

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
;; (setq doom-font (font-spec :family "Iosevka Nerd Font Mono" :weight 'light :size 13))
;; (setq doom-symbol-font (font-spec :family "Iosevka Nerd Font Mono" :weight 'light :size 13))
;; (setq doom-big-font (font-spec :family "Iosevka Nerd Font Mono" :weight 'light :size 26))
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;; (setq doom-variable-pitch-font (font-spec :family "Cantarell" :size 19))
(setq
 default-font "Iosevka Nerd Font Mono"
 ;default-font "Iosevka Term Extended"
 default-font-size 13.0
 default-nice-size 9.0
 doom-font-increment 1
 doom-font (font-spec :family default-font
                      :size default-font-size
                      :weight 'light)
 doom-variable-pitch-font (font-spec :family default-font :weight 'light)
 doom-symbol-font (font-spec :family default-font :weight 'light)
 doom-serif-font (font-spec :family default-font :weight 'light)
 )

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. These are the defaults.
;; (setq doom-theme 'doom-vibrant)
(use-package doom-themes
  :config
  ;; Global settings (defaults)
  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
        doom-themes-enable-italic t) ; if nil, italics is universally disabled
  (load-theme 'doom-one t)

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

(setq projectile-project-search-path '("~/Dev" "~/NextCloud/analysis" "~/NextCloud/org")
      projectile-enable-caching nil)
(projectile-add-known-project "~/NextCloud/PhD")
(projectile-add-known-project "/ssh:cc0:command-centre")
(projectile-add-known-project "/ssh:woodycap:/home/wecapstor3/capn/mpo1217/FibonacciFitSea")
(projectile-add-known-project "/ssh:woodycap:/home/wecapstor3/capn/mpo1217/FibonacciFitRBR")
(projectile-add-known-project "/ssh:woodycap:/home/wecapstor2/capn/mpo1217/analysis/pmt-rates-evolution")
(projectile-add-known-project "/ssh:staticbox:Dev/snakes")
(mapc (lambda (item)
       (add-to-list 'projectile-globally-ignored-directories item))
        '("*venv" "*.snakemake"))

(setq TeX-command-default "LatexMk")
(after! tex
  (map! :localleader                  ; Use local leader
        :map latex-mode-map
        ;; :desc "View" "v" #'TeX-view ; Add which-key description
        ;; :desc "Preview-pane" "p" #'latex-preview-pane-mode
        ;; :desc "Update preview" "u" #'latex-preview-pane-update
        ;; :desc "Compile" "c" #'TeX-command-master
        ;; :desc "Run all" "a" #'TeX-command-run-all
        :desc "Make" "x" #'compile
        :desc "Environment" "n e" #'LaTeX-environment
        :desc "Section" "n s" #'LaTeX-section))
(setq +latex-viewers '(skim))
(add-hook 'LaTeX-mode-hook #'mixed-pitch-mode)
(setq TeX-output-dir "build/")

;; from https://www.ianjones.us/variable-spaced-fonts
; (use-package mixed-pitch
;   :hook
;   ;; If you want it in all text modes:
;   (text-mode . mixed-pitch-mode)
;   :config
;   (setq mixed-pitch-set-heigth t)
;   (set-face-attribute 'variable-pitch nil :height 180)
;   ) ;; or org-mode


(after! org
  (map! :map org-mode-map
        :n "J" #'org-metadown
        :n "K" #'org-metaup
        :n "H" #'org-metaleft
        :n "L" #'org-metaright
        )
  (setq org-directory "~/NextCloud/org/"
        org-agenda-files '("~/NextCloud/org")
        org-archive-location (concat org-directory "archive/%s::")
        org-tags-column -80
        org-journal-dir "~/NextCloud/org/journal/"
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
       :desc "Make" "m" #'compile
       ))
(map! :leader
      :desc "Auto fill mode"
      "t a" #'auto-fill-mode)
(map! :leader
      :desc "Contents of file"
      "i c" #'insert-file)

;; Open all matches from 'SPC s p' with 'C-c C-o'
;; from https://github.com/hlissner/doom-emacs/issues/2648
(after! counsel
  (ivy-add-actions
   #'counsel-rg
   '(("a" (lambda (_path) (mapc #'counsel-git-grep-action ivy--all-candidates))
      "Open all matches"))))


;; lsp-julia
;; (setq lsp-julia-package-dir nil)
;;(setq lsp-julia-default-environment "~/.julia/environments/v1.10")

;; eglot-jl
;;(setq eglot-jl-language-server-project "~/.julia/environments/v1.9")
;; use default eglot base
(after! eglot-jl
  (setq eglot-jl-julia-command "/Users/tamasgal/.julia/juliaup/bin/julia")
  (setq eglot-jl-language-server-project eglot-jl-base))
(setq eglot-ignored-server-capabilites '(:inlayHintProvider))

;; Org Roam
(setq org-roam-directory "~/NextCloud/org/roam")

;; Magit
;; (defun magit-ignored-files ()
;;   (magit-git-items "ls-files" "--others" "--ignored" "--exclude-standard" "-z" "--directory"))

;; (defun magit-insert-ignored-files ()
;;   (-when-let (files (magit-ignored-files))
;;     (magit-insert-section (ignored)
;;       (magit-insert-heading "Ignored files:")
;;       (magit-insert-un/tracked-files-1 files nil)
;;       (insert ?\n))))

;; (after! magit
;;   (magit-add-section-hook 'magit-insert-ignored-files))

(after! elfeed
  (setq elfeed-search-filter "@1-month-ago +unread"))
(setq elfeed-goodies/entry-pane-size 0.5)
(setq elfeed-feeds (quote
                    (("http://arxiv.org/rss/cs" arxiv cs)
                     ("http://arxiv.org/rss/hep-ex" arxiv hep))))


(use-package jinx
  :ensure t
  :hook ((LaTeX-mode . jinx-mode)
         (latex-mode . jinx-mode)
         (org-mode . jinx-mode)
         (text-mode . jinx-mode)))
;; this turns of the flyspell-mode when an org document is opened
(remove-hook 'org-mode-hook #'flyspell-mode)
(remove-hook 'org-mode-hook #'flycheck-mode)
(remove-hook 'latex-mode-hook #'flyspell-mode)
(remove-hook 'latex-mode-hook #'flycheck-mode)
