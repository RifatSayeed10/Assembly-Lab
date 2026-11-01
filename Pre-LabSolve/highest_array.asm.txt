
.model small
.stack 100h

.data
arr db 5 dup(?)
max db ?
a db "Enter 5 numbers:$"
b db 13,10,"Maximum number:$"

.code
main proc
    mov ax,@data
    mov ds,ax

    mov ah,09h
    lea dx,a
    int 21h

    lea si,arr
    mov cx,5

input:
    mov ah,01h
    int 21h
    sub al,48

    mov [si],al
    inc si
    loop input

    lea si,arr
    mov cx,4

    mov al,[si]
    inc si

l1:
    cmp al,[si]
    jae skip

    mov al,[si]

skip:
    inc si
    loop l1

    mov max,al

    mov ah,09h
    lea dx,b
    int 21h

    mov dl,max
    add dl,48
    mov ah,02h
    int 21h

exit:
    mov ah,4ch
    int 21h

main endp
end main
