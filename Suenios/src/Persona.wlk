class Persona {

	const sueniosPendientes = #{}
	const property sueniosCumplidos = #{}
	const edad
	const carreras = #{}
	const carrerasRecibidas = #{}
	const plataDeseada
	const lugaresDeseados = #{}
	var hijos
	var felicidad = 0
	var tipo

	method agregarSuenioCumplido(unSuenio) {
		sueniosPendientes.remove(unSuenio)
		sueniosCumplidos.add(unSuenio)
	}

	method aumentarFelicidad(unaCantidad) {
		felicidad += unaCantidad
	}

	method quiereEstudiar(unaCarrera) {
		return carreras.contains(unaCarrera)
	}

	method seRecibio(unaCarrera) {
		return carrerasRecibidas.contains(unaCarrera)
	}

	method recibirse(unaCarrera) {
		carrerasRecibidas.add(unaCarrera)
	}

	method plataDeseada() {
		return plataDeseada
	}

	method tieneHijo() {
		return hijos > 0
	}

	method agregarHijos(unaCantidad) {
		hijos += unaCantidad
	}

	method viajarA(unLugar) {
		lugaresDeseados.remove(unLugar)
	}

	method cumplirSuenios(unosSuenios) {
		return unosSuenios.all({ unSuenio => self.puedeCumplir(unSuenio) })
	}

	method puedeCumplir(unSuenio) {
		return unSuenio.puedeSerCumplidoPor(self)
	}

	method esFeliz() {
		return felicidad > sueniosPendientes.sum({ unSuenio => unSuenio.felicidad() })
	}

	method esAmbicioso() {
		return self.ambiciosos(sueniosPendientes) + self.ambiciosos(sueniosCumplidos) > 3
	}

	method ambiciosos(unosSuenios) {
		return unosSuenios.filter({ unSuenio => unSuenio.esAmbicioso() }).size()
	}
	
	method cumplir(unSuenio) {
		unSuenio.cumplirSuenio(self)
	}
	
	method cumplirSuenioElegido() {
		const suenioElegido = tipo.elegirSuenio(sueniosPendientes)
		suenioElegido.cumplirSuenio(self)
	}

}

object realista inherits Persona {

	method elegirSuenio(sueniosPendientes) {
		return sueniosPendientes.max({ unSuenio => unSuenio.felicidad() })
	}

}

object alocado inherits Persona {

	method elegirSuenio(sueniosPendientes) {
		return sueniosPendientes.anyOne()
	}

}

object obsesivo inherits Persona {

	method elegirSuenio(sueniosPendientes) {
		return sueniosPendientes.head()
	}

}

