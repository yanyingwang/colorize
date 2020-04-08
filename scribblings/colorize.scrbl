#lang scribble/manual

@(require (for-label colorize
          #;racket/base
          )
           scribble/eval)

@(define my-eval
   (make-eval-factory '(racket/string colorize)))


@title{colorize}
@author[(author+email "yanyingwang" "yanyingwang1@gmail.com")]
@defmodule[colorize]
@smaller{
Colorize the output text of your console as you wish, source code: @url["https://github.com/yanyingwang/colorzie"].@(linebreak)
@smaller{NOTE: this is a exported version of ruby gem @hyperlink["https://github.com/fazibear/colorize" "colorize"].}
}

@[table-of-contents]


@; --------------------------------------------------------------------------------------------------
@section{Procedure Reference}


@defproc[(colorize [str string?]
                   [color1 symbol?]
                   [#:background color2 symbol?]
                   [#:style style symbol?])
string?]{
Colorize @code{str} with @code{color1} as it's foreground color, @code{color2} as it's background color, and @code{style} as the it's style.
}


@defproc[(colorize/argv [sym symbol?])
list?]{
show a list of value for the @litchar{colorize}'s possible arguments.
}

@defproc[(colorized? [str string?])
boolean?]{
check if #code{str} is colorized or not.
}




@; --------------------------------------------------------------------------------------------------
@section{Usage Example}

@examples[
#:eval (my-eval)
(require colorize)

(colorize/argv 'color)

(colorize "this is a raw red string" 'red)

(code:comment "below is an example about how to display the the red string to your terminal")
(displayln (colorize "this is a raw red string" 'red))

(colorize "this is a raw red string on blue with underline" 'red #:background 'blue #:style 'underline)

(code:comment "a practical usage example shown below:")
(string-join `("\n"
               ,(colorize "Happy" 'light-red)
               ,(colorize "Hacking" 'blue)
               ,(colorize (string-titlecase (getenv "USER")) 'green)
               "-"
               ,(colorize "Racket" 'cyan)
               ,(colorize "♥" 'magenta)
               ,(colorize "You" 'light-magenta)
               ,(colorize "!!!" 'red)
               "\n\n")
             " ")
]
