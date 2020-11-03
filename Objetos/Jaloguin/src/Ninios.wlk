import Legiones.*

class Ninio {

	const property elementos = []
	var property actitud
	var property caramelos = 0
	var salud = sano

	method capacidadDeSusto() {
		return elementos.sum({ unElemento => unElemento.sustoQueGenera() }) * actitud
	}

	method intentarAsustarA(unAdulto) {
		unAdulto.serAsustadoPor(self)
	}

	method recibirCaramelos(unosCaramelos) {
		caramelos += unosCaramelos
	}

	method restarCaramelos(unosCaramelos) {
		caramelos -= unosCaramelos
	}

	method tieneMasCaramelosQue(unosCaramelos) {
		return caramelos > unosCaramelos
	}

	method crearLegion(unosNinios) {
		if (unosNinios.size() <= 2) {
			throw new Exception(message = "No se puede crear legion")
		} else {
			return new Legion(miembros = unosNinios)
		}
	}

	method comerCaramelos(unosCaramelos) {
		if (caramelos < unosCaramelos) {
			throw new Exception(message = "No hay suficientes caramelos.")
		} else {
			salud.comerCaramelos(unosCaramelos, self)
		}
	}

	method reducirActitudALaMitad() {
		actitud /= 2
	}

	method salud(unaSalud) {
		salud = unaSalud
	}

}

object sano {

	method comerCaramelos(unosCaramelos, unNinio) {
		if (unosCaramelos > 10) {
			unNinio.reducirActitudALaMitad()
			unNinio.salud(empachado)
		}
		unNinio.restarCaramelos(unosCaramelos)
	}

}

object empachado {

	method comerCaramelos(unosCaramelos, unNinio) {
		if (unosCaramelos > 10) {
			unNinio.actitud(0)
			unNinio.salud(enCama)
		}
		unNinio.restarCaramelos(unosCaramelos)
	}

}

object enCama {

	method comerCaramelos(unosCaramelos, unNinio) {
		throw new Exception(message = "El ninio no puede comer mas caramelos.")
	}

}

object maquillaje {

	method sustoQueGenera() {
		return 3
	}

}

class Traje {

	var representante

	method sustoQueGenera() {
		if (representante.esTierno()) {
			return 2
		} else {
			return 5
		}
	}

}

class Representante {

	const property esTierno

}

