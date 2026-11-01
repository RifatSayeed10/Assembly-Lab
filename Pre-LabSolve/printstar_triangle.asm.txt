.model small
.stack 100h
.code
main proc
    mov bl,5
    
    outer:
    mov cl,bl 
    
    inner:
    mov ah,02h
    mov dl,'*'
    int 21h
    
    dec cl
    cmp cl,0
    jg inner
    
    mov ah,02h
    mov dl,13
    int 21h
    mov dl,10
    int 21h
    
    dec bl
    cmp bl,0
    jg outer
    
exit:
    mov ah,4ch
    int 21
    main endp
end main