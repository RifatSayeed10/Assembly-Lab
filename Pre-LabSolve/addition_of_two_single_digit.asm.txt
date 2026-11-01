.model small
.stack 100h
.data
a db "Enter first number:$"
b db 10,13,"Enter second number:$"
c db 10,13,"Result:$"
.code
main proc
    mov ax,@data
    mov ds,ax
   
    mov ah,09h
    lea dx,a
    int 21h
    
    mov ah,01h
    int 21h
    sub al,48
    mov bl,al
    
    mov ah,09h
    lea dx,b
    int 21h
    
    mov ah,01h
    int 21h
    sub al,48
    
    add al,bl
    aam
    mov bx,ax  
    
    mov ah,09h
    lea dx,c
    int 21h
    
    mov ah,02h
    mov dl,bh
    add dl,48
    int 21h
           
    mov ah,02h
    mov dl,bl
    add dl,48
    int 21h
exit:
     mov ah,4ch
     int 21h
     main endp
end main