module Main (main) where

import CustomIo           (listarArquivos, lerArquivo, lerComando)
import Environment        (carregarMatriz)
import Render             (exibirTabuleiro)
import Rules              (proximaGeracao)

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
  comando <- lerComando "Pressione ENTER para avançar ou Q para sair: "
  
  if comando == "q" || comando == "Q"
    then putStrLn "Encerrando execução"
    else loop (geracao + 1) (proximaGeracao tabuleiro)
