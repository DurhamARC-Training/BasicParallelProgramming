export PATH := $(PWD):$(PATH)
FFLAGS := -fopenmp -fsanitize=thread -O1 -g
LDFLAGS = -fopenmp -fsanitize=thread
FC := gfortran

sumToTen: sumTo10.f90
	$(FC) -o sumToTen_intermediate.o -c sumTo10.f90 $(FFLAGS)
	$(FC) sumToTen_intermediate.o -o sumToTen $(LDFLAGS)
	rm -rf *.o

clean:
	rm -rf sumToTen

# warning - linux kernel changes mean you might have to call sudo sysctl vm.mmap_rnd_bits=28
# before it will let you run the sanitizer...