;; 21 Sept 16: I added the next 6 lines based on instructions from Aaron Bieber at:
;; http://blog.aaronbieber.com/2015/05/24/from-vim-to-emacs-in-fourteen-days.html
(require 'package) ;; Loads the built-in package manager.

;; Adds a couple of popular Emacs package repos to the list of available repos. 
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/") t)

;; The following package management code is based off of:
;; https://realpython.com/blog/python/emacs-the-best-python-editor/

(package-initialize)
(when (not package-archive-contents)
    (package-refresh-contents))

(defvar myPackages
  '(better-defaults
    color-theme-modern
    elpy
    flycheck
    py-autopep8
    magit
    evil))

(mapc #'(lambda (package)
	  (unless (package-installed-p package)
	    (package-install package)))
      myPackages)

;; ******************************************************************************

;; Basic Customizations.

;; Tells Emacs to use evil-mode by default. 
(require 'evil)
(evil-mode t)

(load-theme 'hober t)

(global-linum-mode t)

;; Visual line mode treats each display line as though it has a newline at the end.
(global-visual-line-mode t)

;; Enabling the Emacs Lisp Python Environment. This requires having jedi and flake8
;; installed on the system first in order to work!
(elpy-enable) 

;; For enabling flycheck. 
(when (require 'flycheck nil t)
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode))

;; For enabling autopep8.
(require 'py-autopep8)
(add-hook 'elpy-mode-hook 'py-autopep8-enable-on-save)

;; ******************************************************************************

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#242424" "#e5786d" "#95e454" "#cae682" "#8ac6f2" "#333366" "#ccaa8f" "#f6f3e8"])
 '(custom-enabled-themes (quote (hober)))
 '(custom-safe-themes
   (quote
    ("31772cd378fd8267d6427cec2d02d599eee14a1b60e9b2b894dd5487bd30978e" default)))
 '(python-shell-interpreter "python3"))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(put 'dired-find-alternate-file 'disabled nil)
