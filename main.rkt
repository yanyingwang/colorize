#lang racket/base

(module+ test
  (require rackunit))

;; Notice
;; To install (from within the package directory):
;;   $ raco pkg install
;; To install (once uploaded to pkgs.racket-lang.org):
;;   $ raco pkg install <<name>>
;; To uninstall:
;;   $ raco pkg remove <<name>>
;; To view documentation:
;;   $ raco docs <<name>>
;;
;; For your convenience, we have included a LICENSE.txt file, which links to
;; the GNU Lesser General Public License.
;; If you would prefer to use a different license, replace LICENSE.txt with the
;; desired license.
;;
;; Some users like to add a `private/` directory, place auxiliary files there,
;; and require them in `main.rkt`.
;;
;; See the current version of the racket style guide here:
;; http://docs.racket-lang.org/style/index.html

;; Code here


(require racket/dict)
(provide colorize
         colorize/codes)

(define (colorize str [color 'default]
                  #:background [background 'default]
                  #:style [style 'default])

  (string-append "\033["
                 (dict-ref (colorize/codes 'style) style)
                 ";"
                 (dict-ref (colorize/codes 'fg-color) color)
                 ";"
                 (dict-ref (colorize/codes 'bg-color) background)
                 "m"
                 str
                 "\033[0m"))

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
      [(fg-color "foreground color") fg-color-codes]
      [(background bg-color  "background color") bg-color-codes]
      ['style style-codes]
      [else `((color . ,fg-color-codes)
              (background . ,bg-color-codes)
              (style . ,style-codes))])))



(module+ test
  ;; Any code in this `test` submodule runs when this file is run using DrRacket
  ;; or with `raco test`. The code here does not run when this file is
  ;; required by another module.

  (check-equal? (+ 2 2) 4))

(module+ main
  ;; (Optional) main submodule. Put code here if you need it to be executed when
  ;; this file is run using DrRacket or the `racket` executable.  The code here
  ;; does not run when this file is required by another module. Documentation:
  ;; http://docs.racket-lang.org/guide/Module_Syntax.html#%28part._main-and-test%29

  (require racket/cmdline)
  (define who (box "world"))
  (command-line
    #:program "my-program"
    #:once-each
    [("-n" "--name") name "Who to say hello to" (set-box! who name)]
    #:args ()
    (printf "hello ~a~n" (unbox who))))
