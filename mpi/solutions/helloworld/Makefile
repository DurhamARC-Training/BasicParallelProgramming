export PATH := $(PWD):$(PATH)
CFLAGS := -O3
LDFLAGS := -O3

helloworld: helloworld.c
	mpicc -o helloworld_intermediate.o -c helloworld.c $(CFLAGS)
	mpicc helloworld_intermediate.o -o helloworld $(LDFLAGS)
	rm -rf *.o

all:
	make helloworld

clean:
	rm -rf helloworld