TARGET = main test_unit.o
LIBS = -lbfd -lz -liberty
# LIBS = -l:libiberty.a -l:libz.a -l:libbfd.a
CC = gcc
CFLAGS = -fPIE -g
# -g -Wall

.PHONY: default all clean

default: $(TARGET) test_unit
all: default

%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

test_unit: test_unit.o
	$(CC) --shared -static-libgcc -Wl,-Bstatic -lc $(CFLAGS) $^ -o $@

main: main.o
	$(CC) $(CFLAGS) $^ -o $@ $(LIBS) 

clean:
	-rm -f *.o
	-rm -f $(TARGET)
	
	
# gcc -c test_unit.c -T simple_obj.ld -o test_unit.o -nostdlib -nostartfiles -nodefaultlibs	
# objcopy --remove-section .eh_frame --remove-section .comment --remove-section .note.GNU-stack test_unit.o test_unit.o