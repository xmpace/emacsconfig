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
(evil-mode 0)
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


