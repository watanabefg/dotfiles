" watanabefg's .vimrc
" $Id$
set nocompatible " must be first!
nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k
nnoremap ; :
nnoremap gc `[v`]
vnoremap gc :<C-u>normal gc<Enter>
inoremap gc :<C-u>normal gc<Enter>
nnoremap <Space>. :<C-u>edit $MYVIMRC<Enter>
nnoremap <Space>s. :<C-u>source $MYVIMRC<Enter>
nnoremap <C-h> :<C-u>help<Enter>
nnoremap <C-h><C-h> :<C-u>help<Space><C-r><C-w><Enter>
inoremap <expr> ,df strftime('%Y/%m/%d %H:%M:%S')
inoremap <expr> ,dd strftime('%Y/%m/%d')
inoremap <expr> ,dt strftime('%H:%M:%S')
"-- WEB+DB PRESS option

set shiftround
set autoindent
set backspace=indent,eol,start
set backup
set hidden
set history=50
set hlsearch
set ignorecase
set incsearch
set laststatus=2
set nobackup
set number
set ruler
set shiftwidth=4
set showcmd
set showmatch
set smartcase
set statusline=%<%F\ %m%r%h%w[%{&fileformat}]\ [%{has('multi_byte')&&\&fileencoding!=''?&fileencoding:&encoding}]\ %y
set statusline+=%=\ [%3.3c]\ [%5.5l/%5.5L]
set tabstop=4
set wrapscan
set list
set listchars=tab:>-,extends:<,trail:-,eol:$

syntax on
filetype on
filetype indent on
filetype plugin on

" 入力モード時、ステータスラインのカラーを変更
augroup InsertHook
    autocmd!
    autocmd InsertEnter * highlight StatusLine guifg=#ccdc90 guibg=#2E4340
    autocmd InsertLeave * highlight StatusLine guifg=#2E4340 guibg=#ccdc90
augroup END

" 辞書ファイルを使用する設定に変更
set complete+=k
" ファイルタイプ毎に辞書ファイルを指定
autocmd FileType php :set dictionary+=~/.vim/dict/php_functions.dict

" smartchrで=の両端にスペースを自動挿入 by watanabefg
autocmd FileType php :inoremap <expr> = smartchr#loop(' = ', ' == ', ' === ', '=')
autocmd FileType perl :inoremap <expr> = smartchr#loop(' = ', ' == ', ' => ', ' <= ', '=')

autocmd FileType python :inoremap <expr> = smartchr#loop(' = ', ' == ', '=')
autocmd FileType python :inoremap <expr> , smartchr#loop(', ', ',')
set tags+=~/.tags


" FuzzyFinder.vim
nnoremap <Space>f f
nnoremap <Space>F F
nnoremap f <Nop>
nnoremap <silent> fb :<C-u>FuzzyFinderBuffer!<CR>
nnoremap <silent> ff :<C-u>FuzzyFinderFile! <C-r>=expand('%:~:.')[:-1-len(expand('%:~:.:t'))]<CR><CR>
nnoremap <silent> fm :<C-u>FuzzyFinderMruFile!<CR>
nnoremap <silent> tb :<C-u>tabnew<CR>:tabmove<CR>:FuzzyFinderBuffer!<CR>
nnoremap <silent> tf :<C-u>tabnew<CR>:tabmove<CR>:FuzzyFinderFile! <C-r>=expand('#:~:.')[:-1-len(expand('#:~:.:t'))]<CR><CR>
nnoremap <silent> tm :<C-u>tabnew<CR>:tabmove<CR>:FuzzyFinderMruFile!<CR>


if &encoding !=# 'utf-8'
    set encoding=japan
    set fileencoding=japan
endif
if has('iconv')
    let s:enc_euc = 'euc-jp'
    let s:enc_jis = 'iso-2022-jp'
    if iconv("\x87\x64\x87\x6a", 'cp932', 'eucjp-ms') ==# "\xad\xc5\xad\xcb"
        let s:enc_euc = 'eucjp-ms'
        let s:enc_jis = 'iso-2022-jp-3'
    elseif iconv("\x87\x64\x87\x6a", 'cp932', 'euc-jisx0213') ==# "\xad\xc5\xad\xcb"
        let s:enc_euc = 'euc-jisx0213'
        let s:enc_jis = 'iso-2022-jp-3'
    endif
    if &encoding ==# 'utf-8'
        let s:fileencodings_default = &fileencodings
        let &fileencodings = s:enc_jis .','. s:enc_euc .',cp932'
        let &fileencodings = &fileencodings .','. s:fileencodings_default
        unlet s:fileencodings_default
    else
        let &fileencodings = &fileencodings .','. s:enc_jis
        set fileencodings+=utf-8,ucs-2le,ucs-2
        if &encoding =~# '^\(euc-jp\|euc-jisx0213\|eucjp-ms\)$'
            set fileencodings+=cp932
            set fileencodings-=euc-jp
            set fileencodings-=euc-jisx0213
            set fileencodings-=eucjp-ms
            let &encoding = s:enc_euc
            let &fileencoding = s:enc_euc
        else
            let &fileencodings = &fileencodings .','. s:enc_euc
        endif
    endif
    unlet s:enc_euc
    unlet s:enc_jis
endif
if has('autocmd')
    function! AU_ReCheck_FENC()
        if &fileencoding =~# 'iso-2022-jp' && search("[^\x01-\x7e]", 'n') == 0
            let &fileencoding=&encoding
        endif
    endfunction
    autocmd BufReadPost * call AU_ReCheck_FENC()
endif
set fileformats=unix,dos,mac
if exists('&ambiwidth')
    set ambiwidth=double
endif

""
" AutocomplePopをTABで補完
"" {{{ Autocompletion using the TAB key
" This function determines, wether we are on the start of the line text (then
" tab indents) or
" " if we want to try autocompletion
function! InsertTabWrapper()
let col  =  col('.') - 1
if !col || getline('.')[col - 1] !~ '\k'
return "\<TAB>"
else
if pumvisible()
return "\<C-N>"
else
return "\<C-N>\<C-P>"
end
endif
endfunction
" Remap the tab key to select action with InsertTabWrapper
inoremap <tab> <C-r>=InsertTabWrapper()<CR>
" }}}  Autocompletion using the TAB key 

""
" PHP Lint
" @author halt feits <halt.feits@gmail.com>
"
nmap ,l :call PHPLint()<CR>
function! PHPLint()
    let result = system( &ft . ' -l ' . bufname(""))
    echo result
endfunction

""
" Perl Lint
" @author watanabefg <h.w.watanabe@gmail.com>
"
nmap ,p :call PerlLint()<CR>
function! PerlLint()
    let result = system( &ft . ' -wc ' . bufname(""))
    echo result
endfunction
