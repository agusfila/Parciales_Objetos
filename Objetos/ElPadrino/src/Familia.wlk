import Miembro.*
import Armas.*

class Familia {

	const apellido
	var donDeLaFamilia
	const miembros = #{}
	const traiciones = #{}
	const maximaLealtad

	method maximaLealtad() {
		return maximaLealtad
	}

	method donDeLaFamilia(nuevoDon) {
		nuevoDon.subordinados(donDeLaFamilia.subordinados())
		self.eliminarMiembro(donDeLaFamilia)
		donDeLaFamilia = nuevoDon
		miembros.add(nuevoDon)
	}

	method apellido() {
		return apellido
	}

	method subordinadosDelDon() {
		return miembros.filter({ unMiembro => !unMiembro.esDon() })
	}

	method subordinadosDelSubJefe() {
		return self.subordinadosDelDon().filter({ unSubordinado => !unSubordinado.esSubJefe() })
	}

	method elMasPeligroso() {
		return miembros.filter({ unMiembro => !unMiembro.duermeConLosPeces() }).max({ unMiembro => unMiembro.cantidadDeArmas() })
	}

	method ataqueSorpresa(otraFamilia) {
		miembros.forEach({ unMiembro => unMiembro.atacarA(otraFamilia)})
	}

	method estanTodosMuertos() {
		return miembros.all({ unMiembro => unMiembro.duermeConLosPeces() })
	}

	method protegerDeLaOlaDeCrimenes() {
		miembros.forEach({ unMiembro => unMiembro.agregarArma(new Revolver(balas = 6))})
	}

	method luto() {
		miembros.filter({ unMiembro => unMiembro.soldadoConMasDe5Armas()}).forEach({ unSoldado => unSoldado.convertirASubjefe()})
		self.miembroMasLeal().convertirADon()
		miembros.forEach({ unMiembro => unMiembro.aumentarLealtad(0.1)})
	}

	method miembroMasLeal() {
		return miembros.filter({ unMiembro => unMiembro.despachaElegantemente() }).max({ unMiembro => unMiembro.lealtad() })
	}

	method lealtadPromedio() {
		return miembros.sum({ unMiembro => unMiembro.lealtad() }) / miembros.size()
	}

	method eliminarMiembro(unMiembro) {
		miembros.remove(unMiembro)
	}

	method aniadirSoldado(unMiembro) {
		unMiembro.convertirASoldado()
		miembros.add(unMiembro)
	}

	method recordarTraicion(unaTraicion) {
		traiciones.add(unaTraicion)
	}

}

