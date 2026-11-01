.model small
.stack 100h 
.data
a db "Enter a number:$"
b db 13,10,"Multiplication Table:$"
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
    
    mov ah,02h
    mov dl,13
    int 21h
    mov dl,10
    int 21h
    
    mov cl,1
    
    inner:
    
    cmp cl,9
    jg exit
           
    mov ah,02h
    mov dl,13
    int 21h
    mov dl,10
    int 21h
    
    mov ah,02h
    mov dl,bl
    add dl,48
    int 21h
    
    mov ah,02h
    mov dl,'X'
    int 21h
    
    mov ah,02h
    mov dl,cl
    add dl,48
    int 21h
    
    mov ah,02h
    mov dl,'='
    int 21h 
    
    mov al,bl
    mul cl
    aam
    mov si,ax
    
    mov ah,02h
    mov dx,si
    mov dl,dh
    add dl,48
    int 21h
    
 
    mov dx,si
    add dl,48
    
    mov ah,02h
    int 21h
    
    inc cl
    jmp inner
 
   
exit:
    mov ah,4ch
    int 21h
    main endp
end main