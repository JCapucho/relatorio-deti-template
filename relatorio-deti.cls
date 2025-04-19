\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{relatorio-deti}[2025/04/19 v0.3 class for relatorio deti]

\newif\if@relatoriodeti@draft
\@relatoriodeti@drafttrue
\newif\if@relatoriodeti@header
% By default there is a header
\@relatoriodeti@headertrue

\DeclareKeys
{
	final.ifnot = @relatoriodeti@draft,
	noheader.ifnot = @relatoriodeti@header
}
% Pass any unknow class options to the capucho-report class
\DeclareUnknownKeyHandler{\PassOptionsToClass{\CurrentOption}{capucho-report}}
\ProcessKeyOptions

% Load capucho-report class
\LoadClass{capucho-report}

\if@relatoriodeti@draft
	\RequirePackage[firstpageonly]{draftwatermark}
\fi


% Define variables and commands to use in the title page
\newcommand*{\cadeira}[1]{\gdef\@cadeira{#1}}
\newcommand*{\relatorioData}[1]{\gdef\@relatorioData{#1}}

% Required for lists
\RequirePackage{etoolbox}

\def\@membros{}
\newcommand*{\membro}[2]{
	\listadd{\@membros}{#1|#2}
}

\newcommand*{\@cadeira}{\texttt{\string\cadeira} currently not set. Please fix this.}
\newcommand*{\@relatorioData}{\texttt{\string\relatorioData} currently not set. Please fix this.}

%%% START CUSTOM HEADER

\if@relatoriodeti@header
	\RequirePackage{fancyhdr}

	\pagestyle{fancy}
	\fancyheadwidth[L]{0.25\textwidth}
	\fancyhead[L]{\includegraphics[width=0.25\textwidth]{figs/deti.png}}

	\fancyheadwidth[C]{0.40\textwidth}
	\fancyhead[C]{\centering\leftmark}

	\fancyheadwidth[R]{0.25\headwidth}
	\fancyhead[R]{\RaggedLeft{\makeatletter\@cadeira\makeatother}}
	\fancypagestyle{plain}{}
\fi

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
			{\Large \@relatorioData}
		\end{center}

	\end{titlepage}
}

%%%  END CUSTOM COVER
