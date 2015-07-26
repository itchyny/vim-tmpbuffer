" =============================================================================
" Filename: plugin/tmpbuffer.vim
" Author: itchyny
" License: MIT License
" Last Change: 2015/07/27 06:04:49.
" =============================================================================

if exists('g:loaded_tmpbuffer') || v:version < 700
  finish
endif
let g:loaded_tmpbuffer = 1

let s:save_cpo = &cpo
set cpo&vim

command! -bar -nargs=+ Tmpbuffer call tmpbuffer#start([<f-args>])

let &cpo = s:save_cpo
unlet s:save_cpo
