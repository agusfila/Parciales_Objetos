class Adulto {

	var niniosConMasDe15CaramelosQueIntentaronAsustarlo = 0

	method serAsustadoPor(alguien) {
		if (self.tolerancia() < alguien.capacidadDeSusto()) {
			alguien.recibirCaramelos(self.caramelosQueEntrega())
		} else {
			if (alguien.tieneMasDe15Caramelos()) {
				niniosConMasDe15CaramelosQueIntentaronAsustarlo++
			}
		}
	}


	method tolerancia() {
		return niniosConMasDe15CaramelosQueIntentaronAsustarlo * 10
	}

	method caramelosQueEntrega() {
		return self.tolerancia() / 2
	}

}

class Abuelo inherits Adulto {

	override method serAsustadoPor(alguien) {
		alguien.recibirCaramelos(self.caramelosQueEntrega())
	}

	override method caramelosQueEntrega() {
		return super() / 2
	}

}

class AdultoNecio inherits Adulto {

	override method serAsustadoPor(alguien) {
	}

}

