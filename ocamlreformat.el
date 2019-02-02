;;; ocamlreformat.el --- Automatically format an OCaml buffer -*- lexical-binding: t; -*-

;; Copyright (C) 2010  Ludwig PACIFICI

;; Author: Ludwig PACIFICI
;; Homepage: https://github.com/ludwigpacifici/ocamlreformat.el
;; Keywords: convenience, tools
;; Package-Requires: ((emacs "24.3"))

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <https://www.gnu.org/licenses/>.

;;; Commentary:

;; Proof of concept that aims to simplify the Elisp code of
;; `ocamlformat.el' [1] by using the library `reformatter.el' [2].

;; [1]: https://github.com/ocaml-ppx/ocamlformat/blob/master/emacs/ocamlformat.el
;; [2]: https://github.com/purcell/reformatter.el

;;; Code:
(require 'reformatter)

(defcustom ocamlreformat-command "ocamlformat"
  "The `ocamlformat' command."
  :type 'string
  :group 'ocamlreformat)

(defcustom ocamlreformat-enable 'enable
  "Enable or disable OCamlReformat."
  :type '(choice
          (const :tag "Enable" enable)
          (const :tag "Disable outside detected project"
                 disable-outside-detected-project)
          (const :tag "Disable" disable))
  :group 'ocamlreformat)

(defcustom ocamlreformat-margin-mode nil
  "Specify margin when formatting buffer contents."
  :type '(choice
          (const :tag "Window width" window)
          (const :tag "Fill column" fill)
          (const :tag "None" nil))
  :group 'ocamlreformat)

(defun args-from-ocamlreformat-enable (arg)
  (cond
   ((equal arg 'disable)
    (list "--disable"))
   ((equal arg 'disable-outside-detected-project)
    (list "--disable-outside-detected-project"))))

(defun args-from-ocamlreformat-margin-mode (arg)
  (cond
   ((equal arg 'window)
    (list "--margin" (number-to-string (window-body-width))))
   ((equal arg 'fill)
    (list "--margin" (number-to-string fill-column)))))

(defun args-from-ocamlreformat-name (arg)
  (list "--name" arg))

(defun args-from-ocamlreformat-stdin ()
  (list "-"))

(defun flatten (list-of-lists)
  "Convert a list of lists (with one level of nesting) to a list"
  (apply #'append list-of-lists))

(defun make-args ()
  "Generate list of command line arguments for the `ocamlreformat-command'."
  (flatten
   (list
    (args-from-ocamlreformat-enable ocamlreformat-enable)
    (args-from-ocamlreformat-name (buffer-file-name))
    (args-from-ocamlreformat-margin-mode ocamlreformat-margin-mode)
    (args-from-ocamlreformat-stdin))))

(reformatter-define ocamlreformat
                    :program ocamlreformat-command
                    :args (make-args)
                    :group 'ocamlreformat
                    :lighter nil)

;;;###autoload
(define-obsolete-function-alias 'ocamlreformat-before-save 'ocamlreformat-on-save-mode
  "`ocamlreformat-on-save-mode' is provided by
  reformatter.el. `ocamlreformat-before-save' is aliased to the
  former for backward compatibility")

(provide 'ocamlreformat)
;;; reformatter.el ends here
