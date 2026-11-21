module Rules (proximaGeracao) where

import Environment(celulaViva, celulaMorta)

-- Retorna uma matriz nova representando a próxima iteração do jogo
proximaGeracao :: [[Char]] -> [[Char]]
proximaGeracao tabuleiro =
  -- List COmprehension para iterar sobre as linhas e colunas sem utilizar laços de repetição
  [ [ proximaCelula tabuleiro linha coluna
    | coluna <- [0 .. cols - 1]
    ]
  | linha <- [0 .. rows - 1]
  ]
  where
    rows = length tabuleiro
    cols = length (head tabuleiro)

-- Helper para aplicar as regras em uma única célula
proximaCelula :: [[Char]] -> Int -> Int -> Char
proximaCelula tabuleiro linha coluna
  | estaViva && (vizinhos < 2 || vizinhos > 3)   = celulaMorta 
  | estaViva && (vizinhos == 2 || vizinhos == 3) = celulaViva 
  | not estaViva && vizinhos == 3                = celulaViva 
  | otherwise                                    = celulaMorta  
  where
    estaViva = celula tabuleiro linha coluna == celulaViva
    vizinhos = contarVizinhos tabuleiro linha coluna

-- Helper para computar os vizinhos da célula atual
contarVizinhos :: [[Char]] -> Int -> Int -> Int
contarVizinhos tabuleiro linha coluna =
  -- List Comprehension para gerar uma lista vazia para cada vizinho
  length [ ()
         | dl <- [-1, 0, 1]
         , dc <- [-1, 0, 1]
         , not (dl == 0 && dc == 0)       
         , let l = linha  + dl
         , let c = coluna + dc
         , dentroDoLimite tabuleiro l c   
         , celula tabuleiro l c == celulaViva
         ]

-- Retorna o conteúdo de uma célula na posição (linha, coluna)
celula :: [[Char]] -> Int -> Int -> Char
celula tabuleiro linha coluna = (tabuleiro !! linha) !! coluna

-- Valida se uma célula está dentro do limite da matriz
dentroDoLimite :: [[Char]] -> Int -> Int -> Bool
dentroDoLimite tabuleiro linha coluna =
  linha  >= 0 && linha  < length tabuleiro &&
  coluna >= 0 && coluna < length (head tabuleiro)
