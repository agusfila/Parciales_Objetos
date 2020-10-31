class Equipo {

	const property jugadores = #{}
	var property puntos = 0

	method habilidadPromedio() {
		return jugadores.sum({ unJugador => unJugador.habilidad() }) / jugadores.size()
	}

	method jugadorEstrellaContra(unEquipo) {
		return jugadores.any({ unJugador => unJugador.lePasaElTrapoATodos(unEquipo) })
	}

	method lesPasaElTrapo(unJugador) {
		return jugadores.all({ otroJugador => unJugador.lePasaElTrapoA(otroJugador) })
	}

	method jugarContra(unEquipo) {
		jugadores.forEach({ unJugador => unJugador.jugar(unEquipo)})
	}

	method sumarPuntos(unosPuntos) {
		puntos += unosPuntos
	}

	method restarPuntos(unosPuntos) {
		puntos -= unosPuntos
	}
	
	method puedeBloquearTiro(unCazador) {
		return jugadores.any({unJugador => unJugador.puedeBloquearTiro(unCazador)})
	}
	
	method cazadorMasRapido() {
		return jugadores.filter({unJugador => unJugador.esCazador()}).max({unJugador => unJugador.velocidad()})
	}
	
	method algunBlancoUtil() {
		return jugadores.filter({unJugador => unJugador.esBlancoUtil()}).anyOne()
	}
}

