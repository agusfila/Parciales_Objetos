class Revolver {

	var balas

	method usarArma(unaVictima) {
		if (self.tieneBalas()) {
			unaVictima.dormirConLosPeces()
			balas -= 1
		}
	}

	method tieneBalas() {
		return balas != 0
	}

	method esSutil() {
		return balas.equals(1)
	}

}

class CuerdaDePiano {

	const calidad

	method usarArma(unaVictima) {
		if (self.esDeBuenaCalidad()) {
			unaVictima.dormirConLosPeces()
		}
	}

	method esDeBuenaCalidad() {
		return calidad.equals("Buena")
	}

	method esSutil() {
		return true
	}

}

object escopeta {

	method usarArma(unaVictima) {
		if (unaVictima.estaHerido()) {
			unaVictima.dormirConLosPeces()
		} else {
			unaVictima.herir()
		}
	}

	method esSutil() {
		return false
	}

}

