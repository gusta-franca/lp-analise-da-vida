module Main (main) where

import Analyser (frequenciaPalavras, palavrasFrequentes, totalPalavras)
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

  -- Ver se o usuário quer remover stopwords

  -- Tem que perguntar sobre a ordenação da tabela, provavelmente dentro das próprias funções de atividade 

  case atividade of
    "1" -> do
      totalPalavras texto
    "2" -> do
      frequenciaPalavras texto
    "3" -> do
      palavrasFrequentes texto
    _ -> do
      putStrLn "ERRO: Opção inválida :("

  putStrLn ""
