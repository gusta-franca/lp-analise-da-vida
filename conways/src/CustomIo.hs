module CustomIo (listarArquivos, lerArquivo, lerComando, lerInteiro, lerModo) where

import System.Directory   (listDirectory, doesFileExist)
import System.IO          (hFlush, stdout)
import Data.Char          (isDigit)

-- Helper para listar todos os arquivos em um diretório
listarArquivos :: String -> IO ()
listarArquivos dataDir = do
  putStrLn ""
  putStrLn "Arquivos disponíveis: "
  arquivos <- listDirectory dataDir
  exibirLista arquivos

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
      putStr "\ESC[1F\ESC[K"
      lerComando "Comando inválido"

-- Helper para ler e validar o modo de execução
lerModo :: IO String
lerModo = do
  putStrLn ""
  putStrLn "Escolha o modo de execução"
  putStrLn "1 - Manual"
  putStrLn "2 - Contínuo"
  putStr "Opção: "
  hFlush stdout
  modo <- getLine

  if modo == "1" || modo == "2"
    then return modo
    else do
      putStrLn "ERRO: Opção inválida"
      lerModo

-- Helper para ler e validar um número inteiro
lerInteiro :: String -> Int -> IO Int
lerInteiro mensagem minimo = do
  putStr mensagem
  hFlush stdout
  entrada <- getLine

  -- Função de Ordem Superior 'isDigit' usada em 'entrada' por 'all' para validar a entrada no terminal
  if not (null entrada) && all isDigit entrada
    then do
      let valor = read entrada
      if valor >= minimo
        then return valor
        else do
          putStrLn ("ERRO: Digite um número inteiro >= " ++ show minimo)
          lerInteiro mensagem minimo
    else do
      putStrLn ("ERRO: Digite um número inteiro >= " ++ show minimo)
      lerInteiro mensagem minimo

-- Helper para exibir uma lista
exibirLista :: [String] -> IO ()
exibirLista [] = return () 
exibirLista (item : lista) = do
  putStrLn ("- " ++ item)
  exibirLista lista
