(if (member (file-name-extension (buffer-file-name))
            '("ts")) t nil)

(defun wkf/ts-compile-and-run-file-default ()
  "compile and run current typescript file - default"
  (interactive)
  (if (member (file-name-extension (buffer-file-name))
              '("ts", "tsx"))
      (compile (format "yarn ts-node %s" (buffer-file-name)))
    (compile (format "node %s" (buffer-file-name)))))


(defun wkf/ts-compile-and-run-file-interactive ()
  "compile and run current typescript file - interactive"
  (interactive)
  (if (member (file-name-extension (buffer-file-name))
              '("ts", "tsx"))
      (wkf/compile-interactively (format "yarn ts-node %s\n" (buffer-file-name)))
    (wkf/compile-interactively (format "node %s\n" (buffer-file-name)))))
