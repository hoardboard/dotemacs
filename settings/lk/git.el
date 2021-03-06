;; Git and git-surf helpers
(defun lk/open-pr ()
  (interactive)
  (shell-command "~/.emacs.d/etc/bin/git-surf -p"))

(defun lk/open-current-file-in-gh ()
  (interactive)
  (let* ((line-no (line-number-at-pos))
         (command (format "~/.emacs.d/etc/bin/git-surf -r%s,%s %s"
                          line-no line-no
                          (file-name-nondirectory (buffer-file-name)))))
    (message command)
    (shell-command command)))

(global-set-key (kbd "C-x g f") 'lk/open-current-file-in-gh)

(use-package git
  :ensure t
	:bind (("C-x C-g" . vc-git-grep)
         ("C-x g p" . lk/open-pr)))

(use-package magit
  :ensure t
  :config
  (setq magit-completing-read-function 'ivy-completing-read)
	:bind
  (( "C-c m s" . magit-status)))

(use-package ibuffer-vc
  :ensure t)

(use-package ibuffer-git
  :ensure t
  :init
  (setq ibuffer-formats
      '((mark modified read-only vc-status-mini " "
              (name 18 18 :left :elide)
              " "
              " "
              (mode 16 16 :left :elide)
              " "
              (git-status-mini)
              " "
              (git-status 8 8 :right)
              " "
              filename-and-process))))


(provide 'lk/git)
