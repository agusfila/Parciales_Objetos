import Text.Show.Functions
import Data.Char

data Persona = Persona{
 edad :: Int,
 items :: [String],
 experiencia :: Int
 } deriving (Show,Eq)

mapExperiencia :: (Int -> Int) -> Persona -> Persona
mapExperiencia unaFuncnion unaPersona = unaPersona {experiencia = unaFuncnion (experiencia unaPersona)}

data Criatura = Criatura{
 peligrosidad :: Int,
 puedeDeshacerse :: Condicion
 } deriving (Show)

type Condicion = Persona -> Bool
--Modelos

tito = Persona 19 ["Soplador"] 10

--Funciones
siempreDetras :: Criatura
siempreDetras = Criatura 0 noSePuede

noSePuede :: Persona -> Bool
noSePuede = (<0).edad

gnomos :: Int -> Criatura
gnomos unaCantidad = Criatura (2^unaCantidad) (tieneItem "Soplador")

tieneItem :: String -> Persona -> Bool
tieneItem unItem = (elem unItem).items

fantasma :: Int -> Condicion -> Criatura
fantasma unValor unAsunto = Criatura (unValor*20) unAsunto

--Punto2
type Enfrentamiento = Persona -> Criatura -> Persona

enfrentamiento :: Enfrentamiento
enfrentamiento unaPersona unaCriatura 
 | (puedeDeshacerse unaCriatura) unaPersona = mapExperiencia (+(peligrosidad unaCriatura)) unaPersona
 | otherwise = escaparse unaPersona

escaparse :: Persona -> Persona
escaparse = mapExperiencia (+1)

--Punto3
--a.
experienciaTotal :: Persona -> [Criatura] -> Int
experienciaTotal unaPersona = (sumarExperienciasEnfrentamientos unaPersona).(calcularExperienciaEnfrentamiento unaPersona)

sumarExperienciasEnfrentamientos :: Persona -> [Persona] -> Int
sumarExperienciasEnfrentamientos unaPersona = sum.(map ((subtract (experiencia unaPersona)).experiencia))

calcularExperienciaEnfrentamiento :: Persona -> [Criatura] -> [Persona]
calcularExperienciaEnfrentamiento unaPersona = (map (enfrentamiento unaPersona))

--b.

criaturas :: [Criatura]
criaturas = [gnomos 10, fantasma 3 menorATreceYTieneDisfrazDeOveja, fantasma 1 mayorADiez]

menorATreceYTieneDisfrazDeOveja :: Condicion
menorATreceYTieneDisfrazDeOveja unaPersona = (menorATrece unaPersona) && (tieneItem "Disfraz de oveja" unaPersona)

menorATrece :: Condicion
menorATrece = (<13).edad

mayorADiez :: Condicion
mayorADiez = (>10).experiencia

-- experienciaTotal tito criaturas
-- 1026

--Punto3

zipWithIf :: (a -> b -> b) -> (b -> Bool) -> [a] -> [b] -> [b]
zipWithIf _ _ _ [] = []
zipWithIf _ _ [] _ = []
zipWithIf unaFuncion unaCondicion (x:xs) (y:ys)
 | unaCondicion y = (unaFuncion x y) : (zipWithIf unaFuncion unaCondicion xs ys)
 | otherwise = y : (zipWithIf unaFuncion unaCondicion (x:xs) ys)

--Punto4
abecedarioDesde :: Char -> [Char]
abecedarioDesde = (take 26).(abecedario)

abecedario :: Char -> [Char]
abecedario unCaracter 
 | (ord unCaracter) <= 122 = unCaracter : abecedarioDesde (chr((ord unCaracter)+1))
 | otherwise = abecedarioDesde (chr((ord unCaracter)-26))

desencriptarLetra :: Char -> Char -> Char
desencriptarLetra unaLetraClave unCaracter = (desencriptar (ord unCaracter) unaLetraClave).(abecedarioDesde) $unaLetraClave

desencriptar :: Int -> Char -> [Char] -> Char
desencriptar unNumero unaLetraClave (x:xs) 
 | ((ord unaLetraClave) - (ord x)) == (unNumero - 97) = x
 | otherwise = desencriptar unNumero unaLetraClave xs
 

















