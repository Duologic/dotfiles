function! RandNum() abort
  return str2nr(matchstr(reltimestr(reltime()), '\.\zs\d*'))
endfunction

function! RandChar() abort
  return nr2char((RandNum() % 63) + 33)
endfunction

function! Password() abort
  return join(map(range(12), 'RandChar()'), '')
endfunction

function! SimplePassword()
    " List containing the characters to use in the random string:
    let characters = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '0', 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z', 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z',]

    " Generate the random string
    let replaceString = ""
    for i in range(1, 12)
        let index = GetRandomInteger() % len(characters)
        let replaceString = replaceString . characters[index]
    endfor

    " Do the substitution
    return replaceString

endfunction

function! GetRandomInteger()
    if has('win32')
        return system("echo %RANDOM%")
    else
        return system("echo $RANDOM")
    endif
endfunction
