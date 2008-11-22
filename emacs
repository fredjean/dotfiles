;; This is the Aquamacs Preferences file.
;; Add Emacs-Lisp code here that should be executed whenever
;; you start Aquamacs Emacs. If errors occur, Aquamacs will stop
;; evaluating this file and print errors in the *Messags* buffer.
;; Use this file in place of ~/.emacs (which is loaded as well.)

;; stuff for ruby on rails development
(require 'ruby-mode)

(add-hook 'window-setup-hook (lambda () 
  ;; (tool-bar-mode -1) 
  (mac-toggle-max-window) 
  ))

;; Load CEDET
(load-file "~/.emacs.d/plugins/cedet-1.0pre4/common/cedet.el")

;; Enabling various SEMANTIC minor modes.  See semantic/INSTALL for more ideas.
;; Select one of the following:

;; * This enables the database and idle reparse engines
(semantic-load-enable-minimum-features)

;; * This enables some tools useful for coding, such as summary mode
;;   imenu support, and the semantic navigator
(semantic-load-enable-code-helpers)

;; * This enables even more coding tools such as the nascent intellisense mode
;;   decoration mode, and stickyfunc mode (plus regular code helpers)
(semantic-load-enable-gaudy-code-helpers)

;; * This turns on which-func support (Plus all other code helpers)
(semantic-load-enable-excessive-code-helpers)

;; This turns on modes that aid in grammar writing and semantic tool
;; development.  It does not enable any other features such as code
;; helpers above.
;; (semantic-load-enable-semantic-debugging-helpers)
(add-to-list 'load-path
	     "~/.emacs.d/plugins/ecb-2.32")
(require 'ecb)
(require 'ecb-autoloads)

					; loads ruby mode when a .rb file is opened.
(setq auto-mode-alist  
      (cons '(".rb$" . ruby-mode) auto-mode-alist))

(setq auto-mode-alist  
      (cons '(".rhtml$" . html-mode) auto-mode-alist))

					; this allows us to have constant indentation as
					; we progress in the code from line to line.
(defun create-newline-and-indent()
  (local-set-key [return] 'newline-and-indent))

(add-hook 'ruby-mode-hook 'create-newline-and-indent)


					; enables ruby electric for easier editing of 
					; rb and rhtml files
(add-hook 'ruby-mode-hook
	  (lambda()
	    (add-hook 'local-write-file-hooks
		      '(lambda()
			 (save-excursion
			   (untabify (point-min) (point-max))
			   (delete-trailing-whitespace)
			   )))
	    
					; forces ruby-mode to use tabs for indentation with
					; an indent level of 2
	    (setq indent-tabs-mode 1)
	    (setq ruby-indent-level 2)
	    
					; allows the [tab] key to work with width 4
	    (define-key ruby-mode-map "\t" 'self-insert-command)  
	    (set (make-local-variable 'tab-width) 2)
	    
	    (define-key ruby-mode-map "\C-m" 'newline-and-indent)
	    
					; setting up ruby-electric
	    (require 'ruby-electric)
	    (ruby-electric-mode t)
	    ))

(load "~/.emacs.d/plugins/nxhtml/autostart.el")
(add-to-list 'auto-mode-alist
             '("\\.rhtml$" . kid-rhtml-mode))
;; only special background in submode
(setq mumamo-chunk-coloring 'submode-colored)
(setq nxhtml-skip-welcome t)

;; do not turn on rng-validate-mode automatically, I don't like
;; the anoying red underlines
(setq rng-nxml-auto-validate-flag nil)

;; force to load another css-mode, the css-mode in nxml package
;; seems failed to load under my Emacs 23
(let ((load-path (cons "~/emacs/extension/"
		       load-path)))
  (require 'css-mode))

(defun kid-rhtml-mode ()
  (nxhtml-mode)
  ;; I don't use cua-mode, but nxhtml always complains. So, OK, let's
  ;; define this dummy variable
  (make-local-variable 'cua-inhibit-cua-keys)
  (setq mumamo-current-chunk-family '("eRuby nXhtml Family" nxhtml-mode
				      (mumamo-chunk-eruby
				       mumamo-chunk-inlined-style
				       mumamo-chunk-inlined-script
				       mumamo-chunk-style=
				       mumamo-chunk-onjs=)))
  (mumamo-mode)
  (rails-minor-mode t)
  (auto-fill-mode -1)
  (setq tab-width 2)
  (setq indent-tabs-mode nil))

(add-to-list 'load-path
	     "~/.emacs.d/")

(autoload 'js2-mode "js2" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))

(require 'color-theme)
(color-theme-initialize)
(color-theme-charcoal-black)

(require 'ido)
(ido-mode t)
(setq ido-enable-flex-matching t)

(setq ido-execute-command-cache nil)
(defun ido-execute-command ()
  (interactive)
  (call-interactively
   (intern
    (ido-completing-read
     "M-x "
     (progn
       (unless ido-execute-command-cache
	 (mapatoms (lambda (s)
		     (when (commandp s)
		       (setq ido-execute-command-cache
			     (cons (format "%S" s) ido-execute-command-cache))))))
       ido-execute-command-cache)))))

(add-hook 'ido-setup-hook
          (lambda ()
	    (setq ido-enable-flex-matching t)
	    (global-set-key "\M-x" 'ido-execute-command)))

(defun ido-find-file-in-tag-files ()
  (interactive)
  (save-excursion
    (let ((enable-recursive-minibuffers t))
      (visit-tags-table-buffer))
    (ido-completing-read "Project file: "
			 (tags-table-files)
			 nil t)))

(defun mac-toggle-max-window ()
  (interactive)
  (set-frame-parameter nil 'fullscreen (if (frame-parameter nil 'fullscreen)
                                           nil
                                           'fullboth)))

(setq load-path (cons "~/.emacs.d/rails" load-path))
  (require 'rails)

(define-key global-map [(alt return)] 'mac-toggle-max-window)

(setq-default tab-width 2)
(setq-default indent-tabs-mode nil)
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(cua-mode t nil (cua-base))
 '(ecb-auto-activate t)
 '(ecb-layout-name "left7")
 '(ecb-options-version "2.32")
 '(ecb-source-path (quote ("~/Projects/kenai/junction2" "~/Projects/deploy-trunk" "~/Projects/kenai/CWPAuthservice" ("/" "/"))))
 '(ecb-tip-of-the-day nil)
 '(ecb-windows-width 0.15)
 '(show-paren-mode t)
 '(transient-mark-mode t))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )

(desktop-save-mode 1)
;; Customization follows below
(setq history-length 250)
(add-to-list 'desktop-globals-to-save 'file-name-history)
