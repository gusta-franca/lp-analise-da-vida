module Main (main) where

import Control.Concurrent (threadDelay)
import CustomIo           (listarArquivos, lerArquivo)
import Environment        (carregarMatriz)
import Render             (exibirTabuleiro)
import Rules              (proximaGeracao)

intervalo :: Int
intervalo = 500000

main :: IO ()
main = do
  let dataDir = "data/"

  listarArquivos dataDir
  arquivo <- lerArquivo dataDir
  
  let tabuleiro = carregarMatriz arquivo
  putStrLn ""
  loop 1 tabuleiro

loop :: Int -> [[Char]] -> IO ()
loop geracao tabuleiro = do
  exibirTabuleiro geracao tabuleiro
  threadDelay intervalo
  loop (geracao + 1) (proximaGeracao tabuleiro)
