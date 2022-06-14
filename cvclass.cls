%%%%%%%%%%%%%%%%%%%%%% Tipo de documento %%%%%%%%%%%%%%%%%%%%%%
\ProvidesClass{cvclass}
\LoadClass{article}
\NeedsTeXFormat{LaTeX2e}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%% Paquetes necesarios %%%%%%%%%%%%%%%%%%%%%
\RequirePackage[T1]{fontenc}
\RequirePackage{tikz}
\RequirePackage{xcolor}
\RequirePackage[absolute,overlay]{textpos}
\RequirePackage{ragged2e}
\RequirePackage{etoolbox}
\RequirePackage{ifmtarg}
\RequirePackage{ifthen}
\RequirePackage{pgffor}
\RequirePackage{marvosym}
\RequirePackage{parskip}
\RequirePackage[a4paper,left=7.6cm,top=0.1cm,right=1cm,bottom=0.2cm,nohead,nofoot]{geometry}
\RequirePackage{hyperref}
\RequirePackage{charter}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%% Selección de fuente %%%%%%%%%%%%%%%%%%%%
\renewcommand*\familydefault{bch}
\fontfamily{\familydefault}\selectfont
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%% Opciones de documento %%%%%%%%%%%%%%%%%%%%
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%% Colores %%%%%%%%%%%%%%%%%%%%%%%%%%%
\definecolor{white}{RGB}{255,255,255}
\definecolor{gray}{HTML}{4D4D4D}
\definecolor{sidecolor}{HTML}{E7E7E7}
\definecolor{mainblue}{HTML}{0E5484}
\definecolor{maingray}{HTML}{B9B9B9}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%% Configuracion de links %%%%%%%%%%%%%%%%%%%
\hypersetup
{
    colorlinks=true,
    linkcolor=mainblue,
    filecolor=mainblue,
    urlcolor=mainblue,
}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%% Configuración %%%%%%%%%%%%%%%%%%%%%%%%
\renewcommand{\bfseries}{\color{gray}}

\pagestyle{empty}

\setlength{\parindent}{0pt}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%% Generacion de documento %%%%%%%%%%%%%%%%%%%
\setlength{\TPHorizModule}{1cm}
\setlength{\TPVertModule}{1cm}

\newlength\imagewidth
\newlength\imagescale
\pgfmathsetlength{\imagewidth}{5cm}
\pgfmathsetlength{\imagescale}{\imagewidth/600}

\newlength{\TotalSectionLength}
\newlength{\SectionTitleLength}

