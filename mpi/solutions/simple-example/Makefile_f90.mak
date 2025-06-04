export PATH := $(PWD):$(PATH)
FFLAGS := -O3
LDFLAGS := -O3

simple-example: simple-example.f90
	mpif90 -o simple_example_intermediate.o -c simple-example.f90 $(FFLAGS)
	mpif90 simple_example_intermediate.o -o simple-example $(LDFLAGS)
	rm -rf *.o

all:
	make simple-example

clean:
