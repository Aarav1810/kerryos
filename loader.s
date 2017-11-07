; Mao Mao Loader version 0.01 written by Safal Aryal


    BITS 16     ; tell nasm we're working in 16 bit real mode

start:          ; entry symbol for the os          

        mov ax, 0x07C0          ; 4 kilobyte stack space set up
        add ax, 288             ; (4096+512) / 16 bytes per paragraph
        mov ss, ax              
        mov sp, 4096

        mov ax, 0x07C0          ; set data segment to where we've loaded
        mov ds, ax
        
        call clear_screen
        mov si, loadmsg         ; put our string position into SI
        call write_string       ; call our string printing routine
        
        jmp load_kernel

        cli                     ; jump here for an infinite loop
        hlt

        loadmsg db 'Loading KERNEL.BIN...', 0xA, 0xD, 0

write_string:                   ; output string located in si
    mov ah, 0xE                 ; the 'print char' function of int 0x10
.repeat:                
    lodsb                       ; get character from the string
    cmp al, 0                   ; check if it is zero   
    je .done                    ; if it is, jump to .done and finish the function
    int 10h                     ; call interrupt 10h    
    jmp .repeat                 ; repeat for every char in the string
.done:                  
    ret

clear_screen:
    pusha
    mov ah, 0x00
    
    mov al, 0x03
    int 0x10
    popa
    ret

load_kernel:
    mov ah, 0x02                ; call function 0x02 of int 13h (read sectors)
    mov al, 0x01                ; read one sector (512 bytes)
    mov ch, 0x00                ; track 0
    mov cl, 0x02                ; sector 2
    mov dh, 0x00                ; head 0
    mov dl, 0x00                ; drive 0, floppy 1
    mov bx, 0x2000              ; segment 0x2000
    mov es, bx                  ; segments must be loaded from non immediate data
    mov bx, 0x0000              ; start of segment -offset value
.readsector:
    int 13h                     ; call int 13h
    jc .readsector              ; error? try again

    mov ax, 0x2000              ; set the data segment register
    mov ds, ax                  ; as a pointer to the kernel's memory location

    jmp 0x2000:0x0000           ; jump to the kernel


reboot:
    db 0x0ea
    dw 0x0000   
    dw 0xffff

    times 510-($-$$) db 0       ; pad boot sector with zeroes
    dw 0xAA55                   ; standa;TODO: start writing kernel after here, and eventually move it to another file
