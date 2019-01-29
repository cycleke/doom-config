;;; private/my/+bindings.el -*- lexical-binding: t; -*-

(map!
 ;; overrides other minor mode keymaps (just for non-evil)
 (:map override ;; general-override-mode-map
   "M-q" #'evil-quit-all
   "M-;" #'+my/insert-semicolon-at-the-end-of-this-line
   "C-M-;" #'+my/delete-semicolon-at-the-end-of-this-line)

 "C-h h" nil
 "C-h C-k" #'find-function-on-key
 "C-h C-f" #'find-function-at-point
 "C-h C-v" #'find-variable-at-point
 "<f8>"    #'describe-mode

 "C-M-o"  #'other-frame
 "C-M-\\" #'indent-region-or-buffer
 "C-`" #'+popup/toggle
 "M-w" #'+workspace/close-window-or-workspace
 "M-a" #'mark-whole-buffer
 "M-c" #'evil-yank
 "M-s" #'evil-write-all
 "M-f" #'swiper
 "C-s" #'swiper
 "M-e" #'+ivy/switch-workspace-buffer
 "M-p" #'counsel-git
 "C-;" #'flyspell-correct-previous-word-generic
 "M-m" #'kmacro-call-macro
 "M-/" #'evilnc-comment-or-uncomment-lines)

(map!
 :gi "C-n" #'next-line
 :gi "C-p" #'previous-line
 :gi "C-b" #'backward-char
 :gi "C-f" #'forward-char
 :gi "C-k" #'kill-line
 :gi "C-d" #'delete-forward-char

 :v "C-r"   #'+my/evil-quick-replace
 :v "<del>" (kbd "\"_d")
 :v "<backspace>" (kbd "\"_d")

 :gnmvi "C-e" #'doom/forward-to-last-non-comment-or-eol
 :gnmvi "C-a" #'doom/backward-to-bol-or-indent
 :gnmvi "M-." #'+lookup/definition

 (:prefix "C-x"
   :n "e"  #'pp-eval-last-sexp)
 (:prefix "C-c"
   :ni "/" #'company-files
   :desc "Text properties at point" :nmv "f" (λ! (message "%S" (text-properties-at (point))))))

;; leader/localleader is not compatible with :gnvmi
(map! :leader
      :desc "counsel-M-x" :nmv "SPC" #'counsel-M-x
      :desc "lispyville" :n "L" (+my/prefix-M-x "lispyville ")

      (:prefix ("a" . "app")
        "s" #'prodigy
        "b" #'blog-admin-start
        "p" #'list-processes
        "x" #'align-regexp)
      (:prefix "b"                      ; buffer
        :desc "Last buffer"   "l" #'evil-switch-to-windows-last-buffer
        :desc "Switch buffer" "b" #'ivy-switch-buffer
        "h" #'+doom-dashboard/open
        "r" #'revert-buffer-no-confirm
        "U" #'+my/untabify-buffer)
      (:prefix "c"                      ; code
        :desc "Cspell check buffer"    "c" #'cspell-check-buffer
        :desc "Cspell check directory" "C" #'cspell-check-directory)
      (:prefix [tab]
        :desc "Switch workspace" [tab] #'+workspace/switch-to
        :desc "Display tab bar"  "."   #'+workspace/display)
      (:prefix "f"                      ; file
        :desc "Find file" "f" #'counsel-find-file
        :desc "Deer"      "j" #'deer)
      (:prefix "g"                      ; git
        :desc "Magit browse commit" "O" #'+vc/git-browse-commit
        :desc "M-x magit-*" "*" (+my/prefix-M-x "magit-"))
      (:prefix "h"                      ; help
        "C" #'helpful-command)
      (:prefix ("e" . "error")
        :desc "Flymake next error"      "n" #'flymake-goto-next-error
        :desc "Flymake previous error"  "p" #'flymake-goto-prev-error
        :desc "Flymake list errors"     "l" #'flymake-show-diagnostics-buffer
        :desc "Flycheck next error"     "N" #'flycheck-next-error
        :desc "Flycheck previous error" "P" #'flycheck-previous-error
        :desc "Flycheck list errors"    "L" #'flycheck-list-errors
        :desc "Flycheck verify setup"   "V" #'flycheck-verify-setup)
      (:prefix "o"                      ; open
        :desc "Kill ring"             "k" #'helm-show-kill-ring
        :desc "Open link"             "x" #'link-hint-open-link
        :desc "Open link at point"    "X" #'link-hint-open-link-at-point
        :desc "Ansi-Term"             "s" #'+term/open-popup
        :desc "Project run Ansi-Term" "S" #'+term/open-popup-in-project
        :desc "Eshell popup"          "e" #'+eshell/open-popup
        :desc "Project run Eshell"    "E" #'projectile-run-eshell
        :desc "Ibuffer"               "I" #'ibuffer
        :desc "Youdao dictionary"     "y" #'youdao-dictionary-search-at-point-tooltip
        :desc "Youdao play voice"     "Y" #'youdao-dictionary-play-voice-at-point
        :desc "Debugger start"        "d" #'+debugger:start
        (:when IS-MAC
          :desc "Reveal in default program"  "f" #'+macos/open-in-default-program
          :desc "Reveal in Finder"           "o" #'+macos/reveal-in-finder
          :desc "Reveal project in Finder"   "O" #'+macos/reveal-project-in-finder
          :desc "Reveal in Terminal"         "t" #'+macos/reveal-in-terminal
          :desc "Reveal project in Terminal" "T" #'+macos/reveal-project-in-terminal
          :desc "Reveal file in Apps"        "," #'+shell/reveal-in-apps
          :desc "Reveal project in Apps"     "." #'+shell/reveal-project-in-apps)
        (:when IS-LINUX
          :desc "Reveal in default program"  "f" #'+shell/open-in-default-program
          :desc "Reveal in Finder"           "o" #'+shell/reveal-in-finder
          :desc "Reveal project in Finder"   "O" #'+shell/reveal-project-in-finder
          :desc "Reveal in Terminal"         "t" #'+shell/reveal-in-terminal
          :desc "Reveal project in Terminal" "T" #'+shell/reveal-project-in-terminal
          :desc "Reveal file in Apps"        "," #'+shell/reveal-in-apps
          :desc "Reveal project in Apps"     "." #'+shell/reveal-project-in-apps))
      (:prefix "i"                      ; insert
        "v" #'add-dir-local-variable
        "o" #'symbol-overlay-put
        "q" #'symbol-overlay-remove-all)
      (:prefix "p"                      ; project
        "*" (+my/prefix-M-x "projectile-"))
      (:prefix "t"                      ; toggle
        "c" #'centered-window-mode
        "r" #'rjsx-mode
        "d" #'toggle-debug-on-error
        "D" #'+my/realtime-elisp-doc
        "L" #'toggle-truncate-lines
        "S" #'size-indication-mode
        "I" #'ivy-rich-mode
        "v" #'visual-line-mode)
      (:prefix ("j" . "jump")
        "j" #'avy-goto-char-timer
        "l" #'avy-goto-line
        "b" #'avy-pop-mark)
      (:prefix "s"                      ; snippet
        "t" #'yas/describe-tables)
      (:prefix "/"                      ; search
        :desc "Project"   "/" #'+ivy/project-search
        :desc "Project (hidden)" "h" #'+ivy/project-search-with-hidden-files
        :desc "Comments"  "c" #'counsel-imenu-comments))

(map!
 (:map +popup-mode-map
   :n "q" #'quit-window)
 (:after ranger
   (:map ranger-normal-mode-map
     "M-1" nil
     "M-2" nil
     "M-3" nil
     "M-4" nil
     "M-5" nil
     "M-6" nil
     "M-7" nil
     "M-8" nil
     "M-9" nil
     "M-0" nil
     "g" nil
     "q" #'ranger-close-and-kill-inactive-buffers
     "f" #'counsel-find-file
     "M-g" #'ranger-go
     "C-<tab>" #'ranger-next-tab
     "C-S-<tab>" #'ranger-prev-tab
     "U" #'dired-unmark-all-files
     "u" #'dired-unmark
     "(" #'dired-hide-details-mode
     "+" #'dired-create-directory))
 (:after lispy
   (:map lispy-mode-map
     :i "_" #'special-lispy-different
     :i [remap kill-line] #'lispy-kill
     :i [remap delete-backward-char] #'lispy-delete-backward
     :n "M-<left>" #'lispy-forward-barf-sexp
     :n "M-<right>" #'lispy-forward-slurp-sexp
     :n "C-M-<left>" #'lispy-backward-slurp-sexp
     :n "C-M-<right>" #'lispy-backward-barf-sexp))
 (:after lispyville
   (:map lispyville-mode-map
     :n "M-r"   nil
     :n "M-s"   nil
     :n "M-v"   nil
     :n "C-M-r" #'lispy-raise-sexp
     :n "C-M-s" #'lispy-splice
     :n "M-V"   #'lispy-convolute-sexp
     :n "<tab>" #'lispyville-prettify))
 (:after elisp-mode
   :map emacs-lisp-mode-map
   :n "gh" #'helpful-at-point
   :localleader
   :desc "Eval last expression" "e" (λ! (save-excursion (forward-sexp) (eval-last-sexp nil))))
 (:after lsp-ui
   :map lsp-ui-mode-map
   "C-j" #'toggle-lsp-ui-doc
   :nmvi "M-." #'lsp-ui-peek-find-definitions
   :nv "gd" #'lsp-ui-peek-find-definitions
   :nv "gD" #'lsp-ui-peek-find-references)
 (:after lsp-ui-peek
   :map lsp-ui-peek-mode-map
   "h" #'lsp-ui-peek--select-prev-file
   "j" #'lsp-ui-peek--select-next
   "k" #'lsp-ui-peek--select-prev
   "l" #'lsp-ui-peek--select-next-file)
 (:after python
   :localleader
   :map python-mode-map
   :desc "Import at point" "i" #'importmagic-fix-symbol-at-point
   :desc "Import all"      "I" #'importmagic-fix-imports
   (:prefix ("v" . "ENV")
     "c" #'conda-env-activate
     "C" #'conda-env-deactivate
     "w" #'pyvenv-workon
     "v" #'pyvenv-activate
     "V" #'pyvenv-deactivate
     "p" #'pipenv-activate
     "P" #'pipenv-deactivate))
 (:after pyenv-mode
   (:map pyenv-mode-map
     "C-c C-s" nil
     "C-c C-u" nil))
 (:after js2-mode
   (:map js2-mode-map
     :localleader
     :desc "Import js"  "i" 'import-js-import
     :desc "Import all" "f" 'import-js-fix))
 (:after rjsx-mode
   (:map rjsx-mode-map
     :localleader
     :desc "Import js"  "i" 'import-js-import
     :desc "Import all" "f" 'import-js-fix))
 (:after tide
   :map tide-references-mode-map
   "C-k" 'tide-find-previous-reference
   "p" 'tide-find-previous-reference
   "C-j" 'tide-find-next-reference
   "n" 'tide-find-next-reference
   "C-l" 'tide-goto-reference)
 (:after org
   (:map org-mode-map
     "M-t" #'org-todo
     :localleader
     "s" #'org-schedule
     "w" #'org-refile
     "z" #'org-add-note
     "L" #'org-toggle-link-display
     (:prefix ("a" . "Archive")
       "a" #'org-archive-subtree-default
       "s" #'org-archive-subtree)))
 (:after evil-org
   (:map evil-org-mode-map
     :i "C-d" nil
     :i "C-t" nil
     :i "C-h" nil
     :i "C-k" nil))
 (:after markdown-mode
   (:map markdown-mode-map
     :ni [M-return]   (λ! (+org/insert-item 'below))
     :ni [S-M-return] (λ! (+org/insert-item 'above))
     :localleader
     (:when IS-MAC
       :desc "Reveal in Typora" "o" #'+macos/reveal-in-typora)
     (:when IS-LINUX
       :desc "Reveal in Typora" "o" #'+linux/reveal-in-typora)
     :desc "Insert header line"      "-" #'org-table-insert-hline
     :desc "Crete Table from region" "|" #'org-table-create-or-convert-from-region
     :desc "Edit" "x" (+my/simulate-key "C-c C-s")
     (:prefix ("i" . "Insert")
       "r" #'markdown-table-insert-row
       "c" #'markdown-table-insert-column)))
 (:after grep
   :map grep-mode-map
   "SPC" nil)
 (:after ivy
   :map ivy-occur-grep-mode-map
   "SPC" nil
   :map ivy-minibuffer-map
   "<tab>" #'ivy-partial-or-done
   "C-<return>" #'ivy-immediate-done
   "C-b" nil
   "C-j" #'ivy-call-and-recenter
   "C-;" #'ivy-avy
   "C-k" #'ivy-kill-line
   "C-v" #'ivy-scroll-up-command
   "A-v" #'ivy-scroll-down-command
   "M-v" #'yank)
 (:after magit-blame
   (:map magit-blame-mode-map
     :n "o" #'magit-blame--git-link-commit))
 (:after git-rebase
   (:map git-rebase-mode-map
     "M-j" #'git-rebase-move-line-down
     "M-k" #'git-rebase-move-line-up
     "SPC" nil))
 (:after evil-vars
   :map evil-ex-completion-map
   "C-b" nil
   "C-k" #'kill-line
   "C-d" #'delete-forward-char)
 (:after evil-collection-info
   :map Info-mode-map
   "/" #'Info-search
   "?" #'Info-search-backward)
 (:after company
   (:map company-active-map
     ;; Don't interfere with `evil-delete-backward-word' in insert mode
     "C-v"   #'company-next-page
     "A-v"   #'company-previous-page
     "<tab>" nil
     "C-j"   #'company-show-location
     "C-i"   #'company-complete-selection))
 (:after term
   (:map term-raw-map
     :i "M-v" #'term-paste)))
