module Environment (criarMatriz, popularMatriz, carregarMatriz, celulaViva, celulaMorta, limparLinha, posCursor) where

import System.Random      (randomRIO)

celulaViva :: Char
celulaMorta :: Char
limparLinha :: String
posCursor :: Int -> String

celulaViva = 'O'
celulaMorta = '.'
limparLinha = "\ESC[K"
posCursor n = "\ESC[" ++ show n ++ "F"


criarMatriz :: Int -> [[Char]]
criarMatriz n = replicate n (replicate n celulaMorta)

-- Preenchemos a matriz com valores aleatórios para ser o gatilho das próximas gerações
popularMatriz :: [[Char]] -> IO [[Char]]
popularMatriz matriz = do
  let n      = length matriz
  valores   <- sequence (replicate (n * n) (randomRIO (0, 1) :: IO Int))
  
  -- Map para aplicar 'celulaAleatoria' a todos os elementos de 'valores'
  let chars  = map celulaAleatoria valores
  return (distribuir chars n)

carregarMatriz :: String -> [[Char]]
carregarMatriz conteudo = lines conteudo

celulaAleatoria :: Int -> Char
celulaAleatoria 0 = celulaViva
celulaAleatoria _ = celulaMorta

distribuir :: [Char] -> Int -> [[Char]]
distribuir [] _ = []

-- Recursão para realizar a divisão de uma lista
distribuir cs  n = take n cs : distribuir (drop n cs) n
