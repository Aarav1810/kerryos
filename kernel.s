    BITS 16

start:
    mov ah, 0xE
    mov al, 'A'
    int 10h

    cli
    hlt

