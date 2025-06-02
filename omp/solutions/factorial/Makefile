export PATH := $(PWD):$(PATH)
CFLAGS := -pthread -fopenmp
LDFLAGS = -fopenmp -lpthread -O3 

factorial: factorial.c
	gcc -o intermediate.o -c factorial.c $(CFLAGS)
	gcc intermediate.o -o factorial $(LDFLAGS)
	rm -rf *.o

all:
	make factorial

clean:
	rm -rf factorial