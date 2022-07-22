; A simple boot sector program that demonstrates addressing.
mov ah, 0x0e ; scrolling teletype BIOS routing

;mov bx, the_secret
;add bx, 0x7c00
;mov al, [bx]
int 0x10

jmp $

the_secret:
 db "X"

; Padding and magic BIOS number.
 times 510-($-$$) db 0
 dw 0xaa55
