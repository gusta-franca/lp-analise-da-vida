module Render (exibirTabuleiro) where

import System.IO (hFlush, stdout)
import Data.List (intersperse)

exibirTabuleiro :: Int -> [[Char]] -> IO ()
exibirTabuleiro geracao tabuleiro = do
  let altura = length tabuleiro + 1

  -- Impede o cursor de sobrescrever símbolos fora da matriz
  if geracao > 1
    then moverCursor altura
    else return ()
    
  exibirCabecalho geracao
  exibirLinhas tabuleiro
  hFlush stdout

exibirCabecalho :: Int -> IO ()
exibirCabecalho geracao =
  putStrLn $ "Geração " ++ show geracao ++ "\ESC[K"

exibirLinhas :: [[Char]] -> IO ()
exibirLinhas [] = return ()
exibirLinhas (linha : matriz) = do
  putStrLn (intersperse ' ' linha)
  exibirLinhas matriz

moverCursor :: Int -> IO ()
moverCursor n = putStr $ "\ESC[" ++ show n ++ "F"
