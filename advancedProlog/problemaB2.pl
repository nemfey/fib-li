%ESTADO
%[numMisIzq, numCanIzq, numMisDer, numCanDer, canoa]; Objetivo 3 misioneros y 3 canibales en derecha

main:- EstadoInicial = [3,3,0,0,1], EstadoFinal = [0,0,3,3,2],
    between(1,1000,CosteMax),   % Buscamos soluciónn de coste 0; si no, de 1, etc.
    camino( CosteMax, EstadoInicial, EstadoFinal, [EstadoInicial], Camino ),
    reverse(Camino,Camino1), write(Camino1), write(" con coste "), write(CosteMax), nl, halt.

camino( 0, E,E, C,C ).  % Caso base: cuando el estado actual es el estado final.
camino( CosteMax, EstadoActual, EstadoFinal, CaminoHastaAhora, CaminoTotal ):-
    CosteMax>0,
    unPaso( CostePaso, EstadoActual, EstadoSiguiente ), % En B.1 y B.2, CostePaso es 1.
    \+member( EstadoSiguiente, CaminoHastaAhora ),
    CosteMax1 is CosteMax-CostePaso,
    camino(CosteMax1,EstadoSiguiente,EstadoFinal, [EstadoSiguiente|CaminoHastaAhora], CaminoTotal).

% unPaso (CostePaso, EstadoActual, EstadoSiguiente)

%1 o 2 misioneros de Izquierda a Derecha
unPaso(1, [MI, CI, MD, CD, 1], [MI2, CI, MD2, CD, 2]):-
        member(N, [1,2]),
        MI2 is MI - N,
        MD2 is MD + N,
        MI2 >= 0, MD2 =< 3, (MI2 >= CI ; MI2==0), (MD2 >= CD ; MD2==0).

%1 o 2 canibales de Izquierda a Derecha
unPaso(1, [MI, CI, MD, CD, 1], [MI, CI2, MD, CD2, 2]):-
        member(N, [1,2]),
        CI2 is CI - N,
        CD2 is CD + N,
        CI2 >= 0, CD2 =< 3, (MI >= CI2 ; MI==0), (MD >= CD2 ; MD==0).
        
%1 misionero + 1 canibal de Izquierda a Derecha
unPaso(1, [MI, CI, MD, CD, 1], [MI2, CI2, MD2, CD2, 2]):-
        MI2 is MI - 1, MD2 is MD + 1,
        CI2 is CI - 1, CD2 is CD + 1,
        MI2 >= 0, MD2 =< 3, CI2 >= 0, CD2 =< 3, (MI2 >= CI2 ; MI2==0), (MD2 >= CD2 ; MD2==0).
        
%1 o 2 misioneros de Derecha a Izquierda
unPaso(1, [MI, CI, MD, CD, 2], [MI2, CI, MD2, CD, 1]):-
        member(N, [1,2]),
        MD2 is MD - N,
        MI2 is MI + N,
        MD2 >= 0, MI2 =< 3, (MI2 >= CI ; MI2==0), (MD2 >= CD ; MD2==0).

%1 o 2 canibales de Derecha a Izquierda
unPaso(1, [MI, CI, MD, CD, 2], [MI, CI2, MD, CD2, 1]):-
        member(N, [1,2]),
        CD2 is CD - N,
        CI2 is CI + N,
        CD2 >= 0, CI2 =< 3, (MI >= CI2 ; MI==0), (MD >= CD2 ; MD==0).
        
%1 misionero + 1 canibal de Derecha a Izquierda
unPaso(1, [MI, CI, MD, CD, 2], [MI2, CI2, MD2, CD2, 1]):-
        MD2 is MD - 1, MI2 is MI + 1,
        CD2 is CD - 1, CI2 is CI + 1,
        MD2 >= 0, MI2 =< 3, CD2 >= 0, CI2 =< 3, (MI2 >= CI2 ; MI2==0), (MD2 >= CD2 ; MD2==0).
