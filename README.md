# lp-analise-da-vida

Projeto desenvolvido para a disciplina Aspectos de Linguagens de Programação (BCC6002) da Universidade Tecnológica Federal do Paraná (UTFPR), pelos alunos:

- André Felipe Wonsik Alves
- Eber Felipe Barrotti Louback
- Erick Molina Gehring
- Gustavo Martins França

O projeto contém duas aplicações: Analisador de Textos e Frequência de Palavras (`pasta_texto/`); e o Jogo da Vida de Conway (`conways/`). Ambas foram implementadas em Haskell.


## Exemplo de uso

### Conway's Game of Life

Em um terminal, execute:

```bash
make conways
```

Digite o nome do arquivo de inicío dentre os listados. Os arquivos utilizados para teste representam alguns padrões  conhecidos do jogo:

- mini_glider.txt
- pulsar.txt
- glider.txt
- r_pentomino.txt
- oscilators.txt

Os arquivos de texto estão no diretório `conways/data/`.

Após selecionar um arquivo, escolha um dos seguintes modos de execução:

- Manual
- Contínuo

No modo manual, uma nova geração é compudata e exibida ao pressionar ENTER, e é possível parar a execução com o caractere `q` ou `Q`.

No modo automático, uma nova geração é computada e exibida após um intervalo de tempo. Ao selecionar esse modo, é possível definir esse intervalo de tempo (em segundos) e a quantidade de iterações do jogo.

Na Figura abaixo, está ilustrado o estado do jogo após 38 iterações a partir do arquivo `data/r_pentomino.txt`, modo manual.

<img src="figures/r_pentomino_38.png" alt="r_pentomino_38" width="400">

## Construções e Conceitos de Programação Funcional

Os conceitos de programação funcional utilizados neste trabalho e as funções que os aplicam estão ilustradas na Tabela abaixo. Há comentŕios no código fonte das funções citadas detalhando o uso do conceito respectivo.

| Conceito | Arquivo | Funções |
| :--- | :--- | :--- |
| List Comprehensions | `conways/Rules.hs` | `proximaGeracao`, `contarVizinhos` |
| Recursão | `conways/Main.hs` | `loopContinuo`, `loopManual` |
| Recursão | `conways/CustomIo.hs` | `lerArquivo`, `lerInteiro`, `lerModo`, `lerComando` |
| Recursão | `conways/Environment.hs` | `distribuir` |
| Funções de Ordem Superior | `conways/CustomIo.hs` | `lerInteiro` |
| Map | `conways/Environment.hs` | `popularMatriz` |
