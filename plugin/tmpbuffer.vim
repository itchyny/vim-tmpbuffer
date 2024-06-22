" =============================================================================
" Filename: plugin/tmpbuffer.vim
" Author: itchyny
" License: MIT License
" Last Change: 2024/06/22 20:50:39.
" =============================================================================

if exists('g:loaded_tmpbuffer') || v:version < 800
  finish
endif
let g:loaded_tmpbuffer = 1

let s:save_cpo = &cpo
set cpo&vim

command! -bar -bang -nargs=+ Tmpbuffer call tmpbuffer#start(<bang>0, <q-args>)

let &cpo = s:save_cpo
unlet s:save_cpo
