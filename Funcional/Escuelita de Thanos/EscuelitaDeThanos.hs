import Text.Show.Functions

spiderMan :: Personaje
spiderMan = Personaje{
    edad = 21,
    energia = 2300,
    habilidades = ["sentido arácnido", "sacar fotos", "trepar paredes"],
    nombre = "Peter Parker",
    planeta = "tierra"
}    

ironMan :: Personaje
ironMan = Personaje{
    edad = 48,
    energia = 1900,
    habilidades = ["volar", "programacion en Haskell", "programacion en Prolog"],
    nombre = "Tony Stark",
    planeta = "tierra"
}     

thor :: Personaje
thor = Personaje{
    edad = 1500,
    energia = 3000,
    habilidades = ["usar Mjolnir"],
    nombre = "Thor",
    planeta = "asgard"
}

drStrange :: Personaje
drStrange = Personaje{
    edad = 50,
    energia = 1000,
    habilidades = ["levitar", "ver futuros"],
    nombre = "Stephen Strange",
    planeta = "tierra"
}

universo = [drStrange, thor, ironMan, spiderMan]


--Tipos de Datos
data Personaje = Personaje {
 edad :: Int,
 energia :: Int,
 habilidades :: [String],
 nombre :: String,
 planeta :: String
} deriving (Eq, Show)

data Guantelete = Guantelete {
material :: String,
gemas :: [Gema]
}

type Universo = [Personaje]
type Gema = Personaje -> Personaje

--Funciones Auxiliares

mapEdad :: (Int -> Int) -> Personaje -> Personaje
mapEdad        funcion unPersonaje = unPersonaje {edad = funcion(edad unPersonaje)}
mapEnergia :: (Int -> Int) -> Personaje -> Personaje
mapEnergia     funcion unPersonaje = unPersonaje {energia = funcion(energia unPersonaje)}
mapHabilidades :: ([String] -> [String]) -> Personaje -> Personaje
mapHabilidades funcion unPersonaje = unPersonaje {habilidades = funcion(habilidades unPersonaje)}
mapNombre :: (String -> String) -> Personaje -> Personaje
mapNombre      funcion unPersonaje = unPersonaje {nombre = funcion(nombre unPersonaje)}
mapPlaneta :: (String -> String) -> Personaje -> Personaje
mapPlaneta     funcion unPersonaje = unPersonaje {planeta = funcion(planeta unPersonaje)}

--Punto 1
chasquidoDeUniverso :: Universo -> Universo
chasquidoDeUniverso unUniverso = take (mitadDePersonajes unUniverso) unUniverso

mitadDePersonajes :: Universo -> Int
mitadDePersonajes unUniverso = (length unUniverso) - (div (length unUniverso) 2)

--Punto 2

--a)
aptoParaPendex :: Universo -> Bool
aptoParaPendex unUniverso = any (menorQue 45) unUniverso

menorQue :: Int -> Personaje -> Bool
menorQue num unPersonaje = edad unPersonaje < num

--b)

energiaTotal :: Universo -> Int
energiaTotal = sum.energiasPersonajes

energiasPersonajes :: Universo -> [Int]
energiasPersonajes = map energia . (filter masDeUnaHabilidad)

masDeUnaHabilidad :: Personaje -> Bool
masDeUnaHabilidad unPersonaje = length (habilidades unPersonaje) > 0

--Punto 3

cambiarEnergia :: Int -> Personaje -> Personaje
cambiarEnergia unaEnergia = mapEnergia (const unaEnergia)

cambiarEdad :: Int -> Personaje -> Personaje
cambiarEdad unaEdad = mapEdad (const unaEdad)

--La Mente
laMente :: Int -> Gema
laMente unaEnergia = cambiarEnergia unaEnergia

--El Alma
elAlma :: String -> Gema
elAlma unaHabilidad = (cambiarEnergia 0).(eliminarHabilidad unaHabilidad)

eliminarHabilidad :: String -> Personaje -> Personaje
eliminarHabilidad unaHabilidad unPersonaje 
 | elem unaHabilidad (habilidades unPersonaje) = mapHabilidades (eliminar unaHabilidad) unPersonaje
 | otherwise = unPersonaje

eliminar :: String -> [String] -> [String]
eliminar unaHabilidad = filter (/=unaHabilidad)

--El Espacio

elEspacio :: String -> Gema
elEspacio unPlaneta unPersonaje = cambiarEnergia ((energia unPersonaje)-20) (transportarRival unPlaneta unPersonaje)

transportarRival :: String -> Personaje -> Personaje
transportarRival unPlaneta = mapPlaneta (const unPlaneta)

--El Poder

elPoder :: Gema
elPoder = (cambiarEnergia 0).eliminarHabilidades

eliminarHabilidades :: Personaje -> Personaje
eliminarHabilidades unPersonaje 
 | length (habilidades unPersonaje) <= 2 = mapHabilidades (const []) unPersonaje
 | otherwise = unPersonaje
 
--El Tiempo

elTiempo :: Gema
elTiempo unPersonaje = cambiarEnergia ((energia unPersonaje)-50) (reducirEdad unPersonaje)

reducirEdad :: Personaje -> Personaje
reducirEdad unPersonaje
 | div (edad unPersonaje) 2 < 18 = cambiarEdad 18 unPersonaje
 | otherwise = cambiarEdad (div (edad unPersonaje) 2) unPersonaje

--La Gema Loca

laGemaLoca :: Gema -> Gema
laGemaLoca unaGema = unaGema.unaGema

--Punto 4
--gemas :: [Gema]
--gemas = [(elAlma "usar Mjolnir"),(laGemaLoca (elAlma "programacion en Haskell")),elTiempo]

guanteleteDeGoma :: Guantelete
guanteleteDeGoma = Guantelete "Goma" [elTiempo,(elAlma "usar Mjolnir"),(laGemaLoca (elAlma "programación en Haskell"))]

--Punto 5

utilizar :: [Gema] -> Personaje -> Personaje
utilizar unasGemas unPersonaje = foldl (.) id unasGemas unPersonaje

--Punto 6

gemaMasPoderosaDe :: Personaje -> [Gema] -> Gema
gemaMasPoderosaDe _ [gema] = gema
gemaMasPoderosaDe personaje (gema1:gema2:gemas) 
    | (energia.gema1) personaje < (energia.gema2) personaje = gemaMasPoderosaDe personaje (gema1:gemas)
    | otherwise = gemaMasPoderosaDe personaje (gema2:gemas)
 
--Punto 7

infinitasGemas :: Gema -> [Gema]
infinitasGemas gema = gema : (infinitasGemas gema)

guanteleteDeLocos :: Guantelete
guanteleteDeLocos = Guantelete "vesconite" (infinitasGemas elTiempo)

usoLasTresPrimerasGemas :: Guantelete -> Personaje -> Personaje
usoLasTresPrimerasGemas guantelete = (utilizar . take 3. gemas) guantelete






















