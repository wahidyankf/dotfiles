(message (buffer-name))

(cond ((equal (buffer-name) "scratch.el")
       (message "yo"))
      (t (message "not the same yo!")))
