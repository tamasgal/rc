(menu-bar-mode -1)
;; turn off toolbar
(if window-system
    (tool-bar-mode 0))

(require 'package)

(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/"))

(setq package-enable-at-startup nil)
(package-initialize)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("a85e40c7d2df4a5e993742929dfd903899b66a667547f740872797198778d7b5" "cbd8e65d2452dfaed789f79c92d230aa8bdf413601b261dbb1291fb88605110c" "3de3f36a398d2c8a4796360bfce1fa515292e9f76b655bb9a377289a6a80a132" default)))
 '(package-selected-packages
   (quote
    (julia-mode powerline helm evil markdown-mode use-package))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; bootstrap use-package
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)

;; load evil
(use-package evil
  :ensure t ;; install the evil package if not installed
  :init ;; tweak evil's configuration before loading it
  (setq evil-search-module 'evil-search)
  (setq evil-ex-complete-emacs-commands nil)
  (setq evil-vsplit-window-right t)
  (setq evil-split-window-below t)
  (setq evil-shift-round nil)
  (setq evil-want-C-u-scroll t)
  :config ;; tweak evil after loading it
  (evil-mode)

  ;; example how to map a command in normal mode (called 'normal state' in evil)
  (define-key evil-normal-state-map (kbd ", w") 'evil-window-vsplit))

(use-package helm-make
  :ensure t
  :config
  (global-set-key (kbd "C-c m") 'helm-make-projectile))

(use-package julia-mode
  :ensure t)

(use-package helm
  :ensure t
  :diminish helm-mode
  :commands helm-mode
  :config
  (helm-mode 1)
  (setq helm-buffers-fuzzy-matching t)
  (setq helm-autoresize-mode t)
  (setq helm-buffer-max-length 40)
  (define-key helm-map (kbd "S-SPC")          'helm-toggle-visible-mark)
  (define-key helm-find-files-map (kbd "C-k") 'helm-find-files-up-one-level)
  (define-key helm-read-file-map (kbd "C-k")  'helm-find-files-up-one-level))

(use-package projectile
  :ensure t
  :defer 1
  :config
  (projectile-mode)
  (setq projectile-enable-caching t)
  (setq projectile-mode-line
        '(:eval
          (format " Proj[%s]"
                  (projectile-project-name)))))

(use-package helm-projectile
  :commands (helm-projectile helm-projectile-switch-project)
  :ensure t)

(use-package magit
  :ensure t)

;; (use-package jedi
  ;; :ensure t
  ;; :config
  ;; (add-hook 'python-mode-hook 'jedi:setup)
  ;; (setq jedi:complete-on-dot t)
  ;; ;; (setq jedi:server-command '("/usr/local/bin/jediepcserver"))
  ;; (global-auto-complete-mode 1))
;; 
;; (add-hook 'python-mode-hook 'jedi:setup)
;; (setq jedi:complete-on-dot t)                 ; optional

(use-package elpy
  :ensure t
  :init
  (elpy-enable))

(use-package zenburn-theme
  :ensure t)

(use-package powerline
  :ensure t)

(load-theme 'zenburn t)
(require 'powerline)
(powerline-default-theme)
