class Nimbus {
	
	var anioFabricacion
	var porcentajeSalud
	
	method velocidad() {
		return (80 - (new Date().year() - anioFabricacion)) * porcentajeSalud
	}
	
	method recibirGolpe() {
		porcentajeSalud -= 0.1
	}
}

object saetaDeFuego {
	
	method velicdad() {
		return 100
	}
	
	method recibirGolpe() {
		
	}
}