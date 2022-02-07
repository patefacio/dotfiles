;;; dbd-org.el -*- lexical-binding: t; -*-

;; Very frustrating bug that prevented C-c C-c from finalizing an org-capture
;; This is from https://github.com/hlissner/doom-emacs/issues/5714
;;
(after! org
  (defadvice! dan/+org--restart-mode-h-careful-restart (fn &rest args)
    :around #'+org--restart-mode-h
    (let ((old-org-capture-current-plist (and (bound-and-true-p org-capture-mode)
                                              (bound-and-true-p org-capture-current-plist))))
      (apply fn args)
      (when old-org-capture-current-plist
        (setq-local org-capture-current-plist old-org-capture-current-plist)
        (org-capture-mode +1)))))


(after! org
  (setq org-todo-keywords
        '(
          (sequence "TODO(t)" "STARTED(s!)" "IDEA(i)" "|" "DONE(d!/!)" "KILL(k)")
          (sequence "WAITING(w@/!)" "SOMEDAY(S!)" "|" "CANCELLED(c@/!)")
          )
        )
  (setq
   org-capture-templates
   '(("t" "Personal todo" entry
      (file+headline +org-capture-todo-file "Inbox")
      "* TODO %t: %?\n%i\n%a" :prepend t)
     ("n" "Personal notes" entry
      (file+headline +org-capture-notes-file "Inbox")
      "* %u %?\n%i\n%a" :prepend t)
     ("j" "Journal" entry
      (file+olp+datetree +org-capture-journal-file)
      "* %U %?\n%i\n%a" :prepend t)
     ("p" "Templates for projects")
     ("pt" "Project-local todo" entry
      (file+headline +org-capture-project-todo-file "Inbox")
      "* TODO %?\n%i\n%a" :prepend t)
     ("pn" "Project-local notes" entry
      (file+headline +org-capture-project-notes-file "Inbox")
      "* %U %?\n%i\n%a" :prepend t)
     ("pc" "Project-local changelog" entry
      (file+headline +org-capture-project-changelog-file "Unreleased")
      "* %U %?\n%i\n%a" :prepend t)
     ("o" "Centralized templates for projects")
     ("ot" "Project todo" entry #'+org-capture-central-project-todo-file "* TODO %?\n %i\n %a" :heading "Tasks" :prepend nil)
     ("on" "Project notes" entry #'+org-capture-central-project-notes-file "* %U %?\n %i\n %a" :heading "Notes" :prepend t)
     ("oc" "Project changelog" entry #'+org-capture-central-project-changelog-file "* %U %?\n %i\n %a" :heading "Changelog" :prepend t))
   )

  (setq org-tag-alist
        (quote (
                ("javascript" . ?j)
                ("go" . ?g)
                ("@work" . ?w)
                ("@home" . ?H)
                ("@karen" . ?k)
                ("auction" . ?a)
                ("business_hours" . ?b)
                ("build" . ?B)
                ("codegen" . ?c)
                ("cpp" . ?C)
                ("database" . ?d)
                ("emacs" . ?E)
                ("family" . ?f)
                ("health" . ?m)
                ("quick" . ?q)
                ("reminder" . ?r)
                ("school" . ?S)
                ("tickler" . ?t)
                ("USEFUL_INFO" . ?U)
                )
               )
        )


  (setq org-tag-faces
        '(
          ("@work" . (:background "white" :foreground "black" :weight "bold" :italic t))
          ("@home" . (:background "white" :foreground "navy" :weight "bold" :italic nil))
          ("@karen" . (:background "white" :foreground "navy" :weight "bold" :italic nil))
          ("codegen" . (:background "white" :foreground "DeepPink4" :weight "bold" :italic nil))
          ("cpp" . (:background "white" :foreground "OliveDrab4" :weight "bold" :italic nil))
          ("database" . (:background "white" :foreground "OliveDrab4" :weight "bold" :italic nil))
          ("emacs" . (:background "white" :foreground "DarkOliveGreen4" :weight "bold" :italic nil))
          ("family" . (:background "white" :foreground "navy" :weight "bold" :italic nil))
          ("hdf5" . (:background "white" :foreground "PaleGreen4" :weight "bold" :italic nil))
          ("health" . (:background "white" :foreground "navy" :weight "bold" :italic nil))
          ("orm" . (:background "white" :foreground "DarkOliveGreen4" :weight "bold" :italic nil))
          ("school" . (:background "white" :foreground "dark red" :weight "bold" :italic nil))
          ("tickler" . (:background "white" :foreground "dark goldenrod" :weight "bold" :italic nil))
          ("USEFUL_INFO" . (:background "white" :foreground "black" :weight "bold" :italic nil))
          )
        )
  )
