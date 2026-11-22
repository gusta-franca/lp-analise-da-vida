module Analyser (totalPalavras, frequenciaPalavras, palavrasFrequentes) where

import CustomIo (lerNumPalavras)
import Data.Char (isLetter, toLower)
import Data.List (sortBy)
import qualified Data.Map.Strict as Map
import Data.Ord (Down (..), comparing)

totalPalavras :: String -> IO ()
totalPalavras textoCru = do
  let tamanho = length (words (_normalizarTexto textoCru))
  putStrLn ("")
  putStr ("Número total de palavras no texto lido: " ++ show tamanho)
  putStrLn ""

frequenciaPalavras :: String -> IO ()
frequenciaPalavras textoCru = do
  putStrLn ""
  putStrLn "Palavra: Frequência"
  let mapa = _enumerarPalavras textoCru
  mapM_ (\(palavra, qtd) -> putStrLn (palavra ++ ":" ++ show qtd)) (Map.toAscList mapa)

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

_enumerarPalavras :: String -> Map.Map String Int
_enumerarPalavras textoCru = do
  foldl' inserirContagem Map.empty (words (_normalizarTexto textoCru))
  where
    inserirContagem acc palavra = Map.insertWith (+) palavra 1 acc

_ordenarPorFrequencia :: Map.Map String Int -> [(String, Int)]
_ordenarPorFrequencia = sortBy (comparing (Down . snd)) . Map.toList

_normalizarTexto :: String -> String
_normalizarTexto =
  map (\c -> if isLetter c || c == ' ' || c == '\n' then toLower c else ' ')
