import Text.Show.Functions

data Chico = Chico{
 nombre :: String,
 edad :: Int,
 habilidades :: [String],
 deseos :: [Deseo]
 } deriving (Show)

mapHabilidades :: ([String] -> [String]) -> Chico -> Chico
mapHabilidades unaFuncion unChico = unChico {habilidades = unaFuncion (habilidades unChico)}

mapEdad :: (Int -> Int) -> Chico -> Chico
mapEdad unaFuncion unChico = unChico {edad = unaFuncion(edad unChico)}

--Modelos
timmy :: Chico
timmy = Chico "Timmy" 10 ["mirar television", "jugar en la pc","Cocinar"] [serMayor,aprenderHabilidades ["enamorar"],serGrosoEnNeedForSpeed]

--Punto 1
type Deseo = Chico -> Chico

aprenderHabilidades :: [String] -> Deseo
aprenderHabilidades unasHabilidades = mapHabilidades ((++)unasHabilidades)

serGrosoEnNeedForSpeed :: Deseo
serGrosoEnNeedForSpeed = aprenderHabilidades (zipWith (++) (repeat "jugar a need for speed ") (map show [1..]))

serMayor :: Deseo
serMayor = mapEdad (const 18)
--Punto2

type Padrino = Chico -> Chico

wanda :: Padrino
wanda unChico = (mapEdad (+1)).((head.deseos) $unChico) $unChico

cosmo :: Padrino
cosmo = mapEdad (flip div 2)

muffinMagico :: Padrino
muffinMagico unChico = foldl (.) id (deseos unChico) unChico

--Punto3
type Condicion = Chico -> Bool

tieneHabilidad :: String -> Condicion
tieneHabilidad unaHabilidad = (elem (unaHabilidad)).habilidades

esSuperMaduro :: Condicion
esSuperMaduro unChico = (tieneHabilidad "manejar" unChico) && (((>=18).edad)$unChico)

--Punto4
data Chica = Chica{
 nombreChica :: String,
 condicion :: Condicion
 }

quienConquistaA :: Chica -> [Chico] -> Chico
quienConquistaA _ (x:[]) = x
quienConquistaA unaChica (x:xs)
 | (condicion unaChica) x = x
 | otherwise = quienConquistaA unaChica xs

chica :: Chica
chica = Chica "Chica" saberCocinar

saberCocinar :: Condicion
saberCocinar = tieneHabilidad "Cocinar"

--quienConquistaA chica [timmy]
--timmy

--Punto5
habilidadesProhibidas :: [String]
habilidadesProhibidas = ["enamorar", "matar", "dominar el mundo"]

infractoresDeDarules :: [Chico] -> [Chico]
infractoresDeDarules = (filter (rompioLasReglas)).(map muffinMagico)

rompioLasReglas :: Chico -> Bool
rompioLasReglas = (any (\unaHabilidad -> elem unaHabilidad habilidadesProhibidas)).(take 5).habilidades























