% jugador(Jugador,Equipo): relaciona cada jugador 
% con su equipo
jugador(heaton,nip).	%nip = Ninjas in Pijamas
jugador(potti,nip).
jugador(element,gol).	%gol = Game OnLine

% equipoTerrorista y equipoAntiTerrorista: 
% en qué bando está cada equipo
equipoTerrorista(nip).
equipoAntiTerrorista(gol).

equipamiento(heaton,casco(20,9)).
equipamiento(heaton,chaleco(80)).
equipamiento(element,casco(20,9)).
equipamiento(element,chaleco(80)).
equipamiento(heaton,rifle(ak47,30)).
equipamiento(heaton,pistola(usp,12)).
equipamiento(Jugador,pistola(desertEagle,25)) :-
	jugador(Jugador,Equipo),
	equipoTerrorista(Equipo).

% importanciaRifles: lista de rifles en orden de importancia 
% (el primero es el mas importante)
importanciaRifles([awp,ak47,m4a1,aug,galil,famas]).

% presentoA(EquipoPresentador, EquipoPresentado)
% para entrar al servidor te tiene que presentar otro equipo
presentoA(nip,gol).
presentoA(mTw,nip).
presentoA(mTw,noA).
presentoA(noA,fip).

% mapas (zonas) limítrofes, 
% como la base es generada, ya los arma en ambos sentidos
limitrofe(dust2,inferno).
limitrofe(inferno,dust2).
limitrofe(dust2,train).
limitrofe(train,dust2).
limitrofe(inferno,cbble).
limitrofe(cbble,inferno).

% en qué mapa está cada jugador ahora
estaEn(heaton,dust2).
estaEn(potti,inferno).
estaEn(element,inferno).

resistencia(casco(Resistencia,_),Resistencia).
resistencia(chaleco(Resistencia),Resistencia).
resistencia(rifle(_),0).
resistencia(pistola(_,_),0).

enemigos(Jugador,OtroJugador) :-
	jugador(Jugador,Equipo),
	jugador(OtroJugador,OtroEquipo),
	equipoAntiTerrorista(Equipo),
	equipoTerrorista(OtroEquipo).

equipoComplicado(Equipo) :-
	equipoTerrorista(Equipo),
	forall(jugador(Jugador,Equipo),not(equipamiento(Jugador,rifle(awp,_)))).
equipoComplicado(Equipo) :-
	equipoTerrorista(Equipo),
	jugador(Jugador,Equipo),
	not(equipamiento(Jugador,casco(_,_))),
	not(equipamiento(Jugador,chaleco(_))).
equipoComplicado(Equipo) :-
	equipoAntiTerrorista(Equipo),
	findall(Jugador,(jugador(Jugador,Equipo),equipamiento(Jugador,casco(_,_))),Jugadores),
	length(Jugadores,CantidadConCasco),
	CantidadConCasco < 5 .
equipoComplicado(Equipo) :-
	equipoAntiTerrorista(Equipo),
	forall(jugador(Jugador,Equipo),not(tieneRifleGroso(Jugador))).

tieneRifleGroso(Jugador) :-
	equipamiento(Jugador,rifle(Rifle,_)),
	importanciaRifles(ImportanciaRifles),
	nth1(Posicion,ImportanciaRifles,Rifle),
	nth1(PosicionMaxima,ImportanciaRifles,m4a1),
	Posicion < PosicionMaxima.
tieneRifleGroso(Jugador) :-
	equipamiento(Jugador,rifle(_,Velocidad)),
	Velocidad >= 50 .

equipoProtegido(Equipo) :-
	jugador(_,Equipo),
	forall((jugador(Jugador,Equipo),resistenciaTotal(Jugador,Resistencia)),Resistencia >= 100).

resistenciaTotal(Jugador,ResistenciaTotal) :-
	jugador(Jugador,_),
	findall(Resistencia,(equipamiento(Jugador,Equipamiento),resistencia(Equipamiento,Resistencia)),Resistencias),
	sumlist(Resistencias,ResistenciaTotal).

estaLleno(Mapa) :-
	estaEn(_,Mapa),
	findall(Item,(estaEn(Jugador,Mapa),equipamiento(Jugador,Item)),Items),
	length(Items,Cantidad),
	Cantidad >= 12 .

regionLlena(Mapa) :-
	estaLleno(Mapa),
	forall(limitrofe(Mapa,OtroMapa),estaLleno(OtroMapa)).

puedeIrA(Jugador,Mapa) :-
	estaEn(Jugador,OtroMapa),
	puedeMoverse(Jugador,Mapa,OtroMapa),
	Mapa \= OtroMapa.

puedeMoverse(Jugador,Mapa,OtroMapa) :-
	estaEn(Jugador,Mapa),
	limitrofe(Mapa,OtroMapa).
puedeMoverse(Jugador,Mapa,OtroMapa) :-
	limitrofe(Mapa,Mapa2),
	Mapa2 \= OtroMapa,
	puedeMoverse(Jugador,Mapa2,OtroMapa).
