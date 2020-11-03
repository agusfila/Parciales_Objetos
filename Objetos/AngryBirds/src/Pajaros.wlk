import Isla.*

class Pajaro {

	var property ira
	var property homenajeado = false
	
	method homenajear() {
		homenajeado = true
	}

	method fuerza() {
		return ira * 2
	}

	method enojarse() {
		ira *= 2
	}

	method esFuerte() {
		return self.fuerza() > 50
	}

	method tranquilizar() {
		ira -= 5
	}
	
	method lanzarAIslaCerdito() {
		islaCerdito.impactoAlObstaculoMasCercano(self)
	}
	
	method puedeDerribarObstaculo(unObstaculo) {
		return self.fuerza() > unObstaculo.resistencia()
	}

}

class Rencoroso inherits Pajaro {

	var cantidadDeVecesEnojado = 0

	override method fuerza() {
		return ira * 10 * cantidadDeVecesEnojado
	}

	override method enojarse() {
		super()
		cantidadDeVecesEnojado++
	}

}

object red inherits Rencoroso {

}

object terence inherits Rencoroso {

	var property multiplicador = 1

	override method fuerza() {
		return super() * multiplicador
	}

}


object bomb inherits Pajaro {

	var property fuerzaMaxima = 9000

	override method fuerza() {
		return super().min(fuerzaMaxima)
	}

}

object chuck inherits Pajaro {

	var property velocidad = 0

	override method fuerza() {
		if (velocidad <= 80) {
			return 150
		} else {
			return 150 + (5 * velocidad - 80)
		}
	}

	override method enojarse() {
		velocidad *= 2
	}

	override method tranquilizar() {
	}

}

object matilda inherits Pajaro {

	const huevos = []

	override method fuerza() {
		return super() + self.fuerzaHuevos()
	}

	method fuerzaHuevos() {
		return huevos.sum({ unHuevo => unHuevo.peso() })
	}

	override method enojarse() {
		huevos.add(new Huevo(peso = 2))
	}

}

class Huevo {

	const peso

	method peso() {
		return peso
	}

}