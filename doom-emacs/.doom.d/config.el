(setq user-full-name "Wahidyan Kresna Fridayoka"
      user-mail-address "wahidyankf@gmail.com")

(add-to-list 'initial-frame-alist '(fullscreen . maximized))

(setq doom-theme 'doom-one)

(setq doom-font (font-spec :family "Dank Mono" :size 12))

(blink-cursor-mode t)
(setq display-line-numbers-type 'relative)
(setq-default indicate-empty-lines t)
(setq-default show-trailing-whitespace t)



(display-time-mode)
(display-battery-mode)

(define-key evil-normal-state-map (kbd "<backspace> f n") 'make-frame-command)
(define-key evil-normal-state-map (kbd "<backspace> f o") 'other-frame)
(define-key evil-normal-state-map (kbd "<backspace> f d d") 'delete-frame)
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

(define-key evil-normal-state-map (kbd "<backspace> \\ ") 'wkf/evil-window-vsplit)
(define-key evil-normal-state-map (kbd "<backspace> - ") 'wkf/evil-window-split)
(define-key evil-normal-state-map (kbd "<backspace> = ") 'balance-windows)

(define-key evil-normal-state-map (kbd "<backspace> t") '+vterm/toggle)
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

(defun wkf/find-emacs-init ()
  "Open my init.el in the right vertical split"
  (interactive)
  (wkf/find-file "~/.doom.d/init.el"))

(defun wkf/find-emacs-package ()
  "Open my packages.el in the right vertical split"
  (interactive)
  (wkf/find-file "~/.doom.d/packages.el"))

(defun wkf/find-emacs-config ()
  "Open my config.org in the right vertical split"
  (interactive)
  (wkf/find-file "~/.doom.d/config.org"))

(defun wkf/find-emacs-scratchpad ()
  "Open my scratch.el in the right vertical split"
  (interactive)
  (wkf/find-file "~/.doom.d/scratch.el"))

(define-key evil-normal-state-map (kbd "<backspace> c z") 'wkf/find-zshrc)
(define-key evil-normal-state-map (kbd "<backspace> c e i") 'wkf/find-emacs-init)
(define-key evil-normal-state-map (kbd "<backspace> c e p") 'wkf/find-emacs-package)
(define-key evil-normal-state-map (kbd "<backspace> c e c") 'wkf/find-emacs-config)
(define-key evil-normal-state-map (kbd "<backspace> c e s") 'wkf/find-emacs-scratchpad)

(defun wkf/save-buffer ()
  "Save current buffer with custom lsp formatting"
  (interactive)
  (when (and (equal lsp-mode t) (not (equal major-mode 'reason-mode))) (lsp-format-buffer))
  (save-buffer))

(define-key evil-normal-state-map (kbd ", w") 'wkf/save-buffer)
(define-key evil-normal-state-map (kbd ", q") 'delete-window)

;; Git Wkf Update All
(define-key evil-normal-state-map (kbd "<backspace> g w u a") (kbd "SPC o t git_wkf_update_all <return>"))

(use-package! wakatime-mode
  :hook (after-init . global-wakatime-mode))

(use-package! lsp-mode
  :hook
  (reason-mode . lsp)
  :hook
  (haskell-mode . lsp)
  :hook
  (tuareg-mode . lsp)
  :config
  (lsp-register-client
    (make-lsp-client :new-connection (lsp-stdio-connection "ocamllsp")
                  :major-modes '(tuareg-mode)
                  :notification-handlers (ht ("client/registerCapability" 'ignore))
                  :priority 1
                  :server-id 'ocaml-ls))
  :config
  (lsp-register-client
    (make-lsp-client :new-connection (lsp-stdio-connection "~/.doom.d/rls-macos/reason-language-server")
                  :major-modes '(reason-mode)
                  :notification-handlers (ht ("client/registerCapability" 'ignore))
                  :priority 1
                  :server-id 'reason-ls)
    )
  :config
  (setq lsp-lens-auto-enable t)
  :commands (lsp-mode lsp-define-stdio-client)
  )

(use-package! lsp-ui
  :hook (lsp-mode . lsp-ui-mode)
  :config
  (set-lookup-handlers! 'lsp-ui-mode
                        :definition #'lsp-ui-peek-find-definitions
                        :references #'lsp-ui-peek-find-references)
  (setq lsp-ui-doc-max-height 16
        lsp-ui-doc-max-width 50
        lsp-ui-sideline-ignore-duplicate t))

(use-package! company-lsp
  :after lsp-mode
  :config
  (set-company-backend! 'lsp-mode 'company-lsp)
  (setq company-lsp-enable-recompletion t))

(defun wkf/gdef ()
  "Open +lookup/definition in the split window below"
  (interactive)
  (+lookup/definition (doom-thing-at-point-or-region))
  (evil-window-split)
  (evil-jump-backward-swap)
  (evil-window-down 1)
  (balance-windows)
  (recenter)
)

(defun wkf/gdoc ()
  "Open +lookup/documentation in the mini buffer"
  (interactive)
  (+lookup/documentation (doom-thing-at-point-or-region))
  (evil-window-down 1)
  (balance-windows)
  (recenter)
)

;; glance doKumentation
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
  :config
  (setq lsp-haskell-process-path-hie "hie-wrapper")
  (lsp-haskell-set-formatter-floskell))

(use-package! reason-mode
  :mode "\\.re$"
  :hook
  (before-save . (lambda ()
                   (when (equal major-mode 'reason-mode)
                     (refmt)))))

(use-package! dap-mode
  :after lsp-mode
  :config
  (dap-mode t)
  (dap-ui-mode t))

(use-package! lsp-typescript
  :when (featurep! +javascript)
  :hook ((js2-mode typescript-mode) . lsp-typescript-enable))

(use-package! lsp-css
  :when (featurep! +css)
  :hook ((css-mode less-mode scss-mode) . lsp-css-enable))

(when (featurep! +sh)
  (after! sh-script
    (lsp-define-stdio-client lsp-sh
                            #'projectile-project-root
                            '("bash-language-server" "start"))
    (add-hook 'sh-mode-hook #'lsp-sh-enable)))

(add-hook 'emacs-lisp-mode-hook 'turn-on-eldoc-mode)

(setq org-directory "~/wkf-org/")

(defun wkf/org-open-at-point ()
  "Put org-mode's open at point's content to the right vertical split"
  (interactive)
  (evil-window-vsplit)
  (evil-window-right 1)
  (org-open-at-point)
  (balance-windows))

(evil-define-key 'normal org-mode-map (kbd "<backspace> o") 'wkf/org-open-at-point)

(evil-define-key 'normal org-mode-map (kbd "<backspace> p p") 'org-tree-slide-mode)
(evil-define-key 'normal org-mode-map (kbd "s->") 'org-tree-slide-move-next-tree)
(evil-define-key 'normal org-mode-map (kbd "s-<") 'org-tree-slide-move-previous-tree)

(define-key evil-normal-state-map (kbd ", d g g") 'deadgrep)
(define-key evil-normal-state-map (kbd ", d g r") 'deadgrep-restart)
