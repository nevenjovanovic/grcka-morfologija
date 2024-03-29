#!/usr/bin/env bash
# makebookandsync.sh, 2019-04-06
# apply xelatex; join with title page; rsync result to Dropbox
# usage: ./makebookandsync.sh 1

set -o errexit
set -o pipefail
set -o nounset

NUMBER=$1

# Change directory context

cd ../../citanka

# Run xelatex on file
latexmk -xelatex grc_morf_0"${NUMBER}"_citanka_2018-1.tex

# Run pdftk on files

pdftk A=naslovnica"${NUMBER}".pdf B=grc_morf_secondpage"${NUMBER}".pdf C=main"${NUMBER}".pdf D=texput.pdf E=grc_morf_0"${NUMBER}"_citanka_2018-1.pdf cat A B1 C D E2-end output citankagrcmorf0"${NUMBER}".pdf

# Run rsync on result

rsync -avz citankagrcmorf0"${NUMBER}".pdf  /home/neven/Documents/grc-dropbox/grc_morf_0"${NUMBER}"_citanka_2018-1.pdf
