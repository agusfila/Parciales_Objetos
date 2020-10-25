import Jugador.*

class Rebotador inherits Jugador {

	override method habilidad() {
		return ((self.altura() * 2 + ( self.nivelInteligencia() - self.talento() ) / 3 ) / 5) * self.bonificacionSuciedad()
	}
	
	method bonificacionSuciedad() {
		if(self.esSucio()) {
			return 1.2
		} else {
			return 1
		}
	}
	
	override method entrenar() {
		self.reducirStamina(8)
	}
	
	override method pierdeMenosDe5PuntosDeStaminaAlEntrenar() {
		return false
	}

}

