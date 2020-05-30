;;; ~/Dropbox/wkf-devbox/doom-emacs/.doom.d/scratch.el -*- lexical-binding: t; -*-

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

(define-key evil-normal-state-map (kbd ", w") 'wkf/save-buffer)
(define-key evil-normal-state-map (kbd ", q") 'delete-window)

(delete-window)
