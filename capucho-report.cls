\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{capucho-report}[2024/09/06 v0.1 class for reports by Capucho]

\newif\if@capuchoreport@code
\newif\if@capuchoreport@math
\newif\if@capuchoreport@diagrams
\newif\if@capuchoreport@bibliography

% Default to use portuguese as a language
\def\@capuchoreport@language{portuguese}

\DeclareKeys
{
	code.if = @capuchoreport@code,
	math.if = @capuchoreport@math,
	diagrams.if = @capuchoreport@diagrams,
	bibliography.if = @capuchoreport@bibliography,
	language.store = \@capuchoreport@language,
	language.usage = general
}
% Pass any unknow class options to the capucho-report class
\DeclareUnknownKeyHandler{\PassOptionsToClass{\CurrentOption}{report}}
\ProcessKeyOptions

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

\RequirePackage[headheight=20mm,headsep=5mm]{geometry}

\RequirePackage[\@capuchoreport@language]{babel}
% Add support for portuguese writing rules
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

\if@capuchoreport@code
	% Code highlighting in code blocks
	\RequirePackage{minted}
	% Newer versions don't need (or accept) the output dir option, so only add it
	% if the versions is older than V3.
	\IfPackageAtLeastTF{parskip}{2024-09-22}{}{\PassOptionsToPackage{outputdir=build}{minted}}
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

\if@capuchoreport@math
	% Math environments
	\RequirePackage{amsmath}
\fi

% Number ranges
\RequirePackage[detect-all]{siunitx}
% Cells spanning mulitple rows/columns in tables
\RequirePackage{multirow}

% Context sensitive (and language aware) quotation
\RequirePackage[portuguese=portuguese]{csquotes}

\if@capuchoreport@diagrams
	% Needed for diagrams
	\RequirePackage[dvipsnames]{xcolor}
	\RequirePackage{tikz}
	\usetikzlibrary{shapes, arrows}
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

\if@capuchoreport@bibliography
	% Don't sort the bibliography, use the order of the citations usage
	\RequirePackage[sorting=none, dateabbrev=false, language=\@capuchoreport@language]{biblatex}
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
