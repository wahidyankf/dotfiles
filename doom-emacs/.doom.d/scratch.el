;; (term "*terminal*")
;; (with-current-buffer "*terminal*" (progn (term-send-input "ls")))

;; (progn (set-buffer "*terminal*")
;;        (term-send-raw-string "ls -l\n"))

;; (progn (let ((term-buffer (term "/usr/local/bin/zsh")))
;; (progn (let ((term-buffer (vterm)))
;; (set-buffer term-buffer)

;; start up vi
;; (term-send-raw-string "vi hello.txt\n")

;; some line noise :P
;;  (term-send-raw-string "ihello world\033:wq\n")

;; quit our shell
;;  (term-send-raw-string "exit")
;; (term-send-raw-string "ls -al\n")))

(progn (let ((term-buffer (vterm)))
         (set-buffer term-buffer)
         (term-send-raw-string "echo yo\n")
         (term-send-raw-string "echo yes\n")))
