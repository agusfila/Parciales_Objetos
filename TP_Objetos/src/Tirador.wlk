import Jugador.*

class Tirador inherits Jugador {

	override method habilidad() {
		return (( self.eficaciaTriple() * 2 + ( self.nivelInteligencia() + self.talento() ) / 2 + self.altura() / 2 ) / 2) * self.bonificacionSuciedad() 
	}
	
	method bonificacionSuciedad() {
		if(self.esSucio()) {
			return 0.85
		} else {
			return 1
		}
	}
	
	override method entrenar() {
		self.reducirStamina(3)
	}
	
	override method pierdeMenosDe5PuntosDeStaminaAlEntrenar() {
		return true
	}
	

}

