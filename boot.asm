[BITS 16]
[ORG 0x7C00]

call start

start:
    ; Set up stack and data segments
    xor ax, ax
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov sp, 0x7C00
    mybyte dw 0x00 ; Ein Byte zur Zwischenspeicherung von Werten (Keyboard Press) 
 
    ; Display menu
    call display_menu
 
    call get_user_input

    mov [mybyte], bx

    mov al, mybyte
    mov ah, 0x0E
    int 0x10
    ;.loop:
    ;call check_exit
    ;jmp .loop
    ; Halt on error

;check_exit:
;    int 0x16
;    cmp al, 'q'
;    je .exit
;  .exit:
;    mov si, [mybyte]
;    call print_string
;
;   hlt
;    jmp $


; Display a simple text-based menu to select the kernel version
display_menu:
    mov si, menu_text
    call print_string
    ret
 
; Print a string pointed to by SI
print_string:
    mov ah, 0x0E          ; BIOS teletype function
.next_char:
    lodsb                 ; Load the next byte from [SI] into AL
    cmp al, 0             ; Is this the null terminator?
    je .done              ; If yes, we're done
    int 0x10              ; Otherwise, print the character
    jmp .next_char        ; Repeat for the next character
.done:
    ret
 
; Hier holen wir uns den User Input
get_user_input:
    xor ax, ax ; Da ax = ax wir die XOR Operation ax auf 0 zurücksetzen
    int 0x16              ; BIOS keyboard interrupt call
    sub al, '1'           ; BIOS Trick, um einen ASCII Wert zu einem numerischen Wert zu konvertieren 
    mov bx, ax            ; Store the index in BX
    ret

; Menü text
menu_text db "Select a Kernel Version:", 0x0A, 0x0D
  db "1. Kernel v1", 0x0A, 0x0D
  db "2. Kernel v2", 0x0A, 0x0D
  db "3. Kernel v3", 0x0A, 0x0D
  db 0             ; Null terminator
 
times 510-($-$$) db 0
dw 0xAA55
