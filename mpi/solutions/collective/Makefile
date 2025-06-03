export PATH := $(PWD):$(PATH)
CFLAGS := -O3
LDFLAGS := -O3

collective: collective.c
	mpicc -o collective_intermediate.o -c collective.c $(CFLAGS)
	mpicc collective_intermediate.o -o collective $(LDFLAGS)
	rm -rf *.o

all:
	make collective

clean:
	rm -rf collective