import Jugador.*

class Pasador inherits Jugador {

	method habilidad() {
		return ( ( nivelInteligencia + talento ) / 2 + altura * 0.80 + eficaciaTriple * 0.30 ) / 5
	}
	
	method esCrack() {
		return self.habilidad() > 90
	}

}

