.model small
.stack 100h
.data
a db "Enter first number:$"
b db 10,13,"Enter second number:$"
c db 10,13,"Enter third number:$"
d db 10,13,"Largest number:$"
.code
main proc
    mov ax,@data
    mov ds,ax
    
    mov ah,09h
    lea dx,a
    int 21h
    
    mov ah,01h
    int 21h
    mov bl,al 
    
    mov ah,09h
    lea dx,b
    int 21h
    
    mov ah,01h
    int 21h
    mov bh,al 
    
    mov ah,09h
    lea dx,c
    int 21h
    
    mov ah,01h
    int 21h
    mov cl,al
   
    cmp bl,bh
    jge large
    mov bl,bh
    
    large:
    cmp bl,cl
    jge display
    mov bl,cl
    
    display:
    mov ah,09h
    lea dx,d
    int 21h
    
    mov ah,02h
    mov dl,bl
    int 21h
exit:
    mov ah,4ch
    int 21h
    main endp
end main
    
    