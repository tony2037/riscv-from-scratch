CC = riscv64-unknown-elf-gcc
CFLAGS = -g -ffreestanding -O0 -Wl,--gc-sections -nostartfiles -nostdlib -nodefaultlibs -Wl,-T,

src = add.c
kernel = kernel

kernel: riscv64-virt.ld crt0.s add.c
	$(CC) $(CFLAGS)$^ -o kernel

.PHONY: clean
clean:
	$(RM) kernel

.PHONY: emulate
emulate:
	qemu-system-riscv64 -machine virt -m 128M -gdb tcp::1234 -kernel kernel -bios none

.PHONY: device-tree
device-tree:
	dtcdtc -I dtb -O dts -o riscv64-virt.dts riscv64-virt.dtb

.PHONY: debugger
debugger:
	echo "target remote :1234"
	riscv64-unknown-elf-gdb kernel
