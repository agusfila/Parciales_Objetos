class Equipo {
	
	const jugadores = #{}
	
	method valoracionEquipo() {
		return jugadores.sum({jugador => jugador.habilidad()}) / jugadores.size()
	}
	
	method esDreamTeam() {
		return jugadores.any({jugador => jugador.esLeyenda()})
	}
	
}
