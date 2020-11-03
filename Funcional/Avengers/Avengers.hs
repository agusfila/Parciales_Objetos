import Text.Show.Functions

data Superheroe = Superheroe{
 nombreSuperheroe :: String,
 vida :: Float,
 planetaOrigen :: String,
 artefacto :: Artefacto,
 villanoEnemigo :: Villano
 } deriving(Show)

data Artefacto = Artefacto{
 nombreArtefacto :: String,
 danioSufrido :: Int
 } deriving(Show, Eq)

data Villano = Villano{
 nombreVillano :: String,
 planeta :: String,
 arma :: Arma
 } deriving(Show)

type Arma = Superheroe -> Superheroe
--Funciones Auxiliares
mapVida :: (Float -> Float) -> Superheroe -> Superheroe
mapVida unaFuncion unSuperheroe = unSuperheroe {vida = unaFuncion (vida unSuperheroe)}

mapNombreSuperheroe :: (String -> String) -> Superheroe -> Superheroe
mapNombreSuperheroe unaFuncion unSuperheroe = unSuperheroe {nombreSuperheroe = unaFuncion (nombreSuperheroe unSuperheroe)}

mapNombreArtefacto :: (String -> String) -> Artefacto -> Artefacto
mapNombreArtefacto unaFuncion unArtefacto = unArtefacto {nombreArtefacto = unaFuncion (nombreArtefacto unArtefacto)} 

mapDanioSufrido :: (Int -> Int) -> Artefacto -> Artefacto
mapDanioSufrido unaFuncion unArtefacto = unArtefacto {danioSufrido = unaFuncion (danioSufrido unArtefacto)} 

mapArtefacto :: (Artefacto -> Artefacto) -> Superheroe -> Superheroe
mapArtefacto unaFuncion unSuperheroe = unSuperheroe {artefacto = unaFuncion (artefacto unSuperheroe)}
--Punto1
--a.
traje :: Artefacto
traje = Artefacto "Traje" 12
ironMan :: Superheroe
ironMan = Superheroe "Tony Stark" 100 "La Tierra" traje thanos


stormbreaker :: Artefacto
stormbreaker = Artefacto "Stormbreaker" 0
thor :: Superheroe
thor = Superheroe "Thor Odinson" 300 "Asgard" stormbreaker loki

--b
thanos :: Villano
thanos = Villano "Thanos" "Titan" guanteleteDelInfinito

loki :: Villano
loki = Villano "Loki Laufeyson" "Jotunheim" (cetro 20)
--Punto2

guanteleteDelInfinito :: Arma
guanteleteDelInfinito = disminuirVida 80

disminuirVida :: Float -> Superheroe -> Superheroe
disminuirVida unPorcentaje = mapVida (*(1-(unPorcentaje/100)))

cetro :: Float -> Arma
cetro unPorcentaje unSuperheroe
 |nacioEn "La Tierra" unSuperheroe = (disminuirVida unPorcentaje) . (romperArtefacto) $unSuperheroe
 |otherwise = unSuperheroe

romperArtefacto :: Superheroe -> Superheroe
romperArtefacto unSuperheroe = (mapArtefacto (const((mapNombreArtefacto (++ " machacado")) (mapDanioSufrido (+30)(artefacto unSuperheroe))))) unSuperheroe
 
nacioEn :: String -> Superheroe -> Bool
nacioEn unPlaneta = (==unPlaneta).planetaOrigen

--Punto3
sonAntagonistas :: Villano -> Superheroe -> Bool
sonAntagonistas unVillano unSuperheroe = 
  esVillano unSuperheroe unVillano || (planeta unVillano) == (planetaOrigen unSuperheroe)

esVillano :: Superheroe -> Villano -> Bool
esVillano unSuperheroe unVillano = (== (nombreVillano unVillano)) . (nombreVillano.villanoEnemigo) $unSuperheroe

--Punto4
grupoDeVillanos :: Superheroe -> [Villano] -> Superheroe
grupoDeVillanos unSuperheroe unosVillanos = foldl (.) id (((map arma) . (filter (not.(esVillano unSuperheroe))))$unosVillanos) unSuperheroe

--Punto5
sobreviven :: Villano -> [Superheroe] -> [Superheroe]
sobreviven unVillano = (map (agregarPrefijo "Super ")).(filter ((>=50).vida)) . (map ((arma unVillano)))

agregarPrefijo :: String -> Superheroe -> Superheroe
agregarPrefijo unPrefijo = mapNombreSuperheroe ((++) unPrefijo)

--Punto6
descansar :: [Superheroe] -> [Superheroe]
descansar = (map arreglarArtefacto).(map (aumentarVida 30)).(sobreviven thanos)

aumentarVida :: Float -> Superheroe -> Superheroe
aumentarVida unaVida = mapVida ((+)unaVida)

arreglarArtefacto :: Superheroe -> Superheroe
arreglarArtefacto unSuperheroe 
 |(elem "machacado" . words . nombreArtefacto . artefacto) unSuperheroe = mapArtefacto (const (mapNombreArtefacto (head.words) (reestablecerDanioSufrido.artefacto))) unSuperheroe
 |otherwise = mapArtefacto (reestablecerDanioSufrido (artefacto unSuperheroe)) unSuperheroe
 
reestablecerDanioSufrido :: Artefacto -> Artefacto
reestablecerDanioSufrido = mapDanioSufrido (const 0)

--Punto7
esDebil :: Villano -> [Superheroe] -> Bool
esDebil unVillano = (==0).length.(filter (sonAntagonistas unVillano))

--Punto8
drStrange :: Superheroe
drStrange = Superheroe "Stephen Strange " 60 "La Tierra" capaLevitacion thanos

capaLevitacion :: Artefacto
capaLevitacion = Artefacto "Capa de Levitacion" 0

--clonesDrStrange :: [Superheroe]
--clonesDrStrange = map (mapNombreSuperheroe (++ show[1..])) (cycle [drStrange])


--clonesDrStrange' :: [String]
--clonesDrStrange' = concat (++) (map show [1..]) (map (nombreSuperheroe) (cycle [drStrange]))

















