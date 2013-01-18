:- module(thousands, [n/2,n/3,n/4]).
:- use_module(library(function_expansion)).

% The following definitions for n/{2,3,4} are strictly for the
% documentation system.  These macros are expanded away.

%%	n(Thousands, Hundreds:integer).
%
%	Represents an integer less than 1 million.
n(_,_).

%%	n(Millions, Thousands, Hundreds:integer).
%
%	Represents an integer less than 1 billion.
n(_,_,_).

%% n(Billions, Millions,Thousands, Hundreds:integer).
%
%	Represents an integer less than 1 trillion.
n(_,_,_,_).

user:function_expansion(n(Thousands,Ones), X, true) :-
    calc_n(0, 0, Thousands, Ones, X).

user:function_expansion(n(Millions,Thousands,Ones), X, true) :-
    calc_n(0, Millions, Thousands, Ones, X).

user:function_expansion(n(Billions,Millions,Thousands,Ones), X, true) :-
    calc_n(Billions, Millions, Thousands, Ones, X).

calc_n(Billions, Millions, Thousands, Ones, X) :-
    integer(Billions),
    integer(Millions),
    integer(Thousands),
    integer(Ones),
    X is 1000000000*Billions + 1000000*Millions + 1000*Thousands + Ones.

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
