class Expedicion {

	const vikingos = #{}
	const lugaresAInvadir = #{}

	method valeLaPena() {
		if (vikingos.size() > 0) {
			return lugaresAInvadir.all({ unLugar => unLugar.valeLaPena(vikingos) })
		} else {
			throw new Exception (message = "No hay vikingos en la expedicion.")
		}
	}

	method subirAExpedicion(unVikingo) {
		if (unVikingo.puedeIrAExpedicion()) {
			vikingos.add(unVikingo)
		} else {
			throw new Exception (message = "Este vikingo no puede subir a la expedicion.")
		}
	}

	method realizarExpedicion() {
		lugaresAInvadir.forEach({ unLugar => unLugar.invadir(vikingos)})
	}

}

class Aldea {

	var crucifijos

	method valeLaPena(unosVikingos) {
		return self.botin() >= 15
	}

	method botin() {
		return crucifijos
	}

	method invadir(unosVikingos) {
		unosVikingos.forEach({ unVikingo => unVikingo.agregarMonedas(self.botin() / unosVikingos.size()) })
		crucifijos = 0
	}

}

class AldeaAmurallada inherits Aldea {

	const vikingosMinimosEnLaComitiva

	override method valeLaPena(unosVikingos) {
		return unosVikingos.size() >= vikingosMinimosEnLaComitiva  && super(unosVikingos)
	}

}

class Capital {

	var defensores
	const riqueza

	method valeLaPena(unosVikingos) {
		return self.botin() / unosVikingos.size() >= 3
	}

	method botin() {
		return defensores * riqueza
	}


	method invadir(unosVikingos) {
		unosVikingos.forEach({ unVikingo => unVikingo.agregarMonedas(self.botin() / unosVikingos.size())})
		defensores -= unosVikingos.size()
		unosVikingos.forEach({ unVikingo => unVikingo.agregarVidaCobrada()})
	}

}

