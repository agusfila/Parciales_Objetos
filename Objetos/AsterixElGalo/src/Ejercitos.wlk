class Ejercito {

	const personas = []
	const personasQueVanAdelante = 10

	method poder() {
		return personas.filter({ unaPersona => !unaPersona.estaFueraDeCombate() }).sum({ unaPersona => unaPersona.poder() })
	}

	method recibirDanio(unDanio) {
		self.personasQueVanAdelante().forEach({ unaPersona => unaPersona.recibirDanio(unDanio / personas.size())})
	}

	method personasQueVanAdelante() {
		return personas.sortedBy({ unaPersona , otraPersona => unaPersona.poder() > otraPersona.poder() }).take(personasQueVanAdelante)
	}

	method pelearCon(unEnemigo) {
		if (self.todosFueraDeCombate()) {
			throw new Exception(message = "No hay personas disponibles para pelear")
		} else {
			self.menosPoderoso(unEnemigo).recibirDanio(self.diferenciaDePoderCon(unEnemigo))
		}
	}

	method todosFueraDeCombate() {
		return personas.all({ unaPersona => unaPersona.estaFueraDeCombate() })
	}

	method menosPoderoso(unEnemigo) {
		if (unEnemigo.poder() > self.poder()) {
			return self
		} else {
			return unEnemigo
		}
	}

	method diferenciaDePoderCon(unEnemigo) {
		return (self.poder() - unEnemigo.poder()).abs()
	}

}

class Legion inherits Ejercito {

	var poderMinimo
	var formacion

	override method poder() {
		return formacion.poder(super())
	}

	override method recibirDanio(unDanio) {
		formacion.recibirDanio(unDanio)
		if (self.poder() < poderMinimo) {
			formacion = formacionTortuga
		}
	}

}

object formacionTortuga {

	method poder(unPoder) {
		return 0
	}

	method recibirDanio(unDanio) {
	}

}

class FormacionEnCuadro {

	var personasQueVanAdelante

	method poder(unPoder) {
		return unPoder
	}
	
	method recibirDanio(unDanio) {
		//NO SE RESOLVERLo
	}

}

object formacionFrontemAllargate {

	method poder(unPoder) {
		return unPoder * 1.1
	}
	
	method recibirDanio(unDanio) {
		//NO SE RESOLVERLo
	}

}

const legion = new Legion(poderMinimo = 100, formacion = new FormacionEnCuadro(personasQueVanAdelante = 20))
