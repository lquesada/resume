#!/bin/bash
ADD=$(cat << EOM | tr -d '\n'
<title>Luis Quesada - Resume<\\/title>
<link rel="shortcut icon" type="image\\/png" href="favicon.png"\\/>
EOM
)
alias pdf2htmlEX='~/bin/pdf2htmlEX.AppImage'

xelatex resume.tex
pdf2htmlEX --decompose-ligature 1 --font-size-multiplier 20 --zoom 2 --process-outline 0 resume.pdf
cat resume.html | sed -e s/'<head>'/"<head>$ADD"/g -e s@'href="https://0/local/'@'href="'@g > tmp.html
mv -f tmp.html resume.html
rm -f resume.aux resume.log resume.out
mv -f resume.html index.html

cat resume.tex | sed -e s@'https://0/local/'@'https://lquesada.github.io/resume/'@g > resumepdf.tex
xelatex resumepdf.tex
rm -f resumepdf.aux resumepdf.log resumepdf.out resumepdf.tex
mv resumepdf.pdf resume.pdf
