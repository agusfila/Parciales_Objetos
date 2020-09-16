class Equipo {
	
	const jugadores = #{}
	
	method valoracionEquipo() {
		return jugadores.sum({jugador => jugador.habilidad()})
	}
	
	method esDreamTeam() {
		return jugadores.any({jugador => jugador.esLeyenda()})
	}
	
}
