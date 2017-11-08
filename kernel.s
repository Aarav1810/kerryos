    BITS 16

section .data:
    STACK_SEGMENT equ 0x0050
    STACKP_OFFSET equ 4096
    INPUT_BUFFER_MAX_LEN equ 255
    INPUT_STRING: resb INPUT_BUFFER_MAX_LEN+1

section .text:
    start:
        mov ax, STACK_SEGMENT
        mov ss, ax
        mov sp, STACKP_OFFSET
        
        call prompts

        cli
        hlt

        prompt db '>>', 0
        newline db '', 0xA, 0xD, 0

    prompts:
        mov si, prompt
        call prints
        call scans
        mov si, newline
        call prints
        mov si, INPUT_STRING
        call prints
        mov si, newline
        call prints
        jmp prompts

    search:
        

    prints:
        mov ah, 0xE
    .repeat:
        lodsb
        cmp al, 0
        je .done
        int 10h
        jmp .repeat
    .done:
        ret


    scans:
            mov di,INPUT_STRING                 ; pointer of input buffer
            lea si,[di+INPUT_BUFFER_MAX_LEN]    ; pointer beyond buffer
        .repeat:
            ; check if input buffer is full
            cmp di,si
            jae .done   ; full input buffer, end input
            ; wait for key press from user, using BIOS int 16h,ah=0
            xor ah,ah   ; ah = 0
            int 0x16
            ; AL = ASCII char or zero for extended key, AH = scancode
            test al,al
            jz  .done   ; any extended key will end input
            cmp al,13
            je  .done   ; "Enter" key will end input (not stored in buffer)
            ; store the ASCII character to input buffer
            mov [di],al ; expects ds = data segment
            inc di      ; make the pointer to point to next char
            mov ah, 0xE ; print pressed ASCIII character
            int 10h     ; call function 'print char' of interrrupt 10h
            jmp .repeat ; read more chars until user presses enter
        .done:
            ; store nul-terminator and newline at the end of user input
            mov [di], byte 0
            ret
    
	

