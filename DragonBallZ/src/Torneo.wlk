import Guerreros.*

class Torneo {
	
	const modalidad
	const guerreros = []
	
	method seleccionarJugadores() {
		return modalidad.seleccionarJugadores(guerreros)
	}
}

object powerlsBest {
	
	method seleccionarJugadores(unosJugadores) {
		return unosJugadores.sortBy({unJugador, otroJugador => unJugador.potencialOfensivo() > otroJugador.potencialOfensvio()}).take(16)
	}
}

object funny {
	
	method seleccionarJugadores(unosJugadores) {
		return unosJugadores.sortBy({unJugador, otroJugador => unJugador.elementos() > otroJugador.elementos()}).take(16)
	}
}

object surprise {
	
	method seleccionarJugadores(unosJugadores) {
		return unosJugadores.drop(16)
	}
}

