(setq user-full-name "Harish Chandran")

(setq doom-theme 'doom-dracula)

(setq doom-font (font-spec :family "Fira Code" :size 18))

(setq inhibit-startup-screen t)

(setq display-line-numbers-type nil)

(setq org-agenda-files (list
    "~/org/tasks/tasks.org"))

(setq org-todo-keywords '((sequence "TODO(t)" "IN-PROGRESS(i)" "BLOCKED(b)" "|" "DONE(d)" "KILL(k)")
 (sequence "[ ](T)" "[-](S)" "[?](W)" "|" "[X](D)")))

(defun org-summary-todo (n-done n-not-done)
  "Switch entry to DONE when all subentries are done, to TODO otherwise."
  (let (org-log-done org-log-states)   ; turn off logging
    (org-todo (if (= n-not-done 0) "DONE" "TODO"))))

(add-hook 'org-after-todo-statistics-hook 'org-summary-todo)

(setq org-log-done 'time)

(setq org-export-babel-evaluate nil)

(setq org-startup-folded t)

(define-key evil-normal-state-map ",f" 'counsel-fzf)
(define-key evil-normal-state-map ",rf" 'counsel-recentf)

(define-key evil-normal-state-map ",df" 'describe-functions)
(define-key evil-normal-state-map ",dk" 'describe-key)
(define-key evil-normal-state-map ",dv" 'describe-variable)

(define-key evil-normal-state-map ",oa" 'org-agenda)
(define-key evil-normal-state-map ",os" 'org-schedule)
(define-key evil-normal-state-map ",od" 'org-deadline)
(define-key evil-normal-state-map ",ot" 'org-todo)
(define-key evil-normal-state-map "  " 'org-todo)
(define-key evil-normal-state-map ",rr" 'org-babel-remove-result)

(yas-global-mode 1)

(setq ivy-re-builders-alist '((counsel-rg . ivy--regex-plus)
 (swiper . ivy--regex-plus)
 (swiper-isearch . ivy--regex-plus)
 (t . ivy--regex-fuzzy)))

(package! evil-snipe :disable t)

(evil-put-command-property 'evil-yank-line :motion 'evil-line)
(setq evil-want-change-word-to-end nil)

(setq evil-split-window-bottom t)
(setq evil-vsplit-window-right t)

;; (defgroup evil-custom-textobj nil
;;   "Text object entire buffer for Evil"
;;   :prefix "evil-custom-textobj-"
;;   :group 'evil)

(defcustom evil-custom-textobj-entire-key "d"
  "Key for evil-inner-entire"
  :type 'string
  :group 'evil-custom-textobj)

(defcustom evil-custom-textobj-in-line-key "l"
  "Keys for evil-inner-line"
  :type 'string
  :group 'evil-custom-textobj)

(defcustom evil-custom-textobj-around-line-key "l"
  "Keys for evil-around-line"
  :type 'string
  :group 'evil-custom-textobj)

(defun evil-line-range (count beg end type &optional inclusive)
  (if inclusive
      (evil-range (line-beginning-position) (line-end-position))
    (let ((start (save-excursion
                   (back-to-indentation)
                   (point)))
          (end (save-excursion
                 (goto-char (line-end-position))
                 (skip-syntax-backward " " (line-beginning-position))
                 (point))))
      (evil-range start end))))

(evil-define-text-object evil-custom-entire-buffer (count &optional beg end type)
  "Select entire buffer"
  (evil-range (point-min) (point-max)))

(evil-define-text-object evil-custom-around-line (count &optional beg end type)
  "Select range between a character by which the command is followed."
  (evil-line-range count beg end type t))
(evil-define-text-object evil-custom-inner-line (count &optional beg end type)
  "Select inner range between a character by which the command is followed."
  (evil-line-range count beg end type))

(define-key evil-outer-text-objects-map evil-custom-textobj-entire-key 'evil-custom-entire-buffer)
(define-key evil-inner-text-objects-map evil-custom-textobj-entire-key 'evil-custom-entire-buffer)
(define-key evil-outer-text-objects-map evil-custom-textobj-in-line-key 'evil-custom-around-line)
(define-key evil-inner-text-objects-map evil-custom-textobj-around-line-key 'evil-custom-inner-line)
