% los intereses de cada sim
intereses(cholo,[deportes,musica,computacion,sociedad]).
intereses(lara,[moda, musica,economia,animales]).
intereses(pinchi,[]).

% la personalidad de los Sims en los distintos aspectos
% viene dada por su signo
personalidadPorSigno(aries,pulcritud,5).
personalidadPorSigno(aries,extroversion,7).
personalidadPorSigno(aries,actividad,4).
personalidadPorSigno(aries,animoLudico,5).
personalidadPorSigno(aries,cordialidad,4).
personalidadPorSigno(cancer,pulcritud,7).
personalidadPorSigno(cancer,extroversion,6).
personalidadPorSigno(cancer,actividad,6).
personalidadPorSigno(cancer,animoLudico,4).
personalidadPorSigno(cancer,cordialidad,3).

signoSim(cholo,cancer).
signoSim(lara,aries).
signoSim(pinchi,aries).

% para cada Sim se maneja su nivel de distintos estados
% nivelSim relaciona sim, estado y nivel
nivelSim(cholo,energia,6).
nivelSim(cholo,diversion,3).
nivelSim(cholo,sociedad,7). 
nivelSim(cholo,hambre,3).
nivelSim(cholo,banio,3).
nivelSim(lara,energia,4).
nivelSim(lara,diversion,6).
nivelSim(lara,sociedad,5). 
nivelSim(lara,hambre,4).
nivelSim(lara,banio,6).
nivelSim(pinchi,energia,10).
nivelSim(pinchi,diversion,10).
nivelSim(pinchi,sociedad,10). 
nivelSim(pinchi,hambre,3).
nivelSim(pinchi,banio,6).

% hay estados que se autoatienden, que son
%    la sociedad (el sim se pone a chatear solo) 
%    y el banio (... el sim se hace encima).
seAutoAtiende(sociedad).
seAutoAtiende(banio).

% el efecto que tienen los accesorios que pueden usar 
% los sims sobre sus estados
efecto(sillon,suma(energia,4)).
efecto(cama,asigna(energia,6)).
efecto(tele,duplica(diversion)).

noCongenian(UnSim,OtroSim) :-
	intereses(UnSim,_),
	intereses(OtroSim,_),
	UnSim \= OtroSim,
	forall(leGustaHablar(UnSim,Tema),not(leGustaHablar(OtroSim,Tema))).

leGustaHablar(Sim,Tema) :-
	intereses(Sim,Intereses),
	member(Tema,Intereses).
leGustaHablar(Sim,cocina) :-
	nivelSim(Sim,hambre,NivelHambre),
	NivelHambre < 8.
leGustaHablar(Sim,futuro) :-
	nivelSim(Sim,energia,NivelEnergia),
	NivelEnergia > 12.

seLlevanBien(UnSim,OtroSim) :-
	sumaDeNiveles(UnSim,Suma),
	sumaDeNiveles(OtroSim,Suma),
	UnSim \= OtroSim.

sumaDeNiveles(UnSim,Suma) :-
	nivelSim(UnSim,_,_),
	findall(Nivel,(nivelSim(UnSim,Estado,Nivel),Estado \= banio),Niveles),
	sumlist(Niveles,Suma).

necesitaAtencion(hambre,Nivel) :-
	Resto is Nivel mod 2,
	Resto = 0.
necesitaAtencion(Estado,Nivel) :-
	not(seAutoAtiende(Estado)),
	Estado \= hambre,
	Nivel < 9.

deBuenHumor(Sim) :-
	nivelSim(Sim,_,_),
	forall(nivelSim(Sim,Estado,Nivel),not(necesitaAtencion(Estado,Nivel))).

compartenPesares(UnSim,OtroSim) :-
	nivelSim(UnSim,Estado,UnNivel),
	nivelSim(OtroSim,Estado,OtroNivel),
	UnSim \= OtroSim,
	necesitaAtencion(Estado,UnNivel),
	necesitaAtencion(Estado,OtroNivel).

puedenSerAmigos(UnSim,OtroSim) :-
	cumplenCondiciones(UnSim,OtroSim),
	UnSim \= OtroSim.

cumplenCondiciones(UnSim,OtroSim) :-
	sociable(UnSim),
	sociable(OtroSim).
cumplenCondiciones(UnSim,OtroSim) :-
	seLlevanBien(UnSim,OtroSim),
	deBuenHumor(UnSim),
	deBuenHumor(OtroSim).

sociable(Sim) :-
	signoSim(Sim,Signo),
	personalidadPorSigno(Signo,extroversion,Nivel),
	Nivel > 6.

afecta(Accesorio,Estado) :-
	efecto(Accesorio,suma(Estado,_)).
afecta(Accesorio,Estado) :-
	efecto(Accesorio,asigna(Estado,_)).
afecta(Accesorio,Estado) :-
	efecto(Accesorio,duplica(Estado)).

aplicar(Estado,Accesorio,A,D) :-
	efecto(Accesorio,Efecto),
	afecta(Accesorio,Estado),
	aplicarEfecto(Estado,A,Efecto,D).
aplicar(Estado,Accesorio,A,A) :-
	not(afecta(Accesorio,Estado)).

aplicarEfecto(Estado,A,suma(Estado,Cuanto),D) :-
	D is A + Cuanto.
aplicarEfecto(Estado,_,asigna(Estado,D),D).
aplicarEfecto(Estado,A,duplica(Estado),D) :-
	D is A * 2 .

6.	leVieneBien/2 que relaciona un sim con un accesorio si: el accesorio afecta a algun estado en el que el sim está complicado, 
y el resultado de aplicar el accesorio al nivel del sim en ese estado no necesita atención.
P.ej. en el ejemplo a cholo le viene bien el sillón, porque 
•	cholo está complicado para la energía, 
•	el sillón afecta a la energía, 
•	si le aplico el sillón (que suma 4 a la energía) al nivel de energía de cholo (6), el resultado (10) no necesita atención para la energía.

leVieneBien(Sim,Accesorio) :-
	nivelSim(Sim,Estado,Nivel),
	necesitaAtencion(Estado,Nivel),
	aplicar(Estado,Accesorio,Nivel,NuevoNivel),
	not(necesitaAtencion(Estado,NuevoNivel)).




