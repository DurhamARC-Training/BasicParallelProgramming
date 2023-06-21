export PATH := $(PWD):$(PATH)
CFLAGS := -pthread -fopenmp
LDFLAGS = -fopenmp -lpthread -O3

sumToTen: sumToTen.c
	gcc -o intermediate.o -c sumTo10.c $(CFLAGS)
	gcc intermediate.o -o sumToTen.exe $(LDFLAGS)
	rm -rf *.o

fiveFactorial: 

clean:
	rm -rf *.exe