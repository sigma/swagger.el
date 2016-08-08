;;; swagger-20.el --- swagger 2.0 spec               -*- lexical-binding: t; -*-

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

(swagger-defclass swagger-20-license ()
  ((name :initarg :name :type string)
   (url :initarg :url)))

(swagger-defclass swagger-20-contact ()
  ((name :initarg :name)
   (url :initarg :url)
   (email :initarg :email)))

(swagger-defclass swagger-20-info ()
  ((title :initarg :title :type string)
   (version :initarg :version :type string)
   (description :initarg :description)
   (terms-of-service :initarg :terms-of-service)
   (license :initarg :license :marshal-type swagger-20-license)
   (contact :initarg :contact :marshal-type swagger-20-contact)))

(swagger-defclass swagger-20-documentation ()
  ())

(swagger-defclass swagger-20-response ()
  ())

(swagger-defclass swagger-20-security ()
  ())

(swagger-defclass swagger-20-operation ()
  ((tags :initarg :tags :marshal-type (list string))
   (summary :initarg :summary)
   (description :initarg :description)
   (external-docs :initarg :external-docs :marshal-type swagger-20-documentation)
   (operation-id :initarg :operation-id)
   (consumes :initarg :consumes :marshal-type (list string))
   (produces :initarg :produces :marshal-type (list string))
   (parameters :initarg :parameters :marshal-type (list swagger-20-parameter))
   (responses :initarg :responses :marshal-type (hash string swagger-20-response))
   (schemes :initarg :schemes :marshal-type (list string))
   (deprecated :initarg :deprecated :marshal-type bool)
   (security :initarg :security :marshal-type (list swagger-20-security))))

(swagger-defclass swagger-20-parameter ()
  ((name :initarg :name)
   (in :initarg :in)
   (description :initarg :description)
   (required :initarg :required :marshal-type bool)))

(swagger-defclass swagger-20-path ()
  (($ref :initarg :$ref)
   (get :initarg :get :marshal-type swagger-20-operation)
   (put :initarg :put :marshal-type swagger-20-operation)
   (post :initarg :post :marshal-type swagger-20-operation)
   (delete :initarg :delete :marshal-type swagger-20-operation)
   (options :initarg :options :marshal-type swagger-20-operation)
   (head :initarg :head :marshal-type swagger-20-operation)
   (patch :initarg :patch :marshal-type swagger-20-operation)
   (parameters :initarg :parameters :marshal-type (list swagger-20-parameter))))

(swagger-defclass swagger-20-spec ()
  ((swagger :initarg :swagger :type string)
   (info :initarg :info :marshal-type swagger-20-info)
   (host :initarg :host)
   (base-path :initarg :base-path)
   (schemes :initarg :schemes :marshal-type (list string))
   (consumes :initarg :consumes :marshal-type (list string))
   (produces :initarg :produces :marshal-type (list string))
   (paths :initarg :paths :marshal-type (hash string swagger-20-path))))

(defun swagger-20-client (json-doc)
  (unmarshal 'swagger-20-spec json-doc 'json))

(provide 'swagger-20)
;;; swagger-20.el ends here
