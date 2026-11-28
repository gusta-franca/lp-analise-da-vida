module Analyser (totalPalavras, frequenciaPalavras, palavrasFrequentes) where

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

-- Imprime uma tabela com a frequência absoluta e relativa de cada palavra distinta
frequenciaPalavras :: String -> Bool -> String -> IO ()
frequenciaPalavras textoCru removerComuns ordem = do
  putStrLn ""
  putStrLn ""
  putStrLn "Frequência de palavras"
  let mapa = _enumerarPalavras removerComuns textoCru
      total = sum (Map.elems mapa)
      pares = _ordenarEntradas ordem mapa
      -- Formata o percentual de cada palavra antes de calcular as larguras da tabela
      linhas =
        map
          ( \(palavra, qtd) ->
              let percentual :: Double
                  -- A conversão para Double evita que a divisão descarte as casas decimais
                  percentual = (fromIntegral qtd / fromIntegral total) * 100
               in (palavra, show qtd, printf "%.2f%%" percentual)
          )
          pares
      -- Considera o cabeçalho e o maior valor de cada coluna
      larguraPalavra = maximum (length "Palavra" : map (\(palavra, _, _) -> length palavra) linhas)
      larguraFrequencia = maximum (length "Frequência" : map (\(_, qtd, _) -> length qtd) linhas)
      larguraRelativa = maximum (length "Frequência Relativa" : map (\(_, _, relativa) -> length relativa) linhas)
      -- Distribui espaços ao redor do valor; se sobrar um espaço, ele fica à direita
      centralizar largura valor =
        let espacos = largura - length valor
         in replicate (espacos `div` 2) ' ' ++ valor ++ replicate (espacos - espacos `div` 2) ' '
      separador = " | "
      cabecalho =
        centralizar larguraPalavra "Palavra"
          ++ separador
          ++ centralizar larguraFrequencia "Frequência"
          ++ separador
          ++ centralizar larguraRelativa "Frequência Relativa"
  putStrLn cabecalho
  putStrLn (replicate (larguraPalavra + larguraFrequencia + larguraRelativa + 6) '-')
  mapM_
    (\(palavra, qtd, relativa) ->
      putStrLn
        ( centralizar larguraPalavra palavra
            ++ separador
            ++ centralizar larguraFrequencia qtd
            ++ separador
            ++ centralizar larguraRelativa relativa
        )
    )
    linhas

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

-- Conta as palavras analisáveis e armazena as frequências em um Map
_enumerarPalavras :: Bool -> String -> Map.Map String Int
_enumerarPalavras removerComuns textoCru = do
  -- foldl' evita acumular cálculos pendentes durante a contagem
  foldl' inserirContagem Map.empty (_palavrasAnalisaveis removerComuns textoCru)
  where
    inserirContagem acc palavra = Map.insertWith (+) palavra 1 acc

-- Ordena por frequência decrescente e, em caso de empate, por palavra
_ordenarPorFrequencia :: Map.Map String Int -> [(String, Int)]
_ordenarPorFrequencia =
  sortBy (\a b -> comparing (Down . snd) a b <> comparing fst a b)
    . Map.toList

-- Usa frequência decrescente para a opção "2", nas demais, ordem alfabética
_ordenarEntradas :: String -> Map.Map String Int -> [(String, Int)]
_ordenarEntradas "2" = _ordenarPorFrequencia
_ordenarEntradas _ = Map.toAscList

-- Converte letras para minúsculas e substitui caracteres não alfabéticos por espaços
_normalizarTexto :: String -> String
_normalizarTexto =
  map (\c -> if isLetter c || c == ' ' || c == '\n' then toLower c else ' ')

-- Prepara as palavras para análise, removendo stopwords quando solicitado
_palavrasAnalisaveis :: Bool -> String -> [String]
_palavrasAnalisaveis removerComuns textoCru =
  _removerStopwords removerComuns (words (_normalizarTexto textoCru))

-- Remove palavras comuns da lista quando a opção está ativada
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
