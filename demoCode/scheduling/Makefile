export PATH := $(PWD):$(PATH)
CFLAGS := -pthread -fopenmp
LDFLAGS = -fopenmp -lpthread -O3

schedule: schedule.c
	gcc -o intermediate.o -c schedule.c $(CFLAGS)
	gcc intermediate.o -o schedule.exe $(LDFLAGS)
	rm -rf *.o

# fiveFactorial: 

clean:
	rm -rf *.exe