# Template para relatórios de UCs do DETI

Este repositório contêm um template de relatório para UCs do DETI, este
template não é oficial mas algo que eu compilei ao longo de vários relatórios
para diferentes UCs.

## Edição

O ficheiro `main.tex` é o ficheiro principal, outros ficheiros podem ser
incluídos através dos mecanismos `\input` e `\include`.

## Compilar

O template inclui uma configuração para a ferramenta `latexmk`, para compilar
o documento basta correr o seguinte comando:

```sh
$ latexmk -pdf
```

O PDF gerado irá encontrar-se em `build/main.pdf`.

O `latexmk` também pode pré-visualizar e recompilar o documento sempre que
os ficheiros fontes forem alterados através do seguinte comando:

```sh
$ latexmk -pvc
```

## Opções

A classe `relatorio-deti` utiliza opções para controlar os pacotes ativados
de maneira a cortar o tempo de execução para pacotes que não são
necessários, as opções disponíveis são as seguintes:

- `code`, para listagens de código
- `math`, para inserir expressões matemáticas
- `diagrams`, para criar diagramas com TikZ 
- `bibliography`, para adicionar bibliografia e citações

Além destas opções existe ainda a opção `small-chapter`, esta opção é
fortemente desaconselhada, pois é extremamente instável e parte facilmente.
Esta opção modifica o comando `\chapter` de modo que este não gere um
`\clearpage` não trocando assim de página, isto pode ser útil quando existe
um limite muito estrito no número de páginas e alguns capítulos desperdiçam
muita espaço em branco.
Mais uma vez esta opção não é aconselhada e não funciona com `\include`.

## Configuração da capa

A capa do relatório apresenta o título, o ano letivo, a UC e os membros do
relatório. Estes diferentes campos são configurados no preambulo.

### Título

O título do documento é configurado pelo comando `\title` normal do latex.

```latex
\title{Título do documento}
```

### UC

O nome da UC é configurado pelo comando `\cadeira`.

```latex
\cadeira{Nome da UC}
```

### Ano letivo

O ano letivo é configurado pelo comando `\relatorioAno`.

```latex
\relatorioAno{2069/2070}
```

O valor é simplesmente texto, podendo ser omitido a segunda parte do ano.

```latex
\relatorioAno{2069}
```

### Membros

Os membros são configurados por chamadas consecutivas do comando `\membro`

```latex
\membro{Membro 1}{999998}
\membro{Membro 2}{999999}
```

