import Jugador.*

class Rebotador inherits Jugador {

	method habilidad() {
		return ((altura * 2 - ( nivelInteligencia + talento ) / 3 ) / 5) * 1.20
	}
	
	method esCrack() {
		return self.habilidad() > 90
	}

}

