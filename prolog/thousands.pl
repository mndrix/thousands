:- module(thousands, []).
:- use_module(library(apply), [maplist/3]).

expand_n(n(Thousands, Ones), X) :-
    expand_n(n(0, 0, Thousands, Ones), X).

expand_n(n(Millions, Thousands, Ones), X) :-
    expand_n(n(0, Millions, Thousands, Ones), X).

expand_n(n(Billions, Millions, Thousands, Ones), X) :-
    integer(Billions),
    integer(Millions),
    integer(Thousands),
    integer(Ones),
    X is 1000000000*Billions + 1000000*Millions + 1000*Thousands + Ones.


goal_expansion_loop(T, T) :-  % so `X=n(1,234)` works
    var(T),
    !.
goal_expansion_loop(T0, T) :-
    expand_n(T0, T),  % integer/1 constraints imply nonvar(T0)
    !.
goal_expansion_loop(T0, T) :-  % look for expandable terms inside T0
    nonvar(T0),
    \+ expand_n(T0, _),
    T0 =.. [Functor|Args0],
    maplist(goal_expansion_loop, Args0, Args),
    T =.. [Functor|Args].

% expand n/{2,3,4} macros
user:goal_expansion(T0, T) :-
    (_,_) \= T0,  % ignore conjunction of smaller goals
    (_;_) \= T0,  % ignore disjunction of smaller goals
    thousands:goal_expansion_loop(T0, T).

:- begin_tests(thousands).
test(billions) :-
    1123456789 =:= n(1,123,456,789).
test(millions) :-
    123456789 =:= n(123,456,789).
test(thousands) :-
    123456 =:= n(123,456).

test(nested) :-
    a(9876,b(1234),c(d(6542))) = a(n(9,876),b(n(1,234)),c(d(n(6,542)))).

test(variable) :-
    X = n(9,876,543),
    9876543 =:= X.

test(hundreds_not_expanded) :-
    n(123) =.. [n, 123].
test(variables_not_expanded) :-
    n(A,123) =.. [n, A, 123].
:- end_tests(thousands).
