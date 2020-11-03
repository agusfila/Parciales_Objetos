class Legion {

	const miembros = #{}

	method capacidadDeSusto() {
		return miembros.sum({ unMiembro => unMiembro.capacidadDeSusto() })
	}

	method cantidadDeCaramelos() {
		return miembros.sum({ unMiembro => unMiembro.caramelos() })
	}

	method lider() {
		return miembros.max({ unMiembro => unMiembro.capacidadDeSusto() })
	}

	method intentarAsustar(unAdulto) {
		unAdulto.serAsustadoPor(self)
	}

	method recibirCaramelos(unosCaramelos) {
		self.lider().recibirCaramelos(unosCaramelos)
	}

}

