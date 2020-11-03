import Text.Show.Functions
import Data.Char

type Tiempo = (Int -> Int)

data Planeta = Planeta{
 nombre :: String,
 posicion :: Posicion,
 tiempoTerrestre :: Tiempo
} deriving (Show)

type Posicion = (Float, Float, Float)
coordX (x,_,_) = x
coordY (_,y,_) = y
coordZ (_,_,z) = z

data Astronauta = Astronauta{
 nombreA :: String,
 edad :: Int,
 planeta :: Planeta
} deriving (Show)

mapEdad :: (Int -> Int) -> Astronauta -> Astronauta
mapEdad unaFuncion unAstronauta = unAstronauta {edad = unaFuncion(edad unAstronauta)}

--Datos
planeta1 = Planeta "X" (20,40,50) (id)
planeta2 = Planeta "Y" (200,500,900) (*2)

astronauta1 = Astronauta "Tito" 20 planeta2

--Punto 1
--a.
distancia :: Planeta -> Planeta -> Float
distancia unPlaneta otroPlaneta = sqrt(diferencias (posicion unPlaneta) (posicion otroPlaneta))

diferencias :: Posicion -> Posicion -> Float
diferencias unaPosicion otraPosicion = 
 ((coordX unaPosicion) - (coordX otraPosicion))^2 +
 ((coordY unaPosicion) - (coordY otraPosicion))^2 +
 ((coordZ unaPosicion) - (coordZ otraPosicion))^2

--b.
tiempoDeViaje :: Float -> Planeta -> Planeta -> Float
tiempoDeViaje unaVelocidad unPlaneta = (/unaVelocidad).(distancia unPlaneta)

--Punto2
pasarTiempo :: Int -> Astronauta -> Astronauta
pasarTiempo unTiempo unAstronauta = mapEdad(tiempoTerrestre (planeta unAstronauta)) unAstronauta






















