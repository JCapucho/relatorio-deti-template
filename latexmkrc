$pdf_mode = 4;
$out_dir = 'build';
$latex = 'latex -interaction=nonstopmode -shell-escape';

@default_files = ('main.tex');

set_tex_cmds('--shell-escape %O %S');
