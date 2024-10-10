export PATH := $(PWD):$(PATH)
CFLAGS := -pthread -fopenmp -fsanitize=thread -O1 -g -I/usr/lib/gcc/x86_64-linux-gnu/11/include/
LDFLAGS = -fopenmp -fsanitize=thread -lpthread
CC := gcc-12

sumToTen: sumTo10.c
	$(CC) -o intermediate.o -c sumTo10.c $(CFLAGS)
	$(CC) intermediate.o -o sumToTen.exe $(LDFLAGS)
	rm -rf *.o

# fiveFactorial: 

clean:
	rm -rf *.exe
