TARGET = riscv64-unknown-elf
CC     = $(TARGET)-gcc
GDB    = $(TARGET)-gdb
EMU    = qemu-system-riscv64

CFLAGS = -march=rv64gc -mabi=lp64d -static -mcmodel=medany -fvisibility=hidden -nostdlib -nostartfiles -g -Wall -Wextra
ifeq ($(CC),clang)
	CFLAGS += -target $(TARGET) -mno-relax -Wno-unused-command-line-argument
endif

CODE = ./

EFLAGS = -machine virt -cpu rv64 -bios opensbi-riscv64-generic-fw_dynamic.bin -m 256m -smp 1 -s -nographic
ifdef WAIT_GDB
	EFLAGS += -S
endif

.PHONY: all clean run gdb

all: $(CODE)*.s
	$(CC) $(CFLAGS) -Tforth.ld $? -o forth.elf

clean:
	-rm *.elf

run:
	$(EMU) $(EFLAGS) -kernel forth.elf

gdb:
	$(GDB) -q -x forth.gdb
