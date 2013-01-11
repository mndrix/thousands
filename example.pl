#!/usr/bin/env swipl -q -g main -s
:- use_module(thousands).

main(_) :-
    format('Thousands: ~D~n', [n(4,321)]),
    X = n(9,876,543),
    format('Millions: ~D~n', [X]),
    format('32 years in seconds: ~D~n', [n(1,009,152,000)]),

    % from the synopsis
    Seconds is 32 * 365 * n(86,400),
    Seconds =:= n(1,009,152,000),
    format('32 years in seconds: ~D~n', [n(1,009,152,000)]).
