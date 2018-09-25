;;;; lk/helm.el -- all things helm & projectile
(use-package projectile
  :ensure t)

(use-package grizzl
  :ensure t)

(use-package helm
  :ensure t
  :init
  (setq helm-M-x-fuzzy-match t)
  (helm-mode)
  :bind (("C-c n b" . helm-buffers-list)
         ;; in-buffer navigation
         ("C-c n i" . helm-semantic-or-imenu)
         ("C-c n s" . helm-occur)
         ;; Tags
         ("C-c n t" . helm-etags-select)
         ;; override M-x to use helm-M-x
         ("M-x" . helm-M-x)))

(use-package helm-git-grep
  :ensure t
  :after (helm)
  :bind (("C-c n g" . helm-git-grep)))

(use-package helm-projectile
  :ensure t
  :init
  (setq projectile-completion-system 'helm)
  (helm-projectile-on)
  (setq projectile-git-command "git ls-files -z -c --recurse-submodules")
  (setq projectile-use-git-grep t)
  (setq projectile-completion-system 'grizzl)
  :bind (("C-c n p" . helm-projectile-find-file)))

(helm-mode)

;; dock helm window in the bottom
(add-to-list 'display-buffer-alist
             `(,(rx bos "*helm" (* not-newline) "*" eos)
               (display-buffer-in-side-window)
               (inhibit-same-window . t)
               (window-height . 0.25)))


(provide 'lk/helm)
