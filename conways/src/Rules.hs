module Rules (proximaGeracao) where

proximaGeracao :: [[Char]] -> [[Char]]
proximaGeracao tabuleiro =
  [ [ proximaCelula tabuleiro linha coluna
    | coluna <- [0 .. cols - 1]
    ]
  | linha <- [0 .. rows - 1]
  ]
  where
    rows = length tabuleiro
    cols = length (head tabuleiro)

proximaCelula :: [[Char]] -> Int -> Int -> Char
proximaCelula tabuleiro linha coluna
  | estaViva && (vizinhos < 2 || vizinhos > 3)   = '.' 
  | estaViva && (vizinhos == 2 || vizinhos == 3) = 'X' 
  | not estaViva && vizinhos == 3                = 'X' 
  | otherwise                                    = '.'  
  where
    estaViva = celula tabuleiro linha coluna == 'X'
    vizinhos = contarVizinhos tabuleiro linha coluna

contarVizinhos :: [[Char]] -> Int -> Int -> Int
contarVizinhos tabuleiro linha coluna =
  length [ ()
         | dl <- [-1, 0, 1]
         , dc <- [-1, 0, 1]
         , not (dl == 0 && dc == 0)       
         , let l = linha  + dl
         , let c = coluna + dc
         , dentroDoLimite tabuleiro l c   
         , celula tabuleiro l c == 'X'
         ]

-- Retorna o conteúdo de uma célula na posição (linha, coluna)
celula :: [[Char]] -> Int -> Int -> Char
celula tabuleiro linha coluna = (tabuleiro !! linha) !! coluna

dentroDoLimite :: [[Char]] -> Int -> Int -> Bool
dentroDoLimite tabuleiro linha coluna =
  linha  >= 0 && linha  < length tabuleiro &&
  coluna >= 0 && coluna < length (head tabuleiro)
