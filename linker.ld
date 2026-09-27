ENTRY(kernel_main)
OUTPUT_FORMAT("binary")

SECTIONS
{
    . = 0x1000; /* Expect the kernel to be loaded here */

    .text : {
        *(.text)
    }
    .data : {
        *(.data)
    }
    .bss : {
        *(.bss)
    }
}