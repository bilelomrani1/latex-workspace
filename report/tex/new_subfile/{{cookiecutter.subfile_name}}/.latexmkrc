# Latekmk config file


# Generate pdf using pdflatex (-pdf)
$pdf_mode = 1;

# Use bibtex if a .bib file exists
$bibtex_use = 1;

# Define command to compile with pdfsync support and nonstopmode
$pdflatex = 'pdflatex -synctex=1 --interaction=nonstopmode -file-line-error -shell-escape';

# Files on clean
$clean_ext = "synctex.gz acn bbl glo mw nlo run.xml xdy fdb_latexmk pytxcode listing";

# Maximum number of compilations
$max_repeat = 10;

# Custom dependency and function for nomencl package 
add_cus_dep( 'nlo', 'nls', 0, 'makenlo2nls' );
sub makenlo2nls {
system( "makeindex -s nomencl.ist -t '$_[0].nlg' -o '$_[0].nls' '$_[0].nlo'" );
}
@generated_exts = (@generated_exts, 'nlo');

add_cus_dep('glo', 'gls', 0, 'makeglo2gls');
sub makeglo2gls {
    system("makeglossaries '$_[0]'");
}
@generated_exts = (@generated_exts, 'glo');

# PythonTeX dependency
add_cus_dep('pytxcode', 'tex', 0, 'pythontex');
sub pythontex { 
system("pythontex '$_[0]'");
}
@generated_exts = (@generated_exts, 'pytxmcr');
