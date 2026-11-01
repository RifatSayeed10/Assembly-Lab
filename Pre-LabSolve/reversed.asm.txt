.model small
.stack 100h 
.data
a db "Enter 3 digit number:$"
b db 13,10,"Reversed number:$"
.code
main proc 
    mov ax,@data
    mov ds,ax
    
    mov ah,09h
    lea dx,a
    int 21h 
    
    mov cx,3
    
    input:
    mov ah,01h
    int 21h 
    
    mov ah,0
    push ax
    loop input
    
    
    mov ah,09h
    lea dx,b
    int 21h
    
    mov cx,3
    
    print:
    pop dx
    mov ah,02h
    int 21h
    loop print
    
 exit:
    mov ah,4ch
    int 21h
    main endp
end main
    
    