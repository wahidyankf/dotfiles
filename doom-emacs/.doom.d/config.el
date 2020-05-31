(setq user-full-name "Wahidyan Kresna Fridayoka" user-mail-address "wahidyankf@gmail.com")

(setq shell-file-name "zsh")
(setq shell-command-switch "-ic")

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

;; Frame New
(define-key evil-normal-state-map (kbd "<backspace> f n") 'make-frame-command)
;; Frame Frame (cycle)
(define-key evil-normal-state-map (kbd "<backspace> f f") 'other-frame)
;; Frame Delete Delete (current)
(define-key evil-normal-state-map (kbd "<backspace> f d d") 'delete-frame)
;; Frame Delete Other
(define-key evil-normal-state-map (kbd "<backspace> f d o") 'delete-other-frames)

(defun wkf/window-vsplit ()
  "VSplit then focus on the right pane"
  (interactive)
  (evil-window-vsplit)
  (evil-window-right 1))

(defun wkf/window-split ()
  "Split then focus on the bottom pane"
  (interactive)
  (evil-window-split)
  (evil-window-down 1))

;; | (vertical)
(define-key evil-normal-state-map (kbd "<backspace> \\") 'wkf/window-vsplit)
;; - (horizontal)
(define-key evil-normal-state-map (kbd "<backspace> -") 'wkf/window-split)
;; = (equal)
(define-key evil-normal-state-map (kbd "<backspace> =") 'balance-windows)

(defun wkf/window-close-left ()
  "Close the left pane"
  (interactive)
  (evil-window-left 1)
  (evil-window-delete))

(defun wkf/window-close-bottom ()
  "Close the bottom pane"
  (interactive)
  (evil-window-down 1)
  (delete-window))

(defun wkf/window-close-up ()
  "Close the up pane"
  (interactive)
  (evil-window-up 1)
  (evil-window-delete))

(defun wkf/window-close-right ()
  "Close the right pane"
  (interactive)
  (evil-window-right 1)
  (evil-window-delete))

;; quit h
(define-key evil-normal-state-map (kbd "<backspace> q h") 'wkf/window-close-left)

;; quit j
(define-key evil-normal-state-map (kbd "<backspace> q j") 'wkf/window-close-bottom)

;; quit k
(define-key evil-normal-state-map (kbd "<backspace> q k") 'wkf/window-close-up)

;; quit l
(define-key evil-normal-state-map (kbd "<backspace> q l") 'wkf/window-close-right)

;; Get current pane info
(define-key evil-normal-state-map (kbd "<backspace> b i")
  (lambda ()
    (interactive)
    (message (format "b: %s, p: %s" (buffer-name)
                     (buffer-file-name)))))

(define-key evil-normal-state-map (kbd ", e e") 'revert-buffer)

(defun wkf/window-close-compilation ()
  "Close compilation pane"
  (interactive)
  (delete-windows-on "*compilation*"))

(defun wkf/window-show-compilation ()
  "Close compilation pane"
  (interactive)
  (display-buffer "*compilation*"))

;; compilation Compile
(define-key evil-normal-state-map (kbd ", c C") 'compile)

;; compilation compilation
(define-key evil-normal-state-map (kbd ", c c") 'recompile)

;; compilation open
(define-key evil-normal-state-map (kbd ", c q") 'wkf/window-close-compilation)

;; compilation quit
(define-key evil-normal-state-map (kbd ", c o") 'wkf/window-show-compilation)

;; quit compilation
(define-key evil-normal-state-map (kbd ", c n") 'compilation-next-error)
;; quit compilation
(define-key evil-normal-state-map (kbd ", c p") 'compilation-previous-error)

(set-popup-rule! "^\\*compilation"
  :size 0.15)

(set-popup-rule! "^\\*Org"
  :size 0.5)

(defun wkf/pop-up-size-xl ()
  (interactive)
  (set-popup-rule! "^\\*"
    :size 0.5))

(defun wkf/pop-up-size-l ()
  (interactive)
  (set-popup-rule! "^\\*"
    :size 0.35))

(defun wkf/pop-up-size-m ()
  (interactive)
  (set-popup-rule! "^\\*"
    :size 0.25))

(defun wkf/pop-up-size-s ()
  (interactive)
  (set-popup-rule! "^\\*"
    :size 0.15))

(defun wkf/vterm-open-vertical ()
  "Open vterm in vertical split"
  (interactive)
  (evil-normal-state)
  (wkf/window-vsplit)
  (+vterm/here (buffer-name)))

(defun wkf/vterm-open-horizontal ()
  "Open vterm in vertical split"
  (interactive)
  (evil-normal-state)
  (wkf/window-split)
  (+vterm/here (buffer-name)))

(defun wkf/vterm-close-main ()
  "Close vterm pane"
  (interactive)
  (delete-windows-on "*doom:vterm-popup:main*"))

;; terminal (mini)
(define-key evil-normal-state-map (kbd "<backspace> t t") '+vterm/toggle)
;; Terminal (max)
(define-key evil-normal-state-map (kbd "<backspace> t T") '+vterm/here)
;; Terminal Vertical
(define-key evil-normal-state-map (kbd "<backspace> t v") 'wkf/vterm-open-vertical)
;; Terminal Horizontal
(define-key evil-normal-state-map (kbd "<backspace> t x") 'wkf/vterm-open-horizontal)
;; Terminal main Close
(define-key evil-normal-state-map (kbd "<backspace> t q") 'wkf/vterm-close-main)

(defun wkf/windows-rebalance ()
  "Balance window then recenter"
  (interactive)
  (balance-windows)
  (recenter))

(defun wkf/find-file (filename)
  "Search filename and open it in the right vertical split"
  (interactive)
  (wkf/window-vsplit)
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
(define-key evil-normal-state-map (kbd "<backspace> c z z") 'wkf/find-zshrc)
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

(defun wkf/buffer-format ()
  "Format current buffer"
  (interactive)
  (cond ((equal major-mode 'reason-mode)
         (compile (format "bsrefmt --in-place %s" (buffer-file-name))))
        ((bound-and-true-p lsp-mode)
         (lsp-format-buffer))
        ((equal major-mode 'emacs-lisp-mode)
         (elisp-format-buffer))
        (t nil)))

(defun wkf/buffer-save-and-format ()
  "Format current buffer"
  (interactive)
  (cond ((equal major-mode 'reason-mode) nil)
        (t (wkf/buffer-format)))
  (save-buffer))

;; Write
(define-key evil-normal-state-map (kbd ", w") 'wkf/buffer-save-and-format)

;; Format
(define-key evil-normal-state-map (kbd ", f") 'wkf/buffer-format)

;; Quit
(define-key evil-normal-state-map (kbd ", q") 'delete-window)

;; Git Wkf Update All
(defun wkf/git-wkf-update-all ()
  (interactive)
  (let* ((output-buffer (generate-new-buffer "*Async shell command*"))
         (proc (progn (compile (format "git_wkf_update_all"))
                      (get-buffer-process output-buffer))))))

(define-key evil-normal-state-map (kbd "<backspace> g w u a") 'wkf/git-wkf-update-all)

(use-package! wakatime-mode
  :hook (after-init . global-wakatime-mode))

(setq gc-cons-threshold 200000000)
(setq read-process-output-max (* 1024 1024))
(setq lsp-idle-delay 0.500)
(setq lsp-prefer-capf t)

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

(use-package! lsp-haskell
  :after lsp-mode
  :config (setq lsp-haskell-process-path-hie "hie-wrapper")
  (lsp-haskell-set-formatter-floskell))

;; Git Wkf Update All
(defun wkf/haskell-compile ()
  (interactive)
  (let* ((output-buffer (generate-new-buffer "*Async shell command*"))
         (proc (progn (compile (format
                                "ghc -fwarn-incomplete-patterns %s -e \"return \(\)\"; echo finished"
                                (buffer-file-name)))
                      (get-buffer-process output-buffer))))))

(evil-define-key 'normal haskell-mode-map (kbd ", c C") 'wkf/haskell-compile)

(use-package! reason-mode
  :mode "\\.re$"
  :hook (before-save . (lambda ()
                         (if (equal major-mode 'reason-mode) nil))))

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
(evil-define-key 'normal org-mode-map (kbd "<backspace> o s e") 'org-edit-special)

;; Org SRC Format
(evil-define-key 'normal org-mode-map (kbd "<backspace> o s f")
  (kbd "<backspace> o s e , w : q"))

(defun wkf/org-src-elisp ()
  "Insert Org SRC for elisp"
  (interactive)
  (progn (insert "#+BEGIN_SRC emacs-lisp :results silent")
         (evil-normal-state)
         (evil-open-below 1)
         (insert "#+END_SRC")
         (evil-normal-state)
         (evil-open-above 1)))

(evil-define-key 'normal org-mode-map (kbd "`sel") 'wkf/org-src-elisp)

(add-hook 'org-mode-hook 'org-display-user-inline-images)
(add-hook 'org-mode-hook 'org-display-inline-images)
(add-hook 'org-mode-hook 'org-redisplay-inline-images)

;; Org Images toggle(z)
(evil-define-key 'normal org-mode-map (kbd "<backspace> o i i") 'org-toggle-inline-images)
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

;; search Search
(define-key evil-normal-state-map (kbd ", s S") 'deadgrep)
;; search restart
(define-key evil-normal-state-map (kbd ", s s") 'deadgrep-restart)
