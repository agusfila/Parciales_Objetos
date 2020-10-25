import Jugador.*

class Pasador inherits Jugador {

	override method habilidad() {
		return ( ( self.nivelInteligencia() + self.talento() ) / 2 + self.altura() * 0.80 + self.eficaciaTriple() * 0.30 ) / 5
	}
	
	override method entrenar() {
		self.reducirStamina(5)
	}
	
	override method pierdeMenosDe5PuntosDeStaminaAlEntrenar() {
		return false
	}
	

}

