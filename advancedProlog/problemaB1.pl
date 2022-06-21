main:- EstadoInicial = [0,0], EstadoFinal = [0,4],
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
% todas las transformaciones tienen coste 1
unPaso(1, [_,M], [5,M] ).     % llenar el cubo con 5 litros
unPaso(1, [N,_], [N,8] ).     % llenar el cubo con 8 litros
unPaso(1, [_,M], [0,M] ).    % vaciar el cubo de 5 litros
unPaso(1, [N,_], [N,0] ).    % vaciar el cubo de 8 litros
unPaso(1, [N,M] ,[N1,M1] ):- Aux is min(N, 8-M), N1 is N - Aux, M1 is M + Aux, N1 >= 0, M1 =< 8.
unPaso(1, [N,M] ,[N1,M1] ):- Aux is min(N-5, M), N1 is N + Aux, M1 is M - Aux, N1 =< 5, M1 >= 8.
    
