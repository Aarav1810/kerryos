    BITS 16

STACK_SEGMENT equ 0x0050
STACKP_OFFSET equ 4096

start:
    mov ax, STACK_SEGMENT
    mov ss, ax
    mov sp, STACKP_OFFSET
    
    mov si, bootmsg
    call print
    mov si, prompt

    cli
    hlt

    bootmsg db 'Welcome to KerryOS v0.01', 0xA, 0xD
    prompt db '>>'

print:
    mov ah, 0xE
.repeat:
    lodsb
    cmp al, 0
    je .done
    int 10h
    jmp .repeat
.done:
    ret

scan:
    mov ah, 0x00
