;
; A function that prints strings
;

print_string:
  pusha           ; Save registers by pushing into the stack.
  mov ah, 0x0e    ; Put BIOS teletype on ah.
  jmp loop  

loop:
  cmp al, 0       ; Check if we have reached end of string.  
  je end          ; If we reach end of string, go to end, otherwise continue printing.
  jmp print_char

end:
  popa            ; Else, pop back data saved on stack back to register. 
  ret 

print_char:
  mov al, [bx]    ; Move content of memory address in bx (the message) to al. 
  int 0x10        ; Trigger interrupt to print.
  add bx, 1       ; Increment memory address of bx by 1 to get next char.
  jmp loop
