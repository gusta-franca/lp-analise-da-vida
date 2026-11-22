module Main (main) where

import Analyser (totalPalavras)
import CustomIo (lerArquivo, lerAtividade, lerModo, lerTexto)

main :: IO ()
main = do
  modo <- lerModo

  texto <- case modo of
    "1" -> lerTexto
    "2" -> lerArquivo
    _ -> do
      putStrLn "ERRO: Opção inválida :("
      pure ""

  atividade <- lerAtividade
  -- Ler opções: Ordenar (alfabetica/frequencia), remover stopwords

  case atividade of
    "1" -> do
      totalPalavras texto
    _ -> do
      putStrLn "ERRO: Opção inválida :("

  putStrLn ""
