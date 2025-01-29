export PATH := $(PWD):$(PATH)
CFLAGS := -pthread -fopenmp
LDFLAGS = -fopenmp -lpthread -O3 

picalc: factorial.c
	gcc -o intermediate.o -c factorial.c $(CFLAGS)
	gcc intermediate.o -o factorial.exe $(LDFLAGS)
	rm -rf *.o

all:
	make factorial

clean:
	rm -rf *.exe