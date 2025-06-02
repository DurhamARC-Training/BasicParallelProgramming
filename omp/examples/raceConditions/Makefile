export PATH := $(PWD):$(PATH)
CFLAGS := -pthread -fopenmp -fsanitize=thread -O1 -g
LDFLAGS = -fopenmp -fsanitize=thread -lpthread
CC := gcc

sumToTen: sumTo10.c
	$(CC) -o intermediate.o -c sumTo10.c $(CFLAGS)
	$(CC) intermediate.o -o sumToTen $(LDFLAGS)
	rm -rf *.o

clean:
	rm -rf sumToTen

# warning - linux kernel changes mean you might have to call sudo sysctl vm.mmap_rnd_bits=28
# before it will let you run the sanitizer...
