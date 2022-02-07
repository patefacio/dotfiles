;;; dbd-utils.el -*- lexical-binding: t; -*-

(defun d:named-shell (name)
  (interactive "sEnter name: ")
  (shell (format "*sh (%s)*" name)))

(defun d:shell-in-dir (dir)
  (interactive "DEnter dir: ")
  (save-excursion
    (cd dir)
    (shell (format "*sh (%s)*" dir))))

(defun d:doom-sync ()
  (interactive)
  (shell-command "doom sync"))

(defun d:named-frame (frame-name)
  (interactive "sName: ")
  (make-frame `((name . ,frame-name))))

(defun d:agenda-item-to-other-window ()
  (interactive)
  (progn
    (org-agenda-goto)
    (message "Hit tab")
    ))

(defun d:browse-file ()
    (interactive)
  (shell-command (concat "open -a firefox " buffer-file-name))
  )
