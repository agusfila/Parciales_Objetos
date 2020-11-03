class Persona {

	var fuerza
	var resistencia

	method sumarFuerza(unosPuntos) {
		fuerza += unosPuntos
	}

	method disminuirResistenciaALaMitad() {
		resistencia /= 2
	}

	method duplicarResistencia() {
		resistencia *= 2
	}

	method vecesMasFuerte(unasVeces) {
		fuerza *= unasVeces
	}

	method poder() {
		return fuerza * resistencia
	}

	method recibirDanio(unDanio) {
		resistencia = (resistencia - unDanio).max(0)
	}

	method tomarPocionMagica(unaPocion) {
		unaPocion.serTomadaPor(self)
	}

	method estaFueraDeCombate() {
		return resistencia.equals(0)
	}

	method sumarResistencia(unosPuntos) {
		resistencia += 2
	}

}

