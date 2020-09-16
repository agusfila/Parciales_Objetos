import Jugador.*

class Tirador inherits Jugador{

	method habilidad() {
		return (( eficaciaTriple * 2 + ( nivelInteligencia + talento ) / 2 + altura / 2 ) / 2) * 0.85
	}
	
	method esCrack() {
		return self.habilidad() > 90
	}

}

