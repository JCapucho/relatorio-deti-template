\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{relatorio-deti}[2024/09/06 v0.2 class for relatorio deti]

% Passes and class options to the capucho-report class
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{capucho-report}}
\ProcessOptions

% Load capucho-report class
\LoadClass[11pt,a4paper]{capucho-report}

% Define variables and commands to use in the title page
\newcommand*{\cadeira}[1]{\gdef\@cadeira{#1}}
\newcommand*{\relatorioAno}[1]{\gdef\@relatorioAno{#1}}

% Required for lists
\RequirePackage{etoolbox}

\def\@membros{}
\newcommand*{\membro}[2]{
	\listadd{\@membros}{#1|#2}
}

\newcommand*{\@cadeira}{\texttt{\string\cadeira} currently not set. Please fix this.}
\newcommand*{\@relatorioAno}{\texttt{\string\relatorioAno} currently not set. Please fix this.}

%%% START CUSTOM HEADER

\RequirePackage{fancyhdr}

\pagestyle{fancy}
\fancyhead[L]{\includegraphics[width=0.25\textwidth]{figs/deti.png}}
\fancyhead[C]{%
	\centering%
	\parbox[b]{0.40\textwidth}{\centering\leftmark}%
}
\fancyhead[R]{\parbox[b]{0.25\textwidth}{\RaggedRight{\makeatletter\@cadeira\makeatother}}}
\fancypagestyle{plain}{}

%%%  END CUSTOM HEADER

%%% START CUSTOM COVER

\def\showmember#1{\showmembersplit#1\relax}
\def\showmembersplit#1|#2\relax{#1 & - & #2 \\}
\renewcommand*{\maketitle}{%
	\begin{titlepage}

		\begin{figure}[H]
			\centering
			\includegraphics[width=12cm]{figs/deti.png}
		\end{figure}

		\vspace{4cm}

		\begin{center}
			\onehalfspacing\textbf{\huge \@title}\\
			\vspace{1cm}
			{\LARGE \@cadeira}

			\vspace{2cm}

			\large
			\begin{tabular}{ r c c }
				\forlistloop{\showmember}{\@membros}
			\end{tabular}
			\vfill
			{\Large \@relatorioAno}
		\end{center}

	\end{titlepage}
}

%%%  END CUSTOM COVER
