#!/bin/sh

! which typst > /dev/null && printf "Error: typst not found\n" && exit

if [ ! -d build ]
then
    mkdir build
fi

FORMATS="a4 us-letter"
THEME=standard
PREGEN=empty
# PREGEN=demo
LANGFILES=i18n/*.typ

while getopts "p:t:" option; do
    case "$option" in
        p)
            if [ -f "pregen/$OPTARG.typ" ]
            then
                PREGEN=$OPTARG
            fi
            ;;
        t)
            if [ -f "theme/$1.typ" ]
            then
                THEME=$OPTARG
            fi
            ;;
        *)
            #usage
            ;;
    esac
done

for LANGFILE in $LANGFILES
do
    CC=`echo $LANGFILE| sed 's/i18n\/\(..\)\.typ/\1/'`
    for FORMAT in $FORMATS
    do
        FILENAME="build/$THEME/$PREGEN/$CC/$FORMAT/dnd-character-sheet.$THEME.$PREGEN.$CC.$FORMAT"
        
        if [ ! -d "`dirname $FILENAME`" ]
        then
            mkdir -p "`dirname $FILENAME`"
        fi

        echo "compiling $CC $FORMAT $PREGEN $THEME pdf"
        typst compile --font-path fonts dnd-character-sheet.i18n.typ $FILENAME.pdf --input lang=$CC --input format=$FORMAT --input pregen=$PREGEN
        
        echo "compiling $CC $FORMAT $PREGEN $THEME png"
        typst compile --font-path fonts dnd-character-sheet.i18n.typ $FILENAME.{p}.png --input lang=$CC --input format=$FORMAT --input pregen=$PREGEN --format png
        
        echo "compiling $CC $FORMAT $PREGEN $THEME svg"
        typst compile --font-path fonts dnd-character-sheet.i18n.typ $FILENAME.{p}.svg --input lang=$CC --input format=$FORMAT --input pregen=$PREGEN --format svg
        
        # echo "compiling $CC $FORMAT html"
        # typst compile --font-path fonts dnd-character-sheet.i18n.typ $FILENAME.html --input lang=$CC --input format=$FORMAT --input pregen=$PREGEN --format html --features html
    done
done
