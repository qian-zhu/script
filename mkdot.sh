#!/bin/bash
NAME=$(echo "$1" | sed 's/\..*//g')
dot -Tpng $1 -o $NAME.png ;eog $NAME.png
