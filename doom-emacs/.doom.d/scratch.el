;;; ~/Dropbox/wkf-devbox/doom-emacs/.doom.d/scratch.el -*- lexical-binding: t; -*-

(defun wkf/save-buffer ()
  "Save current buffer with custom lsp formatting"
  (interactive)
  (if (and (equal lsp-mode t)
           (not (equal major-mode 'reason-mode)))
      (progn (lsp-format-buffer)
             (save-buffer))
    (save-buffer)))

(define-key evil-normal-state-map (kbd ", w") 'wkf/save-buffer)
(define-key evil-normal-state-map (kbd ", q") 'delete-window)

(blink-cursor-mode t)

(+ 1 2)

(message "ibe jomblo, barusan diajak ngobrol sama mantan gebetannya yang baru jadian")
