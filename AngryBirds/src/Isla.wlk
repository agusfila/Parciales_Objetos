import Pajaros.*

/////////
//ISLAS//
/////////
object islaPajaro {

	const pajaros = [ red, bomb, chuck, terence, matilda ]

	method pajarosFuertes() {
		return pajaros.filter({ unPajaro => unPajaro.esFuerte() })
	}

	method fuerza() {
		return pajaros.sum({ unPajaro => unPajaro.fuerza() })
	}

	method tranquilizarPajaros() {
		pajaros.forEach({ unPajaro => unPajaro.tranquilizar()})
	}

	method enojarPajaros() {
		pajaros.forEach({ unPajaro => unPajaro.enojarse()})
	}

	method ningunPajaroHomenajeado() {
		return pajaros.all({ unPajaro => !unPajaro.homenajeado() })
	}

	method enojarPajarosHomenajeados() {
		pajaros.filter({ unPajaro => unPajaro.homenajeado()}).forEach({ unPajaro => unPajaro.enojarse()})
	}

	method atacarIslaCerdito() {
		pajaros.forEach({ unPajaro => unPajaro.lanzarAIslaCerdito()})
	}

	method agregarPajaro(unPajaro) {
		pajaros.add(unPajaro)
	}

}

object islaCerdito {

	const obstaculos = []

	method impactoAlObstaculoMasCercano(unPajaro) {
		if (obstaculos.isEmpty()) {
			throw new Exception(message = "Se recuperaron los huevos!")
		} else {
			const obstaculoAImpactar = obstaculos.first()
			obstaculoAImpactar.serImpactadoPor(unPajaro)
		}
	}

	method obstaculoDerribado(unObstaculo) {
		obstaculos.remove(self)
	}

}

//////////////
//OBSTACULOS//
//////////////
class Obstaculo {

	method resistencia()

	method serImpactadoPor(unPajaro) {
		if (unPajaro.puedeDerribarObstaculo(self)) {
			islaCerdito.obstaculoDerribado(self)
		}
	}

}

class ParedDeVidrio inherits Obstaculo {

	const anchoDePared

	override method resistencia() {
		return 10 * anchoDePared
	}

}

class ParedDeMadera inherits Obstaculo {

	const anchoDePared

	override method resistencia() {
		return 25 * anchoDePared
	}

}

class ParedDePiedra inherits Obstaculo {

	const anchoDePared

	override method resistencia() {
		return 50 * anchoDePared
	}

}

object cerditoObrero inherits Obstaculo {

	override method resistencia() {
		return 50
	}

}

class CerditoConCasco inherits Obstaculo {

	const resistenciaCasco

	override method resistencia() {
		return 10 * resistenciaCasco
	}

}

class CerditoConEscudo inherits Obstaculo {

	const resistenciaEscudo

	override method resistencia() {
		return 10 * resistenciaEscudo
	}

}

///////////
//EVENTOS//
///////////
object manejoDeIraConmatilda {

	method realizarEvento(unaIsla) {
		unaIsla.tranquilizarPajaros()
	}

}

class InvasionDeCerditos {

	const cantidad

	method realizarEvento(unaIsla) {
		(cantidad % 100).times({ _ => unaIsla.enojarPajaros()})
	}

}

object fiestaSorpresa {

	method realizarEvento(unaIsla) {
		if (unaIsla.ningunPajaroHomenajeado()) {
			throw new Exception(message = "No hay pajaros homenajeados")
		} else {
			unaIsla.enojarPajarosHomenajeados()
		}
	}

}

class EventosDesafortunados {

	const eventos = []

	method realizarEvento(unaIsla) {
		eventos.forEach({ unEvento => unEvento.realizarEvento(unaIsla)})
	}

}

