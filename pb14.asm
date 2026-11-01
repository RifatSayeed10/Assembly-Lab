.MODEL SMALL
.STACK 100H
.DATA
    NUM DW 1234H
.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX
    NOT NUM            ; invert all 16 bits in memory
    MOV BX, NUM        ; BX = EDCBH
    MOV AH, 4CH
    INT 21H
MAIN ENDP
END MAIN