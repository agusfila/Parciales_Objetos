import Minions.*

class Maldad {

	const minions = []
	var property ciudad = null

	method asignarMinions(unosMinions) {
		unosMinions.forEach({ unMinion => minions.add(unMinion)})
	}
	
	method participo(unMinion) {
		return minions.contains(unMinion)
	}

}

class Congelar inherits Maldad {

	var property concentracionMinima = 500

	method aceptaA(unMinion) {
		return unMinion.tieneArma("Rayo Congelante")
	}

	method realizarMaldad() {
		if (!minions.isEmpty()) {
			ciudad.disminuirGrados(30)
			minions.forEach({ unMinion => unMinion.alimentar(10)})
		} else {
			throw new Exception(message = "No se puede realizar la Maldad.")
		}
	}

}

class Robar inherits Maldad {

	var property cosaARobar

	method aceptaA(unMinion) {
		return unMinion.esPeligroso() && cosaARobar.aceptaA(unMinion)
	}

	method realizarMaldad() {
		if (!minions.isEmpty()) {
			if (ciudad.tiene(cosaARobar)) {
				cosaARobar.robar(minions)
			} else {
				throw new Exception(message = "La Ciudad no tiene la cosa a robar.")
			}
		} else {
			throw new Exception(message = "No se puede realizar la Maldad.")
		}
	}

}

class Ciudad {

	var property cosas = []
	var property grados

	method disminuirGrados(unosGrados) {
		grados -= unosGrados
	}

	method tiene(unaCosa) {
		return cosas.contains(unaCosa)
	}

}

class Piramide {

	var altura

	method aceptaA(unMinion) {
		return unMinion.nivelDeConcentracion() >= altura / 2
	}

	method robar(unosMinions) {
		unosMinions.forEach({ unMinion => unMinion.alimentar(10)})
	}

}

object sueroMutante {

	method aceptaA(unMinion) {
		return unMinion.nivelDeConcentracion() >= 23 && unMinion.estaBienAlimentado()
	}

	method robar(unosMinions) {
		unosMinions.forEach({ unMinion => unMinion.absorberSuertoMutante()})
	}

}

object laLuna {

	method aceptaA(unMinion) {
		return unMinion.tieneArma("Rayo para encoger")
	}

	method robar(unosMinions) {
		unosMinions.forEach({ unMinion => unMinion.otorgarArma(new Arma(nombre = "Rayo Congelante", potencia = 10))})
	}

}

