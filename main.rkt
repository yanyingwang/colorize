#lang racket/base


(require racket/dict
         racket/string
         racket/contract)

(provide colorize
         colorize/argv
         colorized?)



(define/contract (colorize str [color 'default]
                           #:background [background 'default]
                           #:style [style 'default])
  (->* (string?)
       (symbol?
        #:background symbol?
        #:style symbol?)
       string?)
  (string-append "\033["
                 (dict-ref (colorize/codes 'style) style)
                 ";"
                 (dict-ref (colorize/codes 'fg-color) color)
                 ";"
                 (dict-ref (colorize/codes 'bg-color) background)
                 "m"
                 str
                 "\033[0m"))

(define/contract (colorized? str)
  (-> string?
      boolean?)
  (and (string-prefix? str "\e[") ;"\e[0;31;44m"
       (string-suffix? str  "\e[0m")))

(define (colorize/argv [type 'all])
  (let ([colors (dict-keys (colorize/codes 'fg-color))]
        [styles (dict-keys (colorize/codes 'style))])
    (case type
      [(color background) colors]
      ['style styles]
      ['all `((color ,@colors)
              (style ,@styles))])))

(define (colorize/codes [type 'all])
  (let* ([style-codes '((default . "0")            ; Turn off all attributes
                        (bold . "1")               ; Set bold mode
                        (italic . "3")             ; Set italic mode
                        (underline . "4")          ; Set underline mode
                        (blink . "5")              ; Set blink mode
                        (swap . "7")               ; Exchange foreground and background colors
                        (hide . "8")               ; Hide text (foreground color would be the same as background)
                        )]
         [color-codes '((black . 0)
                        (light-black . 60)
                        (red . 1)
                        (light-red . 61)
                        (green . 2)
                        (light-green . 62)
                        (yellow . 3)
                        (light-yellow . 63)
                        (blue . 4)
                        (light-blue . 64)
                        (magenta . 5)
                        (light-magenta . 65)
                        (cyan . 6)
                        (light-cyan . 66)
                        (white . 7)
                        (light-white . 67)
                        (default . 9))]
         [fg-color-codes (map (lambda (l)
                                `(,(car l) . ,(number->string (+ (cdr l) 30))))
                              color-codes)]
         [bg-color-codes (map (lambda (l)
                                `(,(car l) . ,(number->string (+ (cdr l) 40))))
                              color-codes)])
    (case type
      ['fg-color fg-color-codes]
      ['bg-color bg-color-codes]
      ['style style-codes]
      ['all `((fg-color ,@fg-color-codes)
              (bg-color ,@bg-color-codes)
              (style ,@style-codes))])))
