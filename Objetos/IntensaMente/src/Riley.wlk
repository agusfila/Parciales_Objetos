import Recuerdos.*

object riley {

	const edad = 12
	var property felicidad = 1000
	var property emocionDominante
	const recuerdosDelDia = []
	const pensamientosCentrales = #{}
	const memoriaLargoPlazo = []

	method vivirEvento(unaDescripcion) {
		const unRecuerdo = new Recuerdo(descripcion = unaDescripcion, fecha = new Date(), emocionDominante = emocionDominante, poseedor = self)
		recuerdosDelDia.add(unRecuerdo)
	}

	method disminuirFelicidad(unPorcentaje) {
		const resta = (felicidad - felicidad * unPorcentaje)
		if (resta >= 1) {
			felicidad = resta
		} else {
			throw new Exception(message = "Felicidad por debajo de uno")
		}
	}

	method agregarPensamientoCentral(unRecuerdo) {
		pensamientosCentrales.add(unRecuerdo)
	}

	method recuerdosRecientesDelDia() {
		return recuerdosDelDia.drop(recuerdosDelDia.size() - 5)
	}

	method pensamientosCentrales() {
		return pensamientosCentrales
	}

	method pensamientosCentralesDificilesDeExplicar() {
		return self.pensamientosCentrales().filter({ unRecuerdo => unRecuerdo.dificilDeExplicar() })
	}

	method niega(unRecuerdo) {
		return emocionDominante.niega(unRecuerdo)
	}

	method dormir(unosProcesos) {
		unosProcesos.forEach({ unProceso => unProceso.ocurrir(self)})
	}

	method asentarRecuerdosDelDia() {
		recuerdosDelDia.forEach({ unRecuerdo => unRecuerdo.asentarseEn(self)})
	}

	method asentarRecuerdosDelDiaQueTengan(palabraClave) {
		recuerdosDelDia.filter({ unRecuerdo => unRecuerdo.tiene(palabraClave)}).forEach({ unRecuerdo => unRecuerdo.asentarseEn(self)})
	}

	method recuerdosProfundos() {
		return recuerdosDelDia.filter({ unRecuerdo => !unRecuerdo.esCentral(self) }).filter({ unRecuerdo => !unRecuerdo.esNegado(self) })
	}

	method esCentral(unRecuerdo) {
		return pensamientosCentrales.contains(unRecuerdo)
	}

	method agregarALargoPlazo(unosRecuerdos) {
		unosRecuerdos.forEach({ unRecuerdo => unRecuerdo.agregarALargoPlazo(self)})
	}

	method agregarLargoPlazo(unRecuerdo) {
		memoriaLargoPlazo.add(unRecuerdo)
	}

	method pensamientoCentralEnLargoPlazo() {
		return pensamientosCentrales.any({ unRecuerdo => unRecuerdo.estaEnLargoPlazo(self) })
	}

	method estaEnLargoPlazo(unRecuerdo) {
		return memoriaLargoPlazo.contains(unRecuerdo)
	}

	method recuerdosDelDiaConMismaEmocion() {
		recuerdosDelDia.all({ unRecuerdo => unRecuerdo.emocionDominante().equals(emocionDominante)})
	}

	method perder3PensamientosCentralesMasAntiguos() {
	}

	method sumarFelicidad(unosPuntos) {
		felicidad = (felicidad + unosPuntos).min(1000)
	}

	method liberarRecuerdosDelDia() {
		recuerdosDelDia.clear()
	}

	method rememorar() {
		const eventoRememorado = self.algunRecuerdoRememorado()
		self.vivirEvento(eventoRememorado)
	}

	method algunRecuerdoRememorado() {
		return memoriaLargoPlazo.filter({ unRecuerdo => unRecuerdo.puedeSerRememorado(edad) }).anyOne()
	}

	method vecesEnLargoPlazo(unRecuerdo) {
		return memoriaLargoPlazo.occurrencesOf(unRecuerdo)
	}

	method estaTeniendoUnDejaVu(unRecuerdo) {
		return memoriaLargoPlazo.contains(unRecuerdo)
	}

}

class Emocion {

	method asentarseEn(unaPersona, unRecuerdo) {
	}

	method niega(unRecuerdo) {
		return false
	}

	method esAlegre() {
		return false
	}

}

object alegria inherits Emocion {

	override method asentarseEn(unaPersona, unRecuerdo) {
		if (unaPersona.felicidad() > 500) {
			unRecuerdo.convertirseEnPensamientoCentralDe(unaPersona)
		}
	}

	override method niega(unRecuerdo) {
		return !unRecuerdo.esAlegre()
	}

	override method esAlegre() {
		return true
	}

}

object tristeza inherits Emocion {

	override method asentarseEn(unaPersona, unRecuerdo) {
		unRecuerdo.convertirseEnPensamientoCentralDe(unaPersona)
		unaPersona.disminuirFelicidad(0.1)
	}

	override method niega(unRecuerdo) {
		return unRecuerdo.esAlegre()
	}

}

class EmocionCompuesta inherits Emocion {

	const emociones = #{}

	override method esAlegre() {
		return emociones.any({ unaEmocion => unaEmocion.esAlegre() })
	}

	override method niega(unRecuerdo) {
		return emociones.all({ unaEmocion => unaEmocion.niega(unRecuerdo) })
	}

	override method asentarseEn(unaPersona, unRecuerdo) {
		emociones.forEach({ unaEmocion => unaEmocion.asentarseEn(unaPersona, unRecuerdo)})
	}

}

object disgusto inherits Emocion {

}

object furia inherits Emocion {

}

object temor inherits Emocion {

}

object asentamiento {

	method ocurrir(unaPersona) {
		unaPersona.asentarRecuerdosDelDia()
	}

}

class AsentamientoSelectivo {

	const palabraClave

	method ocurrir(unaPersona) {
		unaPersona.asentarRecuerdosDelDiaQueTengan(palabraClave)
	}

}

object profundizacion {

	method ocurrir(unaPersona) {
		const unosRecuerdos = unaPersona.recuerdosProfundos()
		unaPersona.agregarALargoPlazo(unosRecuerdos)
	}

}

object controlHormonal {

	method ocurrir(unaPersona) {
		if (unaPersona.pensamientoCentralEnLargoPlazo() || unaPersona.recuerdosDelDiaConMismaEmocion()) {
			unaPersona.disminuirFelicidad(0.15)
			unaPersona.perder3PensamientosCentralesMasAntiguos()
		}
	}

}

object restauracionCognitiva {

	method ocurrir(unaPersona) {
		unaPersona.sumarFelicidad(100)
	}

}

object liberacionDeRecuerdosDelDia {

	method ocurrir(unaPersona) {
		unaPersona.liberarRecuerdosDelDia()
	}

}

