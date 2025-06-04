export PATH := $(PWD):$(PATH)
CFLAGS := -O3
LDFLAGS := -O3

simple-example: simple-example.c
	mpicc -o simple_example_intermediate.o -c simple-example.c $(CFLAGS)
	mpicc simple_example_intermediate.o -o simple-example $(LDFLAGS)
	rm -rf *.o

all:
	make simple-example

clean:
	rm -rf simple-example