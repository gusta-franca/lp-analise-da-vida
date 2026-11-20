module Environment (criarMatriz, popularMatriz, carregarMatriz, celulaViva, celulaMorta) where

import System.Random      (randomRIO)

celulaViva :: Char
celulaMorta :: Char
celulaViva = 'O'
celulaMorta = '.'

criarMatriz :: Int -> [[Char]]
criarMatriz n = replicate n (replicate n celulaMorta)

-- Preenchemos a matriz com valores aleatórios para ser o gatilho das próximas gerações
popularMatriz :: [[Char]] -> IO [[Char]]
popularMatriz matriz = do
  let n      = length matriz
  valores   <- sequence (replicate (n * n) (randomRIO (0, 1) :: IO Int))
  let chars  = map celulaAleatoria valores
  return (distribuir chars n)

carregarMatriz :: String -> [[Char]]
carregarMatriz conteudo = lines conteudo

celulaAleatoria :: Int -> Char
celulaAleatoria 0 = celulaViva
celulaAleatoria _ = celulaMorta

distribuir :: [Char] -> Int -> [[Char]]
distribuir [] _ = []
distribuir cs  n = take n cs : distribuir (drop n cs) n
