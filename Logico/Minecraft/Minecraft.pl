jugador(stuart, [piedra, piedra, piedra, piedra, piedra, piedra, piedra, piedra], 3).
jugador(tim, [madera, madera, madera, madera, madera, pan, carbon, carbon, carbon, pollo, pollo], 8).
jugador(steve, [madera, carbon, carbon, diamante, panceta, panceta, panceta], 2).

lugar(playa, [stuart, tim], 2).
lugar(mina, [steve], 8).
lugar(bosque, [], 6).

comestible(pan).
comestible(panceta).
comestible(pollo).
comestible(pescado).

tieneItem(Jugador,Item) :-
	jugador(Jugador,Items,_),
	nth1(_,Items,Item).

cantidadDelItem(Jugador,Item,Cantidad) :-
	jugador(Jugador,Items,_),
	nth1(_,Items,Item),
	findall(Posicion,nth1(Posicion,Items,Item),Posiciones),
	length(Posiciones,Cantidad).

sePreocupaPorSuSalud(Jugador) :-
	jugador(Jugador,Items,_),
	nth1(_,Items,Comida1),
	nth1(_,Items,Comida2),
	comestible(Comida1),
	comestible(Comida2),
	Comida1 \= Comida2.

tieneMasDe(Jugador,Item) :-
	cantidadDelItem(Jugador,Item,Cantidad),
	forall((cantidadDelItem(OtroJugador,Item,OtraCantidad),OtroJugador \= Jugador),OtraCantidad < Cantidad).

hayMonstruos(Lugar) :-
	lugar(Lugar,_,Oscuridad),
	Oscuridad > 6.

correPeligro(Jugador) :-
	lugar(Lugar,Jugadores,_),
	nth1(_,Jugadores,Jugador),
	hayMonstruos(Lugar).
correPeligro(Jugador) :-
	hambriento(Jugador).

hambriento(Jugador) :-
	jugador(Jugador,Items,Hambre),
	forall(nth1(_,Items,Item),not(comestible(Item))),
	Hambre < 4 .

poblacionTotal(Cantidad) :-
	findall(Jugador,jugador(Jugador,_,_),Jugadores),
	length(Jugadores,Cantidad).

nivelPeligrosidad(Lugar,Peligrosidad) :-
	not(hayMonstruos(Lugar)),
	findall(Jugador,(jugador(Jugador,_,_),hambriento(Jugador)),Hambrientos),
	length(Hambrientos,CantidadHambrientos),
	poblacionTotal(CantidadJugadores),
	Peligrosidad is CantidadHambrientos / CantidadJugadores.
nivelPeligrosidad(Lugar,100) :-
	hayMonstruos(Lugar).
nivelPeligrosidad(Lugar,Peligrosidad) :-
	lugar(Lugar,Jugadores,Oscuridad),
	length(Jugadores,0),
	Peligrosidad is Oscuridad * 10 .

item(horno, [ itemSimple(piedra, 8) ]).
item(placaDeMadera, [ itemSimple(madera, 1) ]).
item(palo, [ itemCompuesto(placaDeMadera) ]).
item(antorcha, [ itemCompuesto(palo), itemSimple(carbon, 1) ]).

puedeConstruir(Jugador,Item) :-
	item(Item,ItemsRequeridos),
	jugador(Jugador,_,_),
	forall(nth1(_,ItemsRequeridos,ItemRequerido),tieneLoNecesario(Jugador,ItemRequerido)).

tieneLoNecesario(Jugador,itemSimple(Item,CantidadNecesaria)) :-
	cantidadDelItem(Jugador,Item,Cantidad),
	Cantidad >= CantidadNecesaria.
tieneLoNecesario(Jugador,itemCompuesto(ItemSimple)) :-
	puedeConstruir(Jugador,ItemSimple).
	



















