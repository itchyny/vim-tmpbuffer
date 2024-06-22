" =============================================================================
" Filename: autoload/tmpbuffer.vim
" Author: itchyny
" License: MIT License
" Last Change: 2024/06/22 21:18:26.
" =============================================================================

let s:save_cpo = &cpo
set cpo&vim

function! tmpbuffer#start(bang, args) abort
  let first_arg = matchstr(a:args, '\v^\s*(\S+)')
  let use_system = a:bang || first_arg[0] !=# ':' &&
        \ (executable(first_arg) || !exists(':' . first_arg))
  let output = use_system ? system(a:args) : execute(a:args)
  if bufname('') !=# '' || &modified | vnew | endif
  silent % delete _
  call setline(1, split(output, '\n'))
  setlocal filetype= buftype=nofile bufhidden=wipe noswapfile nobuflisted
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
