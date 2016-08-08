;;; swagger.el --- swagger library for Emacs         -*- lexical-binding: t; -*-

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

(require 'swagger-common)

(swagger-defclass swagger-base-spec ()
  ((swagger :initarg :swagger)
   (swagger-version :initarg :swagger-version)))

(defun swagger-client (json-doc)
  (let ((doc (unmarshal 'swagger-base-spec json-doc 'json)))
    (cond ((equal (oref doc :swagger) "2.0")
           (require 'swagger-20)
           (swagger-20-client json-doc))
          ((equal (oref doc :swagger-version) "1.2")
           (require 'swagger-12)
           (swagger-12-client json-doc))
          (t
           (error "unsupported version")))))

(provide 'swagger)
;;; swagger.el ends here
