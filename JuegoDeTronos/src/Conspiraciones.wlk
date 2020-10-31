class Conspiracion {
	
	const enemigo
	const complotados = #{}
	
	method traidores() {
		return complotados.filter({unComplotado => unComplotado.esAliadoDe(enemigo)})
	}
	
	method ejecutar() {
		complotados.forEach({unComplotado => unComplotado.ejecutarAccionConspirativa(enemigo)})
	}
	
	method seCumplioElObjetivo() {
		return !enemigo.esPeligroso()
	}
}
