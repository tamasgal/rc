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
(setq doom-font (font-spec :family "Iosevka" :weight 'light :size 13))
(setq doom-big-font (font-spec :family "Iosevka" :weight 'light :size 26))
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

(setq projectile-project-search-path '("~/Dev" "~/Dropbox" "~/Dropbox/analysis")
      projectile-enable-caching nil)
(projectile-add-known-project "/ssh:cc0:command-centre")
(projectile-add-known-project "/ssh:staticbox:Dev/snakes")
(mapc (lambda (item)
       (add-to-list 'projectile-globally-ignored-directories item))
        '("*venv" "*.snakemake"))

(setq TeX-command-default "LatexMk")
(map! :map latex-mode-map
      :localleader                  ; Use local leader
      :desc "View" "v" #'TeX-view ; Add which-key description
      :desc "Preview pane" "p" #'latex-preview-pane-mode
      :desc "Update preview" "u" #'latex-preview-pane-update
      :desc "Compile" "c" #'TeX-command-master
      :desc "Run all" "a" #'TeX-command-run-all
      :desc "Environment" "n e" #'LaTeX-environment
      :desc "Section" "n s" #'LaTeX-section
      )
(setq +latex-viewers '(skim))
(add-hook 'LaTeX-mode-hook #'mixed-pitch-mode)

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

(add-to-list 'load-path "/opt/homebrew/Cellar/mu/1.8.14/share/emacs/site-lisp/mu/mu4e")
(require 'mu4e) 
(require 'org-mu4e) 
(require 'mu4e-contrib) 
(require 'smtpmail)
(setq mu4e-headers-buffer-name "*mu4e-headers*")
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
;; this command is called to sync imap servers:
(setq mu4e-get-mail-command (concat (executable-find "mbsync") " -a"))
;; how often to call it in seconds:
(setq mu4e-update-interval 300)

;; save attachment to desktop by default
;; or another choice of yours:
(setq mu4e-attachment-dir "~/Downloads")

;; rename files when moving - needed for mbsync:
(setq mu4e-change-filenames-when-moving t)
;; gpg encryptiom & decryption:
;; this can be left alone
(require 'epa-file)
(epa-file-enable)
(setq epa-pinentry-mode 'loopback)
(auth-source-forget-all-cached)

;; don't keep message compose buffers around after sending:
(setq message-kill-buffer-on-exit t)

;; send function:
(setq send-mail-function 'sendmail-send-it
      message-send-mail-function 'sendmail-send-it)

;; send program:
;; this is exeranal. remember we installed it before.
(setq sendmail-program (executable-find "msmtp"))

;; select the right sender email from the context.
(setq message-sendmail-envelope-from 'header)

;; chose from account before sending
;; this is a custom function that works for me.
;; well I stole it somewhere long ago.
;; I suggest using it to make matters easy
;; of course adjust the email adresses and account descriptions
(defun timu/set-msmtp-account ()
  (if (message-mail-p)
      (save-excursion
        (let*
            ((from (save-restriction
                     (message-narrow-to-headers)
                     (message-fetch-field "from")))
             (account
              (cond
               ((string-match "tamas.gal@fau.de" from) "fau")
               ((string-match "tgal@km3net.de" from) "km3net"))))
          (setq message-sendmail-extra-arguments (list '"-a" account))))))

(add-hook 'message-send-mail-hook 'timu/set-msmtp-account)

;; mu4e cc & bcc
;; this is custom as well
(add-hook 'mu4e-compose-mode-hook
          (defun timu/add-cc-and-bcc ()
            "My Function to automatically add Cc & Bcc: headers.
    This is in the mu4e compose mode."
            (save-excursion (message-add-header "Cc:\n"))
            (save-excursion (message-add-header "Bcc:\n"))))

;; mu4e address completion
(add-hook 'mu4e-compose-mode-hook 'company-mode)

;; store link to message if in header view, not to header query:
(setq org-mu4e-link-query-in-headers-mode nil)
;; don't have to confirm when quitting:
(setq mu4e-confirm-quit nil)
;; number of visible headers in horizontal split view:
(setq mu4e-headers-visible-lines 20)
;; don't show threading by default:
;;(setq mu4e-headers-show-threads nil)
;; hide annoying "mu4e Retrieving mail..." msg in mini buffer:
(setq mu4e-hide-index-messages t)
;; customize the reply-quote-string:
(setq message-citation-line-format "%N @ %Y-%m-%d %H:%M :\n")
;; M-x find-function RET message-citation-line-format for docs:
(setq message-citation-line-function 'message-insert-formatted-citation-line)
;; by default do not show related emails:
(setq mu4e-headers-include-related nil)



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
;;(setq lsp-julia-default-environment "~/.julia/environments/v1.8")

;; eglot-jl
(setq eglot-jl-language-server-project "~/.julia/environments/v1.8")
;; use default eglot base
;;(after! eglot-jl
;;  (setq eglot-jl-language-server-project eglot-jl-base))

;; Org Roam
(setq org-roam-directory "~/Dropbox/org/roam")

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

;; accept completion from copilot and fallback to company
(use-package! copilot
  :hook (prog-mode . copilot-mode)
  :bind (:map copilot-completion-map
              ("<tab>" . 'copilot-accept-completion)
              ("TAB" . 'copilot-accept-completion)
              ("C-TAB" . 'copilot-accept-completion-by-word)
              ("C-<tab>" . 'copilot-accept-completion-by-word)))
