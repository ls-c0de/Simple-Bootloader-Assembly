[BITS 16]
[ORG 0x7C00]  ; BIOS lädt Bootloader an Adresse 0x7C00

	call key_return
	jmp $

print_key:
	mov ah, 0x0E
	int 0x10

key_return:
	mov ah, 0x00
	int 0x16
	call print_key
	

times 510-($-$$) db 0  ; Auffüllen bis 510 Bytes
dw 0xAA55  ; Boot-Signatur
