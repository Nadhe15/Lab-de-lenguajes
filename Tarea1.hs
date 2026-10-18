
--CI-3661 — Tarea1 — Septiembre–Diciembre 2026
--
--  Nombre: Nadheska
--  Carnet: [19-10054]
--
--  Declaración de uso de herramientas de IA:
--  Se utilizó asistencia de IA como apoyo para entender los conceptos de
--  las clases, resolver dudas sobre tipos algebraicos, reducciones de
--  plegados (foldr/foldl) y estructurar las soluciones y pruebas.
module Tarea1
  ( esPalindromo
  , mayorYMenor
  , leerHora
  , duracion
  , promedioSobreUmbral
  , movimientosCaballo
  , enDosSaltos
  , miMap
  , miFilter
  , miFoldl
  ) where

import Data.Char (isAlphaNum, isDigit, toLower, digitToInt)

-- =====================================================================
-- Parte A: recursión explícita.
-- Prohibido: map, filter, foldr, foldl, listas por comprensión, reverse,
-- maximum, minimum, all, any y cualquier otra función de orden superior.
-- =====================================================================

-- A1
esPalindromo :: String -> Bool
esPalindromo str =
  let s = normalizar str
  in s == invertir s
  where
    normalizar :: String -> String
    normalizar [] = []
    normalizar (c:cs)
      | isAlphaNum c = toLower c : normalizar cs
      | otherwise    = normalizar cs

    invertir :: String -> String
    invertir xs = rev xs []
      where
        rev :: String -> String -> String
        rev [] acc     = acc
        rev (c:cs) acc = rev cs (c : acc)

-- A2
-- Explica aquí, en dos o tres líneas, por qué tu solución recorre la
-- lista una sola vez:
-- Se utiliza una función auxiliar recursiva de cola con dos acumuladores
-- (el mayor y el menor actuales). En una sola pasada lineal sobre la lista,
-- cada elemento se compara y actualiza ambos valores al mismo tiempo.
mayorYMenor :: Ord a => [a] -> Maybe (a, a)
mayorYMenor []     = Nothing
mayorYMenor (x:xs) = Just (aux x x xs)
  where
    aux may men [] = (may, men)
    aux may men (y:ys)
      | y > may   = aux y men ys
      | y < men   = aux may y ys
      | otherwise = aux may men ys

-- A3
leerHora :: String -> Either String (Int, Int)
leerHora = undefined

duracion :: String -> String -> Either String Int
duracion = undefined

-- =====================================================================
-- Parte B: orden superior.
-- Prohibido: recursión explícita (ninguna función de esta parte, ni sus
-- auxiliares, puede llamarse a sí misma).
-- =====================================================================

-- B1
promedioSobreUmbral :: Double -> [Double] -> Maybe Double
promedioSobreUmbral = undefined

-- B2
movimientosCaballo :: (Int, Int) -> [(Int, Int)]
movimientosCaballo = undefined

enDosSaltos :: (Int, Int) -> Int
enDosSaltos = undefined

-- B3
miMap :: (a -> b) -> [a] -> [b]
miMap = undefined

miFilter :: (a -> Bool) -> [a] -> [a]
miFilter = undefined

miFoldl :: (b -> a -> b) -> b -> [a] -> b
miFoldl = undefined
