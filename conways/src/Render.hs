module Render (exibirTabuleiro) where

import System.IO (hFlush, stdout)

exibirTabuleiro :: Int -> [[Char]] -> IO ()
exibirTabuleiro geracao tabuleiro = do
  -- Impede o cursor de sobrescrever símbolos fora da matriz
  if geracao > 1
    then moverCursor (length tabuleiro + 1)
    else putStr ""
    
  exibirCabecalho geracao
  mapM_ exibirLinha tabuleiro
  hFlush stdout

exibirCabecalho :: Int -> IO ()
exibirCabecalho geracao =
  putStrLn $ "Geração " ++ show geracao

exibirLinha :: [Char] -> IO ()
exibirLinha linha = putStrLn (unwords (map (: []) linha))

moverCursor :: Int -> IO ()
moverCursor n = putStr $ "\ESC[" ++ show n ++ "F"
