import Minions.*
import Roles.*

class ArreglarUnaMaquina {

	const herramientas = []
	const complejidad

	method puedeSerRealizadaPor(unMinion) {
		return (unMinion.estaminaMayorOIgualA(complejidad)) && (unMinion.tiene(herramientas))
	}

	method dificultad(unMinion) {
		return complejidad * 2
	}

	method serRealizadaPor(unMinion) {
		unMinion.arreglarMaquina(complejidad)
	}

}

class DefenderUnSector {

	const gradoDeAmenaza

	method puedeSerRealizadaPor(unMinion) {
		return (unMinion.rol() != mucama) && (unMinion.fuerza() >= gradoDeAmenaza)
	}

	method dificultad(unMinion) {
		return unMinion.dificultadDefenderUnSector(gradoDeAmenaza)
	}

	method serRealizadaPor(unMinion) {
		unMinion.defenderSector()
	}

}

class LimpiarUnSector {

	const property dificultad
	const esGrande

	method puedeSerRealizadaPor(unMinion) {
		return unMinion.estaminaMayorOIgualA(self.estaminaRequerida())
	}

	method dificultad(unMinion) {
		return dificultad
	}

	method serRealizadaPor(unMinion) {
		unMinion.limpiarSector(self.estaminaRequerida())
	}

	method estaminaRequerida() {
		if (esGrande) {
			return 4
		} else {
			return 1
		}
	}

}

