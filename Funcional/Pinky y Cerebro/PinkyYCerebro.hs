import Text.Show.Functions

--Punto1
data Animal = Animal{
 coeficiente :: Int,
 especie :: String,
 capacidades :: [String]
 } deriving (Show, Eq)

mapCoeficiente :: (Int -> Int) -> Animal -> Animal
mapCoeficiente unaFuncion unAnimal = unAnimal{coeficiente = unaFuncion (coeficiente unAnimal)}

mapEspecie :: (String -> String) -> Animal -> Animal
mapEspecie unaFuncion unAnimal = unAnimal{especie = unaFuncion(especie unAnimal)}

mapCapacidades :: ([String] -> [String]) -> Animal -> Animal
mapCapacidades unaFuncion unAnimal = unAnimal{capacidades = unaFuncion(capacidades unAnimal)}

--Punto2

type Transformacion = Animal -> Animal

inteligenciaSuperior :: Int -> Transformacion
inteligenciaSuperior unValor = mapCoeficiente (+unValor)

pinkificar :: Transformacion
pinkificar = mapCapacidades (const [])

superpoderes :: Transformacion
superpoderes unAnimal
 | es "Elefante" unAnimal = agregarCapacidad "No tenerle miedo a los ratones" unAnimal
 | (es "Raton" unAnimal) && (coeficienteMayorA 100 unAnimal) =  agregarCapacidad "Hablar" unAnimal
 | otherwise = unAnimal

es :: String -> Animal -> Bool
es unaEspecie = (==unaEspecie).especie

agregarCapacidad :: String -> Animal -> Animal
agregarCapacidad unaCapacidad = mapCapacidades ((++)[unaCapacidad])

coeficienteMayorA :: Int -> Animal -> Bool
coeficienteMayorA unValor = (>unValor).coeficiente

--Punto3

type Propiedad = Animal -> Bool

tieneLaCapacidad :: String -> Animal -> Bool
tieneLaCapacidad unaCapacidad = (elem (unaCapacidad)).capacidades

atropomorfico :: Propiedad
atropomorfico unAnimal = (tieneLaCapacidad "Hablar" unAnimal) && (coeficienteMayorA 60 unAnimal)

noTanCuerdo :: Propiedad
noTanCuerdo = (>2).length.(filter (pinkinesco)).capacidades

pinkinesco :: String -> Bool
pinkinesco unaCapacidad = (((=="Hacer ").(take 6))$unaCapacidad) && 
 (((<=4).length.(drop 6) $unaCapacidad) && (tieneUnaVocal (drop 6 unaCapacidad)))

tieneUnaVocal :: String -> Bool
tieneUnaVocal = (>0).length.(filter (esVocal))

esVocal :: Char -> Bool
esVocal  unaLetra = elem unaLetra "aeiouAEIUO"

--Punto4
data Experimento = Experimento{
 transformaciones :: [Transformacion],
 criterioDeExito :: Propiedad
} deriving(Show)

experimentoExitoso :: Experimento -> Animal -> Bool
experimentoExitoso unExperimento = (criterioDeExito unExperimento).(aplicarTransformaciones unExperimento)

aplicarTransformaciones :: Experimento -> Animal -> Animal
aplicarTransformaciones unExperimento = foldl (.) id (transformaciones unExperimento)

raton = Animal 17 "Raton" ["Destruenglonir el mundo", "Hacer planes desalmados"]

capacidades1 = ["Destruenglonir el mundo", "Hacer planes desalmados"]

experimento1 = Experimento [pinkificar, inteligenciaSuperior 10, superpoderes] atropomorfico
--experimentoExitoso experimento1 raton
--False

--Punto5
listaDeCoeficientes :: [String] -> Experimento -> [Animal] -> [Int]
listaDeCoeficientes unasCapacidades unExperimento = 
 (map coeficiente).(filter (tieneAlgunaCapacidad unasCapacidades)).(aplicarTransformaciones' unExperimento)

tieneAlgunaCapacidad :: [String] -> Animal -> Bool
tieneAlgunaCapacidad [] _ = False
tieneAlgunaCapacidad (x:xs) unAnimal = (any (==x) (capacidades unAnimal)) || (tieneAlgunaCapacidad xs unAnimal)

listaDeEspecies :: [String] -> Experimento -> [Animal] -> [String]
listaDeEspecies unasCapacidades unExperimento = 
 (map especie).(filter (tieneTodasLasCapacidades unasCapacidades)).(aplicarTransformaciones' unExperimento)

aplicarTransformaciones' :: Experimento -> [Animal] -> [Animal]
aplicarTransformaciones' unExperimento = map (aplicarTransformaciones unExperimento)

tieneTodasLasCapacidades :: [String] -> Animal -> Bool
tieneTodasLasCapacidades [] _ = True
tieneTodasLasCapacidades (x:xs) unAnimal = (any (==x) (capacidades unAnimal)) && (tieneTodasLasCapacidades xs unAnimal)

listaDeCantidadDeCapacidades :: [String] -> Experimento -> [Animal] -> [Int]
listaDeCantidadDeCapacidades unasCapacidades unExperimento = 
 (map (length.capacidades)).(filter (not.(tieneTodasLasCapacidades unasCapacidades))).(aplicarTransformaciones' unExperimento)

--Punto6
--No se puede realizar ningun experimento ya que los unicos dos criterios de salida evaluan las capacidades
-- del animal, entonces estas nunca terminarian de ser evaluadas y no se calcularia si el experimento fue o no exitoso

--Punto7













