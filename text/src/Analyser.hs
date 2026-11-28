module Analyser (totalPalavras, frequenciaPalavras, palavrasFrequentes, frequenciaRelativa) where

import CustomIo (lerNumPalavras)
import Data.Char (isLetter, toLower)
import Data.List (sortBy)
import qualified Data.Map.Strict as Map
import Data.Ord (Down (..), comparing)
import qualified Data.Set as Set
import Text.Printf (printf)

-- Imprime o total de palavras do texto no terminal
totalPalavras :: String -> Bool -> IO ()
totalPalavras textoCru removerComuns = do
  let tamanho = length (_palavrasAnalisaveis removerComuns textoCru)
  putStrLn ("Contagem de palavras")
  putStr ("Número total de palavras no texto lido: " ++ show tamanho)

-- Imprime todas as palavras distintas e o número de vezes que aparecem
frequenciaPalavras :: String -> Bool -> String -> IO ()
frequenciaPalavras textoCru removerComuns ordem = do
  putStrLn ""
  putStrLn ""
  putStrLn "Frequência de palavras"
  putStrLn "Palavra: Frequência"
  let pares = _ordenarEntradas ordem (_enumerarPalavras removerComuns textoCru)
  mapM_ (\(palavra, qtd) -> putStrLn (palavra ++ ":" ++ show qtd)) pares

-- Imprime n palavras mais frequentes
palavrasFrequentes :: String -> Bool -> String -> IO ()
palavrasFrequentes textoCru removerComuns _ordem = do
  let mapa = _enumerarPalavras removerComuns textoCru
  if Map.null mapa
    then putStrLn "Não há palavras para exibir na análise de palavras mais frequentes."
    else do
      numPalavras <- lerNumPalavras
      let pares = _ordenarEntradas "2" mapa
      if numPalavras > Map.size mapa
        then do
          putStrLn "ERRO: O número de palavras não pode ser maior do que a quantidade de palavras distintas no texto."
          palavrasFrequentes textoCru removerComuns _ordem
        else do
          let palavras = take numPalavras pares
          putStrLn ""
          putStrLn (show numPalavras ++ " palavras mais frequentes")
          putStrLn "Palavra: Frequência"
          mapM_ (\(palavra, qtd) -> putStrLn (palavra ++ ":" ++ show qtd)) palavras

-- Imprime todas as palavras distintas e sua frequência relativa
frequenciaRelativa :: String -> Bool -> String -> IO ()
frequenciaRelativa textoCru removerComuns ordem = do
  let mapa = _enumerarPalavras removerComuns textoCru
  putStrLn ""
  putStrLn ""
  putStrLn "Frequência relativa"
  if Map.null mapa
    then putStrLn "Não há palavras para calcular a frequência relativa."
    else do
      putStrLn "Palavra: Frequência relativa"
      let total = sum (Map.elems mapa)
      let pares = _ordenarEntradas ordem mapa
      mapM_
        (\(palavra, qtd) ->
          let percentual :: Double
              percentual = (fromIntegral qtd / fromIntegral total) * 100
           in putStrLn (palavra ++ ":" ++ printf "%.2f%%" percentual)
        )
        pares

-- Cria um dicionário com as palavras e suas frequências
_enumerarPalavras :: Bool -> String -> Map.Map String Int
_enumerarPalavras removerComuns textoCru = do
  -- foldl com ' para evitar stackOverflow
  -- Aqui serve para fazer a contagem das palavras
  foldl' inserirContagem Map.empty (_palavrasAnalisaveis removerComuns textoCru)
  where
    inserirContagem acc palavra = Map.insertWith (+) palavra 1 acc

-- Transforma a tabela em uma lista e usa o sortBy para ordenar com base na frequência
_ordenarPorFrequencia :: Map.Map String Int -> [(String, Int)]
_ordenarPorFrequencia =
  sortBy (\a b -> comparing (Down . snd) a b <> comparing fst a b)
    . Map.toList

-- Seleciona a ordenação usada nas tabelas
_ordenarEntradas :: String -> Map.Map String Int -> [(String, Int)]
_ordenarEntradas "2" = _ordenarPorFrequencia
_ordenarEntradas _ = Map.toAscList

-- Usa a funćão map para limpar o texto provido pelo usuário
_normalizarTexto :: String -> String
_normalizarTexto =
  -- Map que aplica uma função lambda para todos os caracteres do texto
  map (\c -> if isLetter c || c == ' ' || c == '\n' then toLower c else ' ')

-- Seleciona as palavras que farão parte das análises
_palavrasAnalisaveis :: Bool -> String -> [String]
_palavrasAnalisaveis removerComuns textoCru =
  _removerStopwords removerComuns (words (_normalizarTexto textoCru))

-- Remove palavras comuns da lista antes da contagem
_removerStopwords :: Bool -> [String] -> [String]
_removerStopwords removerComuns palavras =
  if removerComuns
    then filter (\palavra -> not (Set.member palavra stopwords)) palavras
    else palavras

stopwords :: Set.Set String
stopwords =
  Set.fromList
    [ "a",
      "ao",
      "aos",
      "as",
      "com",
      "da",
      "das",
      "de",
      "do",
      "dos",
      "e",
      "em",
      "na",
      "nas",
      "no",
      "nos",
      "o",
      "os",
      "para",
      "por",
      "que",
      "se",
      "sem",
      "um",
      "uma",
      "uns",
      "umas"
    ]
