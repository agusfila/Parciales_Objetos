%Días de cursadas (toda materia que se dicte ofrece al menos una opción horaria)
opcionHoraria(paradigmas, lunes).
opcionHoraria(paradigmas, martes).
opcionHoraria(paradigmas, sabados).
opcionHoraria(algebra, lunes).
opcionHoraria(analisis1,lunes).
opcionHoraria(analisis2,martes).
opcionHoraria(algoritmos,viernes).

%Correlatividades
correlativa(paradigmas, algoritmos).
correlativa(paradigmas, algebra).
correlativa(analisis2, analisis1).

%cursada(persona,materia,evaluaciones)
cursada(maria,algoritmos,[parcial(5),parcial(7),tp(mundial,bien)]).
cursada(maria,algebra,[parcial(5),parcial(8),tp(geometria,excelente)]).
cursada(maria,analisis1,[parcial(9),parcial(4),tp(gauss,bien), tp(limite,mal)]).
cursada(wilfredo,paradigmas,[parcial(7),parcial(7),parcial(7),tp(objetos,excelente),tp(logico,excelente),tp(funcional,excelente)]).
cursada(wilfredo,analisis2,[parcial(8),parcial(10)]).

notaFinal(Evaluaciones,NotaFinal) :-
	cursada(_,_,Evaluaciones),
	findall(Nota,(member(Evaluacion,Evaluaciones),nota(Evaluacion,Nota)),Notas),
	length(Notas,CantEvaluaciones),
	sumlist(Notas,NotasTotal),
	NotaFinal is NotasTotal // CantEvaluaciones.

nota(parcial(Nota),Nota).
nota(tp(_,excelente),10).
nota(tp(_,bien),7).
nota(tp(_,mal),2).

aprobo(Persona,Materia) :-
	cursada(Persona,Materia,Evaluaciones),
	notaFinal(Evaluaciones,NotaFinal),
	NotaFinal >= 4,
	forall((member(Evaluacion,Evaluaciones),nota(Evaluacion,Nota)),Nota >= 4).

puedeCursar(Alumno,Materia) :-
	cursada(_,Materia,_),
	cursada(Alumno,_,_),
	not(aprobo(Alumno,Materia)),
	forall(correlativa(Materia,OtraMateria),aprobo(Alumno,OtraMateria)).

opcionesDeCursada(Alumno,opcion(Materia,Dia)) :-
	puedeCursar(Alumno,Materia),
	opcionHoraria(Materia,Dia).

hola(Opciones,Cursada) :-
	sinSuperposiciones(Opciones,Cursada).

sinSuperposiciones([opcion(Materia,Dia) | Opciones],Cursada) :-
	member(_,Cursada),
	opcionHoraria(Materia,Dia),
	not(member(opcion(Materia,Dia),Cursada)),
	append([opcion(Materia,Dia)],Cursada,NuevaCursada),
	sinSuperposiciones(Opciones,NuevaCursada).
sinSuperposiciones([],Cursada) :-
	member(_,Cursada).
