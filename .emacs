(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(inhibit-startup-screen t))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )

;; 设置库加载路径
(setq load-path (cons "~/.emacs.d" load-path))

;;-------------------- 完美多窗口 -----------------
(require 'window-numbering)
(window-numbering-mode 1)

;; 启用winner-mode (www.emacswiki.org/emacs/WinnerMode)
(when (fboundp 'winner-mode)
  (winner-mode 1))
(global-set-key (kbd "C-x 4 u") 'winner-undo)
(global-set-key (kbd "C-x 4 r") 'winner-redo)
;; -------------------完美多窗口--------------------

;;--------------------Evil模式---------------------
(add-to-list 'load-path "~/.emacs.d/evil")
(require 'evil)
(evil-mode 1)
;;--------------------Evil模式---------------------

;; 显示行号
(global-linum-mode 1)
(setq linum-format "%d ")  ;set format

;; 平滑滚动模式
(require 'smooth-scroll)
(smooth-scroll-mode t)
(global-set-key [(control  down)]  'scroll-up-1)
(global-set-key [(control  up)]    'scroll-down-1)
(global-set-key [(control  left)]  'scroll-right-1)
(global-set-key [(control  right)] 'scroll-left-1)

;; 在英文环境下使用ibus输入法
(add-to-list 'load-path "~/.emacs.d/ibus")
(require 'ibus)
;; Turn on ibus-mode automatically after loading .emacs
(add-hook 'after-init-hook 'ibus-mode-on)
;; Change cursor color depending on IBus status
(setq ibus-cursor-color '("red" "blue" "limegreen"))
;; 输入法与设定mark的快捷键冲突，这里修改下set-mark的快捷键
(global-set-key (kbd "M-SPC") 'set-mark-command)

;; Ctrl+滚轮调整字体大小
(global-set-key (kbd "<C-mouse-4>") 'text-scale-increase)
(global-set-key (kbd "<C-mouse-5>") 'text-scale-decrease)

;; 高亮变量
(require 'highlight-symbol)
(global-set-key [f6] 'highlight-symbol-at-point)
(global-set-key [f5] 'highlight-symbol-next)
(global-set-key [(shift f5)] 'highlight-symbol-prev)

;; To auto-start Smex every time you open Emacs
(require 'smex)
(smex-initialize)
;; Bind some keys
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
;; This is your old M-x
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)


;; Make mark visible at all times
;; Author: Patrick Gundlach 
;; nice mark - shows mark as a highlighted 'cursor' so user 'always' 
;; sees where the mark is. Especially nice for killing a region.

(defvar pg-mark-overlay nil
  "Overlay to show the position where the mark is") 
(make-variable-buffer-local 'pg-mark-overlay)

(put 'pg-mark-mark 'face 'secondary-selection)

(defvar pg-mark-old-position nil
  "The position the mark was at. To be able to compare with the
current position")

(defun pg-show-mark () 
  "Display an overlay where the mark is at. Should be hooked into 
activate-mark-hook" 
  (unless pg-mark-overlay 
    (setq pg-mark-overlay (make-overlay 0 0))
    (overlay-put pg-mark-overlay 'category 'pg-mark-mark))
  (let ((here (mark t)))
    (when here
      (move-overlay pg-mark-overlay here (1+ here)))))

(defadvice  exchange-point-and-mark (after pg-mark-exchange-point-and-mark)
  "Show visual marker"
  (pg-show-mark))

(ad-activate 'exchange-point-and-mark)
(add-hook 'activate-mark-hook 'pg-show-mark)
;;; Visible mark end here


;; Expand region
(add-to-list 'load-path "~/.emacs.d/expand-region")
(require 'expand-region)
(global-set-key (kbd "C-=") 'er/expand-region)


;; Auto Mark
;; need auto-mark.el
(when (require 'auto-mark nil t)
  (setq auto-mark-command-class-alist
        '((anything . anything)
          (goto-line . jump)
          (indent-for-tab-command . ignore)
          (undo . ignore)))
  (setq auto-mark-command-classifiers
        (list (lambda (command)
                (if (and (eq command 'self-insert-command)
                         (eq last-command-char ? ))
                    'ignore))))
  (global-auto-mark-mode 1))
;;; Auto mark end here

;;; Make ibuffer default
(defalias 'list-buffers 'ibuffer)

;;; Make ido-mode default for switching buffer
(ido-mode 1)

;;; Switching Next/Previous User Buffers
(defun next-user-buffer ()
  "Switch to the next user buffer.
User buffers are those whose name does not start with *."
  (interactive)
  (next-buffer)
  (let ((i 0))
    (while (and (string-match "^*" (buffer-name)) (< i 50))
      (setq i (1+ i)) (next-buffer) )))

(defun previous-user-buffer ()
  "Switch to the previous user buffer.
User buffers are those whose name does not start with *."
  (interactive)
  (previous-buffer)
  (let ((i 0))
    (while (and (string-match "^*" (buffer-name)) (< i 50))
      (setq i (1+ i)) (previous-buffer) )))

(defun next-emacs-buffer ()
  "Switch to the next emacs buffer.
Emacs buffers are those whose name starts with *."
  (interactive)
  (next-buffer)
  (let ((i 0))
    (while (and (not (string-match "^*" (buffer-name))) (< i 50))
      (setq i (1+ i)) (next-buffer) )))

(defun previous-emacs-buffer ()
  "Switch to the previous emacs buffer.
Emacs buffers are those whose name starts with *."
  (interactive)
  (previous-buffer)
  (let ((i 0))
    (while (and (not (string-match "^*" (buffer-name))) (< i 50))
      (setq i (1+ i)) (previous-buffer) )))

(global-set-key (kbd "<C-prior>") 'previous-user-buffer) ; Ctrl+PageUp
(global-set-key (kbd "<C-next>") 'next-user-buffer) ; Ctrl+PageDown
(global-set-key (kbd "<C-S-prior>") 'previous-emacs-buffer) ; Ctrl+Shift+PageUp
(global-set-key (kbd "<C-S-next>") 'next-emacs-buffer) ; Ctrl+Shift+PageDown
;;; Switching Next/Previous User Buffers ends here

;; ELPA package management
(require 'package)
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/packages/")))

;;; tabbar-mode
(add-to-list 'load-path "~/.emacs.d/elpa/tabbar-20110824.1439")
(require 'tabbar)
(tabbar-mode t)

;;; set yes/no to y/n
(fset 'yes-or-no-p 'y-or-n-p)

;;; weibo
(add-to-list 'load-path "~/.emacs.d/weibo.emacs")
(require 'weibo)

(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-items 25)
(global-set-key "\C-x\ \C-r" 'recentf-open-files)

;;; commenter
(add-to-list 'load-path "~/.emacs.d/elpa/evil-nerd-commenter-20130818.2136")
(require 'evil-nerd-commenter)
(evilnc-default-hotkeys)