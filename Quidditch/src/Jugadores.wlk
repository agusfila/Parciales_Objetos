import Escobas.*
import Pelotas.*

class Jugador {

	var skills
	var peso
	var escoba
	var equipo
	var property punteria
	var property fuerza
	var property nivelReflejos
	var property nivelVision

	method manejoDeEscoba() {
		return skills / peso
	}

	method velocidad() {
		return escoba.velocidad() * self.manejoDeEscoba()
	}

	method habilidad() {
		return self.velocidad() + skills
	}

	method lePasaElTrapoA(unJugador) {
		return self.habilidad() >= unJugador.habilidad()
	}

	method esGroso() {
		return self.habilidadMayorQueElPromedio() && self.velocidadMayorQueLaArbitraria()
	}

	method habilidadMayorQueElPromedio() {
		return self.habilidad() > equipo.habilidadPromedio()
	}

	method velocidadMayorQueLaArbitraria() {
		return self.velocidad() > mercadoDeEscobas.velocidadArbitraria()
	}

	method lePasaElTrapoATodos(unEquipo) {
		return unEquipo.lesPasaElTrapo(self)
	}

	method sumarSkills(unosPuntos) {
		skills += unosPuntos
	}

	method restarSkills(unosPuntos) {
		skills -= unosPuntos
	}

	method esCazador() {
		return false
	}

	method perteneceA(unEquipo) {
		return equipo.equals(unEquipo)
	}

	method serGolpeadoPorUnaBludger(unEquipo) {
		bludger.golpearA(self)
	}

	method recibirGolpeEnEscoba() {
		escoba.recibirGolpe()
	}

}

class Cazador inherits Jugador {

	override method habilidad() {
		return super() + self.punteria() * self.fuerza()
	}

	method jugar(unEquipo) {
		if (quaffle.laTiene() == self) {
			self.intentarMeterGol(unEquipo)
			self.perderQuaffle(unEquipo)
		}
	}

	method perderQuaffle(unEquipo) {
		const otroJugador = unEquipo.cazadorMasRapido()
		quaffle.laTiene(otroJugador)
	}

	method intentarMeterGol(unEquipo) {
		if (!unEquipo.puedeBloquearTiro(self)) {
			equipo.sumarPuntos(10)
			self.sumarSkills(5)
		} else {
			self.restarSkills(2)
			unEquipo.sumarPuntos(10)
		}
	}

	method puedeBloquearTiro(unCazador) {
		return self.lePasaElTrapoA(unCazador)
	}

	override method esCazador() {
		return true
	}

	method esBlancoUtil() {
		return quaffle.laTiene().equals(self)
	}

	override method serGolpeadoPorUnaBludger(equipo) {
		super(equipo)
		if (quaffle.laTiene().equals(self)) {
			self.perderQuaffle(equipo)
		}
	}

}

class Guardian inherits Jugador {

	override method habilidad() {
		return super() + self.nivelReflejos() + self.fuerza()
	}

	method puedeBloquearTiro(unCazador) {
		return [ 1, 2, 3 ].anyOne().equals(3)
	}

	method esBlancoUtil() {
		return quaffle.laTiene().perteneceA(equipo)
	}
	
	method jugar(unEquipo) {
		
	}

}

class Golpeador inherits Jugador {

	override method habilidad() {
		return super() + self.punteria() + self.fuerza()
	}

	method puedeBloquearTiro(unCazador) {
		return self.esGroso()
	}

	method jugar(unEquipo) {
		const blancoUtil = unEquipo.algunBlancoUtil()
		if (self.puedeGolpearA(blancoUtil)) {
			blancoUtil.serGolpeadoPorUnaBludger(equipo)
			self.sumarSkills(1)
		}
	}

	method puedeGolpearA(unJugador) {
		return (self.punteria() > unJugador.nivelReflejos()) || ((1..10).atRandom() >= 8)
	}

	method esBlancoUtil() {
		return false
	}

}

class Buscador inherits Jugador {

	var turnosBuscandoLaSnitch = 0
	var kmRecorridos = 0
	var estaBuscandoSnitch = true

	override method habilidad() {
		return super() + self.nivelReflejos() * self.nivelVision()
	}

	method puedeBloquearTiro(unCazador) {
		return false
	}

	method jugar(unEquipo) {
		if (!estaBuscandoSnitch) {
			if (kmRecorridos >= 5000) {
				self.atraparSnitch()
			}
		} else {
			self.buscarSnitch()
		}
		self.sumarKmRecorridos()
	}

	method sumarKmRecorridos() {
		kmRecorridos += self.velocidad() / 1.6
	}

	method buscarSnitch() {
		const numeroObtenido = (1..1000).atRandom()
		if (numeroObtenido < (self.habilidad() + turnosBuscandoLaSnitch)) {
			estaBuscandoSnitch = false
		}
		turnosBuscandoLaSnitch++
	}

	method atraparSnitch() {
		self.sumarSkills(10)
		equipo.sumarPuntos(150)
		snitch.laTiene(self)
	}

	method esBlancoUtil() {
		return ((5000 - kmRecorridos) < 1000 ) || estaBuscandoSnitch
	}

	override method serGolpeadoPorUnaBludger(equipo) {
		super(equipo)
		self.reiniciarBusqueda()
	}

	method reiniciarBusqueda() {
		kmRecorridos = 0
		estaBuscandoSnitch = true
		turnosBuscandoLaSnitch = 0
	}

}

object mercadoDeEscobas {

	var property velocidadArbitraria = 50

}

