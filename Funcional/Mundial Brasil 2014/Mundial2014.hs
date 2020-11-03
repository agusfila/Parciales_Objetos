import Text.Show.Functions

data Jugador = Jugador{
 nombre :: String,
 edad :: Int,
 promedioGol :: Float,
 habilidad :: Int,
 cansancio :: Float
} deriving (Show, Eq)

mapCansancio :: (Float -> Float) -> Jugador -> Jugador
mapCansancio unaFuncion unJugador = unJugador {cansancio = unaFuncion (cansancio unJugador)}

type Equipo = (String, Char, [Jugador])

martin = Jugador "Martin" 26 0.0 50 35.0
juan = Jugador "Juancho" 30 0.2 50 40.0
maxi = Jugador "Maxi Lopez" 27 0.4 80 30.0

jonathan = Jugador "Chueco" 20 1.5 80 99.0
lean = Jugador "Hacha" 23 0.01 50 35.0
brian = Jugador "Panadero" 21 5 80 15.0

garcia = Jugador "Sargento" 30 1 80 13.0
messi = Jugador "Pulga" 26 10 99 43.0
aguero = Jugador "Aguero" 24 5 90 5.0

equipo1 = ("Lo Que Vale Es El Intento", 'F', [martin, juan, maxi])
losDeSiempre = ( "Los De Siempre", 'F', [jonathan, lean, brian])
restoDelMundo = ("Resto del Mundo", 'A', [garcia, messi, aguero])

equipos = [equipo1, losDeSiempre, restoDelMundo]

quickSort _ [] = [] 
quickSort criterio (x:xs) = (quickSort criterio . filter (not . criterio x)) xs ++
 [x] ++ (quickSort criterio . filter (criterio x)) xs 


--Punto 1

jugadores :: Equipo -> [Jugador]
jugadores (_,_,jugadores') = jugadores'

figurasDelEquipo :: Equipo -> [Jugador]
figurasDelEquipo unEquipo =  filter (esFigura) (jugadores unEquipo)

esFigura :: Jugador -> Bool
esFigura unJugador = (habilidad unJugador) > 75 && (promedioGol unJugador > 0) 

--Punto 2

faranduleros :: [String]
faranduleros = ["Maxi Lopez", "Icardi", "Aguero", "Caniggia", "Demichelis"]

tieneFarandulero :: Equipo -> Bool
tieneFarandulero (nombre, grupo, jugadores) = any (farandulero) jugadores

farandulero :: Jugador -> Bool
farandulero unJugador = elem (nombre unJugador) faranduleros

--Punto 3

grupo :: Equipo -> Char
grupo (_,grupo',_) = grupo'

figuritasDificiles :: [Equipo] -> Char -> [Jugador]
figuritasDificiles [] _ = []
figuritasDificiles (x:xs) unGrupo
 | grupo x == unGrupo = (filter (esDificil) (jugadores x)) ++ (figuritasDificiles xs unGrupo)
 | otherwise = figuritasDificiles xs unGrupo

esDificil unJugador = (esFigura unJugador) && (not.farandulero) unJugador && (esJoven unJugador)

esJoven :: Jugador -> Bool
esJoven unJugador = (edad unJugador) < 27

--Punto 4

type Partido = Equipo -> Equipo

jugarPartido :: Partido
jugarPartido (equipo, grupo, jugadores) = (equipo, grupo, map calcularCansancio jugadores)

calcularCansancio :: Jugador -> Jugador
calcularCansancio x 
 | esDificil x = mapCansancio (const 50) x
 | (esJoven x) && (farandulero x) && (not.esFigura) x = mapCansancio (*0.10) x
 | (not.esJoven) x && (not.esFigura) x =  mapCansancio (+ 20) x
 | otherwise = mapCansancio (*2) x

--Punto 5

sortCansancio jugador1 jugador2 = (cansancio jugador1) < (cansancio jugador2)

quienGanaPartido :: Equipo -> Equipo -> Equipo
quienGanaPartido equipo1 equipo2 
 | (promedio equipo1) > (promedio equipo2) = jugarPartido equipo1
 | otherwise = jugarPartido equipo2

promedio :: Equipo -> Float
promedio = sumarPromedioDeGol.ordenarEquipoPorCansancio

sumarPromedioDeGol :: [Jugador] -> Float
sumarPromedioDeGol = sum . (map cansancio) . (take 11 )

ordenarEquipoPorCansancio :: Equipo -> [Jugador]
ordenarEquipoPorCansancio unEquipo = quickSort (sortCansancio) (jugadores unEquipo)

--Punto 6

quienSaleCampeon :: [Equipo] -> Equipo
quienSaleCampeon (x:[]) = x
quienSaleCampeon (x:xs) = quienGanaPartido x (quienSaleCampeon xs)

quienSaleCampeon' :: [Equipo] -> Equipo
quienSaleCampeon' = foldl1 (quienGanaPartido)

--Punto 7

elGroso :: [Equipo] -> [Jugador]
elGroso = (take 1) . figurasDelEquipo . quienSaleCampeon


















