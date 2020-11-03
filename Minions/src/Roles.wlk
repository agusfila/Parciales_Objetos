class Rol {

	method fuerza(unMinion) {
		return unMinion.estamina() / 2 + 2
	}

	method asignar(unMinion) {
	}

	method defenderSector(unMinion) {
		unMinion.perderMitadDeStamina()
	}

	method limpiarSector(unaEstamina, unMinion) {
		unMinion.perderEstamina(unaEstamina)
	}

	method realizar(unaTarea, unMinion) {
		unaTarea.serRealizadaPor(unMinion)
	}

}

class Soldado inherits Rol {

	var danioPorPractica = 0

	override method asignar(unMinion) {
		danioPorPractica = 0
	}

	override method fuerza(unMinion) {
		return super(unMinion) + danioPorPractica
	}

}

class Obrero inherits Rol {

	const herramientas = []

	override method asignar(unMinion) {
		unMinion.agregarHerramientas(herramientas)
	}

}

object mucama inherits Rol {

	override method limpiarSector(unaEstamina, unMinion) {
	}

}

class Capataz inherits Rol {

	const empleados = #{}

	override method realizar(unaTarea, unMinion) {
		const minionExperto = self.empleadoMasExperto(unaTarea, unMinion)
		unaTarea.serRealizadaPor(minionExperto)
	}
	
	method empleadoMasExperto(unaTarea, unMinion) {
		const empleadosQuePuedenRealizarTarea = empleados.filter({unEmpleado => unaTarea.puedeSerRealizadaPor(unEmpleado)})
		if(empleadosQuePuedenRealizarTarea.isEmpty()) {
			return unMinion
		} else {
			return empleadosQuePuedenRealizarTarea.max({unEmpleado => unEmpleado.experiencia()})
		}
	}

}

