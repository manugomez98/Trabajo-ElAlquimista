object alquimista {
	var itemsDeCombate = []
	var itemsDeExploracion = #{}
	
	method agregarItem(Item){
		itemsDeCombate.add(Item)
	}
		method agregarItemDeExploracion(){
		return itemsDeExploracion.size()
	}
	method capacidadOfensiva(){
		return itemsDeCombate.sum {item => item.capacidadOfensiva{}}
	}
	method tieneCriterio() {
		return self.cantidadDeItemsDeCombateEfectivos() >= self.cantidadDeItemsDeCombate() 
	}
	
	method cantidadDeItemsDeCombateEfectivos() {
		return itemsDeCombate.count({itemDeCombate => itemDeCombate.esEfectivo()})
	}
	
	method cantidadDeItemsDeCombate() {
		return itemsDeCombate.size()
	}
	
	method esBuenExplorador() {
		return self.cantidadDeItemsDeExploracion() > 3
	}
	
	method cantidadDeItemsDeExploracion() {
		return itemsDeExploracion.size()
	}
	
	method capacidadOfensiva() {
		return itemsDeCombate.sum({itemDeCombate => itemDeCombate.capacidadOfensiva()})
	}
	
	method esProfesional() {
		return self.calidadPromedioDeItems() > 50 and self.todosSusItemsDeCombateEfectivos() and self.esBuenExplorador()
	}
	
	method calidadPromedioDeItems() {
		return (itemsDeCombate.sum({itemDeCombate => itemDeCombate.calidad()}) +
			itemsDeExploracion.sum({itemDeExploracion => itemDeExploracion.calidad()})) / self.cantidadDeItems()
	}
	
	method cantidadDeItems() {
		return itemsDeCombate.size() + itemsDeExploracion.size()
	}
	
	method todosSusItemsDeCombateEfectivos() {
		return itemsDeCombate.all({itemDeCombate => itemDeCombate.esEfectivo()})
	}
}

object bomba {
	var materiales = []
	var danio = 150
	
	method esEfectivo() {
		return danio > 100
	}
	
	method capacidadOfensiva() {
		return danio / 2
	}
	
	method calidad() {
		return materiales.min({material => material.calidad()}).calidad()
	}
}

object pocion {
	var materiales = []
	var poderCurativo = 25
	
	method esEfectivo() {
		return poderCurativo > 50 and self.fueCreadoConMaterialMistico()
	}
	
	method fueCreadoConMaterialMistico() {
		return materiales.any({material => material.esMistico()})
	}
	
	method capacidadOfensiva() {
		return poderCurativo + 10 * self.cantidadDeMaterialesMisticos()
	}
	
	method cantidadDeMaterialesMisticos() {
		return materiales.count({material => material.esMistico()})
	}
	
	method calidad() {
		if (self.fueCreadoConMaterialMistico()) return materiales.find({material => material.esMistico()}).calidad()
		return materiales.head().calidad()
	}
}

object debilitador {
	var materiales = []
	var potencia = 1
	
	method esEfectivo() {
		return potencia > 0 and self.fueCreadoConMaterialMistico().negate()
	}
	
	method fueCreadoConMaterialMistico() {
		return materiales.any({material => material.esMistico()})
	}
	
	method cantidadDeMaterialesMisticos() {
		return materiales.count({material => material.esMistico()})
	}
	
	method capacidadOfensiva() {
		if(self.fueCreadoConMaterialMistico()) return 5
		return 12 * self.cantidadDeMaterialesMisticos()
	}
	
	method calidad() {
		return self.dosMaterialesDeMayorCalidad().sum({material => material.calidad()})
	}
	
	method dosMaterialesDeMayorCalidad() {
		return materiales.sortedBy({unMaterial, otroMaterial => unMaterial.calidad() > otroMaterial.calidad()}).take(2)
	}
}


object itemDeRecoleccion {
	var materiales = []
	
	method calidad() {
		return 30 + self.calidadTotalDeMateriales() / 10
	}
	
	method calidadTotalDeMateriales() {
		return materiales.sum({material => material.calidad()})
	}
}