# ebpf-programs/c/Makefile

BPF_SRC = abnormal_traffic.c
BPF_OBJ = $(BPF_SRC:.c=.o)

KERNEL_HEADERS = /usr/lib/modules/$(uname -r)/build
CFLAGS = -O2 -target bpf -I$(KERNEL_HEADERS)/include -I$(KERNEL_HEADERS)/include/uapi -I$(KERNEL_HEADERS)/arch/x86/include -I$(KERNEL_HEADERS)/arch/x86/include/uapi -I/usr/include

all: $(BPF_OBJ)

%.o: %.c
	clang $(CFLAGS) -c $< -o $@

clean:
	rm -f $(BPF_OBJ)
