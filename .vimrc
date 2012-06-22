" agi vim-scripts vim-addon-manager
" vim-addons
" vim-addons install sokoban

if filereadable('.vimrc.perl_id')
    :source .vimrc.perl_id
endif

" sql.vim breaks arrow keys in insert mode
let g:ftplugin_sql_omni_key_right = '»'
let g:ftplugin_sql_omni_key_left  = '«'

iab papp  :r ~/.code_templates/perl_application.pl
iab pmod  :r ~/.code_templates/perl_module.pm

let g:Perl_NoKeyMappings = 1

" Shift-Tab under screen with vim caused a 1sec lag due to tm=1000
" :set timeout timeoutlen=1000 ttimeoutlen=100
" See: ~/pain/vim+screen_shift_tab
if &term == "screen"
    " tell vim about S-Tab: Ctrl-V [ Z
    :set t_kB=[Z
endif

set foldcolumn=0
set foldlevelstart=1
set foldminlines=4
"set foldclose=all

map == :BufExplorer<CR>
map =- :n#<CR>

" http://tinyurl.com/mje9sb
" :set laststatus=2 to see always
if has("statusline") && has("multi_byte")
  set statusline=%<%f\ %h%m%r%=%k[%{(&fenc\ ==\"\"?&enc:&fenc).(&bomb?\",BOM\":\"\")}][U+%04B]\ %-12.(%l,%c%V%)\ %P
endif


" grep modeline /usr/share/vim/vim71/debian.vim
" modelines have historically been a source of security/resource
set modeline

" http://vim.wikia.com/wiki/Highlight_unwanted_spaces
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\t\|\s\+\%#\@<!$/
" trailing space highlighting, F4 toggle (spacehi.vim)
"autocmd syntax * SpaceHi
"autocmd Syntax * syn match ExtraWhitespace /\s\+$\| \+\ze\t/

" :h matchparen, switch it off
:let loaded_matchparen = 1

function SetFoldLevel()
    "echo "Win:" . winheight(0) . " lines:" . line("$")
    if winheight(0) >= line("$")
        set foldlevel=99
        "echo "open"
    else
        set foldlevel=1
        "echo "closed"
    endif
endfunction

autocmd BufRead * call SetFoldLevel()

"function SetTT2Syntax ()
"   set syntax=template_html
"   "source ~/.vim/syntax/template.vim
"endfunction

"autocmd BufRead *.tt2 set syntax=tt2 ai tw=80 ts=4 sw=4 matchpairs+=<:>
"autocmd BufRead *.tt2 set syntax=html source ~/.vim/syntax/template.vim ai tw=80 ts=4 sw=4 matchpairs+=<:>
autocmd BufRead */tt2/*,*.tt2 set syntax=template_html
autocmd BufRead *.tt2 set ai tw=80 ts=4 sw=4 matchpairs+=<:>
autocmd BufRead *.htm,*.html set syntax=html ai tw=80 ts=4 sw=4 matchpairs+=<:>
autocmd BufNewFile *.htm,*.html  0r ~/.vim/skel/html
" must be after *.tt2:
autocmd BufRead httpd*.conf.tt2 set syntax=template_apache
autocmd BufRead httpd*.conf set syntax=apache
autocmd BufRead *.pl.tt2 set syntax=template_perl
autocmd BufRead *.yaml,*.yml set et sts=1 ts=2 syntax=yaml sw=2
autocmd BufRead *.sps,*.SPS,*.spss set syntax=sps
" for topographica
autocmd BufRead *.ty set syntax=python
" for sofa's scenes
autocmd BufRead *.scn set syntax=xml

" sdt's open-this-module command
au FileType perl command! -nargs=1 PerlModuleSource :e `perldoc -lm <args>`
au FileType perl setlocal isfname+=:
au FileType perl noremap ,pm :PerlModuleSource <cword><cr>

if version >= 500
    let make_bsd = 1

    "let perl_include_pod = 0
    "let perl_want_scope_in_variables = 0
    let perl_extended_vars = 1
    "let perl_string_as_statement = 0
endif

if version >= 600
    let perl_fold = 1
endif

if version >= 730
    " untested but sounds cool
    set undofile
    " set undodir
endif

let g:cvimsyn="$VIM/dict"
let g:showmarks_enable=0

" section for { } block matching
set tabstop=4       " spaces per tab
set shiftwidth=4    " spaces for indent
set softtabstop=4   " softtabs - reset tabs :ret! 4
set shiftround      " round >> to sw multiple
set expandtab       " PBP

set nobackup
set hlsearch

"set backspace=1 " bs over EOL
set backspace=indent,eol,start " PBP
set showmatch " bracket matching

set scrolljump=3 " faster
set incsearch " slower

set complete=.,b " complete ^P ^N
set visualbell t_vb= " no bell or visible bell

"Should test somehow
set background=dark
syntax on

set textwidth=78

" debugging why is 'fo' reset?!
" vim -V bin/say
" :set fo?
"   formatoptions=crq
"           Last set from /usr/share/vim/vim70/ftplugin/perl.vim
"
" :h ftplugin-overrule
"   ~/.vim/after/ftplugin/perl.vim
set formatoptions=q
set gdefault " s///g unless g used to switch off

" nopaste so that imapping work
set nopaste
set pastetoggle=<F11>

:filetype plugin on

"  - Formatting
" 950330 ,dp = dequote current paragraph
map     ,dp {jma}kmb:'a,'bs/^> *//<CR>
" 950330 ,qp = quote current paragraph
map     ,qp {jma}kmb:'a,'bs/^/> /<CR>
map     ,p :set syntax=perl<CR>
" del up to -- sig
nmap    ,ds ^d/^--\s*$/<CR>
" toggle wrapping "inv" = invert
"nmap W :set invwrap<CR>


" delete EOL whitespace
nmap ds :%s/\s\+$//<CR>
" from whitepsace.vim
" syn match Tab "\t"
" hi def Tab ctermbg=darkgreen guibg=#003000
map    ,tabs :syn match Tab "\t"<CR>:hi def Tab ctermbg=darkgreen guibg=#003000<CR>
" something to fix syntax highlighting after above line :4

" Squeeze blanks
" :v/./.,/./-1join
map  ,b  GoZ^[:g/^[ ^I]*$/,/[^ ^I]/-j^MGdd

" transpose two letters
nmap T xph
" rot13
nmap ,r g?E
" bracketify word, /(\s|$) to find word end i
" (\v is very magic, | is escaped for map, not regex)
" b for beginning of word, e for end
"map ,{ /\v(\s\|$)<CR>bi{<ESC>ea}<ESC>
"map ,{ bi{<ESC>ea}<ESC>
" back a word, forward to end, back to beginning = geeb = ge e b
map ,{ geebi{<ESC>ea}<ESC>
map ,( geebi(<ESC>ea)<ESC>
map ," geebi"<ESC>ea"<ESC>
map ,' geebi'<ESC>ea'<ESC>

" insert and remove '#' comments, normal and visual
vmap ,ic :s/^/#/g<CR>:let @/ = ""<CR>
map  ,ic :s/^/#/g<CR>:let @/ = ""<CR>
vmap ,rc :s/^#//g<CR>:let @/ = ""<CR>
map  ,rc :s/^#//g<CR>:let @/ = ""<CR>

nmap <Home> :1<CR>
nmap <End> G

if has('perl')
    " Should use built in..
    :perl use Text::Autoformat
    map <F2> :.perldo tr/!-~/P-~!-O/ <CR>
    " toggle 4/8 tab stops
    map <silent> <F3> :perl $ts=(4==(VIM::Eval('&tabstop'))[1])?8:4;VIM::SetOption("ts=$ts")<CR>
endif


" write & execute XXX should prompt for cmd first time, test +x too
"map <F4> :w\|!perl -c ./%<CR>
"map <F5> :w\|!./%<CR>
"set makeprg=/usr/share/doc/vim/tools/efm_perl.pl
if filereadable("$HOME/bin/efm_perl.pl")
    set makeprg=$HOME/bin/efm_perl.pl
    set errorformat=%f:%l:%m
    set shellpipe=>
    map <F4> :w\|:make! -c % $*<CR>\|:cw<CR>
    map <F5> :w\|:make! % $*\|:cw<CR>
endif

" duplicate and comment current line with #
map <F6> yypkI#<ESC>j
" format inner para
map <F7> !ipperl -MText::Autoformat -eautoformat<CR>
" format remainder
map <F8> !Gperl -MText::Autoformat -eautoformat<CR>
"nnoremap <silent> <F9> :Tlist<CR>
imap <F9> <C-N>
" map <F10> :inoremap <tab> <tab><CR>
map <F10>  :set hls!<CR>
" <F11> is paste toggle
" always show laststatus, toggle was too hard, good for unicode
map <F12>  :set laststatus=2<CR>


if filereadable("~/.vim/scripts/closetag.vim")
    :au Filetype html,xml,xsl,tmpl,tt2 source ~/.vim/scripts/closetag.vim
endif

if has("cscope")
    set csprg=/usr/local/bin/cscope
    set csto=1
    set cst
    set nocsverb
    cs add cscope.out
    set csverb
endif

if has("autocmd")

au BufNewFile,BufRead /tmp/psql.*   setf sql

" perl test files
au BufNewFile,BufRead *.t,*.def   set filetype=perl

" perl 0# screws comments, : screws labels
":au BufEnter *.pl,*.pm set fo=croq cindent cinkeys=0{,0},!^F,o,O,e fdc=0
" I got too used to starting in paste mode, don't like formatting help now
au BufEnter *.pl,*.pm set fo=q nocindent cinkeys= fdc=0
au BufLeave *.pl,*.pm set fo=crq nocindent cinkeys=0{,0},#0,:,!^F,o,O,e fdc=0

" With these, you can type "K" when you are over a perl term
" in your code, and it will look it up with "perldoc -f $term"
" what I would like to happen is this: perldoc -f term || perldoc term
" So, it tries to look up the keyword as a perl function
" and then it tries to look it up as a module name if that fails
au BufRead,BufNewFile *.pm,*.pl setlocal keywordprg=perldoc\ -f

" Set some sensible defaults for editing C-files
augroup cprog
  " Remove all cprog autocommands
  au!

  " When starting to edit a file:
  "   For *.c and *.h files set formatting of comments and set C-indenting on.
  "   For other files switch it off.
  "   Don't change the order, it's important that the line with * comes first.
  " autocmd BufRead *       set formatoptions=tcql nocindent comments&
  autocmd BufRead *.c,*.h set formatoptions=croql cindent comments=sr:/*,mb:*,el:*/,://
augroup END

endif " has ("autocmd")
