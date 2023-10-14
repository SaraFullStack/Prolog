animal(X, [mamifero, L]) :- mamifero(X, L), !.
animal(X, [pajaro, L]) :- pajaro(X, L), !.
animal(X, [pez, L]) :- pez(X, L), !.

mamifero(X, [tienepelo, daleche]) :- tiene_pelo(X, si), da_leche(X, si).

pajaro(X, [vuela, ponehuevos]) :- vuela(X, si), pone_huevos(X, si).
pajaro(X, L) :- pinguino(X, L).
pajaro(X, L) :- avestruz(X, L).

pinguino(X, [novuela, ponehuevos, nada]) :- vuela(X, no), pone_huevos(X, si), nada(X, si).

avestruz(X, [novuela, ponehuevos, nonada]) :- vuela(X, no), pone_huevos(X, si), nada(X, no).

vuela(ploco, si).
vuela(poper, no).

pone_huevos(poper, si).
pone_huevos(ploco, si).

tiene_pelo(poper, no).
tiene_pelo(copito_de_nieve, si).

nada(poper, si).
nada(copito_de_nieve, no).

da_leche(copito_de_nieve, si).
da_leche(poper, no).

pez(X, [no_vuela, no_da_leche, nada]) :- vuela(X, no), da_leche(X, no), nada(X, si).
