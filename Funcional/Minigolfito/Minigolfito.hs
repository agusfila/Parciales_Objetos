import Text.Show.Functions
-- Modelo inicial
data Jugador = Jugador {
  nombre :: String,
  padre :: String,
  habilidad :: Habilidad
} deriving (Eq, Show)

data Habilidad = Habilidad {
  fuerzaJugador :: Int,
  precisionJugador :: Int
} deriving (Eq, Show)

data Tiro = Tiro {
  velocidad :: Int,
  precision :: Int,
  altura :: Int
} deriving (Eq, Show) 

mapVelocidad :: (Int -> Int) -> Tiro -> Tiro
mapVelocidad unaFuncion unTiro = unTiro {velocidad = unaFuncion(velocidad unTiro)}

mapPrecision :: (Int -> Int) -> Tiro -> Tiro
mapPrecision unaFuncion unTiro = unTiro {precision = unaFuncion(precision unTiro)}

mapAltura :: (Int -> Int) -> Tiro -> Tiro
mapAltura unaFuncion unTiro = unTiro {altura = unaFuncion(altura unTiro)}
type Puntos = Int

-- Jugadores de ejemplo
bart = Jugador "Bart" "Homero" (Habilidad 25 60)
todd = Jugador "Todd" "Ned" (Habilidad 15 80)
rafa = Jugador "Rafa" "Gorgory" (Habilidad 10 1)

-- Funciones útiles
between n m x = elem x [n .. m]

maximoSegun f = foldl1 (mayorSegun f)
mayorSegun f a b
  | f a > f b = a
  | otherwise = b

--Punto1
type Palo = Jugador -> Tiro
--a.
putter :: Palo
putter unJugador = Tiro 10 (((*2).precisionUnJugador) $unJugador) 0

madera :: Palo
madera unJugador = Tiro 100 ( precisionDivididaN 2 unJugador) 5

precisionUnJugador :: Jugador -> Int
precisionUnJugador = precisionJugador.habilidad

fuerezaUnJugador :: Jugador -> Int
fuerezaUnJugador = fuerzaJugador.habilidad

precisionDivididaN :: Int -> Jugador -> Int
precisionDivididaN n = (flip div n). precisionUnJugador

hierro :: Int -> Palo
hierro n unJugador = Tiro (((*n).fuerezaUnJugador)$unJugador) (precisionDivididaN n unJugador) (max 0 (n-3))

--b.
palos :: [Palo]
palos = [putter, madera, hierro 1, hierro 2, hierro 3, hierro 4, hierro 5, hierro 6, hierro 7, hierro 8, hierro 9, hierro 10]

--Punto2
golpe :: Jugador -> Palo -> Tiro
golpe unJugador unPalo = unPalo unJugador

--Punto3
detenerTiro :: Tiro
detenerTiro = Tiro 0 0 0

type Obstaculo = Tiro -> Tiro

tunelConRampita :: Obstaculo
tunelConRampita unTiro 
 | superaTunelConRampita unTiro = (mapVelocidad (*2)).(mapPrecision (const 100)).(mapAltura (const 0)) $unTiro
 | otherwise = detenerTiro

superaTunelConRampita :: Tiro -> Bool
superaTunelConRampita unTiro = (((>90).precision) $unTiro) && (((==0).altura) $unTiro)

laguna :: Int -> Obstaculo
laguna unLargo unTiro 
 |superaLaguna unTiro = mapAltura (flip div unLargo) unTiro
 |otherwise = detenerTiro

superaLaguna :: Tiro -> Bool
superaLaguna unTiro = (((>80).velocidad) $unTiro) && ((((>=1).altura)$unTiro)&& (((<=5).altura)$unTiro))

hoyo :: Obstaculo
hoyo unTiro 
 | superaHoyo unTiro = detenerTiro
 | otherwise = detenerTiro

superaHoyo :: Tiro -> Bool
superaHoyo unTiro = ((((>=5).velocidad)$unTiro) && (((<=20).velocidad)$unTiro)) && (((==0).altura)$unTiro) && (((>95).precision)$unTiro)

--Punto4
--a.
palosUtiles :: Jugador -> Obstaculo -> [Palo]
palosUtiles unJugador unObstaculo = filter (superaObstaculo unObstaculo unJugador) palos 

superaObstaculo :: Obstaculo -> Jugador -> Palo -> Bool
superaObstaculo unObstaculo unJugador unPalo = (unObstaculo (unPalo unJugador)) /= detenerTiro

superaObstaculo' :: Tiro -> Obstaculo -> Bool
superaObstaculo' unTiro unObstaculo = (unObstaculo unTiro) /= detenerTiro

--b.
superarObstaculos :: [Obstaculo] -> Tiro -> Int
superarObstaculos unosObstaculos unTiro = length(takeWhile (superaObstaculo' unTiro) unosObstaculos)

--c.
paloMasUtil :: Jugador -> [Obstaculo] -> Palo
paloMasUtil unJugador unosObstaculos = (maximoSegun (superarObstaculos' unosObstaculos unJugador)).concat.(map (palosUtiles unJugador)) $unosObstaculos

superarObstaculos' :: [Obstaculo] -> Jugador -> Palo -> Int
superarObstaculos' unosObstaculos unJugador unPalo = superarObstaculos unosObstaculos (golpe unJugador unPalo)

--Punto 5
padresPerdedores :: [(Jugador,Puntos)] -> [String]
padresPerdedores unaLista = (map (padre.fst)).(filter ((/=).(maximoSegun (snd)) $unaLista)) $unaLista









