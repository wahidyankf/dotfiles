(setq user-full-name "Wahidyan Kresna Fridayoka" user-mail-address "wahidyankf@gmail.com")

;; make emacs fullscreen on startup.
(add-to-list 'initial-frame-alist '(fullscreen . maximized))

;; default: doom-one
(setq doom-theme 'doom-gruvbox)

;; the mighty dank-mono
(setq doom-font (font-spec :family "Dank Mono"
                           :size 12))

(blink-cursor-mode t)

(setq display-line-numbers-type 'relative)

(setq-default indicate-empty-lines t)

(setq-default show-trailing-whitespace t)

;; noh
(define-key evil-normal-state-map (kbd "<backspace> /") 'evil-ex-nohighlight)

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

;; | (vertical)
(define-key evil-normal-state-map (kbd ", \\") 'wkf/window-vsplit)

;; - (horizontal)
(define-key evil-normal-state-map (kbd "<backspace> -") 'wkf/window-split)

;; - (horizontal)
(define-key evil-normal-state-map (kbd ", -") 'wkf/window-split)

;; = (equal)
(define-key evil-normal-state-map (kbd "<backspace> =") 'balance-windows)

;; = (equal)
(define-key evil-normal-state-map (kbd ", =") 'balance-windows)

(defun wkf/window-close-left ()
  "Close the pane on the left"
  (interactive)
  (evil-window-left 1)
  (evil-window-delete))

(defun wkf/window-close-below ()
  "Close the pane below"
  (interactive)
  (evil-window-down 1)
  (delete-window))

(defun wkf/window-close-above ()
  "Close the pane above"
  (interactive)
  (evil-window-up 1)
  (evil-window-delete))

(defun wkf/window-close-right ()
  "Close the pane on the right"
  (interactive)
  (evil-window-right 1)
  (evil-window-delete))

;; quit h
(define-key evil-normal-state-map (kbd "<backspace> q h") 'wkf/window-close-left)

;; quit j
(define-key evil-normal-state-map (kbd "<backspace> q j") 'wkf/window-close-below)

;; quit k
(define-key evil-normal-state-map (kbd "<backspace> q k") 'wkf/window-close-above)

;; quit l
(define-key evil-normal-state-map (kbd "<backspace> q l") 'wkf/window-close-right)

;; quit current
(define-key evil-normal-state-map (kbd "<backspace> q q") 'delete-window)

(defun wkf/buffer-close-all ()
  "Kill all buffer except current."
  (interactive)
  (mapc 'kill-buffer (delq (current-buffer)
                           (remove-if-not 'buffer-file-name (buffer-list))))
  (delete-other-windows))

(defun wkf/buffer-info ()
  "Get current buffer info"
  (interactive)
  (message (format "b: %s, p: %s" (buffer-name)
                   (buffer-file-name))))

;; Get current buffer's info
(define-key evil-normal-state-map (kbd "<backspace> b i") 'wkf/buffer-info)

;; Revert/Reload buffer
(define-key evil-normal-state-map (kbd "<backspace> b b") 'revert-buffer)

;; Close all buffers except current
(define-key evil-normal-state-map (kbd "<backspace> b c a") 'wkf/buffer-close-all)

(set-popup-rule! "^\\*compilation"
  :size 0.25
  :side 'bottom)

(set-popup-rule! "^\\*doom:vterm-"
  :size 0.25)

(set-popup-rule! "^\\*format-all-errors"
  :size 0.25
  :side 'bottom)

(set-popup-rule! "^\\*Flycheck errors"
  :size 0.25
  :side 'bottom)

(set-popup-rule! "^\\*eshell"
  :size 0.25
  :side 'bottom)

(set-popup-rule! "^\\*terminal"
  :size 0.25
  :side 'bottom)

(add-hook 'org-mode-hook (lambda ()
                           (set-popup-rule! "^\\*Org Src"
                             :size .75
                             :side 'bottom)))

(defun wkf/popup-size (size)
  "Change default popup size"
  (interactive)
  (cond ((equal size "xxl")
         (set-popup-rule! "^\\*"
           :size 0.75))
        ((equal size "xl")
         (set-popup-rule! "^\\*"
           :size 0.6))
        ((equal size "l")
         (set-popup-rule! "^\\*"
           :size 0.5))
        ((equal size "m")
         (set-popup-rule! "^\\*"
           :size 0.35))
        ((equal size "s")
         (set-popup-rule! "^\\*"
           :size 0.25))))

;; change default popup size to XXL (0.6)
(define-key evil-normal-state-map (kbd "<backspace> p s 5")
  (lambda ()
    (interactive)
    (wkf/popup-size "xxl")))

;; change default popup size to XL (0.5)
(define-key evil-normal-state-map (kbd "<backspace> p s 4")
  (lambda ()
    (interactive)
    (wkf/popup-size "xl")))

;; change default popup size to L (0.35)
(define-key evil-normal-state-map (kbd "<backspace> p s 3")
  (lambda ()
    (interactive)
    (wkf/popup-size "l")))

;; change default popup size to M (0.25)
(define-key evil-normal-state-map (kbd "<backspace> p s 2")
  (lambda ()
    (interactive)
    (wkf/popup-size "m")))

;; change default popup size to S (0.25)
(define-key evil-normal-state-map (kbd "<backspace> p s 1")
  (lambda ()
    (interactive)
    (wkf/popup-size "s")))

;; popup q
(define-key evil-normal-state-map (kbd "<backspace> p q") '+popup/close-all)

(setq shell-file-name "zsh")
(setq shell-command-switch "-ic")

(defun wkf/vterm-open-vertical ()
  "Open vterm in vertical split"
  (interactive)
  (evil-normal-state)
  (wkf/window-vsplit)
  (+vterm/here (buffer-name)))

(defun wkf/vterm-open-horizontal ()
  "Open vterm in horizontal split"
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
  "Search filename and open it in the right vsp"
  (interactive)
  (wkf/window-vsplit)
  (find-file filename)
  (wkf/windows-rebalance))

(defun wkf/find-zshrc ()
  "Open my zshrc in the right vsp"
  (interactive)
  (wkf/find-file "~/.zshrc"))

(defun wkf/find-emacs-init ()
  "Open my init.el in the right vsp"
  (interactive)
  (wkf/find-file "~/.doom.d/init.el"))

(defun wkf/find-emacs-packages ()
  "Open my packages.el in the right vsp"
  (interactive)
  (wkf/find-file "~/.doom.d/packages.el"))

(defun wkf/find-emacs-config-org ()
  "Open my config.org in the right vsp"
  (interactive)
  (wkf/find-file "~/.doom.d/config.org"))

(defun wkf/find-emacs-config-el ()
  "Open my config.org in the right vsp"
  (interactive)
  (wkf/find-file "~/.doom.d/config.el"))

(defun wkf/find-emacs-scratch ()
  "Open my scratch.el in the right vsp"
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

(setq gc-cons-threshold 200000000)
(setq read-process-output-max (* 1024 1024))
(setq lsp-idle-delay 0.500)
(setq lsp-prefer-capf t)

(use-package! lsp-mode
  :hook (reason-mode . lsp)
  :hook (haskell-mode . lsp)
  :hook (tuareg-mode . lsp)
  :hook (elixir-mode . lsp)
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
  :config (lsp-register-client (make-lsp-client :new-connection (lsp-stdio-connection
                                                                 "~/.doom.d/elixir-ls/release/language_server.sh")
                                                :major-modes '(elixir-mode)
                                                :notification-handlers (ht ("client/registerCapability"
                                                                            'ignore))
                                                :priority 1
                                                :initialized-fn (lambda (workspace)
                                                                  (with-lsp-workspace workspace (let
                                                                                                    ((config
                                                                                                      `(:elixirLS
                                                                                                        (:mixEnv
                                                                                                         "dev"
                                                                                                         :dialyzerEnabled
                                                                                                         :json-false))))
                                                                                                  (lsp--set-configuration
                                                                                                   config))))
                                                :server-id 'elixir-ls))
  :config (setq lsp-lens-auto-enable t)
  :commands (lsp-mode lsp-define-stdio-client))

(use-package! lsp-ui
  :hook (lsp-mode . lsp-ui-mode)
  :config (set-lookup-handlers! 'lsp-ui-mode
            :definition #'lsp-ui-peek-find-definitions
            :references #'lsp-ui-peek-find-references)
  (setq lsp-ui-doc-max-height 16 lsp-ui-doc-max-width 50 lsp-ui-sideline-ignore-duplicate t)
  (flycheck-credo-setup))

(use-package! company-lsp
  :after lsp-mode
  :config (set-company-backend! 'lsp-mode 'company-lsp)
  (setq company-lsp-enable-recompletion t))

(defun wkf/gdef ()
  "Look up definition in the current window"
  (interactive)
  (cond ((equal major-mode 'typescript-mode)
         (evil-goto-definition))
        (t (+lookup/definition (doom-thing-at-point-or-region)))))

(defun wkf/gdef-new-frame ()
  "Open +lookup/definition in the new frame"
  (interactive)
  (make-frame-command)
  (cond ((equal major-mode 'reason-mode)
         (evil-goto-definition))
        ((equal major-mode 'typescript-mode)
         (evil-goto-definition))
        ((equal major-mode 'js2-mode)
         (+lookup/definition (doom-thing-at-point-or-region)))
        ((equal major-mode 'rjsx-mode)
         (+lookup/definition (doom-thing-at-point-or-region)))
        (t (+lookup/definition (doom-thing-at-point-or-region))))
  (recenter))

(defun wkf/gdef-split ()
  "Open +lookup/definition in the split window below"
  (interactive)
  (cond ((equal major-mode 'reason-mode)
         (progn (make-frame-command)
                (evil-goto-definition)
                (recenter)))
        ((equal major-mode 'typescript-mode)
         (progn (evil-goto-definition)
                (evil-window-split)
                (evil-jump-backward-swap)
                (evil-window-down 1)
                (balance-windows)
                (recenter)))
        ((equal major-mode 'js2-mode)
         (progn (+lookup/definition (doom-thing-at-point-or-region))
                (evil-window-split)
                (evil-jump-backward-swap)
                (evil-window-down 1)
                (balance-windows)
                (recenter)))
        ((equal major-mode 'rjsx-mode)
         (progn (+lookup/definition (doom-thing-at-point-or-region))
                (evil-window-split)
                (evil-jump-backward-swap)
                (evil-window-down 1)
                (balance-windows)))
        (t (progn (+lookup/definition (doom-thing-at-point-or-region))
                  (evil-window-split)
                  (evil-jump-backward-swap)
                  (evil-window-down 1)
                  (balance-windows)
                  (recenter)))))

(defun wkf/gdoc-split ()
  "Open +lookup/documentation in the mini buffer"
  (interactive)
  (+lookup/documentation (doom-thing-at-point-or-region))
  (evil-window-down 1)
  (balance-windows)
  (recenter))

;; doKumentation
(define-key evil-normal-state-map (kbd "K") 'lsp-ui-doc-glance)

;; Go to Definition in current pane
(define-key evil-normal-state-map (kbd "g d") 'wkf/gdef)

;; Go to Dokumentation in current pane
(define-key evil-normal-state-map (kbd "g k") '+lookup/documentation)

;; Go to Definition hsplit window
(define-key evil-normal-state-map (kbd ", g d") 'wkf/gdef-split)

;; Go to Definition in the new frame
(define-key evil-normal-state-map (kbd ", g D") 'wkf/gdef-new-frame)

;; Go to doKumentation
(define-key evil-normal-state-map (kbd ", g k") 'wkf/gdoc-split)

(defun wkf/buffer-format ()
  "Format current buffer"
  (interactive)
  (cond ((equal major-mode 'reason-mode)
         (compile (format "bsrefmt --in-place %s" (buffer-file-name))))
        ((equal major-mode 'python-mode)
         (py-yapf-buffer))
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

(defun wkf/window-close-compilation ()
  "Close compilation pane"
  (interactive)
  (delete-windows-on "*compilation*")
  (delete-windows-on "*Flycheck errors*"))

(defun wkf/window-show-compilation ()
  "Show compilation pane"
  (interactive)
  (display-buffer "*compilation*"))

(defun wkf/error-next ()
  "Go to next error"
  (interactive)
  (cond ((equal (buffer-name) "*compilation*")
         (compilation-next-error 1))
        (t (flycheck-next-error))))

(defun wkf/error-previous ()
  "Go to previous error"
  (interactive)
  (cond ((equal (buffer-name) "*compilation*")
         (compilation-previous-error 1))
        (t (flycheck-previous-error))))


;; compilation window quit
(define-key evil-normal-state-map (kbd ", c w q") 'wkf/window-close-compilation)

;; compilation window open
(define-key evil-normal-state-map (kbd ", c w e") 'wkf/window-show-compilation)

;; error next
(define-key evil-normal-state-map (kbd ", e n") 'wkf/error-next)

;; error previous
(define-key evil-normal-state-map (kbd ", e p") 'wkf/error-previous)

;; code diagnosis
(define-key evil-normal-state-map (kbd ", c d") 'flycheck-list-errors)

;; compile Custom
(define-key evil-normal-state-map (kbd ", C") 'compile)

;; compile compile (repeat)
(define-key evil-normal-state-map (kbd ", c .") 'recompile)

(add-hook 'emacs-lisp-mode-hook 'turn-on-eldoc-mode)

(use-package! reason-mode
  :mode "\\.re$"
  :hook (before-save . (lambda ()
                         (if (equal major-mode 'reason-mode) nil))))

(defun wkf/ocaml-compile-project ()
  "Compile ocaml project"
  (interactive)
  (compile (format "dune build")))

(defun wkf/ocaml-clean-project ()
  "Clean ocaml project"
  (interactive)
  (compile (format "dune clean")))

;; compile project default
(evil-define-key 'normal tuareg-mode-map (kbd ", c C") 'wkf/ocaml-compile-project)

;; clean ocaml project using dune
(evil-define-key 'normal tuareg-mode-map (kbd ", c l") 'wkf/ocaml-clean-project)

(use-package! lsp-haskell
  :after lsp-mode
  :config (setq lsp-haskell-process-path-hie "hie-wrapper")
  (lsp-haskell-set-formatter-floskell))

;; type check haskell code for exhaustiveness
(defun wkf/haskell-typecheck-file ()
  "Compile haskell project (add exhaustiveness-check)"
  (interactive)
  (let* ((output-buffer (generate-new-buffer "*Async shell command*"))
         (proc (progn (compile (format
                                "ghc -fwarn-incomplete-patterns %s -e \"return \(\)\"; echo finished"
                                (buffer-file-name)))
                      (get-buffer-process output-buffer))))))

;; run current haskell file in compile window
(defun wkf/haskell-compile-and-run-file ()
  "Run current haskell file"
  (interactive)
  (compile (format "ghc %s && %s" (buffer-file-name)
                   (file-name-sans-extension buffer-file-name))))

;; compile quick (typecheck) current file
(evil-define-key 'normal haskell-mode-map (kbd ", c q") 'wkf/haskell-typecheck-file)

;; compile and run current file
(evil-define-key 'normal haskell-mode-map (kbd ", c r") 'wkf/haskell-compile-and-run-file)

(set-popup-rule! "^\\*Anaconda"
  :size 0.25
  :side 'bottom)

(defun wkf/update-elixir-language-server ()
  "Update elixir language server's binary"
  (interactive)
  (compile
   "cd ~/.doom.d/elixir-ls && git reset --hard HEAD && git pull origin master && mix deps.get && mix elixir_ls.release"))

(use-package! alchemist
  :after elixir-mode
  :hook (elixir-mode . alchemist-mode)
  :config (set-lookup-handlers! 'elixir-mode
            :definition #'alchemist-goto-definition-at-point
            :documentation #'alchemist-help-search-at-point)
  (set-eval-handler! 'elixir-mode #'alchemist-eval-region)
  (set-repl-handler! 'elixir-mode #'alchemist-iex-project-run)
  (setq alchemist-mix-env "dev")
  (setq alchemist-hooks-compile-on-save t)
  (map! :map elixir-mode-map
        :nv "m" alchemist-mode-keymap))

(use-package! exunit)

(set-popup-rule! "^\\*alchemist"
  :size 0.2)

;; run current file
(evil-define-key 'normal elixir-mode-map (kbd ", r") 'alchemist-eval-buffer)

(defun wkf/rust-compile-file ()
  "compile current rust file"
  (interactive)
  (compile (format "rustc %s" (buffer-file-name))))

(defun wkf/rust-compile-project ()
  "compile current rust project - development"
  (interactive)
  (compile "cargo build"))

;; ---

(defun wkf/rust-build-development-project ()
  "build current rust project (development)"
  (interactive)
  (compile "cargo build"))

(defun wkf/rust-build-release-project ()
  "build current rust project (release)"
  (interactive)
  (compile "cargo build --release"))

;; ---

(defun wkf/rust-run-file ()
  "run current rust file"
  (interactive)
  (compile (format "%s" (file-name-sans-extension buffer-file-name))))

;; ---

(defun wkf/rust-compile-and-run-file ()
  "compile and run current rust file"
  (interactive)
  (compile (format "rustc %s && %s" (buffer-file-name)
                   (file-name-sans-extension buffer-file-name))))

(defun wkf/rust-compile-and-run-project ()
  "compile and run current rust project"
  (interactive)
  (compile "cargo run"))

;; ---

(defun wkf/rust-quick-check-project ()
  "check current rust project"
  (interactive)
  (compile "cargo check"))

;; compile - compile - file
(evil-define-key 'normal rustic-mode-map (kbd ", c c") 'wkf/rust-compile-file)

;; compile and run current file
(evil-define-key 'normal rustic-mode-map (kbd ", c r") 'wkf/rust-compile-and-run-file)

;; run current file
(evil-define-key 'normal rustic-mode-map (kbd ", r") 'wkf/rust-run-file)

;; compile - compile - file
(evil-define-key 'normal rustic-mode-map (kbd ", c C") 'wkf/rust-compile-project)

;; compile quick project
(evil-define-key 'normal rustic-mode-map (kbd ", c Q") 'wkf/rust-quick-check-project)

;; compile and run current project
(evil-define-key 'normal rustic-mode-map (kbd ", c R") 'wkf/rust-compile-and-run-project)

;; build - release - project
(evil-define-key 'normal rustic-mode-map (kbd ", b R") 'wkf/rust-build-release-project-release)

;; build - development - project
(evil-define-key 'normal rustic-mode-map (kbd ", b D") 'wkf/rust-build-development-project)

;; Org SRC edit special
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

(defun wkf/org-src-elisp ()
  "Insert Org SRC for elisp"
  (interactive)
  (progn (insert "#+BEGIN_SRC sh :results output")
         (evil-normal-state)
         (evil-open-below 1)
         (insert "#+END_SRC")
         (evil-normal-state)
         (evil-open-above 1)))

(evil-define-key 'normal org-mode-map (kbd "`ssh") 'wkf/org-src-elisp)

;; (setq org-image-actual-width nil)

(setq org-image-actual-width (/ (display-pixel-width) 3))

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
  "Put org-mode's open at point's content to the right vsp"
  (interactive)
  (evil-window-vsplit)
  (evil-window-right 1)
  (org-open-at-point)
  (balance-windows))

;; Org Open
(evil-define-key 'normal org-mode-map (kbd "<backspace> o o") 'wkf/org-open-at-point)

;; disable the change slide effect, it is just cheesy
(setq org-tree-slide-slide-in-effect nil)

;; disable the header
(setq org-tree-slide-header nil)

;; Org Presentation
(evil-define-key 'normal org-mode-map (kbd "<backspace> o p")
  (lambda ()
    (interactive)
    (if (bound-and-true-p org-tree-slide-mode)
        (progn (org-tree-slide-mode)
               (setq org-tree-slide-mode nil)
               (display-line-numbers-mode 'relative))
      (progn (org-tree-slide-mode)
             (setq org-tree-slide-mode t)
             (display-line-numbers-mode -1)))))

;; >
(evil-define-key 'normal org-mode-map (kbd "s-.") 'org-tree-slide-move-next-tree)

;; <
(evil-define-key 'normal org-mode-map (kbd "s-,") 'org-tree-slide-move-previous-tree)

;; disable minify in org mode (to make the presentation slide-back miss-hit harmless)
(evil-define-key 'normal org-mode-map (kbd "s-m")
  (lambda ()
    (interactive)
    (message "minify frame manually disabled in org-mode")))

;; disable new buffer in org mode (to make the presentation slide-back miss-hit harmless)
(evil-define-key 'normal org-mode-map (kbd "s-n")
  (lambda ()
    (interactive)
    (message "create new buffer manually disabled in org-mode")))

;; Git Wkf Update All
(defun wkf/git-wkf-update-all ()
  "auto-update all of my essential git repos"
  (interactive)
  (let* ((output-buffer (generate-new-buffer "*Async shell command*"))
         (proc (progn (compile (format "git_wkf_update_all"))
                      (get-buffer-process output-buffer))))))

(define-key evil-normal-state-map (kbd "<backspace> g w u a") 'wkf/git-wkf-update-all)

(use-package! wakatime-mode
  :hook (after-init . global-wakatime-mode))

;; search Search
(define-key evil-normal-state-map (kbd ", s S") 'deadgrep)

;; search restart
(define-key evil-normal-state-map (kbd ", s s") 'deadgrep-restart)
