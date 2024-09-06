\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{capucho-report}[2024/09/06 v0.1 class for reports by Capucho]

% Passes and class options to the underlying report class
\DeclareOption{code}{\def\needsCode{1}}
\DeclareOption{math}{\def\needsMath{1}}
\DeclareOption{diagrams}{\def\needsDiagrams{1}}
\DeclareOption{small-chapter}{\def\smallChapter{1}}
\DeclareOption{bibliography}{\def\needsBibliography{1}}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}
\ProcessOptions

% Load report class
\LoadClass[11pt,a4paper]{report}

% Load packages for text and font handling
\RequirePackage{ifluatex}
\ifluatex
	\RequirePackage{fontspec}
	\RequirePackage{luacode}
\else
	\RequirePackage[utf8]{inputenc}
	\RequirePackage[T1]{fontenc}
\fi

% Add `showframe` to display geometry guides
\RequirePackage[headheight=20mm,headsep=5mm]{geometry}

% Add support for portuguese writing rules
\RequirePackage[portuguese]{babel}
\babelprovide[transforms = hyphen.repeat]{portuguese}

% Allows setting custom padding
\RequirePackage{setspace}
% Makes all references hyperlinked
% NOTE: Must be loaded after setspace or it breaks
\RequirePackage[
	hidelinks,
	colorlinks=true,
	urlcolor=cyan,
	linkcolor=.
]{hyperref}
% Needed for the figure H
\RequirePackage{float}
% Needed for including images
\RequirePackage{graphicx}
% Needed for \Verb and friends (fancy verbatim environments)
\RequirePackage{fancyvrb}
% Needed for custom enumerated environments
\RequirePackage{enumitem}
% Better captions
\RequirePackage[margin=10pt,font=small,labelfont=bf]{caption}
% Allow for verbatim and others in protected environments
\RequirePackage{cprotect}
% Allows control over text alignment
\RequirePackage{ragged2e}

\ifdefined\needsCode
	% Code highlighting in code blocks
	\RequirePackage[outputdir=build]{minted}
	\setminted{autogobble}
	% Prefix for code listings (default: Listing)
	\renewcommand{\listingscaption}{Código}
	% Use the chapter number in the listing counter
	\counterwithin{listing}{chapter}
	% Use TeX box for the minted environment
	\RequirePackage{xpatch}
	\xpretocmd{\minted}{\RecustomVerbatimEnvironment{Verbatim}{BVerbatim}{}}{}{}

	% Extra Inline code commands
	\newmintinline{bash}{}
\fi

\ifdefined\needsMath
	% Math environments
	\RequirePackage{amsmath}
\fi

% Number ranges
\RequirePackage[detect-all]{siunitx}
% Cells spanning mulitple rows/columns in tables
\RequirePackage{multirow}

% Context sensitive (and language aware) quotation
\RequirePackage[portuguese=portuguese]{csquotes}

\ifdefined\needsDiagrams
	% Needed for diagrams
	\RequirePackage[dvipsnames]{xcolor}
	\RequirePackage{tikz}
	\usetikzlibrary{shapes, arrows}
\fi

\ifdefined\smallChapter
	\patchcmd{\chapter}{\if@openright\cleardoublepage\else\clearpage\fi}{}{}{}
\fi

% Change the chapter title to the compact format
% 	Number. Title
% Instead of:
% 	Capítulo Number.
% 	Title
\RequirePackage[explicit,compact]{titlesec}
\titleformat{\chapter}[block]
{\bfseries\huge}{\filright\huge\thechapter.}{1ex}{\huge\filright #1}

% Remove the header from the TOC page
\AtBeginDocument{\addtocontents{toc}{\protect\thispagestyle{empty}}}

\ifdefined\needsBibliography
	% Don't sort the bibliography, use the order of the citations usage
	\RequirePackage[sorting=none, dateabbrev=false, language=portuguese]{biblatex}
\fi

\newcommand{\VerbSection}[1]{%
	\texorpdfstring{\protect\Verb|#1|}{#1}}

%%% START CUSTOM ENVIRONMENTS

% Defines an enumerated description list
\newcounter{descriptcount}
\newlist{enumdescript}{description}{1}
\setlist[enumdescript,1]{%
	before={\setcounter{descriptcount}{0}%
			\renewcommand*\thedescriptcount{\arabic{descriptcount}.}}
	,font=\bfseries\stepcounter{descriptcount}\thedescriptcount~
}

%%%  END CUSTOM ENVIRONMENTS
