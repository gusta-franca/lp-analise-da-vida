module Analyser (totalPalavras, frequenciaPalavras, palavrasFrequentes) where

import CustomIo (lerNumPalavras)
import Data.Char (isLetter, toLower)
import Data.List (sortBy)
import qualified Data.Map.Strict as Map
import Data.Ord (Down (..), comparing)

-- Imprime o total de palavras do texto no terminal
totalPalavras :: String -> IO ()
totalPalavras textoCru = do
  let tamanho = length (words (_normalizarTexto textoCru))
  putStrLn ("")
  putStr ("Número total de palavras no texto lido: " ++ show tamanho)
  putStrLn ""

-- Imprime todas as palavras distintas e o número de vezes que aparecem
frequenciaPalavras :: String -> IO ()
frequenciaPalavras textoCru = do
  putStrLn ""
  putStrLn "Palavra: Frequência"
  let mapa = _enumerarPalavras textoCru
  mapM_ (\(palavra, qtd) -> putStrLn (palavra ++ ":" ++ show qtd)) (Map.toAscList mapa)

-- Imprime n palavras mais frequentes
palavrasFrequentes :: String -> IO ()
palavrasFrequentes textoCru = do
  numPalavras <- lerNumPalavras
  let mapa = _ordenarPorFrequencia (_enumerarPalavras textoCru)
  if numPalavras > length (mapa)
    then do
      putStrLn "ERROR: Número de palavras exibidas não pode ser maior do que o número de palavras no texto."
      palavrasFrequentes textoCru
    else do
      let palavras = take numPalavras (mapa)
      putStrLn ""
      putStrLn "Palavra: Frequência"
      mapM_ (\(palavra, qtd) -> putStrLn (palavra ++ ":" ++ show qtd)) (palavras)

-- Cria um dicionário com as palavras e suas frequências
_enumerarPalavras :: String -> Map.Map String Int
_enumerarPalavras textoCru = do
  -- foldl com ' para evitar stackOverflow
  -- Aqui serve para fazer a contagem das palavras
  foldl' inserirContagem Map.empty (words (_normalizarTexto textoCru))
  where
    inserirContagem acc palavra = Map.insertWith (+) palavra 1 acc

-- Transforma a tabela em uma lista e usa o sortBy para ordenar com base na frequência  
_ordenarPorFrequencia :: Map.Map String Int -> [(String, Int)]
_ordenarPorFrequencia = sortBy (comparing (Down . snd)) . Map.toList

-- Usa a funćão map para limpar o texto provido pelo usuário
_normalizarTexto :: String -> String
_normalizarTexto =
  -- Map que aplica uma função lambda para todos os caracteres do texto
  map (\c -> if isLetter c || c == ' ' || c == '\n' then toLower c else ' ')
