export PATH := $(PWD):$(PATH)
FFLAGS := -O3
LDFLAGS := -O3

pingpong: pingpong.f90
	mpif90 -o pingpong_intermediate.o -c pingpong.f90 $(FFLAGS)
	mpif90 pingpong_intermediate.o -o pingpong $(LDFLAGS)
	rm -rf *.o

all:
	make pingpong

clean:
