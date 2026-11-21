module CustomIo (listarArquivos, lerArquivo, lerComando, lerInteiro, lerModo) where

import Data.Char (isDigit)
import System.Directory (doesFileExist, listDirectory)
import System.IO (hFlush, stdout)

-- Helper para ler os dados de um arquivo
lerArquivo :: String -> IO String
lerArquivo dataDir = do
  nomeArquivo <- pedirArquivo
  let caminho = dataDir ++ nomeArquivo
  caminhoExiste <- doesFileExist caminho

  if caminhoExiste
    then readFile caminho
    else do
      putStrLn "ERRO: Arquivo inválido"

      -- Recursão para realizar a leitura novamente em caso de erro
      lerArquivo dataDir

-- Helper para ler um arquivo do terminal
pedirArquivo :: IO String
pedirArquivo = do
  putStrLn ""
  putStr "Digite o nome do arquivo de inicialização: "
  hFlush stdout
  arquivo <- getLine
  return arquivo

-- Helper para ler e validar os comandos do modo manual
lerComando :: String -> IO String
lerComando mensagem = do
  putStr mensagem
  hFlush stdout
  comando <- getLine

  if comando == "" || comando == "q" || comando == "Q"
    then return comando
    else do
      -- putStr (posCursor 1 ++ limparLinha)
      lerComando "Comando inválido"
