.model small
.stack 100h
.code
main proc
    mov bl,1
    
    outer:
    mov cl,0
    
    inner:
     
    mov ah,02h
    mov dl,'*'
    int 21h
    
    inc cl
    cmp cl,bl
    jl inner
    
    mov ah,02h
    mov dl,13
    int 21h
    mov dl,10
    int 21h
    
    inc bl
    cmp bl,5
    jle outer
    
exit:
    mov ah,4ch
    int 21h
    main endp
end main