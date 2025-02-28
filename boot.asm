[BITS 16]
[ORG 0x7C00]  ; BIOS lädt Bootloader an Adresse 0x7C00

	mov si, msg
	call print_string

	jmp $

print_string:
        mov ah, 0x0E  ; BIOS-Teletype Mode für Textausgabe
.loop:
	lodsb         ; Nächstes Zeichen aus SI laden
	cmp al, 0
	je .done
	int 0x10      ; BIOS-Interrupt für Zeichenanzeige
	jmp .loop
.done:
	ret

msg db "Hello, Bootloader!", 0

times 510-($-$$) db 0  ; Auffüllen bis 510 Bytes
dw 0xAA55  ; Boot-Signatur
