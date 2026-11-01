.model small
.stack 100h
.data
msg db 'IBM Character Set (20H - FFH):', 0dh, 0ah, '$'
.code
main proc
    mov ax, @data
    mov ds, ax

    lea dx, msg
    mov ah, 9
    int 21h

    ; Start from ASCII 20H (space)
    mov dl, 20h

again:
    mov ah, 2
    int 21h

    ; After FFH, 8-bit DL wraps to 00H
    inc dl
    jnz again

    mov ah, 4ch
    int 21h
main endp
end main
