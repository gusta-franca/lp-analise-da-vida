module Environment (criarMatriz, popularMatriz) where

import System.Random (randomRIO)

criarMatriz :: Int -> [[Char]]
criarMatriz n = replicate n (replicate n '.')

-- Preenchemos a matriz com valores aleatórios para ser o gatilho das próximas gerações
popularMatriz :: [[Char]] -> IO [[Char]]
popularMatriz matriz = do
  let n      = length matriz
  valores   <- sequence (replicate (n * n) (randomRIO (0, 1) :: IO Int))
  let chars  = map celulaAleatoria valores
  return (distribuir chars n)

celulaAleatoria :: Int -> Char
celulaAleatoria 0 = '.'
celulaAleatoria _ = 'X'

distribuir :: [Char] -> Int -> [[Char]]
distribuir [] _ = []
distribuir cs  n = take n cs : distribuir (drop n cs) n
