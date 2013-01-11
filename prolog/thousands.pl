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


goal_expansion_loop(T, T) :-
    var(T),
    !.
goal_expansion_loop(T0, T) :-
    expand_n(T0, T),
    !.
goal_expansion_loop(T0, T) :-  % look for expandable terms inside T0
    T0 =.. [Functor|Args0],
    maplist(goal_expansion_loop, Args0, Args),
    T =.. [Functor|Args].

% expand n/{2,3,4} macros
user:goal_expansion(T0, T) :-
    \+ (_,_) = T0,  % ignore conjunction of smaller goals
    \+ (_;_) = T0,  % ignore disjunction of smaller goals
    thousands:goal_expansion_loop(T0, T).
