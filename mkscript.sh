#!/bin/bash
if [ ! -e $1 ]; then
	touch $1;sudo chmod +x $1;echo "#!/bin/bash" > $1;vim $1
else
	vim $1
fi
