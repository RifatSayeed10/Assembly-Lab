
.model small
.stack 100h

.data
a db "Enter 3 digit number:$"
b db 13,10,"Reversed:$"
c db 13,10,"Palindrome$"
d db 13,10,"Not Palindrome$"

original db 3 dup(?)
reversed db 3 dup(?)

.code
main proc
    mov ax,@data
    mov ds,ax

    mov ah,09h
    lea dx,a
    int 21h

    mov cx,3
    mov si,0

input:
    mov ah,01h
    int 21h

    mov original[si],al

    mov ah,0
    push ax

    inc si
    loop input

    mov ah,09h
    lea dx,b
    int 21h

    mov cx,3
    mov si,0

print:
    pop dx
    mov reversed[si],dl

    mov ah,02h
    int 21h

    inc si
    loop print

    mov cx,3
    mov si,0

check:
    mov al,original[si]
    cmp al,reversed[si]
    jne not_palindrome

    inc si
    loop check

    mov ah,09h
    lea dx,c
    int 21h
    jmp exit

not_palindrome:
    mov ah,09h
    lea dx,d
    int 21h

exit:
    mov ah,4ch
    int 21h

main endp
end main
