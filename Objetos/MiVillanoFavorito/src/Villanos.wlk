import Minions.*

class Villano {

	const minions = []
	const ciudad
	const maldades = []

	method nuevoMinion() {
		minions.add(new Minion(bananas = 5, armas = [ new Arma(nombre = "Rayo Congelante", potencia = 10) ]))
	}

	method planificarMaldad(unaMaldad) {
		const minionsParaMaldad = minions.filter({ unMinion => unMinion.puedeParticipar(unaMaldad) })
		unaMaldad.asignarMinions(minionsParaMaldad)
		unaMaldad.ciudad(ciudad)
		maldades.add(unaMaldad)
	}

	method minionMasUtil() {
		return minions.max({ unMinion => unMinion.participaciones(maldades) })
	}

	method minionsInutiles() {
		return minions.filter({ unMinion => unMinion.participaciones(maldades) == 0 })
	}

}

