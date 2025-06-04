export PATH := $(PWD):$(PATH)
FFLAGS := -fopenmp
LDFLAGS = -fopenmp -O3 

taskDemo: taskDemo.f90
	gfortran -o taskDemo_intermediate.o -c taskDemo.f90 $(FFLAGS)
	gfortran taskDemo_intermediate.o -o taskDemo $(LDFLAGS)
	rm -rf *.o

all:
	make taskDemo

clean:
	rm -rf taskDemo