module CustomIo (lerArquivo, lerModo, lerTexto, lerNumPalavras, perguntarStopword, perguntarOrdem) where

import Data.Char (isDigit)
import System.Directory (doesFileExist)
import System.IO (hFlush, stdout)
import Text.Read ()

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

-- Helper para ler um texto inserido manualmente
lerTexto :: IO String
lerTexto = do
  putStrLn ""
  putStrLn "Escreva o texto desejado. Finalize com uma linha vazia:"
  hFlush stdout
  lerLinhas []
  where
    lerLinhas linhas = do
      linha <- getLine
      if null linha
        then pure (unlines (reverse linhas))
        else lerLinhas (linha : linhas)

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

perguntarStopword :: IO Bool
perguntarStopword = do
  putStrLn ""
  putStrLn "Remover palavras comuns (artigos, preposições, etc.)? s/N"
  hFlush stdout
  entrada <- getLine

  if (entrada == "s" || entrada == "S")
    then return True
    else return False

perguntarOrdem :: IO String
perguntarOrdem = do
  putStrLn ""
  putStrLn "Ordenar por: "
  putStrLn "1 - Ordem alfabética"
  putStrLn "2 - Por frequência"
  hFlush stdout
  entrada <- getLine

  if entrada == "1" || entrada == "2"
    then return entrada
    else do
      putStrLn "ERRO: Opção inválida"
      perguntarOrdem
