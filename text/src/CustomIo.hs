module CustomIo (lerArquivo, lerModo, lerTexto, lerAtividade, lerNumPalavras) where

import Data.Char (isDigit)
import System.Directory (doesFileExist)
import System.IO (hFlush, stdout)

-- Helper para ler os dados de um arquivo
lerArquivo :: IO String
lerArquivo = do
  nomeArquivo <- _pedirArquivo
  let caminho = nomeArquivo
  caminhoExiste <- doesFileExist caminho

  if caminhoExiste
    then readFile caminho
    else do
      putStrLn "ERRO: Arquivo inválido"

      -- Recursão para realizar a leitura novamente em caso de erro
      lerArquivo

-- Helper para ler um arquivo do terminal
_pedirArquivo :: IO String
_pedirArquivo = do
  putStrLn ""
  putStr "Digite o nome do arquivo de inicialização: "
  hFlush stdout
  arquivo <- getLine
  return arquivo

-- Helper para ler e validar o modo de execução
lerModo :: IO String
lerModo = do
  putStrLn ""
  putStrLn "Escolha o modo de leitura de texto"
  putStrLn "1 - Escrever texto no terminal"
  putStrLn "2 - Carregar arquivo"
  putStr "Opção: "
  hFlush stdout
  modo <- getLine

  if modo == "1" || modo == "2"
    then return modo
    else do
      putStrLn "ERRO: Opção inválida"
      lerModo

-- Helper para ler qual atividade será realizada
lerAtividade :: IO String
lerAtividade = do
  putStrLn ""
  putStrLn "Escolha a atividade a ser executada:"
  putStrLn "1 - Contagem de palavras"
  putStrLn "2 - Frequência de cada palavra"
  putStrLn "3 - Palavras mais frequentes"
  putStrLn "4 - Frequência relativa"
  putStr "Opção: "
  hFlush stdout
  atividade <- getLine

  if atividade == "1" || atividade == "2" || atividade == "3" || atividade == "4"
    then return atividade
    else do
      putStrLn "ERRO: Opção inválida"
      lerAtividade

-- Helper para ler um texto inserido manualmente
lerTexto :: IO String
lerTexto = do
  putStrLn ""
  putStrLn "Escreva o texto desejado:"
  hFlush stdout

  texto <- getLine
  return texto

-- Helper para ler e validar o número de palavras que devem ser exibidas
lerNumPalavras :: IO Int
lerNumPalavras = do
  putStrLn ""
  putStrLn "Número de palavras: "
  hFlush stdout
  entrada <- getLine

  if not (null entrada) && all isDigit entrada
    then do
      let n = read entrada :: Int
      if n > 0
        then return n
        else invalidInput
    else invalidInput
  where
    invalidInput = do
      putStrLn ""
      putStrLn "ERRO: Entrada inválida!"
      putStrLn ""
      lerNumPalavras
