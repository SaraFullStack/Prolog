% EJERCICIO: 3.5.2 (PAG- 156)
% Escribir un programa que gestione una biblioteca, con libros prestados a una persona y responda a las consultas: 
% ¿Que libros hay prestados? ¿quien tiene algun libro prestado? y ¿qué libros se pueden prestar? 
% Modificar esta primera versión para incluir la fecha del prestado y la de su devolución (10 días),
% para conocer en cada momento si hay algun préstamo fuera de plazo. 

% Libros disponibles
libro('Harry Potter').
libro('El señor de los anillos').
libro('La historia interminable').
libro('El hobbit').

% Préstamos realizados
% préstamo(Libro, Persona, Fecha de préstamo, Fecha de devolución)
prestamo('Harry Potter', 'Sara', date(2023, 4, 1), date(2023, 4, 12)).
prestamo('El señor de los anillos', 'María', date(2023, 3, 20), date(2023, 3, 30)).
prestamo('La historia interminable', 'Miguel', date(2023, 3, 25), date(2023, 4, 5)).

% ¿Que libros hay prestados?
libros_prestados(Persona, Libros) :-
    findall(Libro, prestamo(Libro, Persona, _, _), Libros).

% _ significa que no debe buscar por esos valores en este caso las fechas

% ¿quien tiene algun libro prestado?
persona_prestamo(Libro, Persona) :-
    prestamo(Libro, Persona, _, _).

% ¿qué libros se pueden prestar? 
libros_disponibles(Libros) :-
    findall(Libro, (libro(Libro), \+prestamo(Libro, _, _, _)), Libros).

% \+ es parecido a ! en otros lenguajes pero puede ayudar también a evitar el backtraking. Sirve para la negación. (Libros que no se han prestado)
% Estructura seguida: findall(Variable que devuelve, Lo que evalua, Lista)

% Modificar esta primera versión para incluir la fecha del prestado y la de su devolución (10 días), para conocer en cada momento si hay algun préstamo fuera de plazo. 

prestamo_fuera_de_plazo(Libro) :-
    prestamo(Libro, _, FechaPrestamo, FechaDevolucion),
    FechaDevolucion \= no,
    date_time_stamp(FechaDevolucion, UnixDevolucion),
    date_time_stamp(FechaPrestamo, UnixPrestamo),
    Diferencia is UnixDevolucion - UnixPrestamo,
    Diferencia > 864000. 
    
% 864000 segundos son 10 días, he convertido las fechas para no importar librerías de control de fechas.
% \= es lo mismo que == 
% Valida los que no tienen fecha de devolución y lleven mas de 10 días

