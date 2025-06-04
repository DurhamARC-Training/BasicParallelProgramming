export PATH := $(PWD):$(PATH)
FFLAGS := -O3
LDFLAGS := -O3

collective: collective.f90
	mpif90 -o collective_intermediate.o -c collective.f90 $(FFLAGS)
	mpif90 collective_intermediate.o -o collective $(LDFLAGS)
	rm -rf *.o

all:
	make collective

clean:
	rm -rf collective
