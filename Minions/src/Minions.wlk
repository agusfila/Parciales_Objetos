class Minion {

	var property estamina
	var property rol
	const herramientas = []
	const tareasRealizadas = []

	method asignarRol(unRol) {
		rol = unRol
		rol.asignar(self)
	}

	method agregarHerramientas(unasHerramientas) {
		unasHerramientas.forEach({ unaHerramienta => herramientas.add(unaHerramienta)})
	}

	method comerFruta(unaFruta) {
		unaFruta.comer()
	}

	method sumarEstamina(unosPuntos) {
		estamina += unosPuntos
	}

	method perderEstamina(unosPuntos) {
		estamina -= unosPuntos
	}

	method realizar(unaTarea) {
		if (unaTarea.puedeSerRealizadaPor(self)) {
			rol.realizar(unaTarea, self)
			tareasRealizadas.add(unaTarea)
		} else {
			throw new Exception(message = "Este minion no puede realizar esta tarea.")
		}
	}

	method tiene(unasHerramientas) {
		unasHerramientas.all({ unaHerramienta => herramientas.contains(unaHerramienta)})
	}

	method fuerza() {
		return rol.fuerza(self)
	}

	method estaminaMayorOIgualA(unNumero) {
		return estamina >= unNumero
	}

	method arreglarMaquina(unaComplejidad) {
		estamina -= unaComplejidad
	}

	method defenderSector() {
		rol.defenderSector(self)
	}

	method perderMitadDeStamina() {
		estamina = estamina / 2
	}

	method limpiarSector(unaEstamina) {
		rol.limpiarSector(unaEstamina, self)
	}

	method experiencia() {
		return tareasRealizadas.size() * tareasRealizadas.sum({ unaTarea => unaTarea.dificultad(self) })
	}

}

class Biclope inherits Minion {

	override method sumarEstamina(unosPuntos) {
		estamina = (estamina + unosPuntos).min(10)
	}

	method dificultadDefenderUnSector(gradoDeAmenaza) {
		return gradoDeAmenaza
	}

}

class Ciclope inherits Minion {

	override method fuerza() {
		return super() / 2
	}

	method dificultadDefenderUnSector(gradoDeAmenaza) {
		return gradoDeAmenaza * 2
	}

}

