(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(line-number-mode nil)
 '(org-agenda-files nil)
 '(package-selected-packages
   (quote
    (ob-go exec-path-from-shell company auto-complete merlin utop tuareg wakatime-mode ob-ipython ob-typescript elixir-mode ob-elixir use-package try projectile htmlize helm gruvbox-theme flycheck evil)))
 '(wakatime-cli-path "/usr/local/bin/wakatime")
 '(wakatime-python-bin nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Dank Mono" :foundry "nil" :slant normal :weight normal :height 110 :width normal)))))

;; --- our file

;; Setup package manager
(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/"))

(package-initialize)

;; Package - Use Package
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(use-package try
  :ensure t)

;; install all packages we need
(dolist (package '(evil helm projectile htmlize gruvbox-theme elixir-mode wakatime-mode ob-typescript ob-elixir ob-ipython ob-go linum-relative haskell-mode tuareg utop merlin auto-complete company exec-path-from-shell))
  (unless (package-installed-p package)
   (package-install package))
   (require package))

(require 'org)
(org-babel-load-file
 (expand-file-name "config.org" user-emacs-directory))

(exec-path-from-shell-initialize)
