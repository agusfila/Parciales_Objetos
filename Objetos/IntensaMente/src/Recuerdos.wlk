import Riley.*

class Recuerdo {

	const descripcion
	const fecha
	var property poseedor
	var property emocionDominante
	

	method asentarseEn(unaPersona) {
		emocionDominante.asentarseEn(unaPersona, self)
	}

	method convertirseEnPensamientoCentralDe(unaPersona) {
		unaPersona.agregarPensamientoCentral(self)
	}

	method dificilDeExplicar() {
		return descripcion.words().size() > 10
	}
	
	method esAlegre() {
		return emocionDominante.esAlegre()
	}
	
	method tiene(palabraClave) {
		return descripcion.contains(palabraClave)
	}
	
	method esCentral(unaPersona) {
		return unaPersona.esCentral(self)
	}
	
	method esNegado(unaPersona) {
		return unaPersona.niega(self)
	}
	
	method agregarALargoPlazo(unaPersona) {
		unaPersona.agregarLargoPlazo(self)
	}
	
	method estaEnLargoPlazo(unaPersona) {
		return unaPersona.estaEnLargoPlazo(self)
	}
	
	method puedeSerRememorado(unaEdad) {
		return fecha.year() > unaEdad //ESTA MAL
	}
	
	method repeticionesEnLargoPlazo(unaPersona) {
		return unaPersona.vecesEnLargoPlazo(self)
	}

}