import Tirador.*
import Pasador.*
import Rebotador.*

class Jugador {

	var eficaciaTriple
	const nivelInteligencia
	var talento
	const altura
	const esSucio
	var stamina = 100

	method esSucio() {
		return esSucio
	}
	
	method eficaciaTriple() {
		return eficaciaTriple
	}

	method talento() {
		return talento
	}

	method nivelInteligencia() {
		return nivelInteligencia
	}

	method altura() {
		return altura
	}
	
	method stamina() {
		return stamina
	}

	method aumentarEficacia(unosPuntos) {
		eficaciaTriple += unosPuntos
	}

	method aumentarTalento(unosPuntos) {
		talento += unosPuntos
	}

	method esLeyenda() {
		const estiloTirador = new Tirador(eficaciaTriple = self.eficaciaTriple(), nivelInteligencia = self.nivelInteligencia(), altura = self.altura(), talento = self.talento(), esSucio = self.esSucio())
		const estiloPasador = new Pasador(eficaciaTriple = self.eficaciaTriple(), nivelInteligencia = self.nivelInteligencia(), altura = self.altura(), talento = self.talento(), esSucio = self.esSucio())
		const estiloRebotador = new Rebotador(eficaciaTriple = self.eficaciaTriple(), nivelInteligencia = self.nivelInteligencia(), altura = self.altura(), talento = self.talento(), esSucio = self.esSucio())
		const estilos = [ estiloTirador, estiloPasador, estiloRebotador ]
		return estilos.all({ estilo => estilo.esCrack() })
	}
	
	method habilidad()
	
	method habilidadFinal() {
		return self.habilidad() - self.cansancio()
	}
	
	method cansancio() {
		return 100 - stamina
	}
	
	method esCrack() {
		return self.habilidad() > 90
	}
	
	method entrenar()
	
	method reducirStamina(unaCantidad) {
		stamina = (stamina - unaCantidad).max(0)
	}
	
	method descansar(unValor) {
		stamina = (stamina + unValor).min(100)
	}
	
	method pierdeMenosDe5PuntosDeStaminaAlEntrenar()
	
	method convertirseEnTirador() {
		return new Tirador(eficaciaTriple = self.eficaciaTriple(), nivelInteligencia = self.nivelInteligencia(), altura = self.altura(), talento = self.talento(), esSucio = self.esSucio())
		
	}

}