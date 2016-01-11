" =============================================================================
" Filename: autoload/tmpbuffer.vim
" Author: itchyny
" License: MIT License
" Last Change: 2016/01/11 17:24:19.
" =============================================================================

let s:save_cpo = &cpo
set cpo&vim

function! tmpbuffer#start(bang, arg) abort
  let cmd = matchstr(a:arg, '\v^\s*(\S+)')
  if len(cmd) == 0
    return
  endif
  let usesystem = a:bang || cmd !~# '^:' && (executable(cmd) || !exists(':' . substitute(cmd, '^[: ]*', '', 'g')))
  if !get(b:, 'tmpbuffer') && ((&filetype !=# '') || &modified || bufname('') !=# '')
    vnew
  endif
  let b:tmpbuffer = 1
  let command = usesystem ? 'echo system(' . string(a:arg) . ')' : a:arg
  redir => out
    execute 'silent!' command
  redir END
  silent! % delete _
  silent! $ put=out
  silent! 1,2 delete _
  setlocal filetype= buftype=nofile bufhidden=wipe noswapfile nobuflisted
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
