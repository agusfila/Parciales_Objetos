import Armas.*
import Traicion.*
import Rangos.*

class Miembro {

	var rango = null
	var lealtad
	var familia
	var armas = #{}
	var subordinados = #{}
	var estaHerido = false
	var estaMuerto = false
	var traicion = null
	
	method asignarRango(unRango) {
		rango = unRango
		subordinados = rango.subordinadosPorRango(familia)
		armas = rango.armas()
	}
	
	method algunArma() {
		return armas.anyOne()
	}

	method subordinados(unosSubordinados) {
		subordinados = unosSubordinados
	}

	method subordinados() {
		return subordinados
	}

	method algunSubordinado() {
		return subordinados.anyOne()
	}

	method lealtad() {
		return lealtad
	}

	method estaHerido() {
		return estaHerido
	}

	method herir() {
		estaHerido = true
	}

	method dormirConLosPeces() {
		estaMuerto = true
	}

	method duermeConLosPeces() {
		return estaMuerto
	}

	method agregarArma(unArma) {
		armas.add(unArma)
	}

	method cantidadDeArmas() {
		return armas.size()
	}

	method familia() {
		return familia
	}

	method hacerSuTrabajo(unaVictima) {
		if (armas.isEmpty()) {
			throw new Exception(message = "No hay armas disponible para hacer su trabajo")
		} else {
			rango.usarArmas(unaVictima, self)
		}
	}

	method esDeLaFamilia(unApellido) {
		return familia.equals(unApellido)
	}

	method esDon() {
		return rango.equals(don)
	}

	method esSubJefe() {
		return rango.equals(subJefe)
	}

	method despachaElegantemente() {
		return rango.esElegante(self)
	}

	method tieneArmaSutil() {
		return armas.any({ unArma => unArma.esSutil() })
	}

	method atacarA(unaFamilia) {
		if (unaFamilia.estanTodosMuertos()) {
			throw new Exception(message = "Concluyo el ataque")
		} else {
			self.hacerSuTrabajo(unaFamilia.elMasPeligroso())
		}
	}

	method soldadoConMasDe5Armas() {
		return self.esSoldado() && (armas.size() > 5)
	}

	method esSoldado() {
		return rango.equals(soldado)
	}

	method convertirASubjefe() {
		rango = subJefe
		subordinados = #{}
	}

	method sinSubordinados() {
		subordinados = #{}
	}

	method convertirADon() {
		rango = don
		familia.donDeLaFamilia(self)
	}

	method aumentarLealtad(unPorcentaje) {
		lealtad = lealtad * (1 + unPorcentaje)
	}

	method planearTraicionFamiliar(unaVictima, unaFecha, unaFamilia) {
		traicion = new Traicion(victimas = #{ unaVictima }, fechaTentativa = unaFecha, nuevaFamilia = unaFamilia, familiaTraicionada = familia)
	}

	method seComplicoLaTraicion(unaVictima, nuevaFecha) {
		traicion.adelantarFecha(nuevaFecha)
		traicion.aniadirVictima(unaVictima)
	}

	method ejecutraTraicionFamiliar() {
		traicion.ejecutarTraicion(self)
	}

	method lealtadPromedioFamilia() {
		return familia.lealtadPromedio()
	}

	method abandonarFamilia() {
		familia.eliminarMiembro(self)
	}

	method convertirASoldado() {
		rango = soldado
	}

	method incorporarseA(nuevaFamilia) {
		lealtad = nuevaFamilia.maximaLealtad()
		familia = nuevaFamilia
		familia.aniadirSoldado(self)
	}

	method eliminarArma(unArma) {
		armas.remove(unArma)
	}

	method algunSubordinadoElegante() {
		return subordinados.any({ unSubordinado => unSubordinado.tieneArmaSutil() })
	}

	method usarAlgunArma(unaVictima) {
		self.algunArma().usarArma(unaVictima)
	}

}

