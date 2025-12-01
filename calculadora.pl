:- initialization(main).

main :-
    writeln('=== Calculadora simple ==='),
    writeln('Operadores permitidos: +  -  *  /'),
    ciclo_calculadora.

ciclo_calculadora :-
    leer_numero('Ingresa el primer numero: ', N1),
    leer_operador('Ingresa el operador (+, -, *, /): ', Op),
    leer_numero('Ingresa el segundo numero: ', N2),
    (   calcular(N1, Op, N2, Resultado)
    ->  format('~nResultado: ~w ~w ~w = ~w~n', [N1, Op, N2, Resultado])
    ;   writeln('No se pudo realizar el calculo por un error.')
    ),
    preguntar_continuar.


preguntar_continuar :-
    write('¿Desea hacer otro calculo? (s/n): '),
    flush_output,
    read_line_to_string(user_input, Resp),
    (   Resp = "s" ; Resp = "S" )
    ->  nl, ciclo_calculadora
    ;   writeln('Programa finalizado.'), halt.


leer_numero(Mensaje, Numero) :-
    repeat,
        write(Mensaje),
        flush_output,
        read_line_to_string(user_input, Linea),
        (   Linea = ""
        ->  writeln('Error: debes ingresar un numero.'), fail
        ;   catch(number_string(N, Linea), _, fail),
            number(N)
        ->  Numero = N, !
        ;   writeln('Error: formato de numero invalido.'), fail
        ).

leer_operador(Mensaje, Op) :-
    repeat,
        write(Mensaje),
        flush_output,
        read_line_to_string(user_input, Linea),
        (   Linea = "" ->
            writeln('Error: ingresa un operador (+, -, *, /).'), fail
        ;   atom_string(Atom, Linea),
            member(Atom, [+, -, *, /])
        ->  Op = Atom, !
        ;   writeln('Error: operador invalido. Usa +, -, * o /.'),
            fail
        ).

calcular(_, /, 0, _) :-
    writeln('Error: division por cero no permitida.'),
    fail.

calcular(N1, +, N2, R) :- R is N1 + N2.
calcular(N1, -, N2, R) :- R is N1 - N2.
calcular(N1, *, N2, R) :- R is N1 * N2.
calcular(N1, /, N2, R) :- R is N1 / N2.
