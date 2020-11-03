-- Punto 1

data Pais = Pais{
 ingresoPerCapita :: Float,
 sectorPublico :: Float,
 sectorPrivado :: Float,
 recursosNaturales :: [String],
 deuda :: Float
 } deriving (Show, Eq)

mapDeuda :: (Float -> Float) -> Pais -> Pais
mapDeuda unaFuncion unPais = unPais {deuda = (unaFuncion(deuda unPais))}

mapSectorPublico :: (Float -> Float) -> Pais -> Pais
mapSectorPublico unaFuncion unPais = unPais {sectorPublico = (unaFuncion (sectorPublico unPais))}

mapIngresoPerCapita :: (Float -> Float) -> Pais -> Pais
mapIngresoPerCapita unaFuncion unPais = unPais {ingresoPerCapita = (unaFuncion (ingresoPerCapita unPais))}

mapRecursosNaturales :: ([String] -> [String]) -> Pais -> Pais
mapRecursosNaturales unaFuncion unPais = unPais {recursosNaturales = unaFuncion (recursosNaturales unPais)}

namibia = Pais 4140 400000 650000 ["Mineria", "Ecoturismo"] 50000000

-- Punto 2

type Receta = Pais -> Pais 

--a.
prestarle :: Float -> Receta
prestarle unosMillones = aumentarDeuda unosMillones

aumentarDeuda :: Float -> Pais -> Pais
aumentarDeuda unosMillones = mapDeuda ((+)(1.5*unosMillones))

--b.
reducirSectorPublico :: Float -> Receta
reducirSectorPublico unosPuestos = (reducirPuestos unosPuestos) . calcularReduccionIngresoPerCapita

reducirPuestos unosPuestos = mapSectorPublico ((+) (-unosPuestos))

calcularReduccionIngresoPerCapita :: Receta
calcularReduccionIngresoPerCapita unPais 
 | (sectorPublico unPais)> 100 = disminuirIngresoPerCapita 0.20 unPais
 | otherwise = disminuirIngresoPerCapita 0.15 unPais

disminuirIngresoPerCapita :: Float -> Pais -> Pais
disminuirIngresoPerCapita unPorcentaje unPais = mapIngresoPerCapita ((+) (-unPorcentaje * (ingresoPerCapita unPais))) unPais

--c.

entregarRecurso :: String -> Receta
entregarRecurso unRecurso = (disminuirDeuda 2000000) . (sacarRecurso unRecurso)

disminuirDeuda :: Float -> Pais -> Pais
disminuirDeuda unosMillones = mapDeuda ((+) (- unosMillones))

sacarRecurso :: String -> Pais -> Pais
sacarRecurso unRecurso = mapRecursosNaturales (filter (/= unRecurso))

--d.

blindaje :: Receta
blindaje unPais = (reducirSectorPublico 500) . (prestarle ((pbi unPais)/2)) $unPais

pbi unPais = ((ingresoPerCapita unPais) * ((sectorPrivado unPais) + (sectorPublico unPais)))

--3

prestarYEntregar :: Receta
prestarYEntregar = (entregarRecurso "Mineria").(prestarle 200000000)

--4

--a.

zafan :: [Pais] -> [Pais]
zafan [] = []
zafan unosPaises = filter (\unPais -> (elem "Petroleo" .)(recursosNaturales) $unPais) unosPaises

--b.

deudaTotal :: [Pais] -> Float
deudaTotal [] = 0.0
deudaTotal unosPaises = sum.(map deuda) $unosPaises 

--5
--a.

recetasOrdenadas :: Pais -> [Receta] -> Bool
recetasOrdenadas unPais (x:xs) = any ( > (pbi(x unPais))) (map pbi (map ($unPais) xs))



















