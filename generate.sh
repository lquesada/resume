#!/bin/bash
xelatex resume.tex
ADD=$(cat << EOM | tr -d '\n'
<title>Luis Quesada Torres - Resume<\\/title>
<link rel="shortcut icon" type="image\\/png" href="\\/favicon.png"\\/>
EOM
)

alias pdf2htmlEX='docker run -ti --rm -v `pwd`:/pdf bwits/pdf2htmlex pdf2htmlEX'
pdf2htmlEX --decompose-ligature 1 --zoom 1.5 --hdpi 600 --vdpi 600 --process-outline 0 resume.pdf
cat resume.html | sed s/'<head>'/"<head>$ADD"/ > tmp.html
mv -f tmp.html resume.html
rm -f resume.aux resume.log resume.out
mv -f resume.html index.html
