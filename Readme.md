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

## Cheatsheet

Em baixo encontram-se exemplos de como adicionar vários tipos de conteúdo
comuns.

### Código

Listagem de código requerem a opção `code` na classe.

Código é adicionado através do ambiente `minted` este requer que o programa
`pygmentize` esteja instalado e fornece código com highlighting.

```latex
\begin{minted}{c}
    int main(void) {
        return 0;
    }
\end{minted}
```

O `minted` é configurado de modo que o espaço branco comum à esquerda do
código é removido (opção `autogobble`), por isso o código pode ser indentado
no latex sem causar problemas no resultado.

Caso se pretenda adicionar texto como código, mas que não têm uma linguagem
(por exemplo, a listagem de um diretório) pode se utilizar a linguagem especial
`text`.

```latex
\begin{minted}{text}
    test/a
    d
    test/a
    test/b
\end{minted}
```

Adicionalmente pode ser necessário adicionar um título e `\label` a listagem
de código, isto pode ser implementado utilizando o ambiente `listing`
do seguinte modo:

```latex
\begin{listing}[H]
    \centering
    \begin{minted}{bash}
        find "$@" -type d -print0
    \end{minted}
    \caption{Segunda iteração do comando para obter os subdiretórios}
    \label{code:implementation_second_subdir_find}
\end{listing}
```

### Bibliografia

Bibliografia requer a opção `bibliography` na classe.

Primeiro é preciso declarar os ficheiros de bibliografia no preambulo, isto
é feito com o comando `\addbibresource`.

```latex
\addbibresource{bibliography.bib}
```

Os ficheiros seguem o formato BibTex.

```bibtex
@article{posix,
  author = {},
  journal = {IEEE Std 1003.1-2017 (Revision of IEEE Std 1003.1-2008)},
  title = {{IEEE Standard for Information Technology--Portable Operating System
           Interface (POSIX(TM)) Base Specifications, Issue 7}},
  year = {2018},
  doi = {10.1109/IEEESTD.2018.8277153},
}
```

A seguir podem se adicionar citações ao documento com o comando `\cite`.

```latex
\cite{posix}
```

Finalmente no final do documento adiciona-se a bibliografia completa.

```latex
\printbibliography[heading=bibintoc]
```

## Licença

Este trabalho encontra-se ao abrigo da licença MIT.

Imagens do DETI incluídas no repositório são propriedade da Universidade de
Aveiro.
