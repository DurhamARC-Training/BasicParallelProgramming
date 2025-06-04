export PATH := $(PWD):$(PATH)
FFLAGS := -fopenmp
LDFLAGS = -fopenmp -O3 

mandel: mandel.f90
	gfortran -o mandel_intermediate.o -c mandel.f90 $(FFLAGS)
	gfortran mandel_intermediate.o -o mandel $(LDFLAGS)
	rm -rf *.o

mandelParallel: mandelParallel.f90
	gfortran -o mandelParallel_intermediate.o -c mandelParallel.f90 $(FFLAGS)
	gfortran mandelParallel_intermediate.o -o mandelParallel $(LDFLAGS)
	rm -rf *.o

mandelTask: mandelTask.f90
	gfortran -o mandelTask_intermediate.o -c mandelTask.f90 $(FFLAGS) -g
	gfortran mandelTask_intermediate.o -o mandelTask $(LDFLAGS)
	rm -rf *.o

all:
	make mandel 
	make mandelParallel
	make mandelTask

clean:
	rm -rf mandel mandelParallel mandelTask