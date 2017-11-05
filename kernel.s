; Kerry the Kernel 0.01 written by Safal Aryal


 BITS 16     ; tell nasm we're working in 16 bit real mode

start:          ; entry symbol for the kernel
        
        mov si, text_string     ; put our string position into SI
        call write_string       ; call our string-printing function
        mov si, text_string_tutorial

        cli                     ; jump here for an infinite loop
        hlt

        text_string db 'Kerry the Kernel version 0.01. Type `help` for a list of commands', 0xA, 0xD
        text_string_tutorial db '>'
  
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

