export PATH := $(PWD):$(PATH)
FFLAGS := -fopenmp
LDFLAGS = -fopenmp -O3 

picalc: picalc.f90
	gfortran -o picalc_intermediate.o -c picalc.f90 $(FFLAGS)
	gfortran picalc_intermediate.o -o picalc $(LDFLAGS)
	rm -rf *.o

all:
	make picalc

clean:
	rm -rf picalc