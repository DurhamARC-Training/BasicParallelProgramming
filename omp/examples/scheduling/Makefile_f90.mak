export PATH := $(PWD):$(PATH)
FFLAGS := -fopenmp
LDFLAGS = -fopenmp -O3

schedule: schedule.f90
	gfortran -o schedule_intermediate.o -c schedule.f90 $(FFLAGS)
	gfortran schedule_intermediate.o -o schedule $(LDFLAGS)
	rm -rf *.o

clean:
	rm -rf schedule