import Armas.*

object don {

	method usarArmas(unaVictima, unMiembro) {
		if (unMiembro.esDeLaFamilia("Corleone")) {
			self.ordenarSubordinado(unaVictima, unMiembro)
		}
		self.ordenarSubordinado(unaVictima, unMiembro)
	}

	method ordenarSubordinado(unaVictima, unMiembro) {
		unMiembro.algunSubordinado().hacerSuTrabajo(unaVictima)
	}

	method esElegante(unMiembro) {
		return true
	}

	method subordinadosPorRango(unaFamilia) {
		return unaFamilia.subordinadosDelDon()
	}

	method armas() {
		return #{}
	}

}

object subJefe {

	method armas() {
		return #{}
	}

	method usarArmas(unaVictima, unMiembro) {
		const armaAUsar = unMiembro.algunArma()
		unMiembro.eliminarArma(armaAUsar)
		armaAUsar.usarArma(unaVictima)
	}

	method esElegante(unMiembro) {
		return unMiembro.algunSubordinadoElegante()
	}

	method subordinadosPorRango(unaFamilia) {
		return unaFamilia.subordinadosDelSubJefe()
	}

}

object soldado {

	method usarArmas(unaVictima, unMiembro) {
		unMiembro.usarAlgunArma(unaVictima)
	}

	method esElegante(unMiembro) {
		return unMiembro.tieneArmaSutil()
	}

	method subordinadosPorRango(unaFamilia) {
		return #{}
	}

	method armas() {
		return #{ escopeta }
	}

}

