% 3 Laberinto de Tolkien
% Dado un laberinto formado por celdas comunicadas y en las que se enecuentran determinados objetos,
% o personajes, es necesario encontrar un trayecto desde la celda de entrada hasta la celda de salida, 
% de forma que se eviten los peligros ( a los bandidos y a los malignos trolls) y recogiendo el tesoro 
% (o a la doncella o a ambos, como se desee programar).
% Para formalizar la estructura del laberinto se utiliza el predicado contiguo (X,Y) indicando
% que X es una celda contigua a Y. Los nombres de las celdas, son su contenido y se formalizan como símbolos 
% de constante: {entrada, salida, limbo, doncella, fuente, trolls, comida, bandidos, tesoro }.
% La forma de entender el laberinto es que se puede pasar de una celda a otra si estas son contiguas, luego la
% contiguedad es bidireccional. Para no tener que duplicar los predicados contiguo para reflejar esta caracteristica, 
% se define un nuevo predicado del lenguaje del problema: pasar(X,Y) que se lee "de la celda X se puede pasar a la celda Y",
% que será cierto si ambas son contiguas.

% Limbo lo voy a interpretar como una celda vacia

% Relaciones contiguas entre las celdas del laberinto basado en el dibujo
pasar(limbo, fuente).
pasar(fuente, entrada).
pasar(fuente, doncella).
pasar(fuente, comida).
pasar(fuente, bandidos).
pasar(doncella, salida).
pasar(entrada, trolls).
pasar(comida, tesoro).
pasar(bandidos, tesoro).
pasar(salida, tesoro).
pasar(trolls, tesoro).
pasar(limbo, fuente).
pasar(fuente, limbo).
pasar(fuente, entrada).
pasar(entrada, fuente).
pasar(fuente, doncella).
pasar(doncella, fuente).
pasar(fuente, comida).
pasar(comida, fuente).
pasar(fuente, bandidos).
pasar(bandidos, fuente).
pasar(doncella, salida).
pasar(salida, doncella).
pasar(entrada, trolls).
pasar(trolls, entrada).
pasar(comida, tesoro).
pasar(tesoro, comida).
pasar(bandidos, tesoro).
pasar(tesoro, bandidos).
pasar(salida, tesoro).
pasar(tesoro, salida).
pasar(trolls, tesoro).
pasar(tesoro, trolls).

% Peligros
peligro(trolls).
peligro(bandidos).

% Celda segura
segura(Celda) :- not(peligro(Celda)).

% Celdas contiguas se pueden usar
conectada(Celda1, Celda2) :- pasar(Celda1, Celda2); pasar(Celda2, Celda1).

% Encuentra un camino seguro entre dos celdas
encontrar_camino_seguro(Inicio, Destino, Camino) :-
    encontrar_camino_seguro(Inicio, Destino, [Inicio], Camino).

encontrar_camino_seguro(Destino, Destino, Visitadas, Camino) :-
    reverse(Visitadas, Camino).

encontrar_camino_seguro(Actual, Destino, Visitadas, Camino) :-
    conectada(Actual, Siguiente),
    segura(Siguiente),
    not(member(Siguiente, Visitadas)),
    encontrar_camino_seguro(Siguiente, Destino, [Siguiente|Visitadas], Camino).

% Busca todos los caminos seguros entre dos celdas, 
% comenzando por la celda inicial y realizando la búsqueda recursiva a través de las celdas conectadas y seguras hasta llegar a la celda destino.
% Entonces para ese camino y comprueba todos los posibles.

% Definición del predicado que encuentra todos los caminos seguros entre dos celdas
encontrar_todos_los_caminos_seguros(Inicio, Destino, Caminos) :-
    findall(Camino, encontrar_camino_seguro(Inicio, Destino, Camino), CaminosSeguros),
    list_to_set(CaminosSeguros, Caminos).

% findall -> encuentra Camino, con el predicado que sea seguro, recoge un listado de caminos seguros.
% list_to_set  -> elimina duplicados
