class Traicion {

	const familiaTraicionada
	const nuevaFamilia
	const victimas = #{}
	var fechaTentativa

	method adelantarFecha(unaFecha) {
		fechaTentativa = unaFecha
	}

	method aniadirVictima(otraVictima) {
		victimas.add(otraVictima)
	}

	method ejecutarTraicion(unMiembro) {
		if (unMiembro.lealtadPromedioFamilia() > unMiembro.lealtad() * 2) {
			unMiembro.dormirConLosPeces()
		} else {
			self.atacarVictimas(unMiembro)
			unMiembro.abandonarFamilia()
			unMiembro.incorporarseA(nuevaFamilia)
		}
		familiaTraicionada.recordarTraicion(self)
	}

	method atacarVictimas(unMiembro) {
		victimas.forEach({ unaVictima => unMiembro.hacerSuTrabajo(unaVictima)})
	}

}

