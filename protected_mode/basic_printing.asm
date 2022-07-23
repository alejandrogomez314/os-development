;
; Program that demonstrates basic VGA mode printing in 16-bit protected mode.
;

[bits 32]
; Constants
VIDEO_MEMORY equ 0xb8000
WHITE_ON_BLACK equ 0x0f

; prints a null-terminated string pointed to by EDX
print_string_pm:
  pusha
  mov edx, VIDEO_MEMORY       ; Set edx to start of vid memory

print_string_pm_loop:
  mov al, [ebx]               ; Store the char at EBX in AL
  mov ah, WHITE_ON_BLACK      ; Store text attribute on AH

  cmp al, 0                   ; if al == 0 then end of string.
  je done

  mov [edx], ax               ; else store char and attribute at curr char cell.
  add ebx, 1                  ; Increment EBX to next char in string
  add edx, 2                  ; Move to next char cell in video memory

  jmp print_string_pm_loop    ; Loop to print next char.

print_string_pm_done:
  popa
  ret  

done:
  jmp $
