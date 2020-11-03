class Pocion {

	const ingredientes = []

	method serTomadaPor(unaPersona) {
		ingredientes.forEach({ unIngrediente => unIngrediente.aplicarEfecto(unaPersona, ingredientes.size())} )
	}

}

object dulceDeLeche {

	method aplicarEfecto(unaPersona, unosIngredientes) {
		unaPersona.sumarFuerza(10)
		if(unaPersona.estaFueraDeCombate()) {
			unaPersona.sumarResistencia(2)
		}
	}

}

class HongosSilvestres {

	var cantidadHongos

	method aplicarEfecto(unaPersona, unosIngredientes) {
		if (cantidadHongos > 5) {
			unaPersona.disminuirResistenciaALaMitad()
		}
		unaPersona.sumarFuerza(10)
	}

}

class Grog {

	method aplicarEfecto(unaPersona, unosIngredientes) {
		unaPersona.vecesMasFuerte(unosIngredientes)
	}

}

class GrogXD inherits Grog {

	override method aplicarEfecto(unaPersona, unosIngredientes) {
		super(unaPersona, unosIngredientes)
		unaPersona.duplicarResistencia()
	}

}

