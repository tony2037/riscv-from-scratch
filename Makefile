CC = riscv64-unknown-elf-gcc
CFLAGS = -O0 -g

src = add.c
kernel = kernel

kernel: add.c
	$(CC) $(CFLAGS) $< -o kernel

.PHONY: clean
clean:
	$(RM) kernel

.PHONY: emulate
emulate:
	qemu-system-riscv64 -machine virt -m 128M -gdb tcp::1234 -kernel kernel

.PHONY: device-tree
device-tree:
	dtcdtc -I dtb -O dts -o riscv64-virt.dts riscv64-virt.dtb
