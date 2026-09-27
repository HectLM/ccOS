[bits 16]
[org 0x7c00]

; 1. Entry Point
    cli                     ; Clear interrupts
    mov ax, 0x00
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov sp, 0x7c00          ; Set up a temporary stack

; 2. Switch to 32-bit Protected Mode
    lgdt [gdt_descriptor]   ; Load Global Descriptor Table
    mov eax, cr0
    or eax, 0x1
    mov cr0, eax            ; Set protected mode bit
    jmp CODE_SEG:init_32bit ; Far jump to clear prefetch queue

[bits 32]
init_32bit:
    mov ax, DATA_SEG
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    mov ss, ax
    mov ebp, 0x90000        ; Set up a stable 32-bit stack
    mov esp, ebp

    extern kernel_main
    call kernel_main        ; Jump to your C code
    jmp $                   ; Infinite loop if kernel returns

; Global Descriptor Table (GDT) Setup
gdt_start:
gdt_null: 
    dd 0x0, 0x0
gdt_code: 
    dw 0xffff, 0x0, 0x9a00, 0xcf
gdt_data: 
    dw 0xffff, 0x0, 0x9200, 0xcf
gdt_end:

gdt_descriptor:
    dw gdt_end - gdt_start - 1
    dd gdt_start

CODE_SEG equ gdt_code - gdt_start
DATA_SEG equ gdt_data - gdt_start

times 510-($-$$) db 0       ; Pad remaining bytes with zeroes
dw 0xaa55                   ; Boot signature