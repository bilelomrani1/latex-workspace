%% ********************************************************************
% workspace.cls
% Copyright (C) 2020 Bilel Omrani
%% ********************************************************************

\NeedsTeXFormat{LaTeX2e}[1997/06/01]

\def\fileversion{1.0}
\def\filedate{2020/06/24}

\ProvidesClass{workspace}[\filedate v\fileversion: LaTeX Workspace - Copyright (C) Bilel Omrani]
\message{`workspace' v\fileversion, \filedate\space LaTeX Workspace - Copyright (C) Bilel Omrani}

% ********************************************************************

\pdfminorversion=7

% Patch primitives
\RequirePackage{etex}
\RequirePackage{etoolbox}
\RequirePackage{xparse}
\RequirePackage{xpatch}
\RequirePackage{morewrites}
\AtEndPreamble{
  \RequirePackage{scrhack}
}


% ********************************************************************
%%% Encoding
% ********************************************************************

\RequirePackage{cmap}
\RequirePackage{lmodern}
\RequirePackage[T1]{fontenc}
\RequirePackage[utf8]{inputenc}\DeclareUnicodeCharacter{2212}{-}


% ********************************************************************
% Class options
% ********************************************************************

\RequirePackage{ifthen}
\RequirePackage{kvoptions}
\RequirePackage{ifdraft}
\RequirePackage{iflang}

\SetupKeyvalOptions{family=workspace,prefix=workspace@}

%%%% Base class
\DeclareStringOption[scrbook]{baseclass}

%%%% Layout
\DeclareStringOption[semi]{twoside}
\DeclareBoolOption[false]{twocolumn}
\DeclareStringOption[openleft]{headings}

%%%% Font
\DeclareBoolOption[false]{minionpro}
\DeclareStringOption[10pt]{fontsize}

%%%% Features
\DeclareBoolOption[false]{revision}
\DeclareBoolOption[false]{print}

% Style
\DeclareBoolOption[false]{nomenclintoc}
\DeclareBoolOption[false]{glossaryintoc}
\DeclareBoolOption[false]{indexintoc}

%%%% Process options
\ProcessKeyvalOptions*
% Sanity check if MinionPro exists
\IfFileExists{MinionPro.sty}{}{\setboolean{workspace@minionpro}{false}}
\ifdraft{\setboolean{workspace@minionpro}{false}}{}
% Pass options to baseclass
\ifthenelse{\boolean{workspace@twocolumn}}{
    \PassOptionsToClass{twocolumn}{\workspace@baseclass}}{}
\ifthenelse{\boolean{workspace@revision}}{
    \PassOptionsToClass{overfullrule}{\workspace@baseclass}}{}

\newboolean{isprint}
\ifthenelse{\boolean{workspace@print}}{
  \setboolean{isprint}{true}
}{
  \setboolean{isprint}{false}
}

%%%% Load Class
\LoadClass[
    fontsize=\workspace@fontsize,
    parskip=relative,
    footnotes=multiple,
    numbers=noendperiod,
    headings=optiontoheadandtoc
]{\workspace@baseclass}
% Check if chapters are defined
\newbool{workspace@nochapters}
\@ifclassloaded{scrartcl}{\booltrue{workspace@nochapters}}
{\boolfalse{workspace@nochapters}}


% ********************************************************************
% Bibliography
% ********************************************************************

\RequirePackage[hyphens]{url}
\RequirePackage{biblatex}


% ********************************************************************
% Patch commands
% ********************************************************************

\RequirePackage[section]{placeins}      % adds \FloatBarrier at the start of sections
\RequirePackage{relsize,exscale}        % Custom symbols scale
\RequirePackage{letltxmacro}            % Allows to redifine robust commands
\RequirePackage{environ}                % New interface for environments
\RequirePackage{footnote}               % Better footnotes handling


% ********************************************************************
% Languages
% ********************************************************************

\RequirePackage{babel}                  % Languages
\RequirePackage{foreign}


% ********************************************************************
% Maths packages
% ********************************************************************

\newcommand\hmmax{0}
\newcommand\bmmax{0}
\RequirePackage{bm}
\RequirePackage{amsmath}
\RequirePackage{accents}
\RequirePackage[tbtags]{mathtools}
\RequirePackage{amsthm}
\RequirePackage{stackengine,scalerel}
\RequirePackage{siunitx}
\let\leftbar\undefined
\let\endleftbar\undefined
\RequirePackage{thmtools,thm-restate}


% ********************************************************************
% Font management
% ********************************************************************
       
\RequirePackage[scaled=0.85]{DejaVuSansMono} % Code font
\RequirePackage{carlito}                     % Sans serif font carlito
\PassOptionsToPackage{babel,kerning=true,spacing=false}{microtype}

\ifthenelse{\boolean{workspace@minionpro}}{
    % Import Minion Font and custom font package
    \RequirePackage[fullfamily,loosequotes,lf,footnotefigures]{MinionPro}
    \RequirePackage{MnSymbol}
    \RequirePackage[liby]{misc/BookFont}
}{  
    % Import alternatives
    \RequirePackage{microtype}
    \RequirePackage{amsfonts}
    \RequirePackage{amssymb}
    \RequirePackage[Symbol]{upgreek}
    \RequirePackage{stmaryrd}
    \newcommand{\lsem}{\llbracket}
    \newcommand{\rsem}{\rrbracket}
}
\RequirePackage{dsfont}
\RequirePackage{tabfigures}
\RequirePackage{esint}


% ********************************************************************
% Various layout packages
% ********************************************************************

\RequirePackage[draft=false]{scrlayer-scrpage} % Koma-Script page layout
\RequirePackage{lettrine}                      % Lettrine
\RequirePackage[inline]{enumitem}                      % Better enumerate environments
\RequirePackage{titling}                       % Cover pages environments
\RequirePackage{multicol}                      % Mutiple columns articles
\RequirePackage[multiple]{footmisc}            % Better footnotes
\RequirePackage{epigraph}                      % Epigraphs
\RequirePackage{ragged2e}


% ********************************************************************
% Tables and figures related packages
% ********************************************************************

\RequirePackage{multirow}
\RequirePackage{booktabs}
\RequirePackage{makecell}
\RequirePackage{tabularx}
\RequirePackage{xltabular}
\RequirePackage[roman]{parnotes}
\RequirePackage{array}
\RequirePackage{pbox}
\RequirePackage{caption}
\RequirePackage{subcaption}
\RequirePackage{graphicx}
\RequirePackage{adjustbox}
\RequirePackage{float,floatpag}
\PassOptionsToPackage{dvipsnames}{xcolor}
\RequirePackage{tikz,pgf,pgfplots}
\pgfplotsset{compat=newest}
\RequirePackage{xcolor-material}
\RequirePackage[arrow=yellow,text=black]{callouts}
\RequirePackage{pdfpages}
\RequirePackage{wrapfig}
\RequirePackage{xcolor}
\RequirePackage[most,minted]{tcolorbox}

% Allows footnotes in tables
\makesavenoteenv{tabular}
\makesavenoteenv{table}
\makesavenoteenv{tabularx}
\makesavenoteenv{longtable}


% ********************************************************************
% Watermarks and notes
% ********************************************************************

\ifdraft{\RequirePackage[scale=6]{draftwatermark}}{}
\ifthenelse{\boolean{workspace@revision}}{\RequirePackage[scale=6]{draftwatermark}}{}
\RequirePackage[
    obeyFinal,
    textsize=small,
    linecolor=black!30!cyan,
    bordercolor=black!30!cyan,
    backgroundcolor=black!30!cyan,
    textcolor=white]{todonotes}


% ********************************************************************
% Nomenclature and Index
% ********************************************************************

\ifbool{workspace@nomenclintoc}{
    \PassOptionsToPackage{intoc}{nomencl}}{\relax}
\RequirePackage{nomencl}
\input{nomencl_header.tex}

% Nomenclature headers
\NewDocumentCommand{\nomenclheader}{m}{
  \vspace{\nomgroupstartsep}%
  \item[\hspace*{\parindent}\nomenclheaderstyle{#1}]{\ }\vspace{\nomgrouptitlesep}}

% Nomenclature intertext
\newlist{workspace@nomencl@intertext}{description}{1}
\NewDocumentCommand{\nomenclintertext}{m}{
  \vspace{\dimexpr-\baselineskip+\medskipamount}
  \begin{workspace@nomencl@intertext}[
    leftmargin=-\dimexpr\nomindent+\nom@tempdim-\labelsep,
    labelwidth=0pt,
    itemindent=0pt,
    topsep=0pt,
    partopsep=0pt]
    \let\makelabel\nomlabel\item#1%
  \end{workspace@nomencl@intertext}\medskip}

% Main nomenclature environment
\def\thenomenclature{%
\@ifundefined{chapter}%
  {\section*{\nomname}\if@intoc\addcontentsline{toc}{section}{\nomname}\fi}%
  {\chapter*{\nomname}\if@intoc\addcontentsline{toc}{chapter}{\nomname}\fi}%
  \nompreamble
  \begin{description}[leftmargin=\dimexpr\nomindent+\nom@tempdim+\labelsep,
                      labelwidth=\nom@tempdim,
                      itemindent=0pt,
                      itemsep=\nomitemsep]
  \let\makelabel\nomlabel
}
    
\def\endthenomenclature{\end{description}\nompostamble}

\RequirePackage{imakeidx}
\ifbool{workspace@indexintoc}{\idxlayout{totoc}}


% ********************************************************************
% Glossary
% ********************************************************************

\ifbool{workspace@glossaryintoc}{
  \PassOptionsToPackage{toc}{glossaries}
}
\PassOptionsToPackage{nopostdot,nonumberlist}{glossaries}
\RequirePackage[xindy,acronym]{glossaries}


% ********************************************************************
% Calls for nomenclature, index end glossary
% ********************************************************************

\makenomenclature
\makeindex
\makeglossaries
\loadglsentries{glossary}


% ********************************************************************
% Algorithms related packages
% ********************************************************************

\RequirePackage{algpseudocode}
\RequirePackage{algorithm}
\RequirePackage{algorithmicx}
\RequirePackage{bookmark}


% ********************************************************************
% Style initialisation
% ********************************************************************

% Caption separator
\newcommand{\floatseparator}{:~}

% Margin style
\def\marginlinestyle{}

% Nomenclature style
\newcommand{\nomenclheaderstyle}[1]{#1}
\newlength{\nomgroupstartsep}
\newlength{\nomgrouptitlesep}
\newlength{\nomindent}

% Local toc
\newcommand{\localtocpartdepth}{section}
\newcommand{\localtocchapterdepth}{subsection}
\newcommand{\localtocheaderstyle}[1]{#1}

% Heads style in tables
\newcommand{\theadstyle}{\bfseries}

% Switch old style figures
\ifthenelse{\boolean{workspace@minionpro}}{
    \newcommand{\switchOsf}{\fontfamily{MinionPro-OsF}\selectfont}
}{
    \newcommand{\switchOsf}{\relax}
}

% Supplementary command for part/chapter prefix
\newcommand{\partnumberstyle}[1]{#1}
\newcommand{\chapternumberstyle}[1]{#1}

\newcommand{\localtocstyle}[1]{#1}
\newcommand{\markstyle}[1]{#1}
\newcommand{\pagemarkstyle}[1]{#1}

% Bib entries
\newcommand{\biblabelstyle}[1]{#1}
\newcommand{\bibfontstyle}{\relax}

% Cite setup
\newcommand{\citestyle}{\relax}

% Equations numbers style
\newcommand{\equationnumberstyle}{\relax}

% Initializer for various lengths and commands
\newcommand{\workspace@InitializeSec}[2]{%
    \expandafter\newcommand\csname#1title\endcsname\relax
    \expandafter\newcommand\csname#1pagetitle\endcsname\relax
    \expandafter\newcommand\csname#1prefix\endcsname{}
    \expandafter\newcommand\csname#1prefixsep\endcsname{}
    \expandafter\newcommand\csname#1style\endcsname[1]{##1}
    \expandafter\newcommand\csname#1entryformat\endcsname[1]{##1}
    \expandafter\newcommand\csname#1entrypageformat\endcsname{}
    \expandafter\newlength\csname indenttoc#1\endcsname
    \expandafter\newlength\csname numseptoc#1\endcsname
    \expandafter\newlength\csname beforeskiptoc#1\endcsname
    \setlength{\csname beforeskiptoc#1\endcsname}{0em}
    \DeclareTOCStyleEntry[
      level=#2,
      indent=\csname indenttoc#1\endcsname,
      numwidth=1.5em,
      dynnumwidth=true,
      numsep=\csname numseptoc#1\endcsname,
      pagenumberformat=\csname#1entrypageformat\endcsname,
      beforeskip=\csname beforeskiptoc#1\endcsname]
    {tocline}{#1}
    \newtoggle{numbered#1}
}

% Initializer for list of
\newcommand{\workspace@InitializeListOf}[2]{%
    \expandafter\newlength\csname indenttable#1\endcsname
    \expandafter\newlength\csname numseptable#1\endcsname
    \expandafter\newcommand\csname#1entrynumberformat\endcsname{}
    \expandafter\newcommand\csname#1pagenumberformat\endcsname{}
    \DeclareTOCStyleEntry[
        level=#2,
        indent=\csname indenttable#1\endcsname,
        numwidth=1.5em,
        dynnumwidth=true,
        numsep=\csname numseptable#1\endcsname,
        entrynumberformat=\csname#1entrynumberformat\endcsname,
        pagenumberformat=\csname#1pagenumberformat\endcsname]
    {tocline}{#1}
}


% ********************************************************************
% Initialize Patch
% ********************************************************************

\newcommand{\workspace@PatchSectionsListOf}[1]{%
    % Part
    \xpretocmd{\@addpart}{\global\toggletrue{#1@part}}{}{}
    \xpretocmd{\@part}{\global\toggletrue{#1@part}}{}{}
    \xpretocmd{\@spart}{\global\toggletrue{#1@part}}{}{}

    \ifbool{workspace@nochapters}{}{
      % Chapter
      \xpretocmd{\@addchap}{\global\toggletrue{#1@chapter}}{}{}
      \xpretocmd{\@chapter}{\global\toggletrue{#1@chapter}}{}{}
      \xpretocmd{\@schapter}{\global\toggletrue{#1@chapter}}{}{}
      }

    % Sections
    \xpretocmd{\@addsec}{\global\toggletrue{#1@section}}{}{}
    \xpretocmd{\@sect}{\global\toggletrue{#1@section}}{}{}
    \xpretocmd{\@ssect}{\global\toggletrue{#1@\toggletoc}}{}{}
}

\newcommand{\workspace@InitializeEnvForListOf}[3]{%
    % #1 : code (eg. figure)
    % #2 : table code (eg. lof)
    % #3 : level to patch (eg. chapter)

    \AtBeginEnvironment{#1}{%
        \workspace@AddSectionInListOf{#2}{#3}%
    }%
}

\workspace@InitializeSec{part}{-1}
\ifbool{workspace@nochapters}{}{
  \workspace@InitializeSec{chapter}{0}
}
\workspace@InitializeSec{section}{1}
\workspace@InitializeSec{subsection}{2}
\workspace@InitializeSec{subsubsection}{3}
\workspace@InitializeSec{paragraph}{4}
\workspace@InitializeSec{subparagraph}{5}

\workspace@InitializeListOf{figure}{0}
\workspace@InitializeListOf{table}{0}
\workspace@InitializeListOf{algorithm}{0}
\workspace@InitializeListOf{listing}{0}

\DeclareTOCStyleEntry[
    level=0,
    indent=\indenttablelisting,
    numwidth=1.5em,
    dynnumwidth=true,
    numsep=\numseptablelisting,
    entrynumberformat=\listingentrynumberformat,
    pagenumberformat=\listingpagenumberformat]
{tocline}{listing}

\AtBeginDocument{
    \workspace@InitializeEnvForListOf{figure}{lof}{part}
    \ifbool{workspace@nochapters}{}{
    \workspace@InitializeEnvForListOf{figure}{lof}{chapter}
    }
    \workspace@InitializeEnvForListOf{figure}{lof}{section}
    \workspace@InitializeEnvForListOf{figure}{lof}{subsection}
    \workspace@InitializeEnvForListOf{figure}{lof}{subsubsection}
    \workspace@InitializeEnvForListOf{figure}{lof}{paragraph}
    \workspace@InitializeEnvForListOf{figure}{lof}{subparagraph}

    \workspace@InitializeEnvForListOf{table}{lot}{part}
    \ifbool{workspace@nochapters}{}{
    \workspace@InitializeEnvForListOf{table}{lot}{chapter}
    }
    \workspace@InitializeEnvForListOf{table}{lot}{section}
    \workspace@InitializeEnvForListOf{table}{lot}{subsection}
    \workspace@InitializeEnvForListOf{table}{lot}{subsubsection}
    \workspace@InitializeEnvForListOf{table}{lot}{paragraph}
    \workspace@InitializeEnvForListOf{table}{lot}{subparagraph}

    \workspace@InitializeEnvForListOf{longtable}{lot}{part}
    \ifbool{workspace@nochapters}{}{
    \workspace@InitializeEnvForListOf{longtable}{lot}{chapter}
    }
    \workspace@InitializeEnvForListOf{longtable}{lot}{section}
    \workspace@InitializeEnvForListOf{longtable}{lot}{subsection}
    \workspace@InitializeEnvForListOf{longtable}{lot}{subsubsection}
    \workspace@InitializeEnvForListOf{longtable}{lot}{paragraph}
    \workspace@InitializeEnvForListOf{longtable}{lot}{subparagraph}

    \workspace@InitializeEnvForListOf{algorithm}{loa}{part}
    \ifbool{workspace@nochapters}{}{
      \workspace@InitializeEnvForListOf{algorithm}{loa}{chapter}
    }
    \workspace@InitializeEnvForListOf{algorithm}{loa}{section}
    \workspace@InitializeEnvForListOf{algorithm}{loa}{subsection}
    \workspace@InitializeEnvForListOf{algorithm}{loa}{subsubsection}
    \workspace@InitializeEnvForListOf{algorithm}{loa}{paragraph}
    \workspace@InitializeEnvForListOf{algorithm}{loa}{subparagraph}

    \workspace@InitializeEnvForListOf{listing}{lol}{part}
    \ifbool{workspace@nochapters}{}{
    \workspace@InitializeEnvForListOf{listing}{lol}{chapter}
    }
    \workspace@InitializeEnvForListOf{listing}{lol}{section}
    \workspace@InitializeEnvForListOf{listing}{lol}{subsection}
    \workspace@InitializeEnvForListOf{listing}{lol}{subsubsection}
    \workspace@InitializeEnvForListOf{listing}{lol}{paragraph}
    \workspace@InitializeEnvForListOf{listing}{lol}{subparagraph}

    \workspace@InitializeEnvForListOf{listing}{lol}{part}
    \ifbool{workspace@nochapters}{}{
    \workspace@InitializeEnvForListOf{listing}{lol}{chapter}
    }
    \workspace@InitializeEnvForListOf{listing}{lol}{section}
    \workspace@InitializeEnvForListOf{listing}{lol}{subsection}
    \workspace@InitializeEnvForListOf{listing}{lol}{subsubsection}
    \workspace@InitializeEnvForListOf{listing}{lol}{paragraph}
    \workspace@InitializeEnvForListOf{listing}{lol}{subparagraph}
}

\newcommand{\InitializeDividedList}[2]{%
    \newtoggle{#1@#2}%
    \newbool{#1@#2}%
    \setbool{#1@#2}{false}
}

\InitializeDividedList{lof}{part}
\ifbool{workspace@nochapters}{}{
\InitializeDividedList{lof}{chapter}
}
\InitializeDividedList{lof}{section}
\InitializeDividedList{lof}{subsection}
\InitializeDividedList{lof}{subsubsection}
\InitializeDividedList{lof}{paragraph}
\InitializeDividedList{lof}{subparagraph}

\InitializeDividedList{lot}{part}
\ifbool{workspace@nochapters}{}{
\InitializeDividedList{lot}{chapter}
}
\InitializeDividedList{lot}{section}
\InitializeDividedList{lot}{subsection}
\InitializeDividedList{lot}{subsubsection}
\InitializeDividedList{lot}{paragraph}
\InitializeDividedList{lot}{subparagraph}

\InitializeDividedList{loa}{part}
\ifbool{workspace@nochapters}{}{
\InitializeDividedList{loa}{chapter}
}
\InitializeDividedList{loa}{section}
\InitializeDividedList{loa}{subsection}
\InitializeDividedList{loa}{subsubsection}
\InitializeDividedList{loa}{paragraph}
\InitializeDividedList{loa}{subparagraph}

\InitializeDividedList{lol}{part}
\ifbool{workspace@nochapters}{}{
\InitializeDividedList{lol}{chapter}
}
\InitializeDividedList{lol}{section}
\InitializeDividedList{lol}{subsection}
\InitializeDividedList{lol}{subsubsection}
\InitializeDividedList{lol}{paragraph}
\InitializeDividedList{lol}{subparagraph}

\newcommand{\workspace@DeclareDividedList}[2]{\setbool{#1@#2}{true}}

\ifbool{workspace@nochapters}{}{
    \renewcommand\chapterlineswithprefixformat[3]{%
      \Ifstr{#2}{}{\global\togglefalse{numberedchapter}}{\global\toggletrue{numberedchapter}}%
      \chapternumberstyle{#2}\chapterstyle{#3}%
    }
    \renewcommand\chapterlinesformat[3]{%
      \Ifstr{#2}{}{\global\togglefalse{numberedchapter}}{\global\toggletrue{numberedchapter}}
        \chapternumberstyle{#2}\chapterstyle{#3}%
    }
}

\renewcommand\partformat{\partnumberstyle{\partname~\thepart}\autodot}

\renewcommand\partlineswithprefixformat[3]{%
  \Ifstr{#2}{}{\global\togglefalse{numberedpart}}{\global\toggletrue{numberedpart}}
    \partnumberstyle{#2}\partstyle{#3}}

\renewcommand\sectionlinesformat[4]{%
  \Ifstr{#3}{}{\global\togglefalse{numbered#1}}{\global\toggletrue{numbered#1}}\expandafter\@hangfrom{\hskip#2\csname#1style\endcsname{#3}}{\csname#1style\endcsname{#4}}
}

\renewcommand\sectioncatchphraseformat[4]{%
  \Ifstr{#3}{}{\global\togglefalse{numbered#1}}{\global\toggletrue{numbered#1}}\expandafter\@hangfrom{\hskip#2\csname#1style\endcsname{#3}}{\csname#1style\endcsname{#4}}
}

\newcommand{\workspace@AddSectionInListOf}[2]{
  \Ifstr{#2}{}{}{
  \ifbool{#1@#2}{
      \iftoggle{#1@#2}{%
        \iftoggle{numbered#2}{
          \addtocontents{#1}{\protect\contentsline{#2}{\protect\numberline{\expandafter\csname#2entryformat\endcsname{\csname#2prefix\endcsname{}\csname the#2\endcsname\csname#2prefixsep\endcsname}}\expandafter\texorpdfstring{\expandafter\csname#2entryformat\endcsname{\csname#2title\endcsname{}}}{\csname#2title\endcsname{}}}{\csname#2pagetitle\endcsname}{#2.\csname theH#2\endcsname}}
        }{
            \addtocontents{#1}{\protect\contentsline{#2}{\protect\numberline{}\expandafter\texorpdfstring{\expandafter\csname#2entryformat\endcsname{\csname#2title\endcsname{}}}{\csname#2title\endcsname{}}}{\csname#2pagetitle\endcsname}{#2.\csname theH#2\endcsname}}
        }
      \global\togglefalse{#1@#2}%
      }{}%
  }{}%
  }%
}

\newcommand{\workspace@PatchEntriesInToc}[1]{
    \expandafter\renewcommand\csname add#1tocentry\endcsname[2]{%
      \Ifstr{##1}{}
        {\addtocentrydefault{#1}{##1}{\expandafter\texorpdfstring{\csname#1entryformat\endcsname{##2}}{##2}}}%
        {\addtocentrydefault{#1}{\csname#1entryformat\endcsname{\csname#1prefix\endcsname{}##1\csname#1prefixsep\endcsname}}{\expandafter\texorpdfstring{\csname#1entryformat\endcsname{##2}}{##2}}}
    }
}

\AtBeginDocument{
  \workspace@PatchEntriesInToc{part}%
  \ifbool{workspace@nochapters}{}{\workspace@PatchEntriesInToc{chapter}}
  \workspace@PatchEntriesInToc{section}%
  \workspace@PatchEntriesInToc{subsection}%
  \workspace@PatchEntriesInToc{subsubsection}%
  \workspace@PatchEntriesInToc{paragraph}%
  \workspace@PatchEntriesInToc{subparagraph}%
}

% Macro for a prefix in TOC (Figures, Tables, etc.)
\newcommand{\entrynumberwithprefix}[2]{%
    \csname listof#1entryname\endcsname\ #2%
}%


% ********************************************************************
% Nameref
% ********************************************************************

\RequirePackage{nameref}


% ********************************************************************
% Geometry of the page
% ********************************************************************

\ifbool{workspace@nochapters}{}{\KOMAoptions{headings=\workspace@headings}}
\KOMAoptions{twoside=\workspace@twoside}

\ifbool{workspace@revision}{\PassOptionsToPackage{showframe}{geometry}}{}
\RequirePackage{geometry}


% ********************************************************************
% Watermarks
% ********************************************************************

\ifthenelse{\boolean{workspace@revision}}{\SetWatermarkText{\revisionname}}{}
\ifdraft{\SetWatermarkText{\draftname}}{}


% ********************************************************************
% Commands for greek upshape
% ********************************************************************

\def\changegreek{\@for\next:={%
  alpha,beta,gamma,delta,epsilon,zeta,eta,theta,kappa,lambda,mu,nu,xi,pi,rho,sigma,%
  tau,upsilon,phi,chi,psi,omega,varepsilon,vartheta,varpi,varrho,varsigma,varphi}%
  \do{\expandafter\let\csname\next\expandafter\endcsname\csname up\next\endcsname}}
\def\changegreekbf{\@for\next:={%
  alpha,beta,gamma,delta,epsilon,zeta,eta,theta,kappa,lambda,mu,nu,xi,pi,rho,sigma,%
  tau,upsilon,phi,chi,psi,omega,varepsilon,vartheta,varpi,varrho,varsigma,varphi}%
  \do{\expandafter\def\csname\next\expandafter\endcsname\expandafter{%
    \expandafter\bm\expandafter{\csname up\next\endcsname}}}}

\DeclareRobustCommand{\mathup}[1]{\begingroup\changegreek\mathrm{#1}\endgroup}
\DeclareRobustCommand{\mathbfup}[1]{\begingroup\changegreekbf\mathbf{#1}\endgroup}


% ********************************************************************
% Local table of contents
% ********************************************************************

\RequirePackage{etoc}

\etocstandardlines
\etocstandarddisplaystyle

\newcommand*\mtifont{\normalsize\bfseries}
\newcommand*\mtcfont{\small \rmfamily \upshape \mdseries }

\newlength\mtcindent 

\newcommand*\mtc@zrule{\rule[\z@]{\z@}{\z@}}
\newcommand*\mtc@BBR{\unpenalty\nopagebreak[4]}
\newbox\mtc@strutbox
\setbox\mtc@strutbox=\hbox{\rule[1.8ex]{\z@}{2.5ex}}
\newcommand*\mtc@strut{\relax\ifmmode\copy\mtc@strutbox
                     \else\unhcopy\mtc@strutbox\fi}
\newcommand*\mtc@bottom@rule{%
  \ifx\mtc@rule\relax\relax\else
      \vskip -2.5ex
        \rule[2.4\p@]{\columnwidth}{.4\p@}\vspace*{2.6\p@}\fi}

\newcommand*\mtc@verse[1]{\let\\=\@centercr
  \list{}{%
     \itemsep=\z@\itemindent=\z@\partopsep=\z@
     \listparindent=\itemindent\topsep=1ex
     \parsep=\z@ 
     \leftmargin=\mtcindent\rightmargin=\leftmargin
     \addtolength{\leftmargin}{+#1}%
     \addtolength{\rightmargin}{-#1}%
  }%
  \item[]}


\newcommand\do@mtitc[1]{\null\leavevmode\mtc@strut#1\hfill\null}

\newcommand{\etocrulestyle}[1]{
    \etocsettocstyle
    {%
        \begin{samepage}%
        \raggedright
        \parskip=\z@
        \parindent=\z@
        \nopagebreak[4]%
        \kern-0.8\baselineskip
        \nopagebreak[4]%
        \par\noindent
        \begingroup
        \do@mtitc{\subsectionstyle{\localtocstyle{#1}}}
        \vspace*{1.5\baselineskip}
        \endgroup
        \nopagebreak[4]%
        \mtc@bottom@rule\null\leavevmode\\%
        \vspace*{-3.5\baselineskip}
        \null\leavevmode\mtc@zrule\\\mtc@BBR
        \leftmargin\mtcindent
        \rightmargin\mtcindent
        \itemindent=\z@
        \labelwidth=\z@
        \labelsep=\z@
        \listparindent=\z@
        \begin{mtc@verse}{0pt}%
        \leavevmode\\\mtc@BBR
        \vskip-.5\baselineskip
        \begingroup
    }
    {%
    \vspace{-0.5\baselineskip}%
    \leavevmode\mtc@strut
    \global\@nobreakfalse
    \endgroup
      \end{mtc@verse}%
      \kern-.5\baselineskip\kern.5ex % was \kernafterminitoc
      \nopagebreak[4]%
      \mtc@bottom@rule\null\leavevmode\\%
      \vskip-1.0\baselineskip
      \mtc@zrule
      \end{samepage}%
      \par\pagebreak[1]\vspace*{\baselineskip}%
    }%
}

\NewDocumentCommand{\localchaptoc}{O{\localchaptocname} O{}}{
\markright{#1}
\begingroup
\setlength{\indenttocsection}{0em}
\KOMAoptions{parskip=no}
% \etocsetnexttocdepth{\localtocchapterdepth}
\etocrulestyle{#1}
\hypersetup{hidelinks}
\localtableofcontentswithrelativedepth{+2} #2
\endgroup
\KOMAoptions{parskip=relative}
}
\NewDocumentCommand{\localparttoc}{O{\localparttocname} O{}}{
\markboth{#1}{#1}
\begingroup
\setlength{\indenttocchapter}{0em}
\KOMAoptions{parskip=no}
% \etocsetnexttocdepth{\localtocpartdepth}
\etocrulestyle{#1}
\hypersetup{hidelinks}
\localtableofcontents #2
\endgroup
\KOMAoptions{parskip=relative}
}


% ********************************************************************
% Wrapfigure/wraptab environment
% ********************************************************************

\NewDocumentEnvironment{wrapfig}{O{}mO{\wrapoverhang}mO{6pt}}{%
    \setlength{\intextsep}{#5}%
    \wrapfigure[#1]{#2}[#3]{#4}%
    \vspace{-\baselineskip}%
}{%
    \endwrapfigure%
}

\NewDocumentEnvironment{wraptab}{O{}mO{\wrapoverhang}mO{6pt}}{%
    \setlength{\intextsep}{#5}%
    \wraptable[#1]{#2}[#3]{#4}%
    \vspace{-\baselineskip}%
}{%
    \endwraptable%
}


% ********************************************************************
% Hyperref
% ********************************************************************

\RequirePackage{refcount}
\PassOptionsToPackage{unicode}{hyperref}
\RequirePackage{hyperref}
\RequirePackage[
    autostyle=true,
    autopunct=true]
{csquotes}
\RequirePackage{cleveref}

\definecolor{linkcolor}{RGB}{0,94,131}      % Blue link
\definecolor{urlcolor}{RGB}{140,24,47}      % Red links
\definecolor{citecolor}{RGB}{0,128,0}      % Green links

\ifthenelse{\boolean{workspace@print}}{\hypersetup{hidelinks}}
{
    \hypersetup{
        colorlinks,
        linkcolor=linkcolor,
        urlcolor=urlcolor,
        citecolor=citecolor
    }
}

\pdfstringdefDisableCommands{%
  \renewcommand{\bm}[1]{#1}%
}


% ********************************************************************
% Patch Babel french to get caption separator right
% ********************************************************************

\IfLanguageName{french}{
    \renewcommand*{\CaptionSeparator}{\floatseparator}
    \frenchbsetup{SmallCapsFigTabCaptions=false}
}{}

% ********************************************************************
% Marginpar
% ********************************************************************

\def\graffito@setup{%
   \marginlinestyle\leavevmode%
   \parindent=0pt \lineskip=0pt \lineskiplimit=0pt %
   \tolerance=2000 \hyphenpenalty=300 \exhyphenpenalty=300%
   \doublehyphendemerits=100000%
   \finalhyphendemerits=\doublehyphendemerits}

\RequirePackage{mparhack} % get marginpar right

\let\oldmarginpar\marginpar
\renewcommand{\marginpar}[2][]{% always add optional parameter, make it empty by default
   \if\relax\detokenize{#1}\relax% optional parameter empty, in all normal document calls
      \oldmarginpar[\graffito@setup\raggedleft\hspace{0pt}{#2}]{\graffito@setup\raggedright\hspace{0pt}#2}%
   \else%two parameters, let them use their styling
      \oldmarginpar[{#1}]{#2}%
   \fi%
}

% ********************************************************************
%%% Imports
% ********************************************************************

% Custom macros
\usepackage{misc/macros}

% Style
\usepackage{misc/style}

% Input strings template
\input{misc/strings.tex}

% Code macros
\usepackage{misc/code}


% ********************************************************************
% Patching titles (after style !)
% ********************************************************************

\newcounter{secautolabel}
\newcommand*{\setautolabel}[1]{%
  \stepcounter{secautolabel}%
  \label{sec:autolabel:\thesecautolabel}%
  \expandafter\xdef\csname#1pagetitle\endcsname{%
    \noexpand\getpagerefnumber{sec:autolabel:\thesecautolabel}%
  }%
}

\xpretocmd{\scr@@startpart}{\setautolabel{part}\gdef\parttitle{#2}}{}{}
\xpretocmd{\scr@@startspart}{\setautolabel{part}\gdef\parttitle{#2}}{}{}

\xpretocmd{\scr@@startchapter}{\setautolabel{chapter}\gdef\chaptertitle{#2}}{}{}
\xpretocmd{\scr@@startschapter}{\setautolabel{chapter}\gdef\chaptertitle{#2}}{}{}

\xpretocmd{\@sect}{\setautolabel{\toggletoc}\expandafter\gdef\csname\toggletoc title\endcsname{#7}}{}{}
\xpretocmd{\@ssect}{\setautolabel{\toggletoc}\expandafter\gdef\csname\toggletoc title\endcsname{#5}}{}{}

\workspace@PatchSectionsListOf{lof}
\workspace@PatchSectionsListOf{lot}
\workspace@PatchSectionsListOf{loa}
\workspace@PatchSectionsListOf{lol}

\preto\addpart{\def\toggletoc{part}}
\preto\part{\def\toggletoc{part}}
\ifbool{workspace@nochapters}{}{
  \preto\addchap{\def\toggletoc{chapter}}
  \preto\chapter{\def\toggletoc{chapter}}
}
\preto\addsec{\def\toggletoc{section}}
\preto\section{\def\toggletoc{section}}
\preto\subsection{\def\toggletoc{subsection}}
\preto\subsubsection{\def\toggletoc{subsubsection}}
\preto\paragraph{\def\toggletoc{paragraph}}
\preto\subparagraph{\def\toggletoc{subparagraph}}


% ********************************************************************
% Subfiles
% ********************************************************************

\RequirePackage{subfiles} 
\newcommand{\onlyinsubfile}[1]{#1}
\newcommand{\notinsubfile}[1]{}


%% ********************************************************************
%% End of file `workspace.cls'.
%% ********************************************************************
