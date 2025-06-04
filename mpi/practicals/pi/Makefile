export PATH := $(PWD):$(PATH)
CFLAGS := -O3
LDFLAGS := -O3

pi: pi.c
	mpicc -o pi_intermediate.o -c pi.c $(CFLAGS)
	mpicc pi_intermediate.o -o pi $(LDFLAGS)
	rm -rf *.o

all:
	make pi

clean:
	rm -rf pi