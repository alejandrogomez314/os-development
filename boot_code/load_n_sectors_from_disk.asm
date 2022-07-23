;
; this program loads n NH sectors to ES:BX from drive DL
;

disk_load:
  push dx       ; Store for later recall of how nay sectors were request
                ; to be read
  mov ad, 0x02  ; BIOS read sector fn
  mov al, dh    ; Read DH sectors
  mov ch, 0x00  ; Select cylinder 0
  mov dh, 0x00  ; Select head 0 
  mov ccl, 0x02 ; Start reading from second sector
  int 0x13      ; BIOS interrupt

  jc disk_error

  pop dx        
  cmp dh, al    ; If AL (sectors read) != DH (sectors expected)
  jne disk_error; display error message.
  ret

disk_error:
  mov bx, DISK_ERROR_MSG
  call print_string
  jmp $

; Variables
DISK_ERROR_MSG db "Disk read error!", 0

