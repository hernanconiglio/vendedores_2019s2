import geografia.*

class Vendedor {
	var property certificaciones = []
	
	method esVersatil() {
		return self.certificaciones().size() >= 3
		and self.certificaciones().any( { c=>c.esSobreProductos() } )
		and not self.certificaciones().any( { c=>c.esSobreProductos() } )
	}
	
	method esFirme() {
		return certificaciones.sum( { c=>c.puntos() } ) >= 30	
	}
	
	method esInfluyente() //para que sea clase abstracta
	
	method puntajeTotalPorCertificaciones() {
		return certificaciones.sum( { c=>c.puntos() } )
	}
	
	method esGenerico() {
		return certificaciones.any( { c=> not c.esSobreProductos() } )
	}
	
	method agregarCertificacion(certif) {
		certificaciones.add(certif)
	}
	
	method puedeTrabajarEn(unaCiudad)
	
	method tieneAfinidadCon(unCentro) {
		return self.puedeTrabajarEn(unCentro.ciudad())
	}
}


class VendedorFijo inherits Vendedor {
	var property ciudadDondeVive
	
	override method puedeTrabajarEn(unaCiudad) {
		return self.ciudadDondeVive() == unaCiudad
	}
	
	override method esInfluyente() = false
}

class Viajante inherits Vendedor {
	var property provinciasHabilitadas = #{}
	
	override method puedeTrabajarEn(unaCiudad) {
		return provinciasHabilitadas.contains(unaCiudad.provincia())
	}
	
	override method esInfluyente() {
		return provinciasHabilitadas.sum( { p=>p.poblacion() } ) >= 10000000
	}
}

class ComercioCoresponsal inherits Vendedor {
	var property sucursalesEnCiudades = #{} 
	
	override method puedeTrabajarEn(unaCiudad) {
		return sucursalesEnCiudades.contains(unaCiudad)
	}
	
	override method esInfluyente() {
		return sucursalesEnCiudades.size() >=5 
		or sucursalesEnCiudades.map( { c=>c.provincia() } ).asSet().size() >= 3
	}
	
	override method tieneAfinidadCon(unCentro) {
		return super()
		
	}
}


class Certificaciones {
	var property puntos
	var property esSobreProductos
}
 
