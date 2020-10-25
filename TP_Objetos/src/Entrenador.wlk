class Entrenador {
	
	const nombre
	const apellido
	const edad
	var property equipoDirigido = null

	method entrenarA(unJugador) {
		unJugador.entrenar()
		unJugador.aumentarEficacia(unJugador.eficaciaTriple() * 0.1)
		unJugador.aumentarTalento(unJugador.talento() * 0.1)
	}

	method entrenaEquipoDeAltoRendimiento() {
		return equipoDirigido.esDeAltoRendimiento()
	}
	
	method entrenaEquipoMedioPelo() {
		return equipoDirigido.esMedioPelo()
	}
	
	method entrenaEquipoDreamTeam() {
		return equipoDirigido.esDreamTeam()
	}

}

class Fino inherits Entrenador {
	
	method dirigir(unEquipo) {
		unEquipo.nuevoEntrenador(self)
		self.equipoDirigido(unEquipo)
	}
	
	method entrenar(unEquipo) {
		unEquipo.entrenarJugadores()
		unEquipo.convertirEnTiradores()
	}
	
	method bonificar() {
		if(self.entrenaEquipoDeAltoRendimiento()) {
			return 0.3
		} else {
			return 0
		}
	}
}


class Motivador inherits Entrenador {
	
	method dirigir(unEquipo) {
		unEquipo.nuevoEntrenador(self)
		self.equipoDirigido(unEquipo)
	}
	
	method entrenar(unEquipo) {
		unEquipo.entrenarJugadores()
	}
	
	method bonificar() {
		if(self.entrenaEquipoMedioPelo()) {
			return 0.5
		} else {
			return 0
		}
	}
}

class Vendehumo inherits Entrenador {
	
	method dirigir(unEquipo) {
		unEquipo.nuevoEntrenador(self)
		self.equipoDirigido(unEquipo)
	}
	
	method entrenar(unEquipo) {
		self.bonificar()
		unEquipo.entrenarJugadores()
	}
	
	method bonificar() {
		if(self.entrenaEquipoDreamTeam()) {
			 return 0.25
		} else {
			return -0.15
		}
	}
}

