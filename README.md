Usage
-----

A trivial Prolog macro for specifying **large numbers with a thousands separator**.
For example, instead of writing this:

```prolog
format('32 years in seconds: ~D~n', [1009152000]).
```

One can write this

```prolog
format('32 years in seconds: ~D~n', [n(1,009,152,000)]).
```

The extra commas help one visually parse the number and it's relative magnitude.

Installation
------------

Using SWI-Prolog 6.3 or later:

    $ swipl
    1 ?- pack_install(thousands).