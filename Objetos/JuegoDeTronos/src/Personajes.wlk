import Conspiraciones.*

//////////////
//PERSONAJES//
//////////////

class Personaje {

	const property casa
	const conyuges = #{}
	var property estaVivo = true
	const acompaniantes = #{}
	var property personalidad

	method puedeCasarseCon(unPersonaje) {
		return casa.puedenCasarse(self, unPersonaje)
	}

	method casarseCon(unPersonaje) {
		if (self.puedeCasarseCon(unPersonaje)) {
			conyuges.add(unPersonaje)
		} else {
			throw new Exception (message = "No pueden Casarse.")
		}
	}

	method tienePareja() {
		return conyuges.size() >= 1
	}

	method patrimonio() {
		return casa.patrimonioPorMiembro()
	}

	method estaSolo() {
		return acompaniantes.isEmpty()
	}

	method aliados() {
		return conyuges.union(acompaniantes).union(casa.companieros(self))
	}

	method esPeligroso() {
		return estaVivo && (self.aliadosSuman10000() || self.conyugesDeCasaRica() || self.algunAliadoPeligroso())
	}

	method aliadosSuman10000() {
		return self.aliados().sum({ unAliado => unAliado.patrimonio() }) >= 10000
	}

	method conyugesDeCasaRica() {
		return conyuges.all({ unConyuge => unConyuge.esDeCasaRica() })
	}

	method esDeCasaRica() {
		return casa.esRica()
	}

	method algunAliadoPeligroso() {
		return self.aliados().any({ unAliado => unAliado.esPeligroso() })
	}

	method crearConspiracion(unEnemigo, unosComplotados) {
		if (unEnemigo.esPeligroso()) {
			return new Conspiracion(enemigo = unEnemigo, complotados = unosComplotados)
		} else {
			throw new Exception(message = "El enemigo no es Peligroso")
		}
	}

	method esAliadoDe(unPersonaje) {
		return unPersonaje.aliados().contains(self)
	}

	method ejecutarAccionConspirativa(unEnemigo) {
		personalidad.realizarAccion(unEnemigo)
	}

	method morir() {
		estaVivo = false
	}

	method derrocharDineroDeLaCasa(unPorcentaje) {
		casa.derrocharDinero(unPorcentaje)
	}

}

class Animal inherits Personaje {

	override method patrimonio() {
		return 0
	}

}

object dragon inherits Animal {

	override method esPeligroso() {
		return true
	}

}

class Lobo inherits Animal {

	var esHuargo

	override method esPeligroso() {
		return esHuargo
	}

}


//////////////////
//PERSONALIDADES//
//////////////////

object sutil {

	method realizarAccion(unEnemigo) {
		const novie = [ lannister, stark, guardiaDeLaNoche ].min({ unaCasa => unaCasa.dinero() }).algunIntegranteVivoYSoltero()
		unEnemigo.casarseCon(novie)
	}

}

class Asesino {

	method realizarAccion(unEnemigo) {
		unEnemigo.morir()
	}

}

object asesinoPrecavido inherits Asesino {

	override method realizarAccion(unEnemigo) {
		if (unEnemigo.estaSolo()) {
			super(unEnemigo)
		}
	}

}

object disipado {

	const porcentaje = 0.5

	method realizarAccion(unEnemigo) {
		unEnemigo.derrocharDineroDeLaCasa(porcentaje)
	}

}

object miedoso {

	method realizarAccion(unEnemigo) {
	}

}

/////////
//CASAS//
/////////

class Casa {

	var property dinero = 0
	const miembros = #{}

	method esRica() {
		return dinero > 1000
	}

	method puedenCasarse(unPersonaje, otroPersonaje) {
		return true
	}

	method patrimonioPorMiembro() {
		return dinero / miembros.size()
	}

	method companieros(unPersonaje) {
		const companieros = miembros
		companieros.remove(unPersonaje)
		return companieros
	}

	method derrocharDinero(unPorcentaje) {
		dinero = dinero - (dinero * unPorcentaje)
	}

	method algunIntegranteVivoYSoltero() {
		return miembros.filter({ unMiembro => unMiembro.estaVivo() && !unMiembro.tienePareja() }).anyOne()
	}

}

object lannister inherits Casa {

	override method puedenCasarse(unPersonaje, otroPersonaje) {
		return !(unPersonaje.tienePareja())
	}

}

object stark inherits Casa {

	override method puedenCasarse(unPersonaje, otroPersonaje) {
		return unPersonaje.casa() != otroPersonaje.casa()
	}

}

object guardiaDeLaNoche inherits Casa {

	override method puedenCasarse(unPersonaje, otroPersonaje) {
		return false
	}

}

