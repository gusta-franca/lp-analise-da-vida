module Analyser (totalPalavras) where

import Data.Char (isLetter, toLower)
import qualified Data.Map.Strict as Map

totalPalavras :: String -> IO ()
totalPalavras textoCru = do
  let tamanho = length (words (_normalizarTexto textoCru))
  putStrLn ("")
  putStr ("Número total de palavras no texto lido: ")
  print tamanho
  putStrLn ""

_enumerarPalavras :: String -> Map.Map String Int
_enumerarPalavras textoCru = do
  foldl' inserirContagem Map.empty (words (_normalizarTexto textoCru))
  where
    inserirContagem acc palavra = Map.insertWith (+) palavra 1 acc

_normalizarTexto :: String -> String
_normalizarTexto =
  map (\c -> if isLetter c || c == ' ' || c == '\n' then toLower c else ' ')
