.model small
.stack 100h
.data
    resultAX dw ?
    resultBX dw ?
.code
main proc
    mov ax, @data
    mov ds, ax

    ; MOV
    mov ax, 5
    mov bx, 3

    ; XCHG
    xchg ax, bx

    ; ADD
    add ax, bx

    ; SUB
    sub ax, bx

    ; INC
    inc ax

    ; DEC
    dec bx

    ; NEG
    neg ax

    ; Save final register values in memory
    mov resultAX, ax
    mov resultBX, bx

    mov ah, 4ch
    int 21h
main endp
end main
