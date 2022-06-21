solution(L):-
    % [numcasa, color, profesión, animal, bebida, país]
    L = [ [1,_,_,_,_,_], [2,_,_,_,_,_], [3,_,_,_,_,_], [4,_,_,_,_,_], [5,_,_,_,_,_] ],
    % 1 - El que vive en la casa roja es de Peú
    member([_,roja,_,_,_,peru], L),
    % 2 - Al francés le gusta el perro
    member([_,_,_,perro,_,francia], L),
    % 3 - El pintor es japonés
    member([_,_,pintor,_,_,japon], L),
    % 4 - Al chino le gusta el ron
    member([_,_,_,_,ron,china], L),
    % 5 - El húngaro vive en la primera casa
    member([1,_,_,_,_,hungria], L),
    % 6 - Al de la casa verde le gusta el coñac
    member([_,verde,_,_,conyac,_], L),
    % 7 - La casa verde está justo a la izquierda de la blanca
    member([A,verde,_,_,_,_], L), A < 5, B is A+1, member([B,blanca,_,_,_,_], L),
    % 8 - El escultor cría caracoles
    member([_,_,escultor,caracol,_,_], L),
    % 9 - El de la casa amarilla es actor
    member([_,amarilla,actor,_,_,_], L),
    % 10 - El de la tercera casa bebe cava
    member([3,_,_,_,cava,_], L),    
    % 11 - El que vive al lado del actor tiene un caballo
    member([C,_,actor,_,_,_], L), Next1 is C+1, Prev1 is C-1, member(D,[Next1,Prev1]), member([D,_,_,caballo,_,_], L),
    % 12 - El húngaro vive al lado de la casa azul
    member([E,_,_,_,_,hungria], L), Next2 is E+1, Prev2 is E-1, member(F,[Next2,Prev2]), member([F,azul,_,_,_,_], L),
    % 13 - Al notario la gusta el whisky
    member([_,_,notario,_,whisky,_], L),
    % 14 - El que vive al lado del médico tiene un ardilla,
    member([G,_,medico,_,_,_], L), Next3 is G+1, Prev3 is G-1, member(H,[Next3,Prev3]), member([H,_,_,ardilla,_,_], L),
    displaySol(L),
    fail.   % fail: para calcular todas las soluciones con backtracking
    

displaySol(L):- member(P,L), write(P), nl, fail.    % fail: cada casa es una línia
displaySol(_).
