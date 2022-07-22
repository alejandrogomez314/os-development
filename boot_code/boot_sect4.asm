;
; A simple boot sector program that demonstrates the stack
;

mov ah, 0x0e

mov bp, 0x8000  ; Set the base of the stack above where the BIOS loads
                ; the boot sector.
mov sp, bp

push 'A'
push 'B'
push 'C'

pop bx
mov al, bl
int 0x10        ; Print al.

pop bx          ; Pop the next value.
mov al, bl
int 0x10

mov al, [0x7ffe]; To prove our stack grows downward from bp, fetch
                ; the char at 0x8000-0x2 (16-bits) 
int 0x10

jmp $

; Padding
times 510-($-$$) db 0
dw 0xaa55
