export PATH := $(PWD):$(PATH)
CFLAGS := -O3
LDFLAGS := -O3

pingpong: pingpong.c
	mpicc -o pingpong_intermediate.o -c pingpong.c $(CFLAGS)
	mpicc pingpong_intermediate.o -o pingpong $(LDFLAGS)
	rm -rf *.o

all:
	make pingpong

clean:
	rm -rf pingpong