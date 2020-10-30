class Vikingo {

	var castaSocial = jarl
	var hijos
	var armas
	var hectareas
	var vidasCobradas
	var monedas = 0
	
	method agregarMonedas(unasMonedas) {
		monedas += unasMonedas
	}
	
	method vidasCobradas() {
		return vidasCobradas
	}
	
	method agregarVidaCobrada() {
		vidasCobradas++
	}
	
	method cantidadDeHijos() {
		return hijos
	}

	method hectareas() {
		return hectareas
	}

	method tieneArmas() {
		return armas > 0
	}

	method esProductivo()

	method ascenderAKarl() {
		castaSocial = karl
	}
	
	method ascenderAThrall() {
		castaSocial = thrall
	}

	method puedeIrAExpedicion() {
		return self.esProductivo() && self.castaSocialLePermiteIrAExpedicion()
	}

	method castaSocialLePermiteIrAExpedicion() {
		return castaSocial.lePermiteIrAExpedicion(self)
	}

}

class Soldado inherits Vikingo {

	override method esProductivo() {
		return (self.vidasCobradas() > 20) && self.tieneArmas()
	}

	override method ascenderAKarl() {
		super()
		armas += 10
	}

}

class Granjreo inherits Vikingo {

	override method esProductivo() {
		return self.hectareas() >= 2 * self.cantidadDeHijos()
	}

	override method ascenderAKarl() {
		super()
		hijos += 2
		hectareas += 2
	}

}

object thrall {

	method lePermiteIrAExpedicion(unVikingo) {
		return true
	}

}

object karl {

	method lePermiteIrAExpedicion(unVikingo) {
		return true
	}

}

object jarl {

	method lePermiteIrAExpedicion(unVikingo) {
		return !(unVikingo.tieneArmas())
	}

}

