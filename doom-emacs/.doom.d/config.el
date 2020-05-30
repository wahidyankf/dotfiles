(setq user-full-name "Wahidyan Kresna Fridayoka" user-mail-address "wahidyankf@gmail.com")

(use-package! exec-path-from-shell
  :hook (after-init . exec-path-from-shell-initialize))

;; (let ((path (shell-command-to-string ". ~/.zshrc; echo -n $PATH")))
;;   (setenv "PATH" path)
;;   (setq exec-path (append (split-string-and-unquote path ":") exec-path)))

(add-to-list 'initial-frame-alist '(fullscreen . maximized))

(setq doom-theme 'doom-one)

(setq doom-font (font-spec :family "Dank Mono"
                           :size 12))

(blink-cursor-mode t)
(setq display-line-numbers-type 'relative)
(setq-default indicate-empty-lines t)
(setq-default show-trailing-whitespace t)

(display-time-mode)
(display-battery-mode)

;; Frame Make
(define-key evil-normal-state-map (kbd "<backspace> f m") 'make-frame-command)
;; Frame Z (cycle)
(define-key evil-normal-state-map (kbd "<backspace> f z") 'other-frame)
;; Frame Delete Delete (current)
(define-key evil-normal-state-map (kbd "<backspace> f d d") 'delete-frame)
;; Frame Delete Other
(define-key evil-normal-state-map (kbd "<backspace> f d o") 'delete-other-frames)

(defun wkf/evil-window-vsplit ()
  "VSplit then focus on the right pane"
  (interactive)
  (evil-window-vsplit)
  (evil-window-right 1))

(defun wkf/evil-window-split ()
  "Split then focus on the bottom pane"
  (interactive)
  (evil-window-split)
  (evil-window-down 1))

;; | (vertical)
(define-key evil-normal-state-map (kbd "<backspace> \\ ") 'wkf/evil-window-vsplit)
;; - (horizontal)
(define-key evil-normal-state-map (kbd "<backspace> - ") 'wkf/evil-window-split)
;; = (equal)
(define-key evil-normal-state-map (kbd "<backspace> = ") 'balance-windows)

;; terminal (mini)
(define-key evil-normal-state-map (kbd "<backspace> t") '+vterm/toggle)
;; Terminal (max)
(define-key evil-normal-state-map (kbd "<backspace> T") '+vterm/here)

(defun wkf/windows-rebalance ()
  "Balance window then recenter"
  (interactive)
  (balance-windows)
  (recenter))

(defun wkf/find-file (filename)
  "Search filename and open it in the right vertical split"
  (interactive)
  (wkf/evil-window-vsplit)
  (find-file filename)
  (wkf/windows-rebalance))

(defun wkf/find-zshrc ()
  "Open my zshrc in the right vertical split"
  (interactive)
  (wkf/find-file "~/.zshrc"))

(defun wkf/find-zprofile ()
  "Open my zprofile in the right vertical split"
  (interactive)
  (wkf/find-file "~/.zprofile"))

(defun wkf/find-emacs-init ()
  "Open my init.el in the right vertical split"
  (interactive)
  (wkf/find-file "~/.doom.d/init.el"))

(defun wkf/find-emacs-packages ()
  "Open my packages.el in the right vertical split"
  (interactive)
  (wkf/find-file "~/.doom.d/packages.el"))

(defun wkf/find-emacs-config-org ()
  "Open my config.org in the right vertical split"
  (interactive)
  (wkf/find-file "~/.doom.d/config.org"))

(defun wkf/find-emacs-config-el ()
  "Open my config.org in the right vertical split"
  (interactive)
  (wkf/find-file "~/.doom.d/config.el"))

(defun wkf/find-emacs-scratch ()
  "Open my scratch.el in the right vertical split"
  (interactive)
  (wkf/find-file "~/.doom.d/scratch.el"))

;; Config ZSH
(define-key evil-normal-state-map (kbd "<backspace> c z r") 'wkf/find-zshrc)
;; Config ZSH Profile
(define-key evil-normal-state-map (kbd "<backspace> c z p") 'wkf/find-zprofile)
;; Config Emacs Init.el
(define-key evil-normal-state-map (kbd "<backspace> c e i") 'wkf/find-emacs-init)
;; Config Emacs Packages.el
(define-key evil-normal-state-map (kbd "<backspace> c e p") 'wkf/find-emacs-packages)
;; Config Emacs Config.org
(define-key evil-normal-state-map (kbd "<backspace> c e c") 'wkf/find-emacs-config-org)
;; Config Emacs Config.el (compiled version)
(define-key evil-normal-state-map (kbd "<backspace> c e C") 'wkf/find-emacs-config-el)
;; Config Emacs Scratch.el
(define-key evil-normal-state-map (kbd "<backspace> c e s") 'wkf/find-emacs-scratch)

(defun wkf/save-buffer ()
  "Save current buffer with custom lsp formatting"
  (interactive)
  (cond ((bound-and-true-p lsp-mode)
         (cond ((equal major-mode 'reason-mode)
                (lsp-format-buffer))
               (t (progn (lsp-format-buffer)))))
        ((equal major-mode 'emacs-lisp-mode)
         (progn (elisp-format-buffer)))
        (t nil))
  (save-buffer))

;; Write
(define-key evil-normal-state-map (kbd ", w") 'wkf/save-buffer)

;; Quit
(define-key evil-normal-state-map (kbd ", q") 'delete-window)

;; Git Wkf Update All
(define-key evil-normal-state-map (kbd "<backspace> g w u a")
  (kbd "SPC o t git_wkf_update_all <return>"))

(use-package! wakatime-mode
  :hook (after-init . global-wakatime-mode))

(use-package! lsp-mode
  :hook (reason-mode . lsp)
  :hook (haskell-mode . lsp)
  :hook (tuareg-mode . lsp)
  :config (lsp-register-client (make-lsp-client :new-connection (lsp-stdio-connection "ocamllsp")
                                                :major-modes '(tuareg-mode)
                                                :notification-handlers (ht ("client/registerCapability"
                                                                            'ignore))
                                                :priority 1
                                                :server-id 'ocaml-ls))
  :config (lsp-register-client (make-lsp-client :new-connection (lsp-stdio-connection
                                                                 "~/.doom.d/rls-macos/reason-language-server")
                                                :major-modes '(reason-mode)
                                                :notification-handlers (ht ("client/registerCapability"
                                                                            'ignore))
                                                :priority 1
                                                :server-id 'reason-ls))
  :config (setq lsp-lens-auto-enable t)
  :commands (lsp-mode lsp-define-stdio-client))

(use-package! lsp-ui
  :hook (lsp-mode . lsp-ui-mode)
  :config (set-lookup-handlers! 'lsp-ui-mode
            :definition #'lsp-ui-peek-find-definitions
            :references #'lsp-ui-peek-find-references)
  (setq lsp-ui-doc-max-height 16 lsp-ui-doc-max-width 50 lsp-ui-sideline-ignore-duplicate t))

(use-package! company-lsp
  :after lsp-mode
  :config (set-company-backend! 'lsp-mode 'company-lsp)
  (setq company-lsp-enable-recompletion t))

(defun wkf/gdef ()
  "Open +lookup/definition in the split window below"
  (interactive)
  (+lookup/definition (doom-thing-at-point-or-region))
  (evil-window-split)
  (evil-jump-backward-swap)
  (evil-window-down 1)
  (balance-windows)
  (recenter))

(defun wkf/gdoc ()
  "Open +lookup/documentation in the mini buffer"
  (interactive)
  (+lookup/documentation (doom-thing-at-point-or-region))
  (evil-window-down 1)
  (balance-windows)
  (recenter))

;; doKumentation
(define-key evil-normal-state-map (kbd "K") 'lsp-ui-doc-glance)
;; Go to Definition
(define-key evil-normal-state-map (kbd ", g d") 'wkf/gdef)
;; Go to doKumentation
(define-key evil-normal-state-map (kbd ", g k") 'wkf/gdoc)
;; compile
(define-key evil-normal-state-map (kbd ", C") 'compile)
;; recompile
(define-key evil-normal-state-map (kbd ", c") 'recompile)

(use-package! lsp-haskell
  :after lsp-mode
  :config (setq lsp-haskell-process-path-hie "hie-wrapper")
  (lsp-haskell-set-formatter-floskell))

(use-package! reason-mode
  :mode "\\.re$"
  :hook (before-save . (lambda ()
                         (when (equal major-mode 'reason-mode)
                          (refmt)))))

(add-hook 'emacs-lisp-mode-hook 'turn-on-eldoc-mode)

(use-package! dap-mode
  :after lsp-mode
  :config (dap-mode t)
  (dap-ui-mode t))

(use-package! lsp-typescript
  :when (featurep! +javascript)
  :hook ((js2-mode typescript-mode) . lsp-typescript-enable))

(use-package! lsp-css
  :when (featurep! +css)
  :hook ((css-mode less-mode scss-mode) . lsp-css-enable))

(when (featurep! +sh)
  (after! sh-script (lsp-define-stdio-client lsp-sh #'projectile-project-root '("bash-language-server"
                                                                                "start"))
    (add-hook 'sh-mode-hook #'lsp-sh-enable)))

(setq org-directory "~/wkf-org/")

;; Org SRC Edit
(evil-define-key 'normal org-mode-map (kbd "<backspace> o s '") 'org-edit-special)

;; Org SRC Format
(evil-define-key 'normal org-mode-map (kbd "<backspace> o s f")
  (kbd "<backspace> o s ' , w : q"))

(defun wkf/org-src-elisp ()
  "Insert Org SRC for elisp"
  (interactive)
  (progn (insert "#+BEGIN_SRC emacs-lisp :results silent")
         (evil-normal-state)
         (evil-open-below 1)
         (insert "#+END_SRC")
         (evil-normal-state)
         (evil-open-above 1)))

(evil-define-key 'normal org-mode-map (kbd "<f8>sel") 'wkf/org-src-elisp)

(add-hook 'org-mode-hook 'org-display-user-inline-images)
(add-hook 'org-mode-hook 'org-display-inline-images)
(add-hook 'org-mode-hook 'org-redisplay-inline-images)

;; Org Images toggle(z)
(evil-define-key 'normal org-mode-map (kbd "<backspace> o i z") 'org-toggle-inline-images)
;; Org Images yes
(evil-define-key 'normal org-mode-map (kbd "<backspace> o i y") 'org-display-inline-images)
;; Org Images no
(evil-define-key 'normal org-mode-map (kbd "<backspace> o i n") 'org-remove-inline-images)

(defun wkf/org-open-at-point ()
  "Put org-mode's open at point's content to the right vertical split"
  (interactive)
  (evil-window-vsplit)
  (evil-window-right 1)
  (org-open-at-point)
  (balance-windows))

;; Org Open
(evil-define-key 'normal org-mode-map (kbd "<backspace> o o") 'wkf/org-open-at-point)

;; Org Presentation
(evil-define-key 'normal org-mode-map (kbd "<backspace> o p") 'org-tree-slide-mode)
;; >
(evil-define-key 'normal org-mode-map (kbd "s-.") 'org-tree-slide-move-next-tree)
;; <
(evil-define-key 'normal org-mode-map (kbd "s-,") 'org-tree-slide-move-previous-tree)

(define-key evil-normal-state-map (kbd ", d g g") 'deadgrep)
(define-key evil-normal-state-map (kbd ", d g r") 'deadgrep-restart)
