export PATH := $(PWD):$(PATH)
CFLAGS := -pthread -fopenmp
LDFLAGS = -fopenmp -lpthread -O3 

mandel: mandel.c mandel.h
	gcc -o intermediate.o -c mandel.c $(CFLAGS)
	gcc intermediate.o -o mandel $(LDFLAGS)
	rm -rf *.o

mandelParallel: mandelParallel.c
	gcc -o intermediate.o -c mandelParallel.c $(CFLAGS)
	gcc intermediate.o -o mandelParallel $(LDFLAGS)
	rm -rf *.o

mandelTask: mandelTask.c
	gcc -o intermediate.o -c mandelTask.c $(CFLAGS) -g
	gcc intermediate.o -o mandelTask $(LDFLAGS)
	rm -rf *.o

all:
	make mandel 
	make mandelParallel
	make mandelTask

clean:
	rm -rf mandel mandelParallel mandelTask