if exists("g:loaded_vimcalculator")
	finish
endif
let g:loaded_vimcalculator = 1

if !has('python3')
    echo "Error: Required vim/neovim with python support"
    finish
endif

if !hasmapto("<Plug>calc_launch")
	map <unique> <leader>m <Plug>calc_launch
endif
nnoremap <unique> <script> <Plug>calc_launch :call <SID>Launch()<CR>

"init python
let s:plugin_root_dir = fnamemodify(resolve(expand('<sfile>:p')), ':h')

:py3 << EOF
import sys
from os.path import normpath, join
import vim
plugin_root_dir = vim.eval('s:plugin_root_dir')
python_root_dir = normpath(join(plugin_root_dir, '..', 'python'))
sys.path.insert(0, python_root_dir)
import main
EOF

function s:Launch()
	py3 main.launch()
endfunction
