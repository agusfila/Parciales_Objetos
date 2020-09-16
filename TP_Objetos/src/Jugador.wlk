import Tirador.*
import Pasador.*
import Rebotador.*

class Jugador {

	var eficaciaTriple
	const nivelInteligencia
	var talento
	const altura

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

	method aumentarEficacia(unosPuntos) {
		eficaciaTriple += unosPuntos
	}

	method aumentarTalento(unosPuntos) {
		talento += unosPuntos
	}

	method esLeyenda() {
		const estiloTirador = new Tirador(eficaciaTriple = self.eficaciaTriple(), nivelInteligencia = self.nivelInteligencia(), altura = self.altura(), talento = self.talento())
		const estiloPasador = new Pasador(eficaciaTriple = self.eficaciaTriple(), nivelInteligencia = self.nivelInteligencia(), altura = self.altura(), talento = self.talento())
		const estiloRebotador = new Rebotador(eficaciaTriple = self.eficaciaTriple(), nivelInteligencia = self.nivelInteligencia(), altura = self.altura(), talento = self.talento())
		const estilos = [ estiloTirador, estiloPasador, estiloRebotador ]
		return estilos.all({ estilo => estilo.esCrack() })
	}

}

