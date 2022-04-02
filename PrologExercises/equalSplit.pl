
sum([], 0).
sum([L1|L], X):- sum(L,X1), X is X1 + L1.

perm([],[],[]).
perm([L1|L], [L1|S1], S2):- perm(L, S1, S2).
perm([L1|L], S1, [L1|S2]):- perm(L, S1, S2).

eqSplit(L, S1, S2):- perm(L,S1,S2), sum(S1, X), sum(S2, Y), X == Y.
