module Analyser (totalPalavras, frequenciaPalavras) where

import Data.Char (isLetter, toLower)
import qualified Data.Map.Strict as Map

totalPalavras :: String -> IO ()
totalPalavras textoCru = do
  let tamanho = length (words (_normalizarTexto textoCru))
  putStrLn ("")
  putStr ("Número total de palavras no texto lido: " ++ show tamanho)
  putStrLn ""

frequenciaPalavras :: String -> IO ()
frequenciaPalavras textoCru = do
  let mapa :: Map.Map String Int
      mapa = foldl' inserirContagem Map.empty (words (_normalizarTexto textoCru))
  putStrLn ""
  putStrLn "Palavra: Frequência"
  mapM_ (\(palavra, qtd) -> putStrLn (palavra ++ ":" ++ show qtd)) (Map.toAscList mapa)
  where
    inserirContagem acc palavra = Map.insertWith (+) palavra 1 acc

_normalizarTexto :: String -> String
_normalizarTexto =
  map (\c -> if isLetter c || c == ' ' || c == '\n' then toLower c else ' ')
