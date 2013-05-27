---+ Name

=thousands= - Thousands separator for large integers

---+ Synopsis

This module is *deprecated* now that SWI-Prolog supports
digit groups for large integers.  See the "Syntax Notes"
section of the SWI-Prolog manual.

==
:- use_module(library(thousands)).
main :-
    Seconds is 32 * 365 * n(86,400),
    Seconds =:= n(1,009,152,000),
    format('32 years in seconds: ~D~n', [n(1,009,152,000)]).
==

---+ Description

A Prolog macro for specifying
*|large numbers with a thousands separator|*.
For example, instead of writing this:

==
format('32 years in seconds: ~D~n', [1009152000]).
==

One can write this

==
format('32 years in seconds: ~D~n', [n(1,009,152,000)]).
==

The extra commas help one visually parse the number and its
relative magnitude.

---+ Installation

Using SWI-Prolog 6.3 or later:

==
    $ swipl
    1 ?- pack_install(thousands).
==
