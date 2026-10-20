
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
leerHora [h1, h2, ':', m1, m2]
  | not (isDigit h1 && isDigit h2 && isDigit m1 && isDigit m2) = Left "formato inválido"
  | h > 23    = Left "hora fuera de rango"
  | m > 59    = Left "minutos fuera de rango"
  | otherwise = Right (h, m)
  where
    h = digitToInt h1 * 10 + digitToInt h2
    m = digitToInt m1 * 10 + digitToInt m2
leerHora _ = Left "formato inválido"

duracion :: String -> String -> Either String Int
duracion s1 s2 =
  case leerHora s1 of
    Left err1 -> Left err1
    Right (h1, m1) ->
      case leerHora s2 of
        Left err2 -> Left err2
        Right (h2, m2) ->
          let t1 = h1 * 60 + m1
              t2 = h2 * 60 + m2
              d  = t2 - t1
          in Right (if d < 0 then d + 1440 else d)

-- =====================================================================
-- Parte B: orden superior.
-- Prohibido: recursión explícita (ninguna función de esta parte, ni sus
-- auxiliares, puede llamarse a sí misma).
-- =====================================================================

-- B1
promedioSobreUmbral :: Double -> [Double] -> Maybe Double
promedioSobreUmbral umbral xs =
  let (s, c) = foldr (\x (accS, accC) ->
                        if x > umbral
                          then (accS + x, accC + (1 :: Int))
                          else (accS, accC)
                     ) (0.0, 0 :: Int) xs
  in if c == 0
       then Nothing
       else Just (s / fromIntegral c)

-- B2
movimientosCaballo :: (Int, Int) -> [(Int, Int)]
movimientosCaballo (f, c) =
  [ (f', c')
  | (df, dc) <- [ (-2, -1), (-2, 1)
                , (-1, -2), (-1, 2)
                , ( 1, -2), ( 1, 2)
                , ( 2, -1), ( 2, 1)
                ]
  , let f' = f + df
  , let c' = c + dc
  , 1 <= f' && f' <= 8
  , 1 <= c' && c' <= 8
  ]

enDosSaltos :: (Int, Int) -> Int
enDosSaltos pos =
  let salto1    = movimientosCaballo pos
      dosSaltos = [ p2 | p1 <- salto1, p2 <- movimientosCaballo p1 ]
      sinRep    = foldr (\x acc -> if x `elem` acc then acc else x : acc) [] dosSaltos
  in length sinRep

-- B3
miMap :: (a -> b) -> [a] -> [b]
miMap = undefined

miFilter :: (a -> Bool) -> [a] -> [a]
miFilter = undefined

miFoldl :: (b -> a -> b) -> b -> [a] -> b
miFoldl = undefined
