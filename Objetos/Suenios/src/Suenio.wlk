class Suenio {

	const felicidad
	
	method felicidad() {
		return felicidad
	}

	method cumplirSuenio(unaPersona) {
		unaPersona.agregarSuenioCumplido(self)
		unaPersona.aumentarFelicidad(felicidad)
	}

	method noSePuedeCumplirSuenio() {
		throw new Exception(message = "No se puede cumplir Suenio")
	}

	method puedeSerCumplidoPor(unaPersona) {
		return true
	}
	
	method esAmbicioso() {
		return self.felicidad() > 100
	}

}

class Recibirse inherits Suenio {

	const carrera

	override method cumplirSuenio(unaPersona) {
		if (self.puedeSerCumplidoPor(unaPersona)) {
			super(unaPersona)
			unaPersona.recibirse(carrera)
		} else {
			self.noSePuedeCumplirSuenio()
		}
	}

	override method puedeSerCumplidoPor(unaPersona) {
		return unaPersona.quiereEstudiar(carrera) && !unaPersona.seRecibio(carrera)
	}

}

class Adoptar inherits Suenio {

	const cantidad

	override method cumplirSuenio(unaPersona) {
		if (self.puedeSerCumplidoPor(unaPersona)) {
			super(unaPersona)
			unaPersona.agregarHijos(cantidad)
		} else {
			self.noSePuedeCumplirSuenio()
		}
	}

	override method puedeSerCumplidoPor(unaPersona) {
		return !unaPersona.tieneHijo()
	}

}

class ConseguirTrabajo inherits Suenio {

	const trabajo

	override method cumplirSuenio(unaPersona) {
		if (self.puedeSerCumplidoPor(unaPersona)) {
			super(unaPersona)
		} else {
			self.noSePuedeCumplirSuenio()
		}
	}

	override method puedeSerCumplidoPor(unaPersona) {
		return trabajo.plataGanada() >= unaPersona.plataDeseada()
	}

}

class TenerUnHijo inherits Suenio {
	
	override method cumplirSuenio(unaPersona) {
		super(unaPersona)
		unaPersona.agregarHijos(1)
	}

}

class SuenioMultiple inherits Suenio {

	const suenios = #{}

	override method cumplirSuenio(unaPersona) {
		if (self.puedeSerCumplidoPor(unaPersona)) {
			self.cumplirSuenios(unaPersona)
		} else {
			self.noSePuedeCumplirSuenio()
		}
	}

	override method puedeSerCumplidoPor(unaPersona) {
		return unaPersona.puedeCumplir(suenios)
	}

	method cumplirSuenios(unaPersona) {
		suenios.forEach({ unSuenio => unSuenio.cumplirSuenio(unaPersona)})
	}
	
	override method felicidad() {
		return suenios.sum({unSuenio => unSuenio.felicidad()})
	}

}

class Viajar inherits Suenio {

	const lugar

	override method cumplirSuenio(unaPersona) {
		super(unaPersona)
		unaPersona.viajarA(lugar)
	}

}

class Trabajo {

	const property plataGanada

}

