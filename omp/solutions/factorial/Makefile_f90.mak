export PATH := $(PWD):$(PATH)
FFLAGS := -fopenmp
LDFLAGS = -fopenmp -O3 

factorial: factorial.f90
	gfortran -o factorial_intermediate.o -c factorial.f90 $(FFLAGS)
	gfortran factorial_intermediate.o -o factorial $(LDFLAGS)
	rm -rf *.o

clean:
	rm -rf factorial