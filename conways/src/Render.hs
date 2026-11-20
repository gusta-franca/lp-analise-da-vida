module Render (exibirTabuleiro) where

exibirTabuleiro :: Int -> [[Char]] -> IO ()
exibirTabuleiro geracao tabuleiro = do
  limparTela
  exibirCabecalho geracao
  mapM_ exibirLinha tabuleiro

-- Clear e cursor 
limparTela :: IO ()
limparTela = putStr "\ESC[H\ESC[2J"

exibirCabecalho :: Int -> IO ()
exibirCabecalho geracao =
  putStrLn $ "Geração " ++ show geracao

exibirLinha :: [Char] -> IO ()
exibirLinha linha = putStrLn (unwords (map (: []) linha))
