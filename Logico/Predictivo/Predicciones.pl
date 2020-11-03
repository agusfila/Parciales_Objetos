% mensaje(ListaDePalabras, Receptor).
%	Los receptores posibles son:
%	Persona: un simple átomo con el nombre de la persona; ó
%	Grupo: una lista de al menos 2 nombres de personas que pertenecen al grupo.
mensaje(['hola', ',', 'que', 'onda', '?'], nico).
mensaje(['todo', 'bien', 'dsp', 'hablamos'], nico).
mensaje(['q', 'parcial', 'vamos', 'a', 'tomar', '?'], [nico, lucas, maiu]).
mensaje(['todo', 'bn', 'dsp', 'hablamos'], [nico, lucas, maiu]).
mensaje(['todo', 'bien', 'despues', 'hablamos'], mama).
mensaje(['¿','y','q', 'onda', 'el','parcial', '?'], nico).
mensaje(['¿','y','que', 'onda', 'el','parcial', '?','caca'], lucas).

% abreviatura(Abreviatura, PalabraCompleta) relaciona una abreviatura con su significado.
abreviatura('dsp', 'despues').
abreviatura('q', 'que').
abreviatura('bn', 'bien').

% signo(UnaPalabra) indica si una palabra es un signo.
signo('¿').    signo('?').   signo('.').   signo(','). 

% filtro(Contacto, Filtro) define un criterio a aplicar para las predicciones para un contacto
filtro(nico, masDe(0.5)).
filtro(nico, ignorar(['interestelar'])).
filtro(lucas, masDe(0.7)).
filtro(lucas, soloFormal).
filtro(mama, ignorar(['dsp','paja'])).


recibioMensaje(Persona,Mensaje) :-
    mensaje(Mensaje, Personas),
    member(Persona, Personas).
recibioMensaje(Persona,Mensaje) :-
    mensaje(Mensaje, Persona),
    Persona \= [_ | _].

demasiadoFormal(Mensaje) :-
	mensaje(Mensaje,_),
	formal(Mensaje).

formal(['¿' | Mensaje]) :-
	length(Mensaje,CantidadPalabras),
	CantidadPalabras > 4,
	not(tieneAbreviaturas(Mensaje)).

tieneAbreviaturas(Mensaje) :-
	member(Palabra,Mensaje),
	abreviatura(Palabra,_).

esAceptable(Palabra,Persona) :-
	filtro(Persona,Filtro),
	ultimaPalabra(_,Palabra),
	pasaFiltro(Palabra,Filtro,Persona).

pasaFiltro(Palabra,masDe(N),Persona) :-
	aparicionesEnMensajesEnviados(Palabra,Persona,AparicionesPersona),
	aparicionesEnMensajesEnviados(Palabra,_,AparicionesOtros),
	TasaDeUso is AparicionesPersona // AparicionesOtros,
	TasaDeUso > N.
pasaFiltro(Palabra,ignorar(Palabras),_) :-
	not(member(Palabra,Palabras)).
pasaFiltro(Palabra,soloFormal,_) :-
	mensaje(Mensaje,_),
	member(Palabra,Mensaje),
	demasiadoFormal(Mensaje).

aparicionesEnMensajesEnviados(Palabra,Persona,SumaApariciones) :-
	recibioMensaje(Persona,_),
	ultimaPalabra(_,Palabra),
	findall(Apariciones,(recibioMensaje(Persona,Mensaje),apariciones(Palabra,Mensaje,Apariciones)),AparicionesTotales),
	sumlist(AparicionesTotales,SumaApariciones).

apariciones(Elemento,Lista,Apariciones) :-
	member(Elemento,Lista),
	findall(Buscado,(member(Buscado,Lista), Elemento == Buscado),Buscados),
	length(Buscados,Apariciones).
apariciones(Elemento,Lista,0) :-
	not(member(Elemento,Lista)).

dicenLoMismo(Mensaje1,Mensaje2) :-
	mensaje(Mensaje1,_),
	mensaje(Mensaje2,_),
	Mensaje1 \= Mensaje2,
	iguales(Mensaje1,Mensaje2).

iguales([Palabra1 | Palabras1],[Palabra1 | Palabras2]) :-
	iguales(Palabras1, Palabras2).
iguales([Palabra1 | Palabras1],[Palabra2 | Palabras2]) :-
	abreviatura(Palabra1,Palabra2),
	iguales(Palabras1, Palabras2).
iguales([Palabra1 | Palabras1],[Palabra2 | Palabras2]) :-
	abreviatura(Palabra2,Palabra1),
	iguales(Palabras1, Palabras2).
iguales([],[]).


fraseCelebre(Mensaje) :-
	mensaje(Mensaje,_),
	forall(recibioMensaje(Persona,_),recibioMensaje2(Persona,Mensaje)).

recibioMensaje2(Persona,Mensaje) :-
	dicenLoMismo(Mensaje,OtroMensaje),
	recibioMensaje(Persona,OtroMensaje).
recibioMensaje2(Persona,Mensaje) :-
	recibioMensaje(Persona,Mensaje).

prediccion(Mensaje,Receptor,Prediccion) :-
	mensaje(Mensaje,_),
	ultimaPalabra(Mensaje,UltimaPalabra),
	palabraSeguida(UltimaPalabra,Prediccion),
	esAceptable(Prediccion,Receptor).
prediccion(Mensaje,_,sinPrediccion) :-
	fraseCelebre(Mensaje).

ultimaPalabra(Mensaje,UltimaPalabra) :-
	length(Mensaje,Longitud),
	nth1(Longitud,Mensaje,UltimaPalabra).

palabraSeguida(Palabra,PalabraSeguida) :-
	mensaje(Mensaje,_),
	nth1(Posicion,Mensaje,Palabra),
	NuevaPosicion is Posicion + 1,
	not(ultimaPalabra(Mensaje,Palabra)),
	nth1(NuevaPosicion,Mensaje,PalabraSeguida).







