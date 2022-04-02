%%%% PROCEDURES %%%%
pert(X,[X|_]).
pert(X,[_|L]):- pert(X,L).

concat([],L,L).
concat([X|L1],L2,[X|L3]):- concat(L1,L2,L3).

pert_con_resto(X,L,Resto):- concat(L1,[X|L2],L), concat(L1,L2,Resto).

permutacion([],[]).
permutacion(L,[X|P]):- pert_con_resto(X,L,R), permutacion(R,P).


%%%% EXERCISE 1 %%%%
prod([], 1).
prod([X|XS], P) :- prod(XS, P1),  P is X * P1.


%%%% EXERCISE 2 %%%%
pescalar([], [], 0).
pescalar([X|XS], [Y|YS], P):- pescalar(XS, YS, P1), P is X*Y + P1.


%%%% EXERCISE 3 %%%%
intersection([],_,[]).
intersection([X|XS],YS,[X|L]):- pert(X,YS), !, intersection(XS,YS,L).
intersection([_|XS],YS,L):- intersection(XS,YS,L).

union([], YS, YS).
union([X|XS], YS, L):- member(X,YS), !, union(XS, YS, L).
union([X|XS], YS, [X|L]):- union(XS, YS, L).


%%%% EXERCISE 4 %%%%
last(L,X):- concat(_,[X],L).

reverse([],[]).
reverse([X|XS],L):- reverse(XS,L1), concat(L1,[X],L).


%%%% EXERCISE 5 %%%%
fib(1,1).
fib(2,1).
fib(N,F):- N > 2, N1 is N-1, N2 is N-2, fib(N1,F1), fib(N2,F2), F is F1 + F2.


%%%% EXERCISE 6 %%%%
dados(0,0,[]).
dados(P,N,[X,XS]):- N > 0, pert(X,[1,2,3,4,5,6]), P1 is P-X, N1 is N-1, dados(P1,N1,XS).


%%%% EXERCISE 7 %%%%
is_suma([],0).
is_suma([L|LS],X):- is_suma(LS,X1), X is X1+L.

suma_demas(L):- pert_con_resto(X,L,R), is_suma(R,X), !.


%%%% EXERCISE 8 %%%%
suma_ants(L):- concat(L1,[X|_],L), is_suma(L1,X), !.


%%%% EXERCISE 9 %%%%
card([],[]).
card([X|L], [[X,N1]|Cr]):- card(L,C), pert_con_resto([X,N],C,Cr), !, N1 is N+1.
card([X|L], [[X,1]|C]):- card(L,C).
card(L):- card(L,C), write(C).


%%%% EXERCISE 10 %%%%
esta_ordenada([]).
esta_ordenada([_]):- !.
esta_ordenada([X,Y|XS]):- X =< Y, esta_ordenada([Y|XS]).


%%%% EXERCISE 11 %%%%
ord(L1,L2):- permutacion(L1,L2), esta_ordenada(L2).


%%%% EXERCISE 12 %%%%
nperts(_,0,[]):- !.
nperts(L,N,[X|S]):- pert(X,L), N1 is N-1, nperts(L,N1,S).

escribir([]):- write(' '), nl, !.
escribir([X|L]):- write(X), escribir(L).

diccionario(A,N):- nperts(A,N,S), escribir(S), fail.


%%%% EXERCISE 13 %%%%
es_palindromo([]).
es_palindromo([_]):- !.
es_palindromo([X|L]):- concat(L1,[X],L), es_palindromo(L1).

palindromos(L):- setof(P,(permutacion(L,P), es_palindromo(P)),S), write(S).


%%%% EXERCISE 14 %%%%
suma([], [], [], [], C, C).
suma([X1|L1], [X2|L2], [X3|L3], Cin, Cout):- 	X3 is (X1 + X2 + Cin) mod 10,
						C is (X1 + X2 + Cin) // 10,
						suma(L1,L2,L3,C,Cout).
						
send_more_money:-
	L = [S, E, N, D, M, O, R, Y, _, _],
	permutacion(L, [0,1,2,3,4,5,6,7,8,9]),
	suma([D, N, E, S], [E, R, O, M], [Y, E, N, O], 0, M),
	
	write('S = '), write(S), nl,
	write('E = '), write(E), nl,
	write('N = '), write(N), nl,
	write('D = '), write(D), nl,
	write('M = '), write(M), nl,
	write('O = '), write(O), nl,
	write('R = '), write(R), nl,
	write('Y = '), write(Y), nl,
	write(' '), write([S, E, N, D]), nl,
	write(' '), write([M, O, R, E]), nl,
	write('--------------------'), nl,
	write([M, O, N, E, Y]), nl.


%%%% EXERCISE 15 %%%%
unpaso(A+B, A+C):- unpaso(B,C), !.
unpaso(B+A, C+A):- unpaso(B,C), !.
unpaso(A*B, A*C):- unpaso(B,C), !.
unpaso(B*A, C*A):- unpaso(B,C), !.
unpaso(0*_, 0):- !.
unpaso(_*0, 0):- !.
unpaso(1*X, X):- !.
unpaso(X*1, X):- !.
unpaso(0+X, X):- !.
unpaso(X+0, X):- !.
unpaso(N1+N2, N3):- number(N1), number(N2), N3 is N1+N2, !.
unpaso(N1*N2, N3):- number(N1), number(N2), N3 is N1*N2, !.
unpaso(N1*X+N2*X, N3*X):- number(N1), number(N2), N3 is N1+N2, !.
unpaso(N1*X+X*N2, N3*X):- number(N1), number(N2), N3 is N1+N2, !.
unpaso(X*N1+N2*X, N3*X):- number(N1), number(N2), N3 is N1+N2, !.
unpaso(X*N1+X*N2, N3*X):- number(N1), number(N2), N3 is N1+N2, !.

simplifica(E, E1):- unpaso(E,E2), !, simplifica(E2,E1).
simplifica(E,E).


%%%% EXERCISE 16 %%%%
p([],[]).
p(L,[X,P]):- select(X,L,R), p(R,P).

dom(L):- p(L,P), ok(P), write(P), nl.
dom(_):- write('no hay cadena'), nl.


%%%% EXERCISE 17 %%%%
%sat(I, []):- write('IT IS SATISFIABLE. Model: '), write(I), nl, !.
%sat(I, F):-
%	decision_lit(F,Lit),
%	simplif(Lit,F,F1),
%	sat(...,...).

%p:- readclauses(F), sat([],F).
%p:- write('UNSAT'), nl.


%%%% EXERCISE 18 %%%%



%%%% EXERCISE 19 %%%%



%%%% EXERCISE 20 %%%%
flatten([], []):- !.
flatten(X, [X]):- X \= [_|_].
flaten([L|List],Flist):- flatten(L,L2), flatten(List,List2), append(L2,List2,Flist).


%%%% EXERCISE 21 %%%%



%%%% EXERCISE 22 %%%%



















