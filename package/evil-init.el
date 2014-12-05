;;; package/evil-init --- Initialize evil and its extensions
;;;; Commentary:
;;;; Load evil + evil extensions
;;; code:
(require 'evil)
(evil-mode 1)
(require 'evil-numbers)
(require 'evil-matchit)
(global-evil-matchit-mode 1)

; activate evil-leader and assign
; some of my old mappings
(require 'evil-leader)
(global-evil-leader-mode)

(add-to-list 'load-path "~/.emacs.d/vendor/evil-surround")
(require 'surround)
(global-surround-mode 1)

(require 'lk/evil)

(provide 'evil-init)
;;; evil-init.el ends here
