module Main (main) where

import Analyser (frequenciaPalavras, palavrasFrequentes, totalPalavras)
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

  -- Tem que perguntar sobre a ordenação da tabela, provavelmente dentro das próprias funções de atividade
  ordem <- perguntarOrdem
  -- Se for alfabética não precisa fazer nada, ela já é armazenada assim
  -- Também tem uma função pra ordenar por frequência já

  putStrLn "\n-- ANÁLISE: "
  totalPalavras texto
  frequenciaPalavras texto
  palavrasFrequentes texto

  putStrLn ""
