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
(define-key evil-normal-state-map (kbd ", /") 'evil-ex-nohighlight)

(display-time-mode)

(display-battery-mode)

;; Frame New
(define-key evil-normal-state-map (kbd ", f n") 'make-frame-command)

;; Frame Frame (cycle)
(define-key evil-normal-state-map (kbd ", f f") 'other-frame)

;; Frame Delete Delete (current)
(define-key evil-normal-state-map (kbd ", f d d") 'delete-frame)

;; Frame Delete Other
(define-key evil-normal-state-map (kbd ", f d o") 'delete-other-frames)

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
(define-key evil-normal-state-map (kbd ", \\") 'wkf/window-vsplit)

;; - (horizontal)
(define-key evil-normal-state-map (kbd ", -") 'wkf/window-split)

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
(define-key evil-normal-state-map (kbd ", q h") 'wkf/window-close-left)

;; quit j
(define-key evil-normal-state-map (kbd ", q j") 'wkf/window-close-below)

;; quit k
(define-key evil-normal-state-map (kbd ", q k") 'wkf/window-close-above)

;; quit l
(define-key evil-normal-state-map (kbd ", q l") 'wkf/window-close-right)

;; quit current
(define-key evil-normal-state-map (kbd ", q q") 'delete-window)

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
(define-key evil-normal-state-map (kbd ", b i") 'wkf/buffer-info)

;; Revert/Reload buffer
(define-key evil-normal-state-map (kbd ", b b") 'revert-buffer)

;; Close all buffers except current
(define-key evil-normal-state-map (kbd ", b c a") 'wkf/buffer-close-all)

(setq-default left-margin-width 1 right-margin-width 1)
(set-window-buffer nil (current-buffer))
(add-hook! '+popup-buffer-mode-hook (set-window-margins (selected-window) 1 1))

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

(set-popup-rule! "^\\*info"
  :size 0.45
  :side 'right)

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
(define-key evil-normal-state-map (kbd ", p s 5")
  (lambda ()
    (interactive)
    (wkf/popup-size "xxl")))

;; change default popup size to XL (0.5)
(define-key evil-normal-state-map (kbd ", p s 4")
  (lambda ()
    (interactive)
    (wkf/popup-size "xl")))

;; change default popup size to L (0.35)
(define-key evil-normal-state-map (kbd ", p s 3")
  (lambda ()
    (interactive)
    (wkf/popup-size "l")))

;; change default popup size to M (0.25)
(define-key evil-normal-state-map (kbd ", p s 2")
  (lambda ()
    (interactive)
    (wkf/popup-size "m")))

;; change default popup size to S (0.25)
(define-key evil-normal-state-map (kbd ", p s 1")
  (lambda ()
    (interactive)
    (wkf/popup-size "s")))

;; popup q
(define-key evil-normal-state-map (kbd ", p q") '+popup/close-all)

(define-key evil-normal-state-map (kbd ", , ,") '+workspace/display)
(define-key evil-normal-state-map (kbd ", , 0") '+workspace/switch-to-final)
(define-key evil-normal-state-map (kbd ", , 1") '+workspace/switch-to-0)
(define-key evil-normal-state-map (kbd ", , 2") '+workspace/switch-to-1)
(define-key evil-normal-state-map (kbd ", , 3") '+workspace/switch-to-2)
(define-key evil-normal-state-map (kbd ", , 4") '+workspace/switch-to-3)
(define-key evil-normal-state-map (kbd ", , 5") '+workspace/switch-to-4)
(define-key evil-normal-state-map (kbd ", , 6") '+workspace/switch-to-5)
(define-key evil-normal-state-map (kbd ", , 7") '+workspace/switch-to-6)
(define-key evil-normal-state-map (kbd ", , 8") '+workspace/switch-to-7)
(define-key evil-normal-state-map (kbd ", , 9") '+workspace/switch-to-8)
(define-key evil-normal-state-map (kbd ", , R") '+workspace/restore-last-session)
(define-key evil-normal-state-map (kbd ", , h") '+workspace/switch-left)
(define-key evil-normal-state-map (kbd ", , l") '+workspace/switch-right)
(define-key evil-normal-state-map (kbd ", , d") '+workspace/delete)
(define-key evil-normal-state-map (kbd ", , o") '+workspace/load)
(define-key evil-normal-state-map (kbd ", , n") '+workspace/new)
(define-key evil-normal-state-map (kbd ", , r") '+workspace/rename)
(define-key evil-normal-state-map (kbd ", , s") '+workspace/save)
(define-key evil-normal-state-map (kbd ", , x") '+workspace/kill-session)
(define-key evil-normal-state-map (kbd ", , H") '+workspace/swap-left)
(define-key evil-normal-state-map (kbd ", , L") '+workspace/swap-right)

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

(defun wkf/vterm-close-compilation ()
  "Close interactive compilation pane"
  (interactive)
  (kill-matching-buffers "^\\vterm"))

;; terminal (mini)
(define-key evil-normal-state-map (kbd ", t t") '+vterm/toggle)

;; Terminal (max)
(define-key evil-normal-state-map (kbd ", t T") '+vterm/here)

;; Terminal Vertical
(define-key evil-normal-state-map (kbd ", t v") 'wkf/vterm-open-vertical)

;; Terminal Horizontal
(define-key evil-normal-state-map (kbd ", t x") 'wkf/vterm-open-horizontal)

;; Terminal main Close
(define-key evil-normal-state-map (kbd ", t q q") 'wkf/vterm-close-main)

;; Terminal main Close
(define-key evil-normal-state-map (kbd ", t q c") 'wkf/vterm-close-compilation)

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

;; (projectile-register-project-type 'npm '("package.json")
;;                                   :compile "yarn install"
;;                                   :test "yarn test"
;;                                   :run "yarn start"
;;                                   :test-suffix ".test.js")

(setq gc-cons-threshold 200000000)
(setq read-process-output-max (* 1024 1024))
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
        ((bound-and-true-p flow-minor-mode)
         (progn     (flow-minor-jump-to-definition)
                    (flow-minor-mode)))
        (t (+lookup/definition (doom-thing-at-point-or-region)))))

(defun wkf/gdef-new-frame ()
  "Open +lookup/definition in the new frame"
  (interactive)
  (make-frame-command)
  (cond ((equal major-mode 'reason-mode)
         (evil-goto-definition))
        ((bound-and-true-p flow-minor-mode)
         (progn     (flow-minor-jump-to-definition)
                    (flow-minor-mode)))
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
        ((bound-and-true-p flow-minor-mode)
         (progn (flow-minor-jump-to-definition)
                (evil-window-split)
                (evil-jump-backward-swap)
                (evil-window-down 1)
                (flow-minor-mode)
                (balance-windows)
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

;; Go to Definition hsplit window
(define-key evil-normal-state-map (kbd "g d") 'wkf/gdef-split)
;; Go to Definition in current pane
(define-key evil-normal-state-map (kbd "<backspace> g d") 'wkf/gdef)

;; Go to doKumentation
(define-key evil-normal-state-map (kbd "g k") 'wkf/gdoc-split)
;; Go to Dokumentation in current pane
(define-key evil-normal-state-map (kbd "<backspace> g k") '+lookup/documentation)


;; Go to Definition in the new frame
(define-key evil-normal-state-map (kbd "<backspace> g D") 'wkf/gdef-new-frame)

(defun wkf/buffer-format ()
  "Format current buffer"
  (interactive)
  (cond ((equal major-mode 'reason-mode)
         (compile (format "bsrefmt --in-place %s" (buffer-file-name))))
        ((bound-and-true-p flow-minor-mode)
         (+format/buffer))
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
(define-key evil-normal-state-map (kbd ", c f") 'wkf/buffer-format)

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
(define-key evil-normal-state-map (kbd ", d l") 'flycheck-list-errors)

;; flycheck error - next
(define-key evil-normal-state-map (kbd ", d ]") 'flycheck-next-error)
;; flycheck error - next
(define-key evil-normal-state-map (kbd "] g") 'flycheck-next-error)

;; flycheck error - previous
(define-key evil-normal-state-map (kbd ", d [") 'flycheck-previous-error)
;; flycheck error - previous
(define-key evil-normal-state-map (kbd "[ g") 'flycheck-previous-error)

(defun wkf/compile-interactively (cmd)
  (interactive)
  (progn (let ((term-buffer (vterm)))
           (set-buffer term-buffer)
           (term-send-raw-string cmd)
           (evil-normal-state))))

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

(defun wkf/ocaml-compile-and-run-project-interactive ()
  "Compile and run ocaml project - interactive"
  (interactive)
  (wkf/compile-interactively "dune exec ./main.exe\n"))
(defun wkf/ocaml-compile-and-run-project-default ()
  "Compile and run ocaml project - default"
  (interactive)
  (compile "dune exec ./main.exe"))

;; compile project default
(evil-define-key 'normal tuareg-mode-map (kbd ", c C") 'wkf/ocaml-compile-project)

;; compile and run project default
(evil-define-key 'normal tuareg-mode-map (kbd ", c r R")
  'wkf/ocaml-compile-and-run-project-default)

;; compile and run project interactively
(evil-define-key 'normal tuareg-mode-map (kbd ", c r I")
  'wkf/ocaml-compile-and-run-project-interactive)

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

(defun wkf/haskell-compile-and-run-file-default ()
  "Run current haskell file - default"
  (interactive)
  (compile  (format "ghc %s && %s" (buffer-file-name)
                    (file-name-sans-extension buffer-file-name))))
(defun wkf/haskell-compile-and-run-file-interactive ()
  "Run current haskell file - interactive"
  (interactive)
  (wkf/compile-interactively (format "ghc %s && %s\n" (buffer-file-name)
                                     (file-name-sans-extension buffer-file-name))))

;; compile quick (typecheck) current file
(evil-define-key 'normal haskell-mode-map (kbd ", c q") 'wkf/haskell-typecheck-file)

;; compile and run current file
(evil-define-key 'normal haskell-mode-map (kbd ", c r r") 'wkf/haskell-compile-and-run-file-default)
(evil-define-key 'normal haskell-mode-map (kbd ", c r i") 'wkf/haskell-compile-and-run-file-interactive)

(defun wkf/ts-compile-project ()
  "compile typescript project"
  (interactive)
  (compile (format "yarn tsc")))

(defun wkf/ts-compile-and-run-file-default ()
  "compile and run current typescript file - default"
  (interactive)
  (compile (format "yarn ts-node %s" (buffer-file-name))))
(defun wkf/ts-compile-and-run-file-interactive ()
  "compile and run current typescript file - interactive"
  (interactive)
  (wkf/compile-interactively (format "yarn ts-node %s\n" (buffer-file-name))))

;; compile quick (typecheck) project
(evil-define-key 'normal typescript-mode-map (kbd ", c C") 'wkf/ts-compile-project)

;; compile and run current file
(evil-define-key 'normal typescript-mode-map (kbd ", c r r") 'wkf/ts-compile-and-run-file-default)
(evil-define-key 'normal typescript-mode-map (kbd ", c r i") 'wkf/ts-compile-and-run-file-interactive)

(use-package! flow-js2-mode
  :config (add-hook 'js2-mode-hook #'flow-js2-mode)
  (add-hook 'rjsx-mode-hook #'flow-js2-mode))

;; See flow coverage
(evil-define-key 'normal rjsx-mode-map (kbd ", c t c") 'flow-minor-coverage)
(evil-define-key 'normal js2-mode-map (kbd ", c t c") 'flow-minor-coverage)

;; See flow status
(evil-define-key 'normal rjsx-mode-map (kbd ", c q") 'flow-status)
(evil-define-key 'normal js2-mode-map (kbd ", c q") 'flow-status)

;; enable flow minor mode on rjsx mode
(evil-define-key 'normal rjsx-mode-map (kbd ", m f") 'flow-minor-mode)
;; enable flow minor mode on js2 mode
(evil-define-key 'normal js2-mode-map (kbd ", m f") 'flow-minor-mode)

(defun wkf/go-compile-project ()
  "compile current go project"
  (interactive)
  (compile (format "go build")))

(defun wkf/go-compile-file ()
  "compile current go file"
  (interactive)
  (compile (format "go build %s" (buffer-file-name))))

(defun wkf/go-compile-and-run-file-default ()
  "compile and run current go file - default"
  (interactive)
  (compile (format "go run %s" (buffer-file-name))))
(defun wkf/go-compile-and-run-file-interactive ()
  "compile and run current go file - interactive"
  (interactive)
  (let ((compile-command (format "go run %s" (buffer-file-name))))
    (wkf/compile-interactively (format "%s\n" compile-command))))

(defun wkf/go-run-file-default ()
  "run current go file - default"
  (interactive)
  (compile (file-name-sans-extension buffer-file-name)))
(defun wkf/go-run-file-interactive ()
  "run current go file - interactive"
  (interactive)
  (let ((compile-command (file-name-sans-extension buffer-file-name)))
    (wkf/compile-interactively (format "%s\n" compile-command))))

;; compile and run current file
(evil-define-key 'normal go-mode-map (kbd ", c r r") 'wkf/go-compile-and-run-file-default)
(evil-define-key 'normal go-mode-map (kbd ", c r i") 'wkf/go-compile-and-run-file-interactive)

;; run current file
(evil-define-key 'normal go-mode-map (kbd ", r r") 'wkf/go-run-file-default)
(evil-define-key 'normal go-mode-map (kbd ", r i") 'wkf/go-run-file-interactive )

;; compile current project
(evil-define-key 'normal go-mode-map (kbd ", c C") 'wkf/go-compile-project)

;; compile current file
(evil-define-key 'normal go-mode-map (kbd ", c c") 'wkf/go-compile-file)

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
(evil-define-key 'normal elixir-mode-map (kbd ", r r") 'alchemist-eval-buffer)

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
(evil-define-key 'normal rustic-mode-map (kbd ", c r r") 'wkf/rust-compile-and-run-file)

;; run current file
(evil-define-key 'normal rustic-mode-map (kbd ", r r") 'wkf/rust-run-file)

;; compile - compile - file
(evil-define-key 'normal rustic-mode-map (kbd ", c C") 'wkf/rust-compile-project)

;; compile quick project
(evil-define-key 'normal rustic-mode-map (kbd ", c Q") 'wkf/rust-quick-check-project)

;; compile and run current project
(evil-define-key 'normal rustic-mode-map (kbd ", c r R") 'wkf/rust-compile-and-run-project)

;; build - release - project
(evil-define-key 'normal rustic-mode-map (kbd ", c b r") 'wkf/rust-build-release-project-release)

;; build - development - project
(evil-define-key 'normal rustic-mode-map (kbd ", c b d") 'wkf/rust-build-development-project)

(setq org-directory "~/wkf-org/")

(add-hook 'org-mode-hook (lambda ()
                           (set-popup-rule! "^\\*Org Src"
                             :size .75
                             :side 'bottom)
                           (setq org-log-done 'time)
                           (setq org-agenda-files (directory-files-recursively "~/wkf-org/"
                                                                               "\\.org$")))
)

(defun wkf/find-org-index ()
  "Open my org index in the right vsp"
  (interactive)
  (wkf/find-file "~/wkf-org/index.org"))

;; Open index file
(define-key evil-normal-state-map (kbd ", o e i") 'wkf/find-org-index)

;; Org SRC edit special
(evil-define-key 'normal org-mode-map (kbd ", o s e") 'org-edit-special)

;; Org SRC Format
(evil-define-key 'normal org-mode-map (kbd ", o s f")
  (kbd ", o s e , w : q"))

(evil-define-key 'normal org-mode-map (kbd ", o h h") 'org-insert-heading)

(evil-define-key 'normal org-mode-map (kbd ", o h s") 'org-insert-subheading)

(defun wkf/org-src-elisp ()
  "Insert Org SRC for elisp"
  (interactive)
  (progn (insert "#+BEGIN_SRC emacs-lisp")
         (evil-normal-state)
         (evil-open-below 1)
         (insert "#+END_SRC")
         (evil-normal-state)
         (evil-open-above 1)))

(defun wkf/org-src-elisp-silent ()
  "Insert Org SRC for elisp"
  (interactive)
  (progn (insert "#+BEGIN_SRC emacs-lisp :results silent")
         (evil-normal-state)
         (evil-open-below 1)
         (insert "#+END_SRC")
         (evil-normal-state)
         (evil-open-above 1)))

(defun wkf/org-src-elisp-output ()
  "Insert Org SRC for elisp"
  (interactive)
  (progn (insert "#+BEGIN_SRC emacs-lisp :results output")
         (evil-normal-state)
         (evil-open-below 1)
         (insert "#+END_SRC")
         (evil-normal-state)
         (evil-open-above 1)))

(evil-define-key 'normal org-mode-map (kbd "` e l o s i") 'wkf/org-src-elisp-silent)
(evil-define-key 'normal org-mode-map (kbd "` e l o s o") 'wkf/org-src-elisp-output)
(evil-define-key 'normal org-mode-map (kbd "` e l o s s") 'wkf/org-src-elisp)

(defun wkf/org-src-sh ()
  "Insert Org SRC for sh"
  (interactive)
  (progn (insert "#+BEGIN_SRC sh :results output")
         (evil-normal-state)
         (evil-open-below 1)
         (insert "#+END_SRC")
         (evil-normal-state)
         (evil-open-above 1)))

(evil-define-key 'normal org-mode-map (kbd "` s h o s") 'wkf/org-src-sh)

(defun wkf/org-src-js ()
  "Insert Org SRC for javascript"
  (interactive)
  (progn (insert "#+BEGIN_SRC js :results output")
         (evil-normal-state)
         (evil-open-below 1)
         (insert "#+END_SRC")
         (evil-normal-state)
         (evil-open-above 1)))

(evil-define-key 'normal org-mode-map (kbd "` j s o s") 'wkf/org-src-js)

(defun wkf/js-comment-heading ()
  "Insert comment in JS that looks like a heading"
  (interactive)
  (progn (insert "// ---")
         (evil-normal-state)
         (evil-open-below 1)
         (insert "// ---")
         (evil-normal-state)
         (evil-open-below 1)
         (evil-normal-state)
         (evil-previous-line)
         (evil-open-above 1)
         (insert "// ")))

(evil-define-key 'normal typescript-mode-map (kbd "` j s c h") 'wkf/js-comment-heading)
(evil-define-key 'normal js2-mode-map (kbd "` j s c h") 'wkf/js-comment-heading)

(defun wkf/ocaml-comment-heading ()
  "Insert comment in ocaml that looks like a heading"
  (interactive)
  (insert "(* ---  --- *)")
  (evil-normal-state)
  (evil-backward-char 6)
  (evil-insert-state))

(evil-define-key 'normal tuareg-mode-map (kbd "` m l c h") 'wkf/ocaml-comment-heading)

;; (setq org-image-actual-width nil)

(setq org-image-actual-width (/ (display-pixel-width) 3))

(add-hook 'org-mode-hook 'org-display-user-inline-images)

(add-hook 'org-mode-hook 'org-display-inline-images)

(add-hook 'org-mode-hook 'org-redisplay-inline-images)

;; Org Images toggle(z)
(evil-define-key 'normal org-mode-map (kbd ", o i i") 'org-toggle-inline-images)

;; Org Images yes
(evil-define-key 'normal org-mode-map (kbd ", o i y") 'org-display-inline-images)

;; Org Images no
(evil-define-key 'normal org-mode-map (kbd ", o i n") 'org-remove-inline-images)

(defun wkf/org-open-at-point ()
  "Put org-mode's open at point's content to the right vsp"
  (interactive)
  (evil-window-vsplit)
  (evil-window-right 1)
  (org-open-at-point)
  (balance-windows))

;; Org Open
(evil-define-key 'normal org-mode-map (kbd ", o o") 'wkf/org-open-at-point)

;; disable the change slide effect, it is just cheesy
(setq org-tree-slide-slide-in-effect nil)

;; disable the header
(setq org-tree-slide-header nil)

(defun wkf/toggle-org-presentation ()
  "Toggle org-mode presentation's mode"
  (interactive)
  (if (bound-and-true-p org-tree-slide-mode)
      (progn
        ;; disable presentation mode
        (org-tree-slide-mode)
        (setq org-tree-slide-mode nil)
        (display-line-numbers-mode 'relative)
        (doom-modeline-mode))
    (progn
      ;; enable presentation mode
      (org-tree-slide-mode)
      (setq org-tree-slide-mode t)
      (display-line-numbers-mode -1)
      (doom-modeline-mode -1))))

;; Org Presentation
(evil-define-key 'normal org-mode-map (kbd ", o p") 'wkf/toggle-org-presentation)

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

(define-key evil-normal-state-map (kbd ", g w u a") 'wkf/git-wkf-update-all)

(use-package! wakatime-mode
  :hook (after-init . global-wakatime-mode))

;; search Search
(define-key evil-normal-state-map (kbd ", s S") 'deadgrep)

;; search restart
(define-key evil-normal-state-map (kbd ", s s") 'deadgrep-restart)
