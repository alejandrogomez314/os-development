;
; Read some sectors from the boot disk using our disk_read fn
; 

[org 0x7c00]
  mov [BOOT_DRIVE], dl      ; BIOS stores our boot drive in DL, so 
                            ; best to save for later
  mov bp, 0x8000            ; Set stack safely out of the way
  mov sp, bp

  mov bx, 0x9000            ; Load 5 sectors to 0x0000(ES):0x9000(BX)
  mov dh, 5
  mov dl, [BOOT_DRIVE]
  call disk_load

  mov dx, [0x9000]          ; Print first loaded word
  call print_hex

  mov dx, [0x9000 + 512]    ; Print first word from 2nd loaded sector.
  call print_hex 

  jmp $

%include "print_string.asm"
%include "print_hex.asm"
%include "load_n_sectors_from_disk.asm"

; Global variables
BOOT_DRIVE: db 0

; Bootsector padding
times 510-($-$$) db 0
dw 0xaa55

; Add a few more sectors to prove we are loading from disk now
times 256 dw 0xdada
times 256 dw 0xface

