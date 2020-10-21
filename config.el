;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Milan Raicevic"
      user-mail-address "raikhan@gmail.com")

;; Mac only - swap Alt and Cmd
(setq mac-command-modifier 'meta)
(setq Mac-option-modifier 'super)

;; Start with maximized window
(add-to-list 'default-frame-alist '(fullscreen . maximized))

;; My usual magit binding
(use-package! magit
  :bind
  ("C-x g" . magit-status)
)


;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))
(doom/increase-font-size 2)


;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(load-theme 'doom-material t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)


;; Here are some additional functions/macros that could help you configure Doom :
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.


;;; Navigation changes

;; Enable multiple-cursors mode everywhere with my shortcuts
(use-package! multiple-cursors
  :config
  (global-set-key (kbd "C->") 'mc/mark-next-like-this)
  (global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
)

;; My avy shortcuts 
(use-package! avy
  :bind
  ("C-'" . avy-goto-char-timer)
  ("C-z" . avy-goto-char-timer)
)

;; Helm
(use-package! helm
  :bind (("C-c SPC" . helm-all-mark-rings)          ; helm menu for mark ring
         ("C-x b" . helm-mini)
         ("M-y" . helm-show-kill-ring)
         :map helm-map
         ("<tab>" . helm-execute-persistent-action) ; rebind tab to run persistent action
         ("C-i" . helm-execute-persistent-action)   ; make TAB work in terminal
         ("C-z" . helm-select-action)               ; list actions using C-z
         )
  :config
  (when (executable-find "curl")
    (setq helm-google-suggest-use-curl-p t))
  (setq helm-split-window-inside-p           t ; open helm buffer inside current window, not occupy whole other window
        helm-move-to-line-cycle-in-source     t ; move to end or beginning of source when reaching top or bottom of source.
        helm-ff-search-library-in-sexp        t ; search for library in `require' and `declare-function' sexp.
        helm-scroll-amount                    8 ; scroll 8 lines other window using M-<next>/M-<prior>
        helm-ff-file-name-history-use-recentf t
        helm-echo-input-in-header-line        t
        helm-autoresize-max-height            0
        helm-autoresize-min-height           30
        helm-M-x-fuzzy-match                  t ; fuzzy match all the things
        helm-buffers-fuzzy-matching           t
        helm-recentf-fuzzy-match              t
        helm-semantic-fuzzy-match             t
        helm-imenu-fuzzy-match                t
        mark-ring-max                         3 ; use a smaller size of the mark ring so it is more easy to manage with helm
        )
)

(use-package! helm-config
  :after helm
  :init
  (custom-set-variables '(helm-command-prefix-key "C-c h"))
  :config
  ;; The default "C-x c" is quite close to "C-x C-c", which quits Emacs.
  ;; Changed to "C-c h". Note: We must set "C-c h" globally, because we
  ;; cannot change `helm-command-prefix-key' once `helm-config' is loaded.
  ;; (global-set-key (kbd "C-c h") 'helm-command-prefix)
  (global-unset-key (kbd "C-x c"))
)


;; NOT USING SWOOP - TRYNG SWIPER WHICH COMES WITH DOOM
;; ;; Helm-swoop setup
;; (use-package! helm-swoop
;;   :bind
;;   (("M-i" . helm-swoop)
;;   ;; ("M-S-i" . helm-swoop-back-to-last-point) ; need to decide on a new keyboard shortcut, this one does not work
;;   ("C-c M-i" . helm-multi-swoop)
;;   ("C-x M-i" . helm-multi-swoop-all)
;;   :map isearch-mode-map
;;   ("M-i" . helm-swoop-from-isearch)  ; When doing isearch, hand the word over to helm-swoop
;;   )
;;   :config
;;   (setq helm-multi-swoop-edit-save                                    t  ; Save buffer when helm-multi-swoop-edit complete
;;    helm-swoop-split-with-multiple-windows                      nil  ; If this value is t, split window inside the current window
;;    helm-swoop-split-direction             'split-window-vertically  ; Split direcion. 'split-window-vertically or 'split-window-horizontally
;;    helm-swoop-speed-or-color                                   nil  ; If nil, you can slightly boost invoke speed in exchange for text color
;;    helm-swoop-move-to-line-cycle                                 t  ; Go to the opposite side of line from the end or beginning of line
;;    helm-swoop-use-line-number-face                               t  ; Optional face for line numbers
;;    helm-swoop-use-fuzzy-match                                    t  ; Fuzzy matching
;;    )
;; )

(use-package! swiper
  :bind
  (("M-i" . swiper-thing-at-point)
   ("C-s" . swiper-isearch)
   ("C-r" . swiper-isearch-backward)
   :map swiper-isearch-map
   ("C-r" . ivy-previous-line)
  :map isearch-mode-map
  ("M-i" . swiper-from-isearch)  ; When doing isearch, hand the word over to swiper
  )
)

;; Automatically search the web using s from: https://github.com/zquestz/s
(defun web-search-using-s (searchq &optional provider)
  "Do a web search using s command. Function modelled on the example from http://ergoemacs.org/emacs/elisp_universal_argument.html"
  (interactive
   (cond
    ((equal current-prefix-arg nil) ; no C-u
     (list (read-string "Enter query: ") ""))
    (t ; any other combination of C-u
     (list
      (read-string "Enter query: " )
      (concat " -p " (read-string "Enter provider: "))
      ))))
  ;; call s
  (shell-command (concat "/home/raicevim/go/bin/s -b firefox.exe "
                         (message
                          (replace-regexp-in-string "(" "\\\\("
                           (replace-regexp-in-string ")" "\\\\)" searchq)))
                         provider))
  )

(defun web-search-current-region (beg end)
  "Search the web for the string in the selected region"
  (interactive (if (use-region-p)
                   (list (region-beginning) (region-end))
                 (list nil nil)))
  (if (and beg end)
      (web-search-using-s (buffer-substring beg end))
    (message "Select region first!")))

(global-unset-key (kbd "C-c s o"))

(map! :leader
      :desc "Search web"
      "s o" #'web-search-using-s)

(map! :leader
      :desc "Search web (current region)"
      "s O" #'web-search-current-region)



;;; Editing changes

;; step through camel case
(global-subword-mode 1)

;; "When several buffers visit identically-named files,
;; Emacs must give the buffers distinct names. The usual method
;; for making buffer names unique adds ‘<2>’, ‘<3>’, etc. to the end
;; of the buffer names (all but one of them).
;; The forward naming method includes part of the file's directory
;; name at the beginning of the buffer name
;; https://www.gnu.org/software/emacs/manual/html_node/emacs/Uniquify.html
(use-package! uniquify
  :config
  (setq uniquify-buffer-name-style 'forward)
)

;; comment / uncomment code
(global-set-key (kbd "C-S-d") 'comment-or-uncomment-region)


;; My company preferences
(use-package! company
  :config
  (setq company-tooltip-limit 20)                      ; bigger popup window
  (setq company-tooltip-align-annotations 't)          ; align annotations to the right tooltip border
  (setq company-idle-delay .2)                         ; decrease delay before autocompletion popup shows
  (setq company-begin-commands '(self-insert-command)) ; start autocompletion only after typing
  (setq company-minimum-prefix-length 1)               ; show options after second character
)

;; Turn on cua-mode for advanced rectangle selection
(setq cua-rectangle-mark-key (kbd "C-x SPC"))
(cua-selection-mode t)
(cua-mode t)
(setq cua-enable-cua-keys nil)

;; Don't use hard tabs
(setq-default indent-tabs-mode nil)

;; function to replace tabs in a buffer with 2 spaces
(defun die-tabs ()
  (interactive)
  (set-variable 'tab-width 2)
  (mark-whole-buffer)
  (untabify (region-beginning) (region-end))
  (keyboard-quit))


(defun toggle-comment-on-line ()
  "comment or uncomment current line"
  (interactive)
  (comment-or-uncomment-region (line-beginning-position) (line-end-position)))
(global-set-key (kbd "C-;") 'toggle-comment-on-line)


;; use special tool for indented blocks syntax
(use-package! indent-tools
  :bind
  ("C-c c n" .  indent-tools-hydra/body)
  )


;;; Python-mode settings

(map! :map python-mode-map
      "C-c C-n" #'flycheck-next-error)

(add-hook! python-mode #'rainbow-delimiters-mode)

;;; Org-mode setup

;; set the default org files location
(setq org-directory "/mnt/c/Users/raicevim/OneDrive - Co-Operative Bulk Handling Ltd/org/")
(setq org-journal-file-type `weekly)
(setq org-journal-file-header "#+TITLE: Weekly Journal\n#+STARTUP: folded")

;;; ESS for R settings

(defun R-key-chord-mode ()
  (key-chord-mode 1)
  (key-chord-define-local ">>" "%>%")
)
(add-hook! ess-mode (R-key-chord-mode))
(add-hook! inferior-ess-mode (R-key-chord-mode))

(map! :map ess-mode-map
      "M--" "<-")
(map! :map inferior-ess-mode-map
      "M--" "<-")

(add-hook! python-mode #'rainbow-delimiters-mode)
