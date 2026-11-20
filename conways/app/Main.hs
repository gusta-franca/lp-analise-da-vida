module Main (main) where

import Control.Concurrent (threadDelay)
import Environment        (criarMatriz, popularMatriz)
import Render             (exibirTabuleiro)
import Rules              (proximaGeracao)

tamanho :: Int
tamanho = 20

intervalo :: Int
intervalo = 500000

main :: IO ()
main = do
  let tabuleiroVazio = criarMatriz tamanho
  tabuleiroInicial  <- popularMatriz tabuleiroVazio
  putStrLn ""
  loop 1 tabuleiroInicial

loop :: Int -> [[Char]] -> IO ()
loop geracao tabuleiro = do
  exibirTabuleiro geracao tabuleiro
  threadDelay intervalo
  loop (geracao + 1) (proximaGeracao tabuleiro)
