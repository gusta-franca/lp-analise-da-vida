module Main (main) where

import Analyser (frequenciaPalavras, frequenciaRelativa, palavrasFrequentes, totalPalavras)
import CustomIo (lerArquivo, lerModo, lerTexto, perguntarOrdem, perguntarStopword)

main :: IO ()
main = do
  modo <- lerModo

  texto <- case modo of
    "1" -> lerTexto
    "2" -> lerArquivo
    _ -> do
      putStrLn "ERRO: Opção inválida :("
      pure ""

  -- Ver se o usuário quer remover stopwords
  removerComuns <- perguntarStopword

  -- Ver como o usuário quer ordenar as palavras
  ordem <- perguntarOrdem

  putStrLn "\n-- ANÁLISE: "
  totalPalavras texto removerComuns
  frequenciaPalavras texto removerComuns ordem
  palavrasFrequentes texto removerComuns ordem
  frequenciaRelativa texto removerComuns ordem

  putStrLn ""
