%primeraMarca(Marca)
primeraMarca(laSerenisima).
primeraMarca(gallo).
primeraMarca(vienisima).

%precioUnitario(Producto,Precio)
%donde Producto puede ser arroz(Marca), lacteo(Marca,TipoDeLacteo), salchicas(Marca,Cantidad)
precioUnitario(arroz(gallo),25.10).
precioUnitario(lacteo(laSerenisima,leche), 6.00).
precioUnitario(lacteo(laSerenisima,crema), 4.00).
precioUnitario(lacteo(gandara,queso(gouda)), 13.00).
precioUnitario(lacteo(vacalin,queso(mozzarella)), 12.50).
precioUnitario(salchichas(vienisima,12), 9.80).
precioUnitario(salchichas(vienisima, 6), 5.80).
precioUnitario(salchichas(granjaDelSol, 8), 5.10).

%descuento(Producto, Descuento)
descuento(lacteo(laSerenisima,leche), 0.20).
descuento(lacteo(laSerenisima,crema), 0.70).
descuento(lacteo(gandara,queso(gouda)), 0.70).
descuento(lacteo(vacalin,queso(mozzarella)), 0.05).
descuento(arroz(Arroz),1.50) :-
	precioUnitario(arroz(Arroz),_).
descuento(salchichas(Marca,_),0.50) :-
	not(esVienisima(Marca)).
descuento(lacteo(_,leche),2).
descuento(lacteo(Marca,queso(Queso)),2) :-
	primeraMarca(Marca),
	precioUnitario(queso(Queso),_).
descuento(Producto,Descuento) :-
	mayorPrecioUnitario(Producto,Precio),
	Descuento is Precio * 0.05.

mayorPrecioUnitario(Producto,Precio) :-
	precioUnitario(Producto,Precio),
	forall(precioUnitario(OtroProducto,OtroPrecio), OtroPrecio =< Precio).

esVienisima(vienisima).

%compro(Cliente,Producto,Cantidad)
compro(juan,lacteo(laSerenisima,crema),2).
compro(juan,lacteo(laSerenisima,leche),1).
compro(juan,arroz(gallo),1).
compro(juan,salchichas(vienisima,12),1).
compro(juan,salchichas(vienisima,6),1).
compro(juan,salchichas(granjaDelSol,6),1).

compulsivo(Cliente) :-
	compro(Cliente,_,_),
	forall(primeraMarcaEnDescuento(Producto),compro(Cliente,Producto,_)).

primeraMarcaEnDescuento(Producto) :-
	precioUnitario(Producto,_),
	marcaProducto(Producto,Marca),
	primeraMarca(Marca).

marcaProducto(arroz(Marca),Marca).
marcaProducto(lacteo(Marca,_),Marca).
marcaProducto(salchichas(Marca,_),Marca).

totalAPagar(Cliente,PrecioTotal) :-
	compro(Cliente,_,_),
	findall(Precio,(compro(Cliente,Producto,Cantidad),calcularPrecio(Producto,Cantidad,Precio)),Precios),
	sumlist(Precios,PrecioTotal).

calcularPrecio(Producto,Cantidad,PrecioFinal) :-
	precioUnitario(Producto,Precio),
	mayorDescuento(Producto,Descuento),
	PrecioFinal is (Precio - Descuento) * Cantidad .
calcularPrecio(Producto,Cantidad,PrecioFinal) :-
	precioUnitario(Producto,Precio),
	not(descuento(Producto,_)),
	PrecioFinal is Precio * Cantidad .
	
mayorDescuento(Producto,Descuento) :-
	descuento(Producto,Descuento),
	forall(descuento(Producto,OtroDescuento),OtroDescuento =< Descuento).

4) Definir clienteFiel/2 sabiendo que un cliente es fiel a la marca X cuando no compra nada de otra marca si también lo vende X.

clienteFiel(Cliente,Marca) :-
	not(infiel(Cliente,Marca)).

infiel(Cliente,Marca) :-
	compro(Cliente,Producto,_),
	tipoDeProducto(Producto,Tipo),
	vende(Tipo,OtraMarca),
	OtraMarca \= Marca.

tipoDeProducto(lacteo(_,Producto),Producto).
tipoDeProducto(arroz(_),arroz).
tipoDeProducto(salchichas(_,_),salchichas).

vende(arroz,Marca) :-
	precioUnitario(arroz(Marca),Marca))
vende(Producto,Marca) :-
	precioUnitario(lacteo(Marca,Producto),Marca).
vende(salchichas,Marca) :-
	precioUnitario(salchicas(Marca,_),Marca).












