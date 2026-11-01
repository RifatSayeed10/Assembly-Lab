.model small
.stack 100h
.code
main proc
    mov cx,27
    mov bl,'A'
    
    L1: cmp bl,'Z'
        jg exit
        mov ah,02h
        mov dl,bl
        int 21h
        
        mov ah,02h
        mov dl,32
        int 21h
        
        inc bl
        dec cx
        jmp L1 
        
exit:
    mov ah,4ch
    int 21h
    main endp
end main