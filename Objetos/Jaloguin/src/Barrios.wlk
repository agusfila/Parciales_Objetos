class Barrio {

	const ninios = []
	
	method tresNiniosConMasCaramelos() {
		return ninios.sortedBy{unNinio,otroNinio => unNinio.caramelos() > otroNinio.caramelos()}.take(3)
	}
	
	method elementosUsadosPorNiniosConMasDe10Caramelos() {
		return ninios.filter({unNinio => unNinio.tieneMasCaramelosQue(10)}).map({unNinio => unNinio.elementos()}).withoutDuplicates()
	}

}

