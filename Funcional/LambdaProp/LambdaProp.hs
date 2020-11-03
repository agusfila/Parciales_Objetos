type Requisito = Depto -> Bool
type Busqueda = [Requisito]
type Depto = (Int, Int, Int, String)
type Persona = (String, [Busqueda])

ambientes (a, _,_,_) =a
superficie (_,m2,_,_) = m2
precio (_,_,p,_)= p
barrio (_,_,_,b) = b

mail persona = fst persona
busquedas persona = snd persona

ordenarSegun :: (a -> a -> Bool) -> [a] -> [a]
ordenarSegun _ [] = []
ordenarSegun criterio (x:xs) = (ordenarSegun criterio.filter (not.criterio x)) xs ++ [x] ++ (ordenarSegun criterio.filter (criterio x)) xs

between x y z = x <= z && y >= z

deptosDeEjemplo = [(3,80,7500,"Palermo"), (1,45,3500,"Villa Urquiza"), (2,50,5000,"Palermo"), (1,45,5500,"Recoleta")]
depto1 = (3,80,7500,"Palermo")

--Punto1
--a.
mayor :: Ord b => (a -> b) -> a -> a -> Bool
mayor funcion v1 = (<(funcion v1)).funcion

menor :: Ord b => (a -> b) -> a -> a -> Bool
menor funcion v1 = (>(funcion v1)).funcion

--Punto 2
--a.
ubicadoEn :: Depto -> [String] -> Bool
ubicadoEn unDepto = elem (barrio unDepto)

--b.
cumpleRango :: (Num a, Ord a) => (Depto -> a) -> a -> a -> Depto -> Bool
cumpleRango unaFuncion num1 num2 = (between num1 num2).unaFuncion

--Punto3
--a.
cumpleBusqueda :: Depto -> Busqueda -> Bool
cumpleBusqueda unDepto = (foldl1 (&&)) . (map ($unDepto))
--b.
buscar :: Busqueda -> (Depto -> Depto -> Bool) -> [Depto] -> [Depto]
buscar unosRequisitos unCriterio = (ordenarSegun unCriterio) . (filter (\unDepto -> cumpleBusqueda unDepto unosRequisitos)) 
--c.

--Punto4
mailsDePersonasInteresadas :: Depto -> [Persona] -> [String]
mailsDePersonasInteresadas _ [] = []
mailsDePersonasInteresadas unDepto (x:xs)
 | ((any (cumpleBusqueda unDepto)).busquedas) $x = [mail x] ++ mailsDePersonasInteresadas unDepto xs
 | otherwise = mailsDePersonasInteresadas unDepto xs
 
--Punto5
--f :: (z -> z -> z) -> ((c,d) -> a) -> [(Int,b)] -> a
f x y = y.head.map (\(_,z) -> menor x z).filter (even.fst)






