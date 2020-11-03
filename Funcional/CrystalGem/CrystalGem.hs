import Text.Show.Functions

data Aspecto = Aspecto {
  tipoDeAspecto :: String,
  grado :: Float
} deriving (Show, Eq)

type Situacion = [Aspecto]

mejorAspecto mejor peor = grado mejor < grado peor
mismoAspecto aspecto1 aspecto2 = tipoDeAspecto aspecto1 == tipoDeAspecto aspecto2
buscarAspecto aspectoBuscado = head.filter (mismoAspecto aspectoBuscado)
buscarAspectoDeTipo tipo = buscarAspecto (Aspecto tipo 0)
reemplazarAspecto aspectoBuscado situacion =
    aspectoBuscado : (filter (not.mismoAspecto aspectoBuscado) situacion)

--Punto 1
--a.
mapGrado :: (Float -> Float) -> Aspecto -> Aspecto
mapGrado unaFuncion unAspecto = unAspecto {grado = unaFuncion(grado unAspecto)}

--b.
mejorSituacion :: Situacion -> Situacion -> Bool
mejorSituacion [] [] = True
mejorSituacion [] otraSituacion = False
mejorSituacion unaSituacion [] = True
mejorSituacion (x:xs) (y:ys) = (mejorAspecto x y) && (mejorSituacion xs ys)

--c.
modificarSituacion :: Aspecto -> (Float -> Float) -> Situacion -> Situacion
modificarSituacion unAspecto unaFuncion unaSituacion =
 reemplazarAspecto (mapGrado unaFuncion (buscarAspecto unAspecto unaSituacion)) unaSituacion
 
--Punto2
--a.
data Gema = Gema{
 nombre :: String,
 fuerza :: Int,
 personalidad :: Personalidad
 } deriving(Show)
type Personalidad = Situacion -> Situacion

--b.

vidente :: Personalidad
vidente = (mapIncertidumbre (flip (/) 2)).(disminuirTension 10)

mapIncertidumbre :: (Float -> Float) -> Situacion -> Situacion
mapIncertidumbre unaFuncion = modificarSituacion (Aspecto "Incertidumbre" 0) unaFuncion

mapTension :: (Float -> Float) -> Situacion -> Situacion
mapTension unaFuncion = modificarSituacion (Aspecto "Peligro" 0) unaFuncion

mapPeligro :: (Float -> Float) -> Situacion -> Situacion
mapPeligro unaFuncion = modificarSituacion (Aspecto "Peligro" 0) unaFuncion

disminuirTension :: Float -> Situacion -> Situacion
disminuirTension unValor = mapTension (subtract unValor)

relajada :: Float -> Personalidad
relajada unValor = (disminuirTension 30).(mapPeligro (+unValor))

--c.
gemaVidente = Gema "Vidente" 20 vidente
gemaRelajada = Gema "Relajada" 5 (relajada 20)

--Punto3
mejorGema :: Gema -> Gema -> Situacion -> Bool
mejorGema unaGema otraGema unaSituacion =
 ((fuerza unaGema) > (fuerza otraGema)) && (mejorSituacion (situacionResultante unaGema unaSituacion) (situacionResultante otraGema unaSituacion))

situacionResultante :: Gema -> Situacion -> Situacion
situacionResultante unaGema = (personalidad unaGema)

--Punto4
type Fusion = Situacion -> Gema -> Gema -> Gema

fusion :: Fusion
fusion unaSituacion unaGema otraGema  = 
 Gema (fusionNombre unaGema otraGema) (fusionFuerza unaGema otraGema unaSituacion) (fusionPersonalidad unaGema otraGema)

fusionNombre :: Gema -> Gema -> String
fusionNombre unaGema otraGema 
 | (==(nombre unaGema)).(nombre) $otraGema = (nombre unaGema)
 | otherwise = (nombre unaGema) ++ (nombre otraGema)
 
fusionPersonalidad :: Gema -> Gema -> Personalidad
fusionPersonalidad unaGema otraGema =
 (personalidad unaGema).(personalidad otraGema).(map (disminuirGrado 10))

disminuirGrado :: Float -> Aspecto -> Aspecto
disminuirGrado unValor = mapGrado (subtract unValor)

fusionFuerza :: Gema -> Gema -> Situacion ->Int
fusionFuerza unaGema otraGema unaSituacion
 |sonCompatibles unaGema otraGema unaSituacion = 10*((fuerza unaGema) + (fuerza otraGema))
 |otherwise = (fuerza (gemaDominante unaGema otraGema unaSituacion))*7

gemaDominante :: Gema -> Gema -> Situacion -> Gema
gemaDominante unaGema otraGema unaSituacion 
 | (mejorGema unaGema otraGema unaSituacion) = unaGema
 | otherwise = otraGema

sonCompatibles :: Gema -> Gema -> Situacion -> Bool
sonCompatibles unaGema otraGema unaSituacion = 
 mejorSituacion ((fusionPersonalidad unaGema otraGema) unaSituacion) ((personalidad unaGema) unaSituacion) && 
 mejorSituacion ((fusionPersonalidad unaGema otraGema) unaSituacion) ((personalidad otraGema) unaSituacion)

--Punto5
fusionGrupal :: Situacion -> [Gema] -> Gema
fusionGrupal unaSituacion = foldl1 (fusion unaSituacion)

--Punto6
foo :: (Eq b) => c -> (c -> b) -> ([a] -> [b]) -> [a] -> Bool
foo x y z = any (== y x).z

--foo 5 (+7) [1..] hay errores de tipo, falta agregar el parametro z
--foo 3 even (map (< 7)) hay error, falta un paramtro que debe ser una lista
--foo 3 even [1, 2, 3] same primer ejemplo
--foo [1..] head (take 5) [1.. ] la funcion esya bien tipada y en este caso termina,
-- ya que de las dos listas infinitas antes agarra en este caso el primer elemento y los primeros 5
-- antes de evaluarla














