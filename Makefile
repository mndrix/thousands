TAG=$(shell git tag -l | tail -n 1)
DIR=/tmp/thousands-${TAG}

pack:
	rm -rf ${DIR}
	mkdir ${DIR}
	cp pack.pl ${DIR}
	mkdir ${DIR}/prolog
	cp thousands.pl ${DIR}/prolog
	tar -czv -C /tmp -f thousands-${TAG}.tgz thousands-${TAG}
