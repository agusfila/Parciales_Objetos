class Persona {

	var property posicion
	const property elementosCerca = []
	const comidas = []
	var criterio
	var criterioComida

	method pedir(unElemento, otraPersona) {
		if (otraPersona.tiene(unElemento)) {
			otraPersona.pasar(unElemento, self)
		} else {
			throw new Exception (message = "No puede realizarse la accion.")
		}
	}

	method tiene(unElemento) {
		return elementosCerca.contains(unElemento)
	}

	method pasar(unElemento, otraPersona) {
		criterio.leDa(unElemento, otraPersona, self)
	}

	method agregarElementoCerca(unElemento) {
		elementosCerca.add(unElemento)
	}

	method eliminarElementoCerca(unElemento) {
		elementosCerca.remove(unElemento)
	}

	method comer(unaComida) {
		if (self.eligeComer(unaComida)) {
			comidas.add(unaComida)
		}
	}

	method eligeComer(unaComida) {
		return criterioComida.come(unaComida)
	}

	method estaPipon() {
		return comidas.all({ unaComida => unaComida.esPesada() })
	}

	method laEstaPasandoBien() {
		return !comidas.isEmpty()
	}

	method comioCarne() {
		return comidas.any({ unaComida => unaComida.esCarne() })
	}

}

object osky inherits Persona {

	override method laEstaPasandoBien() {
		return true
	}

}

object moni inherits Persona {

	override method laEstaPasandoBien() {
		return self.posicion().equals(1)
	}

}

object facu inherits Persona {

	override method laEstaPasandoBien() {
		return self.comioCarne()
	}

}

object vero inherits Persona {

	override method laEstaPasandoBien() {
		return elementosCerca.size() <= 3
	}

}

object vegetariano {

	method come(unaComida) {
		return !unaComida.esCarne()
	}

}

object dietetico {

	var caloriasMinimas = 500

	method caloriasMinimas(nuevasCalorias) {
		caloriasMinimas = nuevasCalorias
	}

	method come(unaComida) {
		return unaComida.calorias() < caloriasMinimas
	}

}

object alternado {

	method come(unaComida) {
		return [ true, false ].anyOne()
	}

}

class CombinacionCriterios {

	const criterios = []

	method come(unaComida) {
		return criterios.all({ unCriterio => unCriterio.come(unaComida) })
	}

}

object sordo {

	method leDa(unElemento, otraPersona, unaPersona) {
		const elemento = unaPersona.elementosCerca().first()
		otraPersona.agregarElementoCerca(elemento)
		unaPersona.eliminarElementoCerca(elemento)
	}

}

object comeTranquilo {

	method leDa(unElemento, otraPersona, unaPersona) {
		unaPersona.elementosCerca().forEach({ otroElemento =>
			otraPersona.agregarElementoCerca(otroElemento)
			unaPersona.eliminarElementoCerca(otroElemento)
		})
	}

}

object charlatan {

	method leDa(unElemento, otraPersona, unaPersona) {
		const posicionA = otraPersona.posicion()
		const posicionB = unaPersona.posicion()
		otraPersona.posicion(posicionB)
		unaPersona.posicion(posicionA)
	}

}

object normal {

	method leDa(unElemento, otraPersona, unaPersona) {
		otraPersona.agregarElementoCerca(unElemento)
		unaPersona.eliminarElementoCerca(unElemento)
	}

}

class Comida {

	var property nombre
	var property esCarne
	var property calorias

	method esPesada() {
		return calorias > 500
	}

}

