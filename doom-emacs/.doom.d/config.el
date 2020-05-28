(setq user-full-name "Wahidyan Kresna Fridayoka"
      user-mail-address "wahidyankf@gmail.com")

(setq doom-font (font-spec :family "Dank Mono" :size 12))

(setq doom-theme 'doom-one)

(setq org-directory "~/wkf-org/")

(setq display-line-numbers-type 'relative)

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

(defun wkf-gd ()
  (interactive)
  (+lookup/definition (doom-thing-at-point-or-region))
  (evil-window-split)
  (evil-jump-backward-swap)
  (evil-window-down 1)
  (recenter)
)

(define-key evil-normal-state-map (kbd "K") 'lsp-ui-doc-glance)
(define-key evil-normal-state-map (kbd ",gd") 'wkf-gd)

(defun wkf-org-open-at-point ()
  (interactive)
  (evil-window-vsplit)
  (evil-window-right 1)
  (org-open-at-point)
  )

(evil-define-key 'normal org-mode-map (kbd "C-c C-o") 'wkf-org-open-at-point)

(define-key evil-normal-state-map (kbd ",dgg") 'deadgrep)
(define-key evil-normal-state-map (kbd ",dgr") 'deadgrep-restart)
