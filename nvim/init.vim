filetype on
filetype plugin indent on
syntax on

let mapleader=","

call plug#begin('~/.local/share/nvim/plugged')
Plug 'ledger/vim-ledger'                " Ledger
Plug 'deviantfero/wpgtk.vim'
Plug 'dhruvasagar/vim-table-mode'		" Tables!
Plug 'honza/vim-snippets'               " Snippets
Plug 'lotabout/skim.vim'
Plug 'mattn/emmet-vim'                  " Emmet
Plug 'mhinz/vim-startify'               " Startify
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'psliwka/vim-smoothie'
Plug 'scrooloose/nerdtree'              " NERDTree
Plug 'sheerun/vim-polyglot'             " languages
Plug 'tmsvg/pear-tree'                  " auto-pairs
Plug 'tpope/vim-commentary'             " commentary
Plug 'tpope/vim-fugitive'               " Vim fugitive
call plug#end()

let $SKIM_DEFAULT_COMMAND = 'ag -g "" --hidden --ignore-dir={.git,node_modules}'
let g:comfortable_motion_no_default_key_mappings = 1
let g:comfortable_motion_impulse_multiplier = 1  " Feel free to increase/decrease this value.
let g:go_fmt_autosave = 0
let g:ledger_bin = 'hledger'
let g:startify_custom_header = startify#fortune#cowsay('', '═','║','╔','╗','╝','╚')
let g:startify_lists = [
            \ { 'type': 'sessions',  'header': ['   Sessions']             },
            \ { 'type': 'dir',       'header': ['   Recent in '. getcwd()] },
            \ { 'type': 'files',     'header': ['   Recent']               },
            \ { 'type': 'bookmarks', 'header': ['   Bookmarks']            },
            \ { 'type': 'commands',  'header': ['   Commands']             },
            \ ]
let g:startify_session_persistence = 1
let g:user_emmet_leader_key=','
let g:tex_conceal = ""
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_math = 1

