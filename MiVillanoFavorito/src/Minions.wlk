class Minion {

	var property bananas
	const armas = []
	var tipo = minionAmarillo

	method esPeligroso() {
		return tipo.esPeligroso(self)
	}

	method absorberSuertoMutante() {
		tipo.absorberSuertoMutante(self)
	}

	method convertir(unTipo) {
		tipo = unTipo
	}

	method restarBananas(unasBananas) {
		bananas = (bananas - unasBananas).max(0)
	}

	method perderArmas() {
		armas.clear()
	}

	method cantidadDeArmas() {
		return armas.size()
	}

	method nivelDeConcentracion() {
		return tipo.concentracion(self)
	}

	method potenciaArmas() {
		return armas.sum({ unArma => unArma.potencia() })
	}

	method otorgarArma(unArma) {
		armas.add(unArma)
	}

	method alimentar(unasBananas) {
		bananas += unasBananas
	}

	method puedeParticipar(unaMaldad) {
		return unaMaldad.aceptaA(self)
	}

	method tieneArma(unNombre) {
		return armas.any({ unArma => unArma.nombre().equals(unNombre) })
	}
	
	method estaBienAlimentado() {
		return bananas >= 100
	}
	
	method participaciones(unasMaldades) {
		return unasMaldades.count({unaMaldad => unaMaldad.participo(self)})
	}

}

object minionAmarillo {

	method esPeligroso(unMinion) {
		return unMinion.cantidadDeArmas() > 2
	}

	method absorberSuertoMutante(unMinion) {
		unMinion.convertir(minionVioleta)
		unMinion.perderArmas()
		unMinion.restarBananas(1)
	}

	method concentracion(unMinion) {
		return unMinion.potenciaArmas() + unMinion.bananas()
	}

}

object minionVioleta {

	method esPeligroso(unMinion) {
		return true
	}

	method absorberSuertoMutante(unMinion) {
		unMinion.convertir(minionAmarillo)
		unMinion.restarBananas(1)
	}

	method concentracion(unMinion) {
		return unMinion.bananas()
	}

}

class Arma {

	var property nombre
	var property potencia

}

