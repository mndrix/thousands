TAG=$(shell git tag -l | tail -n 1)
DIR=/tmp/thousands-${TAG}

pack:
	rm -rf ${DIR}
	mkdir ${DIR}
	cp pack.pl ${DIR}
	mkdir ${DIR}/prolog
	cp thousands.pl ${DIR}/prolog
	tar czvf thousands-${TAG}.tgz ${DIR}
