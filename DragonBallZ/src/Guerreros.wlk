class Guerrero {

	var property potencialOfensivo
	var experiencia
	var energiaOriginal
	var energia
	var traje

	method atacar(otroGuerrero) {
		otroGuerrero.serAtacado(potencialOfensivo * 0.1)
	}

	method serAtacado(unaEnergia) {
		traje.recibirDanio(unaEnergia, self)
	}

	method disminuirEnergia(unaEnergia) {
		energia = (energia - unaEnergia).max(0)
	}

	method comerSemillaDelErmitanio() {
		energia = energiaOriginal
	}

	method modificarExperiencia(unPorcentaje) {
		experiencia *= unPorcentaje
	}

	method aumentarExperiencia(unaExperiencia) {
		experiencia += unaExperiencia
	}
	
	method elementos() {
		traje.elementos()
	}

}

class Saiyan inherits Guerrero {

	var superSaiyan = false
	var nivel

	method convertirseEnSuperSaiyan() {
		potencialOfensivo *= 1.5
		superSaiyan = true
	}

	override method serAtacado(unaEnergia) {
		traje.recibirDanio(unaEnergia, self)
		if (energia < energiaOriginal * 0.01) {
			self.volverAEstadoOriginal()
		}
	}

	override method comerSemillaDelErmitanio() {
		super()
		potencialOfensivo *= 1.05
	}

	override method disminuirEnergia(unaEnergia) {
		nivel.disminuirEnergia(unaEnergia, self)
	}

	method volverAEstadoOriginal() {
		energia = energiaOriginal
		nivel = nivel0
	}

}

object nivel0 {

	method disminuirEnergia(unaEnergia, unGuerrero) {
		unGuerrero.disminuirEnergia(unaEnergia)
	}

}

object nivel1 {

	method disminuirEnergia(unaEnergia, unGuerrero) {
		unGuerrero.disminuirEnergia(unaEnergia * 0.95)
	}

}

object nivel2 {

	method disminuirEnergia(unaEnergia, unGuerrero) {
		unGuerrero.disminuirEnergia(unaEnergia * 0.93)
	}

}

object nivel3 {

	method disminuirEnergia(unaEnergia, unGuerrero) {
		unGuerrero.disminuirEnergia(unaEnergia * 0.85)
	}

}

class Traje {

	var desgaste = 0

	method recibirDanio(unaEnergia, unGuerrero) {
		desgaste = (desgaste + 5).min(100)
	}

	method estaGastado() {
		return desgaste.equals(100)
	}
	
	method elementos() {
		return 1
	}

}

class TrajeComun inherits Traje {

	const porcentajeReduccion

	override method recibirDanio(unaEnergia, unGuerrero) {
		if (self.estaGastado()) {
			unGuerrero.disminuirEnergia(unaEnergia)
		} else {
			super(unaEnergia, unGuerrero)
			unGuerrero.disminuirEnergia(unaEnergia * porcentajeReduccion)
		}
	}

}

object trajeDeEntrenamiento inherits Traje {

	var property porcentaje = 2

	override method recibirDanio(unaEnergia, unGuerrero) {
		super(unaEnergia, unGuerrero)
		unGuerrero.disminuirEnergia(unaEnergia)
		unGuerrero.modificarExperiencia(porcentaje)
	}

}

class TrajeModularizado inherits Traje {

	const piezas = []

	override method estaGastado() {
		return piezas.all({ unaPieza => unaPieza.estaGastada() })
	}

	override method recibirDanio(unaEnergia, unGuerrero) {
		self.aumentarExperiencia(unGuerrero)
		if (self.estaGastado()) {
			unGuerrero.disminuirEnergia(unaEnergia)
		} else {
			const danio = unaEnergia - self.resistenciaDePiezasNoGastadas()
			unGuerrero.disminuirEnergia(danio)
		}
	}

	method resistenciaDePiezasNoGastadas() {
		return piezas.filter({ unaPieza => !unaPieza.estaGastada() }).sum({ unaPieza => unaPieza.porcentajeResistencia() })
	}

	method aumentarExperiencia(unGuerrero) {
		const experiencia = piezas.size() - self.piezasGastadas() / piezas.size()
		unGuerrero.aumentarExperiencia(experiencia)
	}

	method piezasGastadas() {
		return piezas.filter({ unaPieza => unaPieza.estaGastada() }).size()
	}
	
	override method elementos() {
		return piezas.size()
	}

}

class Pieza {

	var property porcentajeResistencia
	var property desgaste

	method estaGastada() {
		return desgaste >= 20
	}

}

