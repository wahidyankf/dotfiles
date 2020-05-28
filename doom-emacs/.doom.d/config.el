(setq user-full-name "Wahidyan Kresna Fridayoka"
      user-mail-address "wahidyankf@gmail.com")

(setq doom-font (font-spec :family "Dank Mono" :size 12))

(setq doom-theme 'doom-one)

(setq display-line-numbers-type 'relative)

(blink-cursor-mode 1)

(display-time-mode)
(display-battery-mode)

(defun wkf-evil-window-vsplit ()
  (interactive)
  (evil-window-vsplit)
  (evil-window-right 1))

(defun wkf-evil-window-split ()
  (interactive)
  (evil-window-split)
  (evil-window-down 1))

(defun wkf-windows-rebalance ()
  (interactive)
  (balance-windows)
  (recenter))

(defun wkf-find-file (filename)
  (interactive)
  (wkf-evil-window-vsplit)
  (find-file filename)
  (wkf-windows-rebalance))

(defun wkf-find-zshrc ()
  (interactive)
  (wkf-find-file "~/.zshrc"))

(defun wkf-find-emacs-init ()
  (interactive)
  (wkf-find-file "~/.doom.d/init.el"))

(defun wkf-find-emacs-package ()
  (interactive)
  (wkf-find-file "~/.doom.d/packages.el"))

(defun wkf-find-emacs-config ()
  (interactive)
  (wkf-find-file "~/.doom.d/config.org"))

(define-key evil-normal-state-map (kbd "<backspace> \\") 'wkf-evil-window-vsplit)
(define-key evil-normal-state-map (kbd "<backspace> -") 'wkf-evil-window-split)
(define-key evil-normal-state-map (kbd "<backspace> =") 'balance-windows)

(define-key evil-normal-state-map (kbd "<backspace> fn") 'make-frame-command)
(define-key evil-normal-state-map (kbd "<backspace> fo") 'other-frame)
(define-key evil-normal-state-map (kbd "<backspace> fdd") 'delete-frame)
(define-key evil-normal-state-map (kbd "<backspace> fdo") 'delete-other-frames)

(define-key evil-normal-state-map (kbd "<backspace> cz") 'wkf-find-zshrc)
(define-key evil-normal-state-map (kbd "<backspace> cei") 'wkf-find-emacs-init)
(define-key evil-normal-state-map (kbd "<backspace> cep") 'wkf-find-emacs-package)
(define-key evil-normal-state-map (kbd "<backspace> cec") 'wkf-find-emacs-config)

(define-key evil-normal-state-map (kbd ",w") 'save-buffer)
(define-key evil-normal-state-map (kbd ",q") 'delete-window)

(use-package! wakatime-mode
  :hook (after-init . global-wakatime-mode))

(use-package! lsp-mode
  :hook
  (reason-mode . lsp)
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

(use-package! dap-mode
  :after lsp-mode
  :config
  (dap-mode t)
  (dap-ui-mode t))

(use-package! reason-mode
  :mode "\\.re$"
  :hook
  (before-save . (lambda ()
                   (when (equal major-mode 'reason-mode)
                     (refmt)))))

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

(defun wkf-gdef ()
  (interactive)
  (+lookup/definition (doom-thing-at-point-or-region))
  (evil-window-split)
  (evil-jump-backward-swap)
  (evil-window-down 1)
  (balance-windows)
  (recenter)
)

(defun wkf-gdoc ()
  (interactive)
  (+lookup/documentation (doom-thing-at-point-or-region))
  (evil-window-down 1)
  (balance-windows)
  (recenter)
)

;; glance doKumentation
(define-key evil-normal-state-map (kbd "K") 'lsp-ui-doc-glance)
;; Go to Definition
(define-key evil-normal-state-map (kbd ",gd") 'wkf-gdef)
;; Go to doKumentation
(define-key evil-normal-state-map (kbd ",gk") 'wkf-gdoc)

(setq org-directory "~/wkf-org/")

(defun wkf-org-open-at-point ()
  (interactive)
  (evil-window-vsplit)
  (evil-window-right 1)
  (org-open-at-point)
  (balance-windows))

(evil-define-key 'normal org-mode-map (kbd "<backspace> o") 'wkf-org-open-at-point)

(define-key evil-normal-state-map (kbd ",dgg") 'deadgrep)
(define-key evil-normal-state-map (kbd ",dgr") 'deadgrep-restart)
