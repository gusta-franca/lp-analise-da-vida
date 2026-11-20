module CustomIo (listarArquivos, lerArquivo) where

import System.Directory   (listDirectory, doesFileExist)
import System.IO          (hFlush, stdout)

listarArquivos :: String -> IO ()
listarArquivos dataDir = do
  putStrLn ""
  putStrLn "Arquivos disponíveis: "
  arquivos <- listDirectory dataDir
  exibirLista arquivos

lerArquivo :: String -> IO String
lerArquivo dataDir = do
  nomeArquivo <- pedirArquivo
  let caminho = dataDir ++ nomeArquivo
  caminhoExiste <- doesFileExist caminho

  if caminhoExiste
    then readFile caminho
    else do
      putStrLn "ERRO: Arquivo inválido"
      lerArquivo dataDir

pedirArquivo :: IO String
pedirArquivo = do
  putStrLn ""
  putStr "Digite o nome do arquivo de inicialização: "
  hFlush stdout
  arquivo <- getLine
  return arquivo

exibirLista :: [String] -> IO ()
exibirLista [] = return () 
exibirLista (item : lista) = do
  putStrLn ("- " ++ item)
  exibirLista lista
