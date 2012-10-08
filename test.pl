:- use_module(nice_numbers).

main :-
    format('Thousands: ~D~n', [n(4,321)]),
    X = n(9,876,543),
    (   format('Millions: ~D~n', [X])
    ;   format('Math: ~d~n', [n(10*X)])
    ).

fib(0, 1) :- !.
fib(1, 1) :- !.
fib(N, FibN) :-
    fib(n(N-1), N1),
    fib(n(N-2), N2),
    FibN is N1 + N2.

factorial(1, 1) :- !.
factorial(N, Nfac) :-
    N > 0,
    factorial(n(N-1), N1),
    Nfac is N*N1.
