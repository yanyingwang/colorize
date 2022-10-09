#lang racket/base

(require "main.rkt")

(provide (all-defined-out))


(define colorize?
  (make-parameter #true))


;; https://no-color.org/

(define NO_COLOR?
  (let ([NO_COLOR
         (getenv "NO_COLOR")])
    (and NO_COLOR (not (equal? "0" NO_COLOR)))))


(define-syntax-rule (colorize-optional str args ...)
  (if (and (colorize?) (not NO_COLOR?))
      (colorize str args ...)
      str))
