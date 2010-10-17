" From http://got-ravings.blogspot.com/2008/07/vim-pr0n-visual-search-mappings.html

" makes * and # work on visual mode too.
function! s:VSetSearch()
  let temp = @s
  norm! gv"sy
  let @/ = '\V' . substitute(escape(@s, '\'), '\n', '\\n', 'g')
  let @s = temp
endfunction

function! visual_search#GrepCurrentWord()
  let search = substitute(escape(expand('<cword>'), '\'), '\n', '\\n', 'g')
  execute 'noautocmd vimgrep /'.search.'/ **'
  copen
endfunction

function! visual_search#GrepSelection()
  call <SID>VSetSearch()
  execute 'noautocmd vimgrep /'.@/.'/ **' 
  copen
endfunction

vnoremap # :<C-u>call <SID>VSetSearch()<CR>:set hls<CR>
vnoremap * #

" recursively vimgrep for word under cursor or selection if you hit leader-star
nmap <leader>* :<C-u>call visual_search#GrepCurrentWord()<CR>
vmap <leader>* :<C-u>call visual_search#GrepSelection()<CR>
