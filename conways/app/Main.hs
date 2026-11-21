module Main (main) where

import CustomIo           (listarArquivos, lerArquivo, lerComando, lerModo, lerInteiro)
import Environment        (carregarMatriz)
import Render             (exibirTabuleiro)
import Rules              (proximaGeracao)
import Control.Concurrent (threadDelay)

main :: IO ()
main = do
  let dataDir = "data/"

  listarArquivos dataDir
  arquivo <- lerArquivo dataDir

  let tabuleiro = carregarMatriz arquivo
  modo <- lerModo
  putStrLn ""

  case modo of 
    "1" -> do
      loopManual 1 tabuleiro    
    "2" -> do
      intervalo <- lerInteiro "Intervalo entre gerações: " 1
      maximo <- lerInteiro "Máximo de gerações (0 para infinito): " 0
      putStrLn ""
      loopContinuo 1 maximo (intervalo * 1000000) tabuleiro
    _ -> do
      putStrLn "ERRO: Opção inválida"

-- Controla a execução manual do sistema
loopManual :: Int -> [[Char]] -> IO ()
loopManual geracao tabuleiro = do
  exibirTabuleiro geracao 2 tabuleiro  
  comando <- lerComando "Pressione ENTER para avançar ou Q para sair: "
  
  if comando == "q" || comando == "Q"
    then putStrLn "Encerrando execução"

    -- Recursão para computar e exibir a próxima geração
    else loopManual (geracao + 1) (proximaGeracao tabuleiro)

-- Controla a execução contínua do sistema
loopContinuo :: Int -> Int -> Int -> [[Char]] -> IO ()
loopContinuo geracao maximo intervalo tabuleiro = do
  exibirTabuleiro geracao 1 tabuleiro

  if maximo > 0 && geracao >= maximo
    then putStrLn "\nExecução concluída"
    else do
      threadDelay intervalo
      
      -- Recursão para computar e exibir a próxima geração
      loopContinuo (geracao + 1) maximo intervalo (proximaGeracao tabuleiro)
