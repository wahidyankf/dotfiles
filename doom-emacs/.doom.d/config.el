(exec-path-from-shell-initialize)

(setq user-full-name "Wahidyan Kresna Fridayoka" user-mail-address "wahidyankf@gmail.com")

;; make emacs fullscreen on startup.
(add-to-list 'initial-frame-alist '(fullscreen . maximized))

(defun wkf/theme-main ()
  "use main theme"
  (interactive)
  (load-theme 'doom-gruvbox t))

(defun wkf/theme-monochrome ()
  "use primary theme"
  (interactive)
  (load-theme 'monochrome t))

(which-key-add-key-based-replacements
  "<backspace> t" "theme")

;; default: doom-one
(define-key evil-normal-state-map (kbd "<backspace> t 1") 'wkf/theme-main)
(define-key evil-normal-state-map (kbd "<backspace> t 2") 'wkf/theme-monochrome)

(load "~/.doom.d/monochrome-theme.el")
(setq doom-theme 'doom-gruvbox)

;; the mighty dank-mono
(setq doom-font (font-spec :family "Dank Mono"
                           :size 12))

(setq global-auto-revert-mode t)
(setq auto-revert-mode t)

(blink-cursor-mode t)
(setq display-line-numbers-type 'relative)
(setq-default indicate-empty-lines t)
(setq-default show-trailing-whitespace t)

(global-visual-line-mode 1)

(which-key-add-key-based-replacements
  "<backspace> /" "search-nohl")
(which-key-add-key-based-replacements
  ", /" "search-nohl")

(define-key evil-normal-state-map (kbd "<backspace> /") 'evil-ex-nohighlight)
(define-key evil-normal-state-map (kbd ", /") 'evil-ex-nohighlight)

(setq treemacs-no-png-images t
      treemacs-follow-after-init t
      treemacs-width 35
      treemacs-position 'left
      treemacs-is-never-other-window t
      treemacs-silent-refresh nil
      treemacs-indentation 1
      treemacs-sorting 'alphabetic-desc
      treemacs-show-hidden-files t
      treemacs-goto-tag-strategy 'refetch-index)

;; Project Explorer
(define-key evil-normal-state-map (kbd "<backspace> e p") '+treemacs/toggle)

(display-time-mode)
(display-battery-mode)

(which-key-add-key-based-replacements
  "<backspace> f" "frame")
(which-key-add-key-based-replacements
  "<backspace> f d" "frame-delete")
(which-key-add-key-based-replacements
  "<backspace> f f" "frame-cycle")
(which-key-add-key-based-replacements
  "<backspace> f n" "frame-new")
(which-key-add-key-based-replacements
  "<backspace> f d d" "frame-delete-current")
(which-key-add-key-based-replacements
  "<backspace> f d o" "frame-delete-other")

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

(which-key-add-key-based-replacements
  ", x" "window-vsplit-and-focus")
(which-key-add-key-based-replacements
  ", v" "window-split-and-focus")
(which-key-add-key-based-replacements
  ", =" "window-balance")

;; | (vertical)
(define-key evil-normal-state-map (kbd ", v") 'wkf/window-vsplit)
;; - (horizontal)
(define-key evil-normal-state-map (kbd ", x") 'wkf/window-split)
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

(which-key-add-key-based-replacements
  ", q" "quit-window")
(which-key-add-key-based-replacements
  ", q h" "quit-window-left")
(which-key-add-key-based-replacements
  ", q j" "quit-window-below")
(which-key-add-key-based-replacements
  ", q k" "quit-window-above")
(which-key-add-key-based-replacements
  ", q l" "quit-window-right")
(which-key-add-key-based-replacements
  ", q q" "quit-window-current")
(which-key-add-key-based-replacements
  ", q c" "quit-window-compilation")

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
;; quit compile
(define-key evil-normal-state-map (kbd ", q c") 'wkf/window-close-compilation)

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

(which-key-add-key-based-replacements
  "<backspace> b" "buffer")
(which-key-add-key-based-replacements
  "<backspace> b i" "current-buffer-info")
(which-key-add-key-based-replacements
  "<backspace> b b" "buffer-revert")
(which-key-add-key-based-replacements
  "<backspace> b c" "buffer-close")
(which-key-add-key-based-replacements
  "<backspace> b c a" "buffer-close-all-except-current")
(which-key-add-key-based-replacements
  "<backspace> b i" "buffer-list-all")
(which-key-add-key-based-replacements
  "<backspace> b x" "buffer-kill")
(which-key-add-key-based-replacements
  "<backspace> b l" "buffer-list")
(which-key-add-key-based-replacements
  "<backspace> b l s" "buffer-list-current-perspective")
(which-key-add-key-based-replacements
  "<backspace> b l S" "buffer-list-all")

;; Get current buffer's info
(define-key evil-normal-state-map (kbd "<backspace> b i") 'wkf/buffer-info)
;; Revert/Reload buffer
(define-key evil-normal-state-map (kbd "<backspace> b b") 'revert-buffer)
;; Kill other buffers
(define-key evil-normal-state-map (kbd "<backspace> b c a") 'doom/kill-other-buffers)
;; Kill buffer
(define-key evil-normal-state-map (kbd "<backspace> b x") 'kill-buffer)
;; Buffer list current perspective
(define-key evil-normal-state-map (kbd "<backspace> b l s") 'persp-switch-to-buffer)
;; Buffer list all
(define-key evil-normal-state-map (kbd "<backspace> b l S") 'ibuffer)

(setq-default left-margin-width 1 right-margin-width 1)
(set-window-buffer nil (current-buffer))
(add-hook! '+popup-buffer-mode-hook (set-window-margins (selected-window) 1 1))

(setq wkf/popup-size-xs 0.10)
(setq wkf/popup-size-s 0.175)
(setq wkf/popup-size-m 0.25)
(setq wkf/popup-size-l 0.35)
(setq wkf/popup-size-xl 0.45)
(setq wkf/popup-size-xxl 0.65)
(setq wkf/popup-size-xxxl 0.75)

(set-popup-rule! "^\\*compilation"
  :size wkf/popup-size-s
  :side 'bottom)
(set-popup-rule! "^\\*doom:vterm-"
  :size wkf/popup-size-s)
(set-popup-rule! "^\\*format-all-errors"
  :size wkf/popup-size-s
  :side 'bottom)
(set-popup-rule! "^\\*Flycheck errors"
  :size wkf/popup-size-s
  :side 'bottom)
(set-popup-rule! "^\\*lsp-diagnostics"
  :size wkf/popup-size-s
  :side 'bottom)
(set-popup-rule! "^\\*eshell"
  :size wkf/popup-size-s
  :side 'bottom)
(set-popup-rule! "^\\*terminal"
  :size wkf/popup-size-s
  :side 'bottom)
(set-popup-rule! "^\\*info"
  :size wkf/popup-size-xl
  :side 'right)
(set-popup-rule! "^\\*doom:scratch"
  :size wkf/popup-size-s
  :side 'bottom)

(add-hook 'org-mode-hook (lambda ()
                           (set-popup-rule! "^\\*Org Src"
                             :size wkf/popup-size-xxxl
                             :side 'bottom)))

(defun wkf/popup-size (size)
  "Change default popup size"
  (interactive)
  (set-popup-rule! "^\\*"
    :size size))

(which-key-add-key-based-replacements "<backspace> p" "popup")
(which-key-add-key-based-replacements "<backspace> p s" "popup-size")
(which-key-add-key-based-replacements "<backspace> p s s" "popup-size-s")
(which-key-add-key-based-replacements "<backspace> p s m" "popup-size-m")
(which-key-add-key-based-replacements "<backspace> p s l" "popup-size-l")
(which-key-add-key-based-replacements "<backspace> p s x" "popup-size-xl")
(which-key-add-key-based-replacements "<backspace> p s X" "popup-size-xxl")

(define-key evil-normal-state-map (kbd "<backspace> p s s")
  (lambda ()
    (interactive)
    (wkf/popup-size wkf/popup-size-s)))
(define-key evil-normal-state-map (kbd "<backspace> p s m")
  (lambda ()
    (interactive)
    (wkf/popup-size wkf/popup-size-m)))
(define-key evil-normal-state-map (kbd "<backspace> p s l")
  (lambda ()
    (interactive)
    (wkf/popup-size wkf/popup-size-l)))
(define-key evil-normal-state-map (kbd "<backspace> p s x")
  (lambda ()
    (interactive)
    (wkf/popup-size wkf/popup-size-xl)))
(define-key evil-normal-state-map (kbd "<backspace> p s X")
  (lambda ()
    (interactive)
    (wkf/popup-size wkf/popup-size-xxl)))
;; popup q
(define-key evil-normal-state-map (kbd "<backspace> p q") '+popup/close-all)

(which-key-add-key-based-replacements
  ", ," "workspace")

(define-key evil-normal-state-map (kbd "<backspace> <backspace>") '+workspace/display)
(define-key evil-normal-state-map (kbd "<backspace> 0") '+workspace/switch-to-final)
(define-key evil-normal-state-map (kbd "<backspace> 1") '+workspace/switch-to-0)
(define-key evil-normal-state-map (kbd "<backspace> 2") '+workspace/switch-to-1)
(define-key evil-normal-state-map (kbd "<backspace> 3") '+workspace/switch-to-2)
(define-key evil-normal-state-map (kbd "<backspace> 4") '+workspace/switch-to-3)
(define-key evil-normal-state-map (kbd "<backspace> 5") '+workspace/switch-to-4)
(define-key evil-normal-state-map (kbd "<backspace> 6") '+workspace/switch-to-5)
(define-key evil-normal-state-map (kbd "<backspace> 7") '+workspace/switch-to-6)
(define-key evil-normal-state-map (kbd "<backspace> 8") '+workspace/switch-to-7)
(define-key evil-normal-state-map (kbd "<backspace> 9") '+workspace/switch-to-8)
(define-key evil-normal-state-map (kbd "<backspace> R") '+workspace/restore-last-session)
(define-key evil-normal-state-map (kbd "<backspace> h") '+workspace/switch-left)
(define-key evil-normal-state-map (kbd "<backspace> l") '+workspace/switch-right)
(define-key evil-normal-state-map (kbd "<backspace> H") '+workspace/swap-left)
(define-key evil-normal-state-map (kbd "<backspace> L") '+workspace/swap-right)
(define-key evil-normal-state-map (kbd "<backspace> r") '+workspace/rename)

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
(define-key evil-normal-state-map (kbd ", , H") '+workspace/swap-left)
(define-key evil-normal-state-map (kbd ", , L") '+workspace/swap-right)
(define-key evil-normal-state-map (kbd ", , r") '+workspace/rename)

(define-key evil-normal-state-map (kbd ", , d") '+workspace/delete)
(define-key evil-normal-state-map (kbd ", , o") '+workspace/load)
(define-key evil-normal-state-map (kbd ", , n") '+workspace/new)
(define-key evil-normal-state-map (kbd ", , s") '+workspace/save)
(define-key evil-normal-state-map (kbd ", , X") '+workspace/kill-session)

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

(which-key-add-key-based-replacements
  ", t" "terminal")
(which-key-add-key-based-replacements
  ", t t" "terminal-popup")
(which-key-add-key-based-replacements
  ", t T" "terminal-here")
(which-key-add-key-based-replacements
  ", t v" "terminal-vsplit")
(which-key-add-key-based-replacements
  ", t x" "terminal-split")
(which-key-add-key-based-replacements
  ", t q" "terminal-quit")
(which-key-add-key-based-replacements
  ", t q q" "terminal-quit-current")
(which-key-add-key-based-replacements
  ", t q c" "terminal-quit-compilation")

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

(setq wkf/file-zshrc "~/.zshrc")
(setq wkf/file-doom-init-el "~/.doom.d/init.el")
(setq wkf/file-doom-packages-el "~/.doom.d/packages.el")
(setq wkf/file-doom-config-el "~/.doom.d/config.el")
(setq wkf/file-doom-config-org "~/.doom.d/config.org")
(setq wkf/file-doom-scratch-el "~/.doom.d/scratch.el")

(defun wkf/windows-rebalance ()
  "Recenter windows"
  (interactive)
  (recenter))

(defun wkf/find-file-vsplit (filename)
  "Search filename and open it in the right vsp"
  (interactive)
  (wkf/window-vsplit)
  (find-file filename)
  (wkf/windows-rebalance))

(defun wkf/find-file-split (filename)
  "Search filename and open it in the right vsp"
  (interactive)
  (wkf/window-split)
  (find-file filename)
  (wkf/windows-rebalance))

(defun wkf/find-config (open-in filename)
  "Open my zshrc in current buffer"
  (interactive)
  (cond ((equal open-in "v")
         (wkf/find-file-vsplit filename))
        ((equal open-in "x")
         (wkf/find-file-split filename))
        ((equal open-in "e")
         (find-file filename))))

(which-key-add-key-based-replacements "<backspace> c" "config-open")
(which-key-add-key-based-replacements "<backspace> c z" "config-open-zshrc")
(which-key-add-key-based-replacements "<backspace> c z e" "config-open-zshrc-current-buffer")
(which-key-add-key-based-replacements "<backspace> c z v" "config-open-zshrc-vsplit")
(which-key-add-key-based-replacements "<backspace> c z x" "config-open-zshrc-split")
(which-key-add-key-based-replacements "<backspace> c e" "config-open-emacs")
(which-key-add-key-based-replacements "<backspace> c e i" "config-open-emacs-init")
(which-key-add-key-based-replacements "<backspace> c e i e" "config-open-emacs-init-current-buffer")
(which-key-add-key-based-replacements "<backspace> c e i v" "config-open-emacs-init-vsplit")
(which-key-add-key-based-replacements "<backspace> c e i x" "config-open-emacs-init-split")
(which-key-add-key-based-replacements "<backspace> c e p" "config-open-emacs-packages")
(which-key-add-key-based-replacements "<backspace> c e p e" "config-open-emacs-packages-current-buffer")
(which-key-add-key-based-replacements "<backspace> c e p v" "config-open-emacs-packages-vsplit")
(which-key-add-key-based-replacements "<backspace> c e p x" "config-open-emacs-packages-split")
(which-key-add-key-based-replacements "<backspace> c e c" "config-open-emacs-config-org")
(which-key-add-key-based-replacements "<backspace> c e c e" "config-open-emacs-config-org-current-buffer")
(which-key-add-key-based-replacements "<backspace> c e c v" "config-open-emacs-config-org-vsplit")
(which-key-add-key-based-replacements "<backspace> c e c x" "config-open-emacs-config-org-split")
(which-key-add-key-based-replacements "<backspace> c e C" "config-open-emacs-config-el")
(which-key-add-key-based-replacements "<backspace> c e C e" "config-open-emacs-config-el-current-buffer")
(which-key-add-key-based-replacements "<backspace> c e C v" "config-open-emacs-config-el-vsplit")
(which-key-add-key-based-replacements "<backspace> c e C x" "config-open-emacs-config-el-split")
(which-key-add-key-based-replacements "<backspace> c e s" "config-open-emacs-scratch")
(which-key-add-key-based-replacements "<backspace> c e s e" "config-open-emacs-scratch-current-buffer")
(which-key-add-key-based-replacements "<backspace> c e s v" "config-open-emacs-scratch-vsplit")
(which-key-add-key-based-replacements "<backspace> c e s x" "config-open-emacs-scratch-split")

;; Config ZSH
(define-key evil-normal-state-map (kbd "<backspace> c z e")
  (lambda ()
    (interactive)
    (wkf/find-config "e" wkf/file-zshrc)))
(define-key evil-normal-state-map (kbd "<backspace> c z v")
  (lambda ()
    (interactive)
    (wkf/find-config "v" wkf/file-zshrc)))
(define-key evil-normal-state-map (kbd "<backspace> c z x")
  (lambda ()
    (interactive)
    (wkf/find-config "x" wkf/file-zshrc)))
;; Config Emacs Init.el
(define-key evil-normal-state-map (kbd "<backspace> c e i e")
  (lambda ()
    (interactive)
    (wkf/find-config "e" wkf/file-doom-init-el)))
(define-key evil-normal-state-map (kbd "<backspace> c e i v")
  (lambda ()
    (interactive)
    (wkf/find-config "v" wkf/file-doom-init-el)))
(define-key evil-normal-state-map (kbd "<backspace> c e i x")
  (lambda ()
    (interactive)
    (wkf/find-config "x" wkf/file-doom-init-el)))
;; Config Emacs Packages.el
(define-key evil-normal-state-map (kbd "<backspace> c e p e")
  (lambda ()
    (interactive)
    (wkf/find-config "e" wkf/file-doom-packages-el)))
(define-key evil-normal-state-map (kbd "<backspace> c e p v")
  (lambda ()
    (interactive)
    (wkf/find-config "v" wkf/file-doom-packages-el)))
(define-key evil-normal-state-map (kbd "<backspace> c e p x")
  (lambda ()
    (interactive)
    (wkf/find-config "x" wkf/file-doom-packages-el)))
;; Config Emacs Config.org
(define-key evil-normal-state-map (kbd "<backspace> c e c e")
  (lambda ()
    (interactive)
    (wkf/find-config "e" wkf/file-doom-config-org)))
(define-key evil-normal-state-map (kbd "<backspace> c e c v")
  (lambda ()
    (interactive)
    (wkf/find-config "v" wkf/file-doom-config-org)))
(define-key evil-normal-state-map (kbd "<backspace> c e c x")
  (lambda ()
    (interactive)
    (wkf/find-config "x" wkf/file-doom-config-org)))
;; Config Emacs Config.el (compiled version)
(define-key evil-normal-state-map (kbd "<backspace> c e C e")
  (lambda ()
    (interactive)
    (wkf/find-config "e" wkf/file-doom-config-el)))
(define-key evil-normal-state-map (kbd "<backspace> c e C v")
  (lambda ()
    (interactive)
    (wkf/find-config "v" wkf/file-doom-config-el)))
(define-key evil-normal-state-map (kbd "<backspace> c e C x")
  (lambda ()
    (interactive)
    (wkf/find-config "x" wkf/file-doom-config-el)))
;; Config Emacs Scratch.el
(define-key evil-normal-state-map (kbd "<backspace> c e s e")
  (lambda ()
    (interactive)
    (wkf/find-config "e" wkf/file-doom-scratch-el)))
(define-key evil-normal-state-map (kbd "<backspace> c e s v")
  (lambda ()
    (interactive)
    (wkf/find-config "v" wkf/file-doom-scratch-el)))
(define-key evil-normal-state-map (kbd "<backspace> c e s x")
  (lambda ()
    (interactive)
    (wkf/find-config "x" wkf/file-doom-scratch-el)))

(define-key evil-normal-state-map (kbd "<SPC> c <SPC>") 'comment-line)
(define-key evil-visual-state-map (kbd "<SPC> c <SPC>") 'comment-line)

(which-key-add-key-based-replacements
  ", e" "eval-elisp")

;; Eval last sexp
(define-key evil-normal-state-map (kbd ", e e") 'eval-last-sexp)
;; Eval buffer
(define-key evil-normal-state-map (kbd ", e b") 'eval-buffer)
;; Emacs Lisp Mode
(define-key evil-normal-state-map (kbd ", e m") 'emacs-lisp-mode)

(setq gc-cons-threshold 200000000)
(setq read-process-output-max (* 1024 1024))
(setq lsp-prefer-capf t)

(use-package! lsp-mode
  :hook (reason-mode . lsp)
  :hook (haskell-mode . lsp)
  :hook (tuareg-mode . lsp)
  :hook (elixir-mode . lsp)
  :init (add-to-list 'exec-path "~/.doom.d/elixir-ls")
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
  (setq lsp-ui-doc-max-height 25 lsp-ui-doc-max-width 100 lsp-ui-sideline-ignore-duplicate t)
  ;; hack for lsp-ui issue: https://github.com/emacs-lsp/lsp-ui/issues/414
  ;; (add-to-list 'lsp-ui-doc-frame-parameters '(no-accept-focus . t))
  (lsp-ui-flycheck-enable t))

(which-key-add-key-based-replacements ", p" "popup")
(which-key-add-key-based-replacements ", p p" "popup-focus-frame")
(which-key-add-key-based-replacements ", p q" "popup-unfocus-frame")

;; focus unfocus frame
(define-key evil-normal-state-map (kbd ", p p") 'lsp-ui-doc-focus-frame)
(define-key evil-normal-state-map (kbd ", p q") 'lsp-ui-doc-unfocus-frame)

(use-package! company-lsp
  :after lsp-mode
  :config (set-company-backend! 'lsp-mode 'company-lsp)
  (setq company-lsp-enable-recompletion t))

(defun wkf/gdef ()
  "Look up definition in the current window"
  (interactive)
  (cond ((equal major-mode 'reason-mode)
         (progn (evil-goto-definition)
                (recenter)))
        ((equal major-mode 'typescript-mode)
         (evil-goto-definition))
        (t (+lookup/definition (doom-thing-at-point-or-region)))))

(defun wkf/gdef-new-frame ()
  "Open +lookup/definition in the new frame"
  (interactive)
  (make-frame-command)
  (cond ((equal major-mode 'reason-mode)
         (progn (make-frame-command)
                (evil-goto-definition)
                (recenter)))
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
  (cond
   ((equal major-mode 'reason-mode)
    (progn (evil-goto-definition)
           (evil-window-split)
           (evil-jump-backward-swap)
           (evil-window-down 1)
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

(which-key-add-key-based-replacements ", g" "goto")
(which-key-add-key-based-replacements ", g d" "goto-def-split")
(which-key-add-key-based-replacements ", g k" "goto-doc-split")
(which-key-add-key-based-replacements ", g D" "goto-def-new-frame")
(which-key-add-key-based-replacements ", d r" "restart-lsp")

;; Go to Definition in current pane
(define-key evil-normal-state-map (kbd "g d") 'wkf/gdef)
;; Go to Definition hsplit window
(define-key evil-normal-state-map (kbd ", g d") 'wkf/gdef-split)
;; Go to Dokumentation in current pane
(define-key evil-normal-state-map (kbd "g k") '+lookup/documentation)
;; Go to doKumentation
(define-key evil-normal-state-map (kbd ", g k") 'wkf/gdoc-split)
;; Go to Definition in the new frame
(define-key evil-normal-state-map (kbd ", g D") 'wkf/gdef-new-frame)
;; doKumentation
(define-key evil-normal-state-map (kbd "K") 'lsp-ui-doc-glance)
;; doKumentation
(define-key evil-normal-state-map (kbd ", d r") 'lsp-restart-workspace)

(defun wkf/buffer-format ()
  "Format current buffer"
  (interactive)
  (cond ((equal major-mode 'python-mode)
         (py-yapf-buffer))
        ((bound-and-true-p lsp-mode)
         (lsp-format-buffer))
        ((equal major-mode 'emacs-lisp-mode)
         (elisp-format-buffer))
        (t nil)))

(defun wkf/buffer-save-and-format ()
  "Format current buffer"
  (interactive)
  (cond ((equal major-mode 'reason-mode)
         (wkf/buffer-format))
        (t (wkf/buffer-format)))
  (save-buffer))

(which-key-add-key-based-replacements ", w" "buffer-save-and-format")
(which-key-add-key-based-replacements ", f" "format-current-buffer")

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

(which-key-add-key-based-replacements ", c w" "compilation-window")
(which-key-add-key-based-replacements ", d c" "diagnosis-compilation")
(which-key-add-key-based-replacements ", d c n" "diagnosis-compilation-next")
(which-key-add-key-based-replacements ", d c p" "diagnosis-compilation-previous")

;; compilation window open
(define-key evil-normal-state-map (kbd ", c w") 'wkf/window-show-compilation)
;; error next
(define-key evil-normal-state-map (kbd ", d c n") 'wkf/error-next)
;; error previous
(define-key evil-normal-state-map (kbd ", d c p") 'wkf/error-previous)

(which-key-add-key-based-replacements
  ", d" "diagnosis")

;; code diagnosis workspace
(define-key evil-normal-state-map (kbd ", d l") 'lsp-ui-flycheck-list)
;; code diagnosis local
(define-key evil-normal-state-map (kbd ", d L") 'flycheck-list-errors)
;; flycheck error - next
(define-key evil-normal-state-map (kbd ", d ]") 'flycheck-next-error)
;; flycheck error - next
(define-key evil-normal-state-map (kbd "] g") 'flycheck-next-error)
;; flycheck error - previous
(define-key evil-normal-state-map (kbd ", d [") 'flycheck-previous-error)
;; flycheck error - previous
(define-key evil-normal-state-map (kbd "[ g") 'flycheck-previous-error)

(which-key-add-key-based-replacements
  ", m" "mode")
(which-key-add-key-based-replacements
  ", c t" "compile-file-test")
(which-key-add-key-based-replacements
  ", c t c" "compile-file-test-coverage")
(which-key-add-key-based-replacements
  ", c" "compile-file")
(which-key-add-key-based-replacements
  ", c c" "compile-file-default")
(which-key-add-key-based-replacements
  ", c r" "compile-file-and-run")
(which-key-add-key-based-replacements
  ", c r r" "compile-file-and-run-default")
(which-key-add-key-based-replacements
  ", c r i" "compile-file-and-run-interactive")
(which-key-add-key-based-replacements
  ", c q" "compile-file-and-run")
(which-key-add-key-based-replacements
  ", c b" "compile-file-build")
(which-key-add-key-based-replacements
  ", c b d" "compile-file-build-dev")
(which-key-add-key-based-replacements
  ", c b r" "compile-file-build-release")
(which-key-add-key-based-replacements
  ", r" "run-file")
(which-key-add-key-based-replacements
  ", r r" "run-file-default")
(which-key-add-key-based-replacements
  ", r i" "run-file-interactively")
(which-key-add-key-based-replacements
  ", C" "compile-project")
(which-key-add-key-based-replacements
  ", C c" "compile-project-default")
(which-key-add-key-based-replacements
  ", C r" "compile-project-and-run")
(which-key-add-key-based-replacements
  ", C r r" "compile-project-and-run-default")
(which-key-add-key-based-replacements
  ", C r i" "compile-project-and-run-interactive")
(which-key-add-key-based-replacements
  ", C q" "compile-project-quick")
(which-key-add-key-based-replacements
  ", C b" "compile-project-build")
(which-key-add-key-based-replacements
  ", C b d" "compile-project-build-dev")
(which-key-add-key-based-replacements
  ", C b r" "compile-project-build-release")
(which-key-add-key-based-replacements
  ", R" "run-project")
(which-key-add-key-based-replacements
  ", R r" "run-project-default")
(which-key-add-key-based-replacements
  ", R i" "run-project-interactively")

(defun wkf/compile-interactively (cmd)
  (interactive)
  (progn (let ((term-buffer (vterm)))
           (set-buffer term-buffer)
           (term-send-raw-string cmd)
           (evil-normal-state))))

(which-key-add-key-based-replacements
  ", c ." "recompile-using-last-command")

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

(defun wkf/ocaml-compile-and-run-file-interactive ()
  "Compile and run ocaml file - interactive"
  (interactive)
  (wkf/compile-interactively (format "dune exec ./%s.exe\n" (file-name-sans-extension
                                                            (buffer-name)))))

(defun wkf/ocaml-compile-and-run-file-default ()
  "Compile and run ocaml file - default"
  (interactive)
  (compile (format "dune build && dune exec ./%s.exe\n" (file-name-sans-extension (buffer-name)))))

(defun wkf/ocaml-compile-and-run-project-interactive ()
  "Compile and run ocaml project - interactive"
  (interactive)
  (wkf/compile-interactively "dune build && dune exec ./main.exe\n"))

(defun wkf/ocaml-compile-and-run-project-default ()
  "Compile and run ocaml project - default"
  (interactive)
  (compile "dune exec ./main.exe"))

;; compile and run project default
(evil-define-key 'normal tuareg-mode-map (kbd ", c r r")
  'wkf/ocaml-compile-and-run-file-default)
;; compile and run project interactively
(evil-define-key 'normal tuareg-mode-map (kbd ", c r i")
  'wkf/ocaml-compile-and-run-file-interactive)

;; compile project default
(evil-define-key 'normal tuareg-mode-map (kbd ", C c") 'wkf/ocaml-compile-project)
;; compile and run project default
(evil-define-key 'normal tuareg-mode-map (kbd ", C r r")
  'wkf/ocaml-compile-and-run-project-default)
;; compile and run project interactively
(evil-define-key 'normal tuareg-mode-map (kbd ", C r i")
  'wkf/ocaml-compile-and-run-project-interactive)
;; clean ocaml project using dune
(evil-define-key 'normal tuareg-mode-map (kbd ", C l") 'wkf/ocaml-clean-project)

;; (use-package! lsp-haskell
;;   :after lsp-mode
;;   :config (setq lsp-haskell-process-path-hie "hie-wrapper")
;;   (lsp-haskell-set-formatter-floskell))

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

;; Go to doKumentation
(evil-define-key 'normal haskell-mode-map (kbd "K") 'wkf/gdoc-split)

(defun wkf/jts-compile-project ()
  "compile and run current typescript file - default"
  (interactive)
  (if (member (file-name-extension (buffer-file-name))
              '("ts", "tsx"))
      (compile (format "yarn tsc")) nil))

(defun wkf/jts-compile-and-run-file-default ()
  "compile and run current typescript file - default"
  (interactive)
  (if (member (file-name-extension (buffer-file-name))
              '("ts", "tsx"))
      (compile (format "yarn ts-node %s" (buffer-file-name)))
    (compile (format "node %s" (buffer-file-name)))))


(defun wkf/jts-compile-and-run-file-interactive ()
  "compile and run current typescript file - interactive"
  (interactive)
  (if (member (file-name-extension (buffer-file-name))
              '("ts", "tsx"))
      (wkf/compile-interactively (format "yarn ts-node %s\n" (buffer-file-name)))
    (wkf/compile-interactively (format "node %s\n" (buffer-file-name)))))

;; compile project
(evil-define-key 'normal typescript-mode-map (kbd ", C c") 'wkf/jts-compile-project)
;; compile and run current file
(evil-define-key 'normal typescript-mode-map (kbd ", c r r") 'wkf/jts-compile-and-run-file-default)
(evil-define-key 'normal typescript-mode-map (kbd ", c r i") 'wkf/jts-compile-and-run-file-interactive)

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
(evil-define-key 'normal go-mode-map (kbd ", C c") 'wkf/go-compile-project)
;; compile current file
(evil-define-key 'normal go-mode-map (kbd ", c c") 'wkf/go-compile-file)

(set-popup-rule! "^\\*Anaconda"
  :size wkf/popup-size-s
  :side 'bottom)

(defun wkf/update-elixir-language-server ()
  "Update elixir language server's binary"
  (interactive)
  (wkf/compile-interactively
   "cd ~/.doom.d/elixir-ls && git reset --hard HEAD && git pull origin master && cp -r ~/.tool-versions . && mix deps.get && mix compile && mix elixir_ls.release -o release\n"))

(use-package! flycheck-credo
  :after flycheck
  :after lsp-ui
  :config (flycheck-credo-setup))

(after! lsp (add-hook 'elixir-mode-hook (lambda ()
                                          (add-hook 'before-save-hook 'lsp-format-buffer nil t)
                                          (add-hook 'after-save-hook
                                                    'alchemist-iex-reload-module))))

(use-package! alchemist
  :after elixir-mode
  :hook (elixir-mode . alchemist-mode)
  :config (set-lookup-handlers! 'elixir-mode
            :definition #'alchemist-goto-definition-at-point
            :documentation #'alchemist-help-search-at-point)
  (set-eval-handler! 'elixir-mode #'alchemist-eval-region)
  (set-repl-handler! 'elixir-mode #'alchemist-iex-project-run)
  (setq alchemist-mix-env "dev")
  ;; (setq alchemist-hooks-compile-on-save t)
  (map! :map elixir-mode-map
        :nv "m" alchemist-mode-keymap))
(use-package! exunit)

(set-popup-rule! "^\\*alchemist"
  :size wkf/popup-size-s)

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

(defun wkf/rust-build-development-project ()
  "build current rust project (development)"
  (interactive)
  (compile "cargo build"))

(defun wkf/rust-build-release-project ()
  "build current rust project (release)"
  (interactive)
  (compile "cargo build --release"))

(defun wkf/rust-run-file ()
  "run current rust file"
  (interactive)
  (compile (format "%s" (file-name-sans-extension buffer-file-name))))

(defun wkf/rust-compile-and-run-file ()
  "compile and run current rust file"
  (interactive)
  (compile (format "rustc %s && %s" (buffer-file-name)
                   (file-name-sans-extension buffer-file-name))))

(defun wkf/rust-compile-and-run-file-interactive ()
  "compile and run current rust file"
  (interactive)
  (wkf/compile-interactively (format "rustc %s && %s\n" (buffer-file-name)
                   (file-name-sans-extension buffer-file-name))))

(defun wkf/rust-compile-and-run-project ()
  "compile and run current rust project"
  (interactive)
  (compile "cargo run"))

(defun wkf/rust-compile-and-run-project-interactive ()
  "compile and run current rust project interactively"
  (interactive)
  (wkf/compile-interactively "cargo run\n"))

(defun wkf/rust-quick-check-project ()
  "check current rust project"
  (interactive)
  (compile "cargo check"))

;; compile - compile - file
(evil-define-key 'normal rustic-mode-map (kbd ", c c") 'wkf/rust-compile-file)
;; compile and run current file
(evil-define-key 'normal rustic-mode-map (kbd ", c r r") 'wkf/rust-compile-and-run-file)
;; compile and run current file interactive
(evil-define-key 'normal rustic-mode-map (kbd ", c r i") 'wkf/rust-compile-and-run-file-interactive)
;; run current file
(evil-define-key 'normal rustic-mode-map (kbd ", r r") 'wkf/rust-run-file)

;; compile - compile - file
(evil-define-key 'normal rustic-mode-map (kbd ", C c") 'wkf/rust-compile-project)
;; compile quick project
(evil-define-key 'normal rustic-mode-map (kbd ", C q") 'wkf/rust-quick-check-project)
;; compile and run current project
(evil-define-key 'normal rustic-mode-map (kbd ", C r r") 'wkf/rust-compile-and-run-project)
;; compile and run current project interactively
(evil-define-key 'normal rustic-mode-map (kbd ", C r i") 'wkf/rust-compile-and-run-project-interactive)
;; build - release - project
(evil-define-key 'normal rustic-mode-map (kbd ", C b r") 'wkf/rust-build-release-project)
;; build - development - project
(evil-define-key 'normal rustic-mode-map (kbd ", C b d") 'wkf/rust-build-development-project)

;; >
(evil-define-key 'normal Info-mode-map (kbd "s-.") 'Info-forward-node)
;; <
(evil-define-key 'normal Info-mode-map (kbd "s-,") 'Info-backward-node)

(which-key-add-key-based-replacements
  ", o" "org")

(setq org-directory "~/wkf-org/")

(add-hook 'org-mode-hook (lambda ()
                           (set-popup-rule! "^\\*Org Src"
                             :size wkf/popup-size-xxxl
                             :side 'bottom)
                           (setq org-log-done 'time)
                           (setq org-agenda-files (directory-files-recursively "~/wkf-org/"
                                                                               "\\.org$")))
)

(defun wkf/find-org-index ()
  "Open my org index in the right vsp"
  (interactive)
  (wkf/find-file "~/wkf-org/index.org"))

(which-key-add-key-based-replacements
  ", o e" "org-edit")
(which-key-add-key-based-replacements
  ", o e i" "org-edit-index")

;; Open index file
(define-key evil-normal-state-map (kbd ", o e i") 'wkf/find-org-index)

(which-key-add-key-based-replacements
  ", o c" "org-chekcbox")

(which-key-add-key-based-replacements
  ", o c t" "org-checkbox-toggle")
(which-key-add-key-based-replacements
  ", o s" "org-src")
(which-key-add-key-based-replacements
  ", o s e" "org-src-edit-special")
(which-key-add-key-based-replacements
  ", o s f" "org-src-format")
(which-key-add-key-based-replacements
  ", o h" "org-heading")
(which-key-add-key-based-replacements
  ", o h h" "org-heading-insert")
(which-key-add-key-based-replacements
  ", o h s" "org-heading-sub-insert")


(evil-define-key 'normal org-mode-map (kbd ", o c t") 'org-toggle-checkbox)

;; Org SRC edit special
(evil-define-key 'normal org-mode-map (kbd ", o s e") 'org-edit-special)
;; Org SRC Format
(evil-define-key 'normal org-mode-map (kbd ", o s f")
  (kbd ", o s e , w : q"))
;; Org heading
(evil-define-key 'normal org-mode-map (kbd ", o h h") 'org-insert-heading)
(evil-define-key 'normal org-mode-map (kbd ", o h s") 'org-insert-subheading)

(setq org-image-actual-width (/ (display-pixel-width) 3))

(add-hook 'org-mode-hook 'org-display-user-inline-images)
(add-hook 'org-mode-hook 'org-display-inline-images)
(add-hook 'org-mode-hook 'org-redisplay-inline-images)

(which-key-add-key-based-replacements
  ", o i" "org-inline-images")
(which-key-add-key-based-replacements
  ", o i i" "org-inline-images-toggle")
(which-key-add-key-based-replacements
  ", o i y" "org-inline-images-display-yes")
(which-key-add-key-based-replacements
  ", o i n" "org-inline-images-display-no")

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

(which-key-add-key-based-replacements
  ", o o" "org-open-at-point")

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

(defun wkf/git-wkf-update-all ()
  "auto-update all of my essential git repos"
  (interactive)
  (compile "git_wkf_update_all"))
(defun wkf/git-complom-clean ()
  "checkout master -> clean all branch -> pull latest"
  (interactive)
  (compile "git_complom_clean"))

(which-key-add-key-based-replacements
  "<backspace> g" "git")
(which-key-add-key-based-replacements
  "<backspace> g w" "git-wkf")
(which-key-add-key-based-replacements
  "<backspace> g w u" "git-wkf-update")
(which-key-add-key-based-replacements
  "<backspace> g w u a" "git-wkf-update-all")
(which-key-add-key-based-replacements
  "<backspace> g c" "git-checkout-master")
(which-key-add-key-based-replacements
  "<backspace> g c p" "git-checkout-master-pull-origin")
(which-key-add-key-based-replacements
  "<backspace> g c p c" "git-checkout-master-pull-origin-clean-branch")

(define-key evil-normal-state-map (kbd "<backspace> g w u a") 'wkf/git-wkf-update-all)
(define-key evil-normal-state-map (kbd "<backspace> g c p c") 'wkf/git-complom-clean)

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

(which-key-add-key-based-replacements
  "` e" "emacs")
(which-key-add-key-based-replacements
  "` e l" "emacs-lisp")
(which-key-add-key-based-replacements
  "` e l o" "emacs-lisp-org")
(which-key-add-key-based-replacements
  "` e l o s" "emacs-lisp-org-source")
(which-key-add-key-based-replacements
  "` e l o s i" "emacs-lisp-org-source-silent")
(which-key-add-key-based-replacements
  "` e l o s o" "emacs-lisp-org-source-output")
(which-key-add-key-based-replacements
  "` e l o s s" "emacs-lisp-org-source-default")

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

(which-key-add-key-based-replacements
  "` s" "shell")
(which-key-add-key-based-replacements
  "` s h" "shell")
(which-key-add-key-based-replacements
  "` s h o" "shell-org")
(which-key-add-key-based-replacements
  "` s h o s" "shell-org-source")

(evil-define-key 'normal org-mode-map (kbd "` s h o s") 'wkf/org-src-sh)

(which-key-add-key-based-replacements "` j" "javascript")
(which-key-add-key-based-replacements "` j s" "javascript")
(which-key-add-key-based-replacements "` j s o" "javascript-org")
(which-key-add-key-based-replacements "` j s o s" "javascript-org-source")

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

(which-key-add-key-based-replacements "` j s c" "javascript-comment")
(which-key-add-key-based-replacements "` j s c h" "javascript-comment-heading")

(evil-define-key 'normal typescript-mode-map (kbd "` j s c h") 'wkf/js-comment-heading)
(evil-define-key 'normal js2-mode-map (kbd "` j s c h") 'wkf/js-comment-heading)

(add-to-list 'auto-mode-alist '("\\.js\\'" . typescript-mode))

(which-key-add-key-based-replacements
  "` m" "ocaml")
(which-key-add-key-based-replacements
  "` m l" "ocaml")
(which-key-add-key-based-replacements
  "` m l c" "ocaml-comment")
(which-key-add-key-based-replacements
  "` m l c h" "ocaml-comment-heading")

(defun wkf/ocaml-comment-heading ()
  "Insert comment in ocaml that looks like a heading"
  (interactive)
  (insert "(* ---  --- *)")
  (evil-normal-state)
  (evil-backward-char 6)
  (evil-insert-state))

(evil-define-key 'normal tuareg-mode-map (kbd "` m l c h") 'wkf/ocaml-comment-heading)

(defun wkf/org-src-query-sql ()
  "Insert Org SRC for sh"
  (interactive)
  (progn (insert "#+BEGIN_SRC sql")
         (evil-normal-state)
         (evil-open-below 1)
         (insert "#+END_SRC")
         (evil-normal-state)
         (evil-open-above 1)))

(which-key-add-key-based-replacements
  "` q" "query")
(which-key-add-key-based-replacements
  "` q s" "query-sql")
(which-key-add-key-based-replacements
  "` q s o" "query-sql-org")
(which-key-add-key-based-replacements
  "` q s o s" "query-sql-org-source")

(evil-define-key 'normal org-mode-map (kbd "` q s o s") 'wkf/org-src-query-sql)

(use-package! wakatime-mode
  :hook (after-init . global-wakatime-mode))

(which-key-add-key-based-replacements
  ", s" "search")
(which-key-add-key-based-replacements
  ", s s" "search-default")
(which-key-add-key-based-replacements
  ", s ." "search-restart")

;; search Search
(define-key evil-normal-state-map (kbd ", s s") 'deadgrep)
;; search restart
(define-key evil-normal-state-map (kbd ", s .") 'deadgrep-restart)

(setq which-key-idle-delay 0.5)
