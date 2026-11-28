# lp-analise-da-vida

Projeto desenvolvido para a disciplina Aspectos de Linguagens de Programação (BCC6002) da Universidade Tecnológica Federal do Paraná (UTFPR), pelos alunos:

- André Felipe Wonsik Alves
- Eber Felipe Barrotti Louback
- Erick Molina Gehring
- Gustavo Martins França

O projeto contém duas aplicações em Haskell: um analisador de textos (`text/`) e o Jogo da Vida de Conway (`conways/`). Escolhemos Haskell para ter a experiência prática de aprender e utilizar uma linguagem funcional. Além disso, entre as opções apresentadas em aula, ela nos pareceu a mais acessível para iniciantes, tanto para absorver os conceitos quanto para aplicar na prática.

## Requisitos

- GHC 9.10.3 e `cabal-install` (o projeto requer `base-4.20.2.0`).
- GNU Make.
- Em distribuições Debian/Ubuntu, instale também a biblioteca de desenvolvimento GMP:

```bash
sudo apt update
sudo apt install build-essential libgmp-dev
```

Instale o GHC e o Cabal pela forma recomendada para seu sistema. Confira as versões com `ghc --version` e `cabal --version`.

## Compilar e executar

Na raiz do repositório:

```bash
make build      # compila as duas aplicações
make text       # compila e executa o analisador
make conways    # compila e executa o Jogo da Vida
```

O Cabal pode baixar as dependências Haskell necessárias durante a primeira compilação.

## Analisador de textos

Execute `make text`. O programa pergunta se a entrada será digitada (`1`) ou lida de um arquivo (`2`). No modo arquivo, informe o caminho do arquivo; caminhos relativos são interpretados a partir do diretório `text/`, de onde o executável é iniciado. No modo de digitação, informe o texto em uma linha.

Em seguida, responda se deseja remover palavras comuns (`s` para sim; qualquer outra resposta mantém todas as palavras) e escolha a ordenação das tabelas (`1` alfabética ou `2` por frequência). O programa executa as análises em sequência:

- **Contagem:** total de palavras consideradas.
- **Frequência:** quantidade de ocorrências de cada palavra.
- **Palavras mais frequentes:** solicita quantas palavras distintas devem ser exibidas.
- **Frequência relativa:** percentual de cada palavra em relação ao total considerado.

Maiúsculas são convertidas para minúsculas e pontuação é tratada como separador. A remoção de stopwords é aplicada antes das contagens, então também afeta o total usado na frequência relativa. Na ordenação por frequência, empates são apresentados em ordem alfabética.

A figura mostra um exemplo de execução do analisador:

<img src="figures/text-exemplo.png" alt="Exemplo de execução do analisador de textos" width="520">

## Jogo da Vida de Conway

Execute `make conways`. O programa lista os arquivos de configuração inicial disponíveis em `conways/data/`; informe o nome de um deles. Cada arquivo descreve o tabuleiro inicial, usando `O` para célula viva e `.` para célula morta.

Escolha o modo de execução:

- **Manual (`1`):** pressione ENTER para avançar uma geração ou `q`/`Q` para encerrar.
- **Contínuo (`2`):** informe o intervalo entre gerações em segundos e o máximo de gerações. Informe `0` como máximo para executar continuamente.

O jogo aplica as regras clássicas de sobrevivência, morte por isolamento, morte por superpopulação e reprodução. A cada passo, o tabuleiro da geração seguinte é calculado a partir do tabuleiro anterior.

Os padrões de exemplo estão em `conways/data/`: `mini_glider.txt`, `pulsar.txt`, `glider.txt`, `r_pentomino.txt` e `oscilators.txt`.

<img src="figures/r_pentomino_38.png" alt="Jogo da Vida após 38 gerações do padrão R-pentomino" width="400">

## Conceitos de programação funcional

Os conceitos abaixo são usados efetivamente no código. Os caminhos são relativos à raiz do repositório.

| Conceito | Onde aparece | Contribuição |
| :--- | :--- | :--- |
| List comprehensions | `conways/src/Rules.hs`: `proximaGeracao`, `contarVizinhos` | Percorrem posições e vizinhos do tabuleiro para construir a próxima geração e contar células vivas. |
| Recursão | `conways/app/Main.hs`: `loopManual`, `loopContinuo`; `conways/src/CustomIo.hs`: `lerArquivo`, `lerModo`, `lerInteiro`, `lerComando`, `exibirLista`; `conways/src/Environment.hs`: `distribuir` | Repetem a evolução do jogo, validam/repetem entradas e dividem a lista de células em linhas. |
| Funções de ordem superior | `conways/src/CustomIo.hs`: `lerInteiro` (`all isDigit`); `text/src/Analyser.hs`: `_ordenarPorFrequencia` (`sortBy`) | Recebem funções como argumento para validar caracteres e ordenar as frequências. |
| `map` | `conways/src/Environment.hs`: `popularMatriz`; `text/src/Analyser.hs`: `_normalizarTexto` | Aplicam uma transformação a cada item de uma lista. |
| `filter` | `text/src/Analyser.hs`: `_removerStopwords` | Mantém as palavras que não pertencem ao conjunto de stopwords. |
| `foldl'` (fold) | `text/src/Analyser.hs`: `_enumerarPalavras` | Percorre as palavras e acumula as contagens em um mapa. |
| Lambdas | `text/src/Analyser.hs`: `_normalizarTexto`, `_removerStopwords`, `_ordenarPorFrequencia` | Definem funções locais usadas nas transformações, filtragem e ordenação. |
| Composição de funções | `text/src/Analyser.hs`: `_ordenarPorFrequencia` | Compõe a conversão do mapa para uma lista com a ordenação por frequência. |
| Estruturas imutáveis e funções puras | `conways/src/Rules.hs`: `proximaGeracao`; `text/src/Analyser.hs`: `_normalizarTexto`, `_enumerarPalavras` | Produzem resultados novos a partir das entradas, sem alterar o tabuleiro ou texto original. |
| Estruturas de dados funcionais | `text/src/Analyser.hs`: `Map` e `Set` | Guardam as frequências e permitem consultar o conjunto de stopwords sem mutação compartilhada. |

