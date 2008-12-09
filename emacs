';; This is the Aquamacs Preferences file.
;; Add Emacs-Lisp code here that should be executed whenever
;; you start Aquamacs Emacs. If errors occur, Aquamacs will stop
;; evaluating this file and print errors in the *Messags* buffer.
;; Use this file in place of ~/.emacs (which is loaded as well.)

;; stuff for ruby on rails development
(require 'ruby-mode)

(add-hook 'window-setup-hook (lambda () 
  (tool-bar-mode -1) 
  ;; (mac-toggle-max-window) 
  ))

;; (add-to-list 'load-path "~/.emacs.d/plugins/ecb-2.32")
(require 'ecb)
(require 'ecb-autoloads)

;; force to load another css-mode, the css-mode in nxml package
;; seems failed to load under my Emacs 23
(let ((load-path (cons "~/emacs/extension/"
		       load-path)))
  (require 'css-mode))

(require 'ido)
(ido-mode t)
(setq ido-enable-flex-matching t)

(add-to-list 'load-path "~/.emacs.d/plugins/rinari")
(require 'rinari)
(setq rinari-tags-file-name "TAGS")

(setq
      nxhtml-global-minor-mode t
      mumamo-chunk-coloring 'submode-colored
      nxhtml-skip-welcome t
      indent-region-mode t
      rng-nxml-auto-validate-flag nil
      nxml-degraded t)
     (add-to-list 'auto-mode-alist '("\\.html\\.erb\\'" . eruby-nxhtml-mumamo))

(add-to-list 'load-path
	     "~/.emacs.d/")

(autoload 'js2-mode "js2" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))

(require 'color-theme)
;;(color-theme-initialize)
(color-theme-charcoal-black)

(add-hook 'eshell-mode-hook
   '(lambda nil
   (let ((path))
      (setq path "/Users/fjean/bin:/Users/fjean/depot_tools:/Users/fjean/.gem/ruby/1.8/bin:/System/Library/Frameworks/JavaVM.framework/Versions/1.6/Home/bin:/Users/fjean/scala/bin:/Users/fjean/jruby/bin:/Users/fjean/groovy/bin:/Users/fjean/grails/bin:/Users/fjean/maven/bin:/opt/local/bin:/usr/local/bin:/usr/local/mysql/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/X11/bin")
    (setenv "PATH" path))
   (local-set-key "\C-u" 'eshell-kill-input))
 )

;; (defun eshell-handle-ansi-color ()
;;  (ansi-color-apply-on-region eshell-last-output-start
;;                              eshell-last-output-end))
;;(add-to-list 'eshell-output-filter-functions 'eshell-handle-ansi-color)

(define-key global-map [(alt return)] 'mac-toggle-max-window)

(setq-default tab-width 2)
(setq-default indent-tabs-mode nil)
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(CUA-mode t t)
 '(cua-mode t nil (cua-base))
 '(ecb-auto-activate t)
 '(ecb-layout-name "left7")
 '(ecb-layout-window-sizes (quote (("left7" (0.23404255319148937 . 0.4657534246575342) (0.23404255319148937 . 0.2328767123287671) (0.23404255319148937 . 0.2876712328767123)))))
 '(ecb-options-version "2.32")
 '(ecb-source-path (quote ("~/Projects/kenai~subversion/junction2" "~/Projects/kenai~subversion/CWPAuthservice" ("/" "/"))))
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
(setq mac-command-key-is-meta t)