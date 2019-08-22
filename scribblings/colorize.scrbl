#lang scribble/manual
@require[@for-label[colorize]]

@title{colorize}
@author[(author+email "yanyingwang" "yanyingwang1@gmail.com")]

@defmodule[colorize]

colorize you console as you wish, @hyperlink["https://gitlab.com/yanyingwang/chive" "source code"].

NOTE: this is a exported version of ruby gem @hyperlink["https://github.com/fazibear/colorize" "colorize"]


@defproc[(colorize [str string?]
                   [color1 symbol?]
                   [#:background color2 symbol?]
                   [#:style style symbol?])
string?]{
Colorize @code{str} with @code{color1} as the foreground color, @code{color2} as the background, and @code{style} as the font style.

Check the result of @racket[colorize/argv] for the possiable values of arguments.
}


@defproc[(colorize/argv [sym symbol?])
list?]{
Check the result of @racket[colorize/argv] for the possiable values of arguments.
}



@bold{Examples:}
@codeblock[#:keep-lang-line? #f]|{

(colorize/argv 'color)
;=> '(black
; light-black
; red
; light-red
; green
; light-green
; yellow
; light-yellow
; blue
; light-blue
; magenta
; light-magenta
; cyan
; light-cyan
; white
; light-white
; default)

(displayln (colorize "red string" 'red))
;=> red string

(colorize "this is a red string on blue with underline" 'red #:background 'blue #:style 'underline)
;=> "\e[4;31;44mthis is a red string on blue with underline\e[0m"

}|
