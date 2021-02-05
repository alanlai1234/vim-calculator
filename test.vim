"maintainer : Alan Lai(lai.abc8660@gmail.com)
"last change : 2021/1/28

if exists("g:loaded_vimcalculator")
	finish
endif
let g:loaded_vimcalculator = 1

if !hasmapto("<Plug>calc_launch")
	map <unique> <leader>m <Plug>calc_launch
endif

function s:power(n2)
	if a:n2 == 0
		return 1
	endif
	let tmp = 10
	for i in range(a:n2-1)
		let tmp *= 10
	endfor
	return tmp
endfunction

function s:docalc(a, b, o)
	if a:o == '+'
		return a:a+a:b
	elseif a:o == '-'
		return a:a-a:b
	elseif a:o == '/'
		return a:a/a:b
	elseif a:o == '*'
		return a:a*a:b
	endif
endfunction

function s:solve(n, o)
	if len(o) == 1
		return s:docalc(n[0], n[1], o[0])
	endif

	for i in a:n

	endfor
	
endfunction

function s:launch()
	let in = input("calculator>>")
	if in == ""
		return
	endif
	let s:charnum = []
	let res = 0
	let s:num = []
	let s:op = []

	for n in split(a:in, '\zs')
		if (char2nr(n)>=char2nr("0")) && (char2nr(n)<=char2nr("9"))
			let s:charnum = add(s:charnum, char2nr(n)-char2nr("0"))
		else
			let s:tmp = 0
			for i in range(len(s:charnum))
				let s:tmp += s:power(i)*s:charnum[len(s:charnum)-i-1]
			endfor

			let s:num = add(s:num, s:tmp)
			if len(s:op) > 0 && n != '/' && n != '*'
				s:solve(s:num, s:op)
			endif
			let s:charnum = []
			let s:op = add(s:op, n)
		endif
	endfor
endfunction
nnoremap <unique> <script> <Plug>calc_launch :call <SID>launch()<CR>
