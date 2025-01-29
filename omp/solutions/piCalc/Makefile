export PATH := $(PWD):$(PATH)
CFLAGS := -pthread -fopenmp
LDFLAGS = -fopenmp -lpthread -O3 

picalc: picalc.c
	gcc -o intermediate.o -c picalc.c $(CFLAGS)
	gcc intermediate.o -o picalc.exe $(LDFLAGS)
	rm -rf *.o

all:
	make picalc

clean:
	rm -rf *.exe