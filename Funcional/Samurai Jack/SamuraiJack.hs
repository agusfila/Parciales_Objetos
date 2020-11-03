import Text.Show.Functions

--Tipos
data Elemento = Elemento {
 tipo :: String,
 ataque :: (Personaje-> Personaje),
 defensa :: (Personaje-> Personaje)
 } deriving (Show)
 
data Personaje = Personaje {
 nombre :: String,
 salud :: Float,
 elementos :: [Elemento],
 anioPresente :: Int
 } deriving (Show)

mapAnioPresente :: (Int -> Int) -> Personaje -> Personaje
mapAnioPresente unaFuncion unPersonaje = unPersonaje{anioPresente = unaFuncion(anioPresente unPersonaje)}

mapSalud :: (Float -> Float) -> Personaje -> Personaje
mapSalud unaFuncion unPersonaje = unPersonaje{salud = max 0 (unaFuncion(salud unPersonaje))}

mapElementos :: ([Elemento] -> [Elemento]) -> Personaje -> Personaje
mapElementos unaFuncion unPersonaje = unPersonaje{elementos = unaFuncion(elementos unPersonaje)}
--Modelos

tito = Personaje "Tito" 50 [elemento1] 2020
elemento1 = Elemento "Maldadd" (causarDanio 50) (mandarAlAnio 2000)

--Punto1
mandarAlAnio :: Int -> Personaje -> Personaje
mandarAlAnio unAnio = mapAnioPresente (const unAnio)

meditar :: Personaje -> Personaje
meditar = mapSalud (*1.5)

causarDanio :: Float -> Personaje -> Personaje
causarDanio unDanio = mapSalud (subtract unDanio)

--Punto2
esMalvado :: Personaje -> Bool
esMalvado = (any (=="Maldad")).(map tipo).elementos

danioQueProduce :: Personaje -> Elemento -> Float
danioQueProduce unPersonaje unElemento = (salud unPersonaje)-(salud(atacar unElemento unPersonaje))

atacar :: Elemento -> Personaje -> Personaje
atacar unElemento = ataque unElemento

enemigosMortales :: Personaje -> [Personaje] -> [Personaje]
enemigosMortales unPersonaje unosEnemigos = filter ((any (loMata unPersonaje)).elementos) unosEnemigos

loMata :: Personaje -> Elemento -> Bool
loMata unPersonaje unElemento = (==0).salud.(atacar unElemento) $unPersonaje

--Punto3
concentracion :: Int -> Elemento
concentracion unNivel = Elemento "Magia" id (meditarNVeces unNivel)

meditarNVeces :: Int -> Personaje -> Personaje
meditarNVeces unNivel = head.(drop (unNivel-1)).(take unNivel).(iterate (meditar))

esbirrosMortales :: Int -> [Elemento]
esbirrosMortales unaCantidad = take unaCantidad (repeat (Elemento "Maldado" (causarDanio 1) id))

jack :: Personaje
jack = Personaje "Jack" 300 [concentracion 3, katanaMagica] 200

katanaMagica :: Elemento
katanaMagica = Elemento "Magia" (causarDanio 1000) id

aku :: Int -> Float -> Personaje
aku unAnio unaSalud = Personaje "Aku" unaSalud ((++)[(concentracion 4)] [portalAlFuturo (2800 + unAnio)]) unAnio

portalAlFuturo :: Int -> Elemento
portalAlFuturo unAnio unPersonaje = Elemento "Magia" (mandarAlAnio (2800 + unAnio)) (generarNuevoAku unAnio unPersonaje)

generarNuevoAku :: Int -> Personaje -> Personaje
generarNuevoAku unAnio unPersonaje = aku unAnio (salud unPersonaje)













 