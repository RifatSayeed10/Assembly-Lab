.MODEL SMALL
.STACK 100H

.DATA
STR DB 'HELLO'
REV DB 5 DUP(?),'$'
MSG DB 'Reversed String: $'

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX
    MOV ES, AX

    LEA SI, STR
    LEA DI, REV+4

    MOV CX, 5
    CLD

L1:
    LODSB
    STOSB
    SUB DI, 2
    LOOP L1

    ; Display message
    LEA DX, MSG
    MOV AH, 9
    INT 21H

    ; Display reversed string
    LEA DX, REV
    MOV AH, 9
    INT 21H

    MOV AH, 4CH
    INT 21H

MAIN ENDP
END MAIN
