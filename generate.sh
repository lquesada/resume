#!/bin/bash
xelatex resume.tex
ADD=$(cat << EOM | tr -d '\n'
<title>Luis Quesada - Resume<\\/title>
<link rel="shortcut icon" type="image\\/png" href="favicon.png"\\/>
EOM
)

alias pdf2htmlEX='docker run -ti --rm -v `pwd`:/pdf bwits/pdf2htmlex pdf2htmlEX'
pdf2htmlEX --decompose-ligature 1 --font-size-multiplier 20 --zoom 2 --hdpi 600 --vdpi 600 --process-outline 0 resume.pdf
cat resume.html | sed -e s/'<head>'/"<head>$"/ -e s@'href="https://0/local/'@'target="_blank" href="'@g > tmp.html
mv -f tmp.html resume.html
rm -f resume.aux resume.log resume.out
mv -f resume.html index.html
