module Render (exibirTabuleiro) where

import System.IO (hFlush, stdout)
import Data.List (intersperse)

-- Exibe a matriz completa no terminal
exibirTabuleiro :: Int -> Int -> [[Char]] -> IO ()
exibirTabuleiro geracao linhas tabuleiro = do
  let altura = length tabuleiro + linhas

  -- Impede o cursor de sobrescrever símbolos fora da matriz
  if geracao > 1
    then moverCursor altura
    else return ()
    
  exibirCabecalho geracao
  exibirLinhas tabuleiro
  hFlush stdout

-- Helper para exibir o cabeçalho de uma nova geração
exibirCabecalho :: Int -> IO ()
exibirCabecalho geracao =
  putStrLn $ "Geração " ++ show geracao ++ "\ESC[K"

-- Helper para exibir as linhas de uma matriz
exibirLinhas :: [[Char]] -> IO ()
exibirLinhas [] = return ()
exibirLinhas (linha : matriz) = do
  putStrLn (intersperse ' ' linha)
  exibirLinhas matriz

-- Helper para voltar o cursor ao começo do terminal
moverCursor :: Int -> IO ()
moverCursor n = putStr $ "\ESC[" ++ show n ++ "F"
