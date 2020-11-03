duenio(andy, woody, 8).
duenio(andy, buzz, 5).
duenio(andy, soldados, 3).
duenio(sam, jessie, 3).
duenio(sam, woody, 3).
duenio(andy,jessie2,4).

juguete(woody, deTrapo(vaquero)).
juguete(jessie2,deTrapo(vaquero)).
juguete(jessie, deTrapo(vaquero)).
juguete(buzz, deAccion(espacial, [original(casco)])).
juguete(soldados, miniFiguras(soldado, 60)).
juguete(monitosEnBarril, miniFiguras(mono, 50)).
juguete(seniorCaraDePapa,
	caraDePapa([ original(pieIzquierdo),
	original(pieDerecho),
	repuesto(nariz) ])).

esRaro(deAccion(stacyMalibu, [sombrero])).
esColeccionista(sam).

tematica(Juguete,Tematica) :-
	juguete(Juguete,Tipo),
	tipoDeTematica(Tipo,Tematica).

tipoDeTematica(deTrapo(Tematica),Tematica).
tipoDeTematica(deAccion(Tematica,_),Tematica).
tipoDeTematica(miniFiguras(Tematica,_),Tematica).
tipoDeTematica(caraDePapa(_),caraDePapa).

esDePlastico(Juguete) :-
	juguete(Juguete,miniFiguras(_,_)).
esDePlastico(Juguete) :-
	juguete(Juguete,caraDePapa(_)).

esDeColeccion(Juguete) :-
	juguete(Juguete,deAccion(Tematica,Partes)),
	esRaro(deAccion(Tematica,Partes)).
esDeColeccion(Juguete) :-
	juguete(Juguete,caraDePapa(Partes)),
	esRaro(caraDePapa(Partes)).
esDeColeccion(Juguete):-
	juguete(Juguete,deTrapo(_)).

amigoFiel(Duenio,Juguete) :-
	duenio(Duenio,Juguete,Anios),
	forall((duenio(Duenio,Juguete2,Anios2),Juguete2 \= Juguete),Anios2 < Anios),
	not(esDePlastico(Juguete)).

superValioso(Juguete) :-
	juguete(Juguete,Tipo),
	not(tieneRepuestos(Tipo)),
	duenio(Duenio,Juguete,_),
	not(esColeccionista(Duenio)).

tieneRepuestos(deAccion(_,Partes)) :-
	nth1(_,Partes,repuesto(_)).
tieneRepuestos(caraDePapa(Partes)) :-
	nth1(_,Partes,repuesto(_)).

duoDinamico(Duenio,Juguete1,Juguete2) :-
	duenio(Duenio,Juguete1,_),
	duenio(Duenio,Juguete2,_),
	Juguete1 \= Juguete2,
	hacenBuenaPareja(Juguete1,Juguete2).

hacenBuenaPareja(woody,buzz).
hacenBuenaPareja(Juguete1,Juguete2) :-
	tematica(Juguete1,Tematica),
	tematica(Juguete2,Tematica).


felicidad(Duenio,FelicidadTotal) :-
	duenio(Duenio,_,_),
	findall(Felicidad,(duenio(Duenio,Juguete,_),calcularFelicidad(Juguete,Felicidad)),Felicidades),
	sumlist(Felicidades,FelicidadTotal).

calcularFelicidad(Juguete,Felicidad) :-
	juguete(Juguete,Tipo),
	felicidadJuguete(Tipo,Felicidad).
calcularFelicidad(Juguete,120) :-
	juguete(Juguete,deAccion(_,_)),
	esDeColeccion(Juguete),
	duenio(Duenio,Juguete,_),
	esColeccionista(Duenio).
calcularFelicidad(Juguete,100) :-
	juguete(Juguete,deAccion(_,_)),
	not(esDeColeccion(Juguete)).

felicidadJuguete(miniFiguras(_,Cantidad),Felicidad) :- Felicidad is Cantidad * 20.
felicidadJuguete(caraDePapa(Partes),Felicidad) :-
	findall(Original,esOriginal(Partes,Original),Originales),
	length(Originales,CantOriginal),
	findall(Repuesto,esRepuesto(Partes,Repuesto),Repuestos),
	length(Repuestos,CantRepuestos),
	Felicidad is (CantOriginal * 5) + (CantRepuestos * 8).
felicidadJuguete(deTrapo(_),100).
	
esOriginal(Partes,Original) :-
	nth1(_,Partes,original(Original)).
esRepuesto(Partes,Repuesto) :-
	nth1(_,Partes,repuesto(Repuesto)).

puedeJugarCon(Alguien,Juguete) :-
	duenio(Alguien,Juguete,_).
puedeJugarCon(Alguien,Juguete) :-
	puedeJugarCon(Otro,Juguete),
	Otro \= Alguien,
	puedePrestarle(Otro,Alguien).

puedePrestarle(Otro,Alguien) :-
	cantidadDeJuguetes(Otro,CantOtro),
	cantidadDeJuguetes(Alguien,CantAlguien),
	CantOtro > CantAlguien.
	
cantidadDeJuguetes(Alguien,Cantidad) :-
	duenio(Alguien,_,_),
	findall(Juguete,duenio(Alguien,Juguete,_),Juguetes),
	length(Juguetes,Cantidad).

podriaDonar(Duenio,ListaJuguetes,FelicidadInicial) :-
	duenio(Duenio,_,_),
	length(ListaJuguetes,_),
	findall(Felicidad,(duenio(Duenio,Juguete,_),nth1(_,ListaJuguetes,Juguete),calcularFelicidad(Juguete,Felicidad)),Felicidades),
	sumlist(Felicidades,NuevaFelicidad),
	NuevaFelicidad < FelicidadInicial.








