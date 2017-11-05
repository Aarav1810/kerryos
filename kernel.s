    BITS 16
start:
    mov si, welcome_msg
    call write_string
    
    cli
    hlt

    welcome_msg db 'Welcome to KerryOS', 0xA, 0xD

write_string:
    mov ah, 0xE
.repeat:
    lodsb
    cmp al, 0
    je .done
    int 10h
    jmp .repeat
.done:
    ret


