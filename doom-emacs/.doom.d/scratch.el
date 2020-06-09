(setq-default left-margin-width 2 right-margin-width 2)

(add-hook! '+popup-buffer-mode-hook (set-window-margins (selected-window) 1 1))
