vocaloid(magurineLuka,[cancion(nightFever,4),cancion(foreverYoung,5)]).
vocaloid(hatsuneMiku,[cancion(tellYourWorld,4)]).
vocaloid(gumi,[cancion(foreverYoung,4),cancion(tellYourWorld,5)]).
vocaloid(seeU,[cancion(novemberRain,6),cancion(nightFever,5)]).
vocaloid(kaito,[]).

concierto(mikuExpo,gigante(3,6),estadosUnidos,200).
concierto(magicalMirai,gigante(4,10),japon,3000).
concierto(vocalektVisions,mediano(9),estadosUnidos,1000).
concierto(mikuFest,pequenio(4),argentina,100).

esNovedoso(Vocaloid) :-
	duracionDeCanciones(Vocaloid,Duraciones),
	length(Duraciones,Cantidad),
	Cantidad >= 2 ,
	sumlist(Duraciones,TiempoTotal),
	TiempoTotal < 15 .

duracionDeCanciones(Vocaloid,Duraciones) :-
	vocaloid(Vocaloid,Canciones),
	findall(Duracion,nth1(_,Canciones,cancion(_,Duracion)),Duraciones).
	
esAcelerado(Vocaloid) :-
	duracionDeCanciones(Vocaloid,Duraciones),
	length(Duraciones,Cantidad),
	sumlist(Duraciones,TiempoTotal),
	Cantidad \= 0,
	Aceleracion is TiempoTotal / Cantidad,
	Aceleracion =< 4 .

puedeParticipar(Vocaloid,Concierto) :-
	concierto(Concierto,Tamanio,_,_),
	cumpleRequisitos(Vocaloid,Tamanio),
	duracionDeCanciones(Vocaloid,Duraciones),
	length(Duraciones,Cantidad),
	Cantidad \= 0 .
puedeParticipar(hatsuneMiku,_).

cumpleRequisitos(Vocaloid,gigante(MinCantCanciones,MinDuracionTotal)) :-
	duracionDeCanciones(Vocaloid,Duraciones),
	length(Duraciones,CantCanciones),
	CantCanciones >= MinCantCanciones,
	sumlist(Duraciones,DuracionTotal),
	DuracionTotal >= MinDuracionTotal.
cumpleRequisitos(Vocaloid,mediano(MaxDuracionTotal)) :-
	duracionDeCanciones(Vocaloid,Duraciones),
	sumlist(Duraciones,DuracionTotal),
	DuracionTotal =< MaxDuracionTotal.
cumpleRequisitos(Vocaloid,pequenio(MinDuracionCancion)) :-
	duracionDeCanciones(Vocaloid,Duraciones),
	nth1(_,Duraciones,DuracionCancion),
	DuracionCancion > MinDuracionCancion.

elMasFamoso(Vocaloid) :-
	famaTotal(Vocaloid,FamaTotal),
	forall((vocaloid(OtroVocaloid,_),Vocaloid \= OtroVocaloid,famaTotal(OtroVocaloid,FamaOtroVocaloid)),FamaOtroVocaloid < FamaTotal).

famaTotal(Vocaloid,FamaTotal) :-
	duracionDeCanciones(Vocaloid,Duraciones),
	findall(Fama,(puedeParticipar(Vocaloid,Concierto),concierto(Concierto,_,_,Fama)),Famas),
	sumlist(Famas,SumFama),
	length(Duraciones,CantCanciones),
	FamaTotal is SumFama * CantCanciones.

conoceA(magurineLuka,hatsuneMiku).
conoceA(magurineLuka,gumi).
conoceA(gumi,seeU).
conoceA(seeU,kaito).

unicoParticipante(Vocaloid,Concierto) :-
	puedeParticipar(Vocaloid,Concierto),
	forall(conoceA(Vocaloid,OtroVocaloid),not(puedeParticipar(OtroVocaloid,Concierto))).

	