set autowriteall
set autoread
set background=dark
set breakindent                         " Indents word-wrapped lines as much as the line above
set clipboard+=unnamedplus
set cmdheight=2
set complete+=kspell                    " spell check
set completeopt+=preview
set conceallevel=1
set diffopt+=hiddenoff
set equalalways
set fillchars+=vert:\||
set fillchars+=fold:\ |
set fillchars+=stl:-
set fillchars+=stlnc:-
set expandtab
set formatoptions+=lt " Ensures word-wrap does not split words
set hidden
set ignorecase
set lazyredraw
set lbr
set list listchars=tab:\>\ ,trail:·
set mouse=a
set nobackup
set cursorline
set noshowmode " hides -- INSERT --
set noswapfile
set noeb vb t_vb= " disable error bells
set nowb
set nowrap
set number
set rnu
" set runtimepath+=~/.config/nvim/plugged/deoplete.nvim
set shiftwidth=4
set shortmess=aFTW
set si   " Smart indent
set signcolumn=auto:1
"set signcolumn=yes
set smartcase
set softtabstop=4
set scrolloff=5
set splitbelow
set splitright
set tabstop=4 " Tab size is 4
set tags=./tags;
set notermguicolors
set undodir=~/.local/share/nvim/undodir
set undofile
set undolevels=1000
set undoreload=10000
set updatetime=300
set whichwrap+=<,>,h,l
set wildignore+=*/node_modules,*/node_modules/*,.git,.git/*,tags,*/dist,*/dist/*

" call echodoc#enable()


" get highlight under cursor
map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
            \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
            \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" navigate long lines easily
nnoremap <silent> j gj
nnoremap <silent> k gk

inoremap <silent><expr> <C-n> coc#refresh()
" FZF/skim
map <C-p> :SK<CR>

" todo list
nnoremap <leader>to :Ag (NOTE)\|(XXX)\|(FIXME)\|(TODO)<cr>

" easily edit init.vim file
map <leader>rc :tabe ~/.config/nvim/init.vim<CR>

" find word under the cursor
noremap <leader>f /<C-R><C-W><CR>
" easy window resizing in normal mode
nnoremap <silent> + :5wincmd ><CR>
nnoremap <silent> - :5wincmd <<CR>
nnoremap <silent> ^ :3wincmd +<CR>
nnoremap <silent> _ :3wincmd -<CR>

" toggle wrap
noremap <leader>w :set wrap!<CR>

" easy window moving and switching
noremap <silent> <leader>H :wincmd H<CR>
noremap <silent> <leader>J :wincmd J<CR>
noremap <silent> <leader>K :wincmd K<CR>
noremap <silent> <leader>L :wincmd L<CR>
noremap <silent> <leader>h :wincmd h<CR>
noremap <silent> <leader>j :wincmd j<CR>
noremap <silent> <leader>k :wincmd k<CR>
noremap <silent> <leader>l :wincmd l<CR>
noremap <silent> <leader>= :wincmd =<CR>

" trim whitespace
noremap <silent> <leader>tw :%s/\s\+$//e<CR>:noh<CR>

" tab shortcuts
noremap <leader>tc :tabc<CR>
noremap <leader>te :tabe<CR>

" splitting shortcuts
noremap <leader>v :vs<CR>
noremap <leader>nv :vs<CR>:SK<CR>
noremap <leader>s :sp<CR>
noremap <leader>ns :sp<CR>:SK<CR>
noremap <leader>nt :tabe<CR>:SK<CR>

" Fugitive shortcuts
noremap <leader>gg :Git
noremap <leader>gs :Gstatus<CR>
noremap <leader>gc :Gcommit -m
noremap <leader>gd :Gvdiff<CR>
noremap <leader>gb :Git checkout
noremap <leader>gpl :Gpull
noremap <leader>gph :Gpush

" Golang shortcuts
nnoremap <silent> <leader>gof :!gofmt -s -w "%"<CR>
nnoremap <leader>gob :!go build<CR>
nnoremap <leader>goi :!go install<CR>
nnoremap <leader>gor :!go run *.go

" Lanuage Server shortcuts
nmap <silent> <leader>ca :CocAction<CR>
nmap <silent> <leader>cr <Plug>(coc-rename)
nmap <silent> <leader>cf <Plug>(coc-format)
nmap <silent> <leader>ct <Plug>(coc-type-definition)
nmap <silent> <leader>cx <Plug>(coc-references)
nmap <silent> <leader>/ :call CocAction('jumpDefinition')<CR>
nmap <silent> <leader>? :call CocAction('doHover')<CR>
nmap <silent> K :call CocAction('doHover')<CR>

nnoremap <silent> <leader>xt :tabe<CR>:terminal<CR>i
nnoremap <silent> <leader>xv :vs<CR>:terminal<CR>i
nnoremap <silent> <leader>xx :terminal<CR>i
nnoremap <silent> <leader>xs :sp<CR>:terminal<CR>i

" Misc shortcuts
noremap <silent> <leader>e :NERDTreeToggle<CR>
noremap <silent> <leader>P :Prettier<CR>
noremap <silent> <leader>q :q<CR>
noremap <silent> <leader>p :pwd<CR>
noremap <silent> <leader>cd :cd %:p:h<CR>:pwd<CR>
nnoremap Y y$

" diff shortcuts
nnoremap <leader>dp :diffput<CR>
nnoremap <leader>dg :diffget<CR>
nnoremap <leader>dt :diffthis<CR>
nnoremap <leader>do :diffoff<CR>:set noscrollbind<CR>:set nocursorbind<CR>

" press jj or fj to go from insert to normal mode
inoremap jj <esc>
imap jj <Plug>(PearTreeFinishExpansion)
inoremap fj <esc>
imap fj <Plug>(PearTreeFinishExpansion)

nnoremap <silent> <leader>mm :silent !sh $HOME/.config/nvim/pandocPreview.sh "%"<CR>:echo "Markdown preview was started."<CR>
nnoremap <silent> <leader>mq :silent !killall entr && rm "%.tmp.pdf"<CR>:echo "Markdown preview was stopped. You can close your editor when you want. :)"<CR>

nnoremap ! :!

" autocommands
augroup auto_commands
    autocmd!
    autocmd FileType defx call s:defx_my_settings()
    autocmd FileType markdown call SetupMarkdown()
    autocmd FileType json syntax match Comment +\/\/.\+$+
    autocmd BufWinLeave * silent! mkview
    autocmd BufWinEnter * silent! loadview
    autocmd VimLeave * call SaveLastSession()
    autocmd BufEnter * checktime
    autocmd InsertLeave * nested call AutoSave()
    autocmd CursorHold * call coc#refresh()
augroup END

" au CursorHold,InsertLeave * nested update

"color wpgtk

" change gutter (SignColumn) color to clear
hi SignColumn guibg=NONE ctermbg=NONE
hi LineNr ctermfg=4 guibg=NONE ctermbg=NONE

hi MatchParen cterm=bold ctermbg=8 ctermfg=231 gui=bold guibg=8 guifg=white
hi FoldColumn guibg=NONE ctermbg=NONE
hi CursorLineNr guibg=8 ctermbg=8 cterm=bold gui=bold guifg=white ctermfg=231
hi CursorLine guibg=8 ctermbg=8 cterm=NONE gui=NONE ctermfg=NONE guifg=NONE
hi CursorColumn guibg=8 ctermbg=8 cterm=NONE gui=NONE ctermfg=NONE guifg=NONE
hi Folded guibg=0 ctermbg=0 guifg=4 ctermfg=4 gui=italic cterm=italic

hi WarningMsg guibg=NONE ctermbg=NONE guifg=yellow ctermfg=226 gui=bold cterm=bold
hi ErrorMsg guibg=NONE ctermbg=NONE guifg=red ctermfg=196 gui=bold cterm=bold
hi InfoMsg guibg=NONE ctermbg=NONE guifg=51 ctermfg=51 gui=bold cterm=bold

hi link CocUnderline InfoMsg
hi link CocErrorHighlight ErrorMsg
hi link CocWarningHighlight WarningMsg
hi link CocInfoHighlight WarningMsg

hi link CocErrorSign ErrorMsg
hi link CocWarningSign WarningMsg
hi link CocInfoSign WarningMsg
hi link CocError ErrorMsg
hi link CocWarning WarningMsg
hi link CocInfo WarningMsg
hi CocInfoSign guibg=NONE ctermbg=NONE guifg=cyan ctermfg=51 gui=bold cterm=bold term=bold
hi CocStyleErrorSign guibg=NONE ctermbg=NONE guifg=red ctermfg=196 gui=bold cterm=bold term=bold
hi CocStyleWarningSign guibg=NONE ctermbg=NONE guifg=yellow ctermfg=226 gui=bold cterm=bold term=bold

hi VertSplit guibg=NONE guifg=8 gui=NONE ctermbg=NONE ctermfg=8 cterm=NONE
hi StatusLineNC cterm=NONE ctermbg=NONE ctermfg=8 guibg=NONE guifg=8
hi StatusLine cterm=NONE ctermbg=NONE ctermfg=8 guibg=NONE guifg=8
hi Normal ctermbg=NONE guibg=NONE
hi NonText cterm=NONE gui=NONE ctermbg=NONE guibg=NONE
hi Comment ctermbg=NONE guibg=NONE
hi SpecialComment ctermfg=4 ctermbg=NONE guibg=NONE cterm=bold,italic gui=bold,italic term=bold,italic
hi Delimiter ctermbg=NONE guibg=NONE
hi Exception ctermbg=NONE guibg=NONE
hi SpecialChar ctermbg=NONE guibg=NONE
hi Typedef ctermbg=NONE guibg=NONE
hi Type ctermfg=10 guifg=10
hi PreProc ctermfg=14 guifg=14
hi Whitespace ctermfg=8 guifg=8

hi link javaScriptLineComment Comment

hi DiffAdd ctermbg=NONE guibg=NONE ctermfg=48 guifg=green
hi DiffChange ctermbg=NONE guibg=NONE ctermfg=214 guifg=orange
hi DiffDelete ctermbg=NONE guibg=NONE ctermfg=196 guifg=red
hi DiffText ctermbg=NONE guibg=NONE ctermfg=226 guifg=yellow cterm=bold gui=bold

hi diffAdded ctermbg=NONE guibg=NONE ctermfg=48 guifg=green
hi diffRemoved ctermbg=NONE guibg=NONE ctermfg=196 guifg=orange

hi Pmenu cterm=NONE gui=NONE ctermbg=8 ctermfg=14 guibg=8 guifg=14
hi PmenuSel cterm=bold gui=bold ctermbg=6 ctermfg=8 guibg=6 guifg=8
hi PmenuSbar cterm=NONE gui=NONE ctermbg=0 ctermfg=0 guibg=0 guifg=0
hi PmenuThumb cterm=NONE gui=NONE ctermbg=5 ctermfg=5 guibg=5 guifg=5

fu! SaveLastSession()
    execute 'mksession! ' . '~/.vim/session/previous'
endfu

fu! UpdateGitInfo()
    let b:custom_git_branch = ''
    try
        if &ft !~? 'vimfiler\|gundo' && exists('*fugitive#head')
            b:custom_git_branch = fugitive#head
        endif
    catch
    endtry
    return b:custom_git_branch
endfu

function! WordCount()
    if &filetype == "markdown"
        let currentmode = mode()
        if !exists("g:lastmode_wc")
            let g:lastmode_wc = currentmode
        endif
        " if we modify file, open a new buffer, be in visual ever, or switch modes
        " since last run, we recompute.
        if &modified || !exists("b:wordcount") || currentmode =~? '\c.*v' || currentmode != g:lastmode_wc
            let g:lastmode_wc = currentmode
            let l:old_position = getpos('.')
            let l:old_status = v:statusmsg
            execute "silent normal g\<c-g>"
            if v:statusmsg == "--No lines in buffer--"
                let b:wordcount = 0
            else
                let s:split_wc = split(v:statusmsg)
                if index(s:split_wc, "Selected") < 0
                    let b:wordcount = str2nr(s:split_wc[11])
                else
                    let b:wordcount = str2nr(s:split_wc[5])
                endif
                let v:statusmsg = l:old_status
            endif
            call setpos('.', l:old_position)
            return b:wordcount . " words"
        else
            return b:wordcount . " words"
        endif
    else
        return ""
    endif
endfunction

function! MarkdownFoldText()
    let linetext = getline(v:foldstart)
    let txt = linetext . ' [...]'
    return txt
endfunction

function! s:isAtStartOfLine(mapping)
  let text_before_cursor = getline('.')[0 : col('.')-1]
  let mapping_pattern = '\V' . escape(a:mapping, '\')
  let comment_pattern = '\V' . escape(substitute(&l:commentstring, '%s.*$', '', ''), '\')
  return (text_before_cursor =~? '^' . ('\v(' . comment_pattern . '\v)?') . '\s*\v' . mapping_pattern . '\v$')
endfunction

function! SetupMarkdown()
    setlocal expandtab 
    setlocal tw=60 
    setlocal foldtext=MarkdownFoldText()
endfunction

function! AutoSave()
    silent! wa 
    call coc#refresh()
endfunction

"" Status bar

hi CustomFile cterm=bold gui=bold ctermfg=12 guifg=12 ctermbg=NONE guibg=NONE
hi CustomPercentage cterm=bold gui=bold ctermfg=10 guifg=10 ctermbg=NONE guibg=NONE
hi CustomFiletype cterm=bold gui=bold ctermfg=11 guifg=11 ctermbg=NONE guibg=NONE
hi CustomGitBranch cterm=bold gui=bold ctermfg=9 guifg=9 ctermbg=NONE guibg=NONE
hi CustomMode cterm=bold gui=bold ctermfg=13 guifg=13 ctermbg=NONE guibg=NONE
hi Inactive cterm=italic gui=italic ctermfg=1 guifg=1 ctermbg=NONE guibg=NONE

let g:currentmode={
    \ 'n'  : 'n',
    \ 'no' : '...',
    \ 'v'  : 'v',
    \ 'V'  : 'vl',
    \ '^V' : 'vb',
    \ 's'  : 's',
    \ 'S'  : 'sl',
    \ '^S' : 'sb',
    \ 'i'  : 'i',
    \ 'R'  : 'r',
    \ 'Rv' : 'vr',
    \ 'c'  : 'cmd',
    \ 'cv' : 'vim ex',
    \ 'ce' : 'ex',
    \ 'r'  : 'p',
    \ 'rm' : 'm',
    \ 'r?' : '?',
    \ '!'  : 'sh',
    \ 't'  : 't'
    \ }

function! CurrentMode() abort
    let l:modecurrent = mode()
    " use get() -> fails safely, since ^V doesn't seem to register
    " 3rd arg is used when return of mode() == 0, which is case with ^V
    " thus, ^V fails -> returns 0 -> replaced with 'V Block'
    let l:modelist = tolower(get(g:currentmode, l:modecurrent, 'vb'))
    let l:current_status_mode = l:modelist
    return l:current_status_mode
endfunction

function! PasteMode()
    let paste_status = &paste
    if paste_status == 1
        return "paste"
    else
        return ""
    endif
endfunction

function! CocCustomStatus() abort
    let info = get(b:, 'coc_diagnostic_info', {})
    if empty(info)
        return ''
    endif
    let msgs = []
    if get(info, 'error', 0)
        call add(msgs, 'E' . info['error'])
    endif
    if get(info, 'warning', 0)
        call add(msgs, 'W' . info['warning'])
    endif
    return join(msgs, " ")." ". get(g:, "coc_status", "")
endfunction

function! ActiveStatus()
    let statusline="%=%#Inactive# %{CocCustomStatus()}"
    let statusline.="  %#CustomFile# %f %M %r"
    let statusline.="  %#CustomPercentage# %3p%%"
    let statusline.="  %#CustomFiletype# ".tolower(&ft)
    let statusline.="  %#CustomGitBranch# "."%{fugitive#head()!=''?fugitive#head():''}"
    let statusline.="  %#CustomMode# %{CurrentMode()}\%-6{PasteMode()} "
    return statusline
endfunction

function! InactiveStatus()
    let statusline="%=%#Inactive#"
    let statusline.="  %f %M %r %3p%% "
    return statusline
endfunction

set laststatus=2
set noshowmode
set statusline=%!ActiveStatus()

augroup status
    autocmd!
    autocmd BufEnter,WinEnter,SessionLoadPost * setlocal statusline=%!ActiveStatus()
    autocmd BufLeave,WinLeave * setlocal statusline=%!InactiveStatus()
augroup END

"" Tab line

fu! TabLine()
    let s = ''
    for i in range(tabpagenr('$'))
        " select the highlighting
        if i + 1 == tabpagenr()
            let s .= '%#TabLineSel#'
        else
            let s .= '%#TabLine#'
        endif

        " set the tab page number (for mouse clicks)
        let s .= '%' . (i + 1) . 'T'

        " the label is made by MyTabLabel()
        let s .= ' %{MyTabLabel(' . (i + 1) . ')} '
    endfor

    " after the last tab fill with TabLineFill and reset tab page nr
    let s .= '%#TabLineFill#%T'

    " right-align the label to close the current tab page
    if tabpagenr('$') > 1
        let s .= '%=%#TabLine#%999Xclose'
    endif

    return s
endfunction

fu! TabLabel(n)
    let buflist = tabpagebuflist(a:n)
    let winnr = tabpagewinnr(a:n)
    return bufname(buflist[winnr - 1])
endfunction

hi TabLine cterm=bold ctermfg=1 guifg=1 ctermbg=NONE guibg=NONE
hi TabLineFill cterm=bold ctermfg=8 guifg=8 ctermbg=NONE guibg=NONE
hi TabLineSel cterm=bold ctermfg=15 guifg=15 ctermbg=NONE guibg=NONE
