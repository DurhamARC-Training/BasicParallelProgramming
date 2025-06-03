export PATH := $(PWD):$(PATH)
FFLAGS := -O3
LDFLAGS := -O3

pi: pi.f90
	mpif90 -o pi_intermediate.o -c pi.f90 $(FFLAGS)
	mpif90 pi_intermediate.o -o pi $(LDFLAGS)
	rm -rf *.o

all:
	make pi

clean:
	rm -rf pi