\newcommand{\profilesection}[1]
{
	\setlength\TotalSectionLength{\linewidth}
	\settowidth{\SectionTitleLength}{\huge #1 }
	\addtolength\TotalSectionLength{-\SectionTitleLength}
	\addtolength\TotalSectionLength{-2.22221pt}
	\vspace{8pt}
	{\color{black!80} \huge #1 \rule[0.15\baselineskip]{\TotalSectionLength}{1pt}}
}

% Datos personales
\newcommand{\cvdate}[1]{\renewcommand{\cvdate}{#1}}
\newcommand{\cvmail}[1]{\renewcommand{\cvmail}{#1}}
\newcommand{\cvnumberphone}[1]{\renewcommand{\cvnumberphone}{#1}}
\newcommand{\cvaddress}[1]{\renewcommand{\cvaddress}{#1}}
\newcommand{\cvsite}[1]{\renewcommand{\cvsite}{#1}}
\newcommand{\aboutme}[1]{\renewcommand{\aboutme}{#1}}
\newcommand{\cvprofilepic}[1]{\renewcommand{\cvprofilepic}{#1}}
\newcommand{\cvname}[1]{\renewcommand{\cvname}{#1}}
\newcommand{\cvjobtitle}[1]{\renewcommand{\cvjobtitle}{#1}}

% Informacion de contacto
\newcommand*\icon[1]{\tikz[baseline=(char.base)]{\node[shape=circle,draw,inner sep=1pt,fill=mainblue,mainblue,text=white](char){#1};}}

% Barras de habilidades
\newcommand\skills[1]
{ 
	\renewcommand{\skills}
	{
		\begin{tikzpicture}
			\foreach [count=\i] \x/\y in {#1}
			{
				\draw[fill=maingray,maingray] (0,\i) rectangle (10*0.6,\i+0.4);
				\draw[fill=white,mainblue](0,\i) rectangle (\y*0.6,\i+0.4);
				\node[above right] at (0,\i+0.4) {\x};
			}
		\end{tikzpicture}
	}
}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%% Barra lateral %%%%%%%%%%%%%%%%%%%%%%%%
\newcommand{\makeprofile}
{
	\begin{tikzpicture}[remember picture,overlay]
   		\node[rectangle,fill=sidecolor,anchor=north,minimum width=9cm,minimum height=\paperheight+1cm](box) at (-5cm,0.5cm){};
	\end{tikzpicture}

	\begin{textblock}{6}(0.5, 0.2)
		\ifthenelse{\equal{\cvprofilepic}{}}{}
		{
			\begin{center}
				\begin{tikzpicture}[x=\imagescale,y=-\imagescale]
					\clip (600/2, 567/2) circle (567/2);
					\node[anchor=north west,inner sep=0pt,outer sep=0pt] at (0,0)
					{
						\includegraphics[width=\imagewidth]{\cvprofilepic}
					};
				\end{tikzpicture}
			\end{center}
		}

		{\Huge\color{mainblue}\cvname}

		{\Large\color{black!80}\cvjobtitle}

		\renewcommand{\arraystretch}{1.6}

		\begin{tabular}{p{0.5cm} @{\hskip 0.5cm}p{5cm}}
			\ifthenelse{\equal{\cvdate}{}}{}{\textsc{\Large\icon{\Info}} & \cvdate\\}
			\ifthenelse{\equal{\cvaddress}{}}{}{\textsc{\Large\icon{\Letter}} & \cvaddress\\}
			\ifthenelse{\equal{\cvnumberphone}{}}{}{\textsc{\Large\icon{\Telefon}} & \cvnumberphone\\}
			\ifthenelse{\equal{\cvsite}{}}{}{\textsc{\Large\icon{\Mundus}} & \href{\cvsite}{\cvsite}\\}
			\ifthenelse{\equal{\cvmail}{}}{}{\textsc{\large\icon{@}} & \href{mailto:\cvmail}{\cvmail}}
		\end{tabular}

		\ifthenelse{\equal{\aboutme}{}}{}
		{
			\profilesection{Sobre mí}
			\begin{flushleft}
				\aboutme
			\end{flushleft}
		}

		\profilesection{Habilidades}

		\skills
		\scriptsize
	\end{textblock}
}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%% Caja de titulo %%%%%%%%%%%%%%%%%%%%%%%
\newcommand*\round[2]
{
	\tikz[baseline=(char.base)]\node[anchor=north west,draw,rectangle,rounded corners=0.1cm,inner sep=1.6pt,minimum size=6.8mm,text height=3.8mm,fill=#2,#2,text=white](char){#1};%
}

\renewcommand{\section}[1]
{
	{
		\color{gray}
		\Large\round{#1}{mainblue}
	}
}

\renewcommand{\subsection}[1]{
	\par\vspace{.5\parskip}{
		\large\color{gray} #1
	}
	\par\vspace{.25\parskip}
}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%% Listas largas %%%%%%%%%%%%%%%%%%%%%%%
\setlength{\tabcolsep}{0pt}

\newenvironment{twenty}{
	\begin{tabular*}{\textwidth}{@{\extracolsep{\fill}}ll}
}{
	\end{tabular*}
}

\newcommand{\twentyitem}[4]{
	#1&\parbox[t]{0.83\textwidth}{
		\textbf{#2}
		\hfill
		{\footnotesize#3}\\
		#4\vspace{\parsep}
	}\\
}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%% Listas cortas %%%%%%%%%%%%%%%%%%%%%%%
\setlength{\tabcolsep}{0pt}

\newenvironment{twentyshort}{
	\begin{tabular*}{\textwidth}{@{\extracolsep{\fill}}ll}
}{
	\end{tabular*}
}

\newcommand{\twentyitemshort}[2]{
	#1&\parbox[t]{0.83\textwidth}{
		\textbf{#2}
	}\\
}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
