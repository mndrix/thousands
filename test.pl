:- use_module(thousands).

main :-
    format('Thousands: ~D~n', [n(4,321)]),
    X = n(9,876,543),
    format('Millions: ~D~n', [X]).
