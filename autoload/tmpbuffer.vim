" =============================================================================
" Filename: autoload/tmpbuffer.vim
" Author: itchyny
" License: MIT License
" Last Change: 2015/12/08 08:50:32.
" =============================================================================

let s:save_cpo = &cpo
set cpo&vim

function! tmpbuffer#start(args) abort
  if len(a:args) < 1
    return
  endif
  let cmd = a:args[0]
  let usesystem = cmd !~# '^:' && (executable(cmd) || !exists(':' . substitute(cmd, '^:*', '', 'g')))
  if !get(b:, 'tmpbuffer') && ((&filetype !=# '') || &modified || bufname('') !=# '')
    vnew
  endif
  let b:tmpbuffer = 1
  let command = usesystem ? 'echo system(' . string(join(a:args)) . ')' : join(a:args)
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
