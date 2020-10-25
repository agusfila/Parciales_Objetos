class Equipo {

	const jugadores = #{}
	var property entrenador = null

	method valoracionEquipo() {
		return self.valoracionJugadores() + self.bonificacionMismoCriterio()
	}

	method bonificacionMismoCriterio() {
		if (self.mismoCriterio()) {
			return 10
		} else {
			return 0
		}
	}

	method mismoCriterio() {
		return self.equipoSucio() || self.equipoLimpio()
	}

	method equipoSucio() {
		return jugadores.all({ unJugador => unJugador.esSucio() })
	}

	method equipoLimpio() {
		return jugadores.all({ unJugador => !unJugador.esSucio() })
	}

	method valoracionJugadores() {
		return self.promedioHabilidad() * (1 + entrenador.bonificar())
	}

	method promedioHabilidad() {
		return jugadores.sum({ jugador => jugador.habilidad() }) / jugadores.size()
	}

	method esDreamTeam() {
		return jugadores.any({ jugador => jugador.esLeyenda() })
	}

	method entrenarJugadores() {
		jugadores.forEach({ unJugador => entrenador.entrenarA(unJugador)})
	}
	
	method convertirEnTiradores() {
		jugadores.map({ unJugador => unJugador.convertirseEnTirador()})
	}
	
	method esDeAltoRendimiento() {
		return jugadores.all({unJugador => unJugador.pierdeMenosDe5PuntosDeStaminaAlEntrenar()})
	}
	
	method esMedioPelo() {
		return self.promedioHabilidad() < 75
	}
	
	method nuevoEntrenador(unEntrenador) {
		entrenador = unEntrenador
	}

}

