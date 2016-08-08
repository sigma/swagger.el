;;; swagger-common.el ---                            -*- lexical-binding: t; -*-

;; Copyright (C) 2016  Yann Hodique

;; Author: Yann Hodique <yann.hodique@gmail.com>
;; Keywords:

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;;

;;; Code:

(require 's)
(require 'marshal)

;;;###autoload
(defun swagger-marshal-default-spec (slot)
  (let ((slot-name (symbol-name slot)))
    (list (cons 'json
                (intern (s-lower-camel-case slot-name))))))

;;;###autoload
(defmacro swagger-defclass (name superclass slots &rest options-and-doc)
  (declare (debug t) (indent 2))
  `(marshal-defclass ,name ,superclass ,slots ,@options-and-doc
                     :marshal-default-spec swagger-marshal-default-spec))


(provide 'swagger-common)
;;; swagger-common.el ends here
