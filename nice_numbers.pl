:- module(nice_numbers, []).
:- use_module(library(apply), [maplist/3]).

expand_n(n(Thousands, Ones), X) :-
    integer(Thousands),
    integer(Ones),
    X is 1000*Thousands + Ones.

expand_n(n(Millions, Thousands, Ones), X) :-
    integer(Millions),
    integer(Thousands),
    integer(Ones),
    X is 1000000*Millions + 1000*Thousands + Ones.

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
    T0 =.. [Functor|Args0],
    ( Args0=[] -> T = T0
    ; Functor=n -> expand_n(T0, T)
    ; maplist(goal_expansion_loop, Args0, Args),
        T =.. [Functor|Args]
    ).

% expand n/{2,3,4} macros
user:goal_expansion(T0, T) :-
    nice_numbers:goal_expansion_loop(T0, T).


goal_expansion_math(_, T, T) :-
    var(T),
    !.
goal_expansion_math(T is Expression, n(Expression), T) :- !.
goal_expansion_math(Math, T0, T) :-
    T0 =.. [Functor|Args0],
    (   Args0=[] -> T=T0
    ;   maplist(goal_expansion_math(Math), Args0, Args),
        T =.. [Functor|Args]
    ).


% expand n/1 arithmetic macros
user:goal_expansion(T0, (Math,T)) :-
    %format('GOAL: ~w~n', [T0]),
    \+ (_,_) = T0,  % skip conjunction of smaller goals
    \+ (_;_) = T0,  % skip disjunctions of smaller goals
    nice_numbers:goal_expansion_math(Math, T0, T),
    nonvar(Math).
