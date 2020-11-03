mago(harry, mestiza, [coraje, amistad, orgullo, inteligencia]).
mago(ron, pura, [amistad, diversion, coraje]).
mago(hermione, impura, [inteligencia, coraje, responsabilidad, amistad, orgullo]).
mago(hannahAbbott, mestiza, [amistad, diversion]).
mago(draco, pura, [inteligencia, orgullo]).
mago(lunaLovegood, mestiza, [inteligencia, responsabilidad, amistad, coraje]).

odia(harry,slytherin).
odia(draco,hufflepuff).

casa(gryffindor).
casa(hufflepuff).
casa(ravenclaw).
casa(slytherin).

caracteriza(gryffindor,amistad).
caracteriza(gryffindor,coraje).
caracteriza(slytherin,orgullo).
caracteriza(slytherin,inteligencia).
caracteriza(ravenclaw,inteligencia).
caracteriza(ravenclaw,responsabilidad).
caracteriza(hufflepuff,amistad).
caracteriza(hufflepuff,diversion).

permiteEntrar(Casa,Mago) :-
	casa(Casa),
	Casa \= slytherin,
	mago(Mago,_,_).
permiteEntrar(slytherin, Mago) :-
	mago(Mago,Sangre,_),
	Sangre \= impura.

sangreImpura(Mago) :-
	mago(Mago,impura,_).

tieneCaracter(Mago,Casa) :-
	mago(Mago,_,Caracteristicas),
	casa(Casa),
	forall(caracteriza(Casa,Caracteristica),member(Caracteristica,Caracteristicas)).

casaPosible(Mago,Casa) :-
	tieneCaracter(Mago,Casa),
	permiteEntrar(Casa,Mago),
	not(odia(Mago,Casa)).

cadenaDeAmistades([Mago, OtroMago | Magos]) :-
	tieneCaracteristica(amistad,Mago),
	casaPosible(Mago,Casa),
	casaPosible(OtroMago,Casa),
	cadenaDeAmistades([OtroMago | Magos]).
cadenaDeAmistades([Mago | []]) :-
	tieneCaracteristica(amistad,Mago).
cadenaDeAmistades([]).

tieneCaracteristica(Caracteristica,Mago) :-
	mago(Mago,_,Caracteristicas),
	member(Caracteristica,Caracteristicas).

lugarProhibido(bosque,50).
lugarProhibido(seccionRestringida,10).
lugarProhibido(tercerPiso,75).

alumnoFavorito(flitwick, hermione).
alumnoFavorito(snape, draco).
alumnoOdiado(snape, harry).

hizo(ron, buenaAccion(jugarAlAjedrez, 50)).
hizo(harry, fueraDeCama).
hizo(hermione, irA(tercerPiso)).
hizo(hermione, responder("Donde se encuentra un Bezoar", 15, snape)).
hizo(hermione, responder("Wingardium Leviosa", 25, flitwick)).
hizo(ron, irA(bosque)).
hizo(draco, irA(mazmorras)).

esDe(harry, gryffindor).
esDe(ron, gryffindor).
esDe(hermione, gryffindor).
esDe(draco,slytherin).
esDe(hannahAbbott, hufflepuff).
esDe(lunaLovegood, ravenclaw).

esBuenAlumno(Mago) :-
	mago(Mago,_,_),
	forall(puntajePorAccion(Mago,Puntaje),Puntaje >= 0).

puntajePorAccion(Mago,Puntaje) :-
	hizo(Mago,Accion),
	puntaje(Mago,Accion,Puntaje).

puntaje(_,buenaAccion(_,Puntaje),Puntaje).
puntaje(_,irA(Lugar),Puntaje) :-
	lugarProhibido(Lugar,PuntajeAbsoluto),
	Puntaje is PuntajeAbsoluto * (-1) .
puntaje(_,fueraDeCama,Puntaje) :-
	Puntaje is 50 * (-1) .
puntaje(Mago,responder(_,Dificultad,Profesor),Puntaje) :-
	alumnoFavorito(Profesor,Mago),
	Puntaje is Dificultad * 2 .
puntaje(Mago,responder(_,_,Profesor),0) :-
	alumnoOdiado(Profesor,Mago).
puntaje(Mago,responder(_,Dificultad,Profesor),Dificultad) :-
	alumnoNormal(Profesor,Mago).

alumnoNormal(Profesor,Mago) :-
	not(alumnoFavorito(Profesor,Mago)),
	not(alumnoOdiado(Profesor,Mago)).

puntosDeCasa(Casa,PuntajeTotal) :-
	casa(Casa),
	findall(Puntaje,(esDe(Mago,Casa),puntajeMago(Mago,Puntaje)),Puntajes),
	sumlist(Puntajes,PuntajeTotal).

puntajeMago(Mago,PuntajeTotal) :-
	mago(Mago,_,_),
	findall(Puntaje,puntajePorAccion(Mago,Puntaje),Puntajes),
	sumlist(Puntajes,PuntajeTotal).

casaGanadora(Casa) :-
	puntosDeCasa(Casa,Puntos),
	forall(puntosDeCasa(OtraCasa,OtrosPuntos),OtrosPuntos =< Puntos).