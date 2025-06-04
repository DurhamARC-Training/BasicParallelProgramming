export PATH := $(PWD):$(PATH)
CFLAGS := -pthread -fopenmp
LDFLAGS = -fopenmp -lpthread -O3 

taskDemo: taskDemo.c
	gcc -o intermediate.o -c taskDemo.c $(CFLAGS)
	gcc intermediate.o -o taskDemo $(LDFLAGS)
	rm -rf *.o

all:
	make taskDemo

clean:
	rm -rf taskDemo