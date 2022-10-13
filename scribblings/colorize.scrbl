#lang scribble/manual


@(require (for-label colorize colorize/optional racket/base racket/string)
          scribble/eval)

@(define my-eval
   (make-eval-factory '(racket/string colorize colorize/optional)))


@title{colorize}
@author[(author+email "yanyingwang" "yanyingwang1@gmail.com")]
@defmodule[colorize]
Colorize the output text of your console as you wish, @hyperlink["https://github.com/yanyingwang/colorzie" "source code"].
@(linebreak)
@smaller{NOTE: this is a exported version of ruby gem @hyperlink["https://github.com/fazibear/colorize" "colorize"].}


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
(colorize/argv 'style)
(colorize/argv 'all)

(colorize "this is a raw red string" 'red)

(code:comment "below is an example about how to display the the red string to your terminal")
(displayln (colorize "this is a raw red string" 'red))

(colorize "this is a raw red string on blue with underline" 'red
                                                            #:background 'blue
                                                            #:style 'underline)

(code:comment "a practical usage example shown below:")
(string-join `("\n"
               ,(colorize "Happy" 'light-red)
               ,(colorize "Hacking" 'blue)
               ,(colorize (string-titlecase (or (getenv "USER") "user")) 'green)
               "-"
               ,(colorize "Racket" 'cyan)
               ,(colorize "♥" 'magenta)
               ,(colorize "You" 'light-magenta)
               ,(colorize "!!!" 'red)
               "\n\n")
             " ")
]


@section{Optional Colorization}

@defmodule[colorize/optional]

@defparam[colorize? boolean boolean?]{
Parameter used by @racket[colorize-optional].
}

@defthing[NO_COLOR? boolean?]{
True if the environment variable @racket{NO_COLOR}
is set and not equal to @racket[0].
}

@defparam[no-color? boolean boolean?]{
Parameter used by @racket[colorize-optional].
Initial value of this parameter is equal to the value of @racket[NO_COLOR?],
}

@defform[(colorize-optional str arg ...)]{
If @racket[colorize?] is @racket[#true] and @racket[no-color?] is @racket[#false]
then the @racket[str] will be colorized with @racket[colorize].

@racket[arg ...] are the arguments passed down to @racket[colorize].

@examples[
#:eval (my-eval)
(parameterize ([colorize? #false]
               [no-color? #true])
  (colorize-optional "Happy" 'light-red))
]
}
