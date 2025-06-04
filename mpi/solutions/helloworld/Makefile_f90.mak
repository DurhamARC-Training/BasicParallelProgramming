export PATH := $(PWD):$(PATH)
FFLAGS := -O3
LDFLAGS := -O3

helloworld: helloworld.f90
	mpif90 -o helloworld_intermediate.o -c helloworld.f90 $(FFLAGS)
	mpif90 helloworld_intermediate.o -o helloworld $(LDFLAGS)
	rm -rf *.o

all:
	make helloworld

clean:
