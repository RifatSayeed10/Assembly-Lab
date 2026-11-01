
.model small
.stack 100h

.data
str db "HELLO"
rev db 5 dup(?),'$'
a db "Reversed:$"

.code
main proc
    mov ax,@data
    mov ds,ax
    mov es,ax

    lea si,str
    add si,4

    lea di,rev
    mov cx,5

    std

reverse:
    lodsb
    stosb
    add di,2
    loop reverse

    cld

    mov ah,09h
    lea dx,a
    int 21h

    mov ah,09h
    lea dx,rev
    int 21h

exit:
    mov ah,4ch
    int 21h

main endp
end main
