class Equipo {
	
	const jugadores = #{}
	
	method valoracionEquipo() {
		return jugadores.sum({jugador => jugador.habilidad()}) / 3
	}
	
	method esDreamTeam() {
		return jugadores.any({jugador => jugador.esLeyenda()})
	}
	
}
