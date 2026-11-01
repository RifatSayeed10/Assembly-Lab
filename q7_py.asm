.MODEL SMALL
.STACK 100H

.DATA
    NUM DB 5AH
    ONES_COUNT DB 0
    MSG DB 'Number of 1 bits = $'

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    MOV AL, NUM
    MOV CX, 8
    MOV BL, 0

COUNT_LOOP:
    SHR AL, 1
    JNC SKIP_INC

    INC BL

SKIP_INC:
    LOOP COUNT_LOOP

    MOV ONES_COUNT, BL

    ; Display message
    LEA DX, MSG
    MOV AH, 9
    INT 21H

    ; Print number of 1 bits
    MOV DL, ONES_COUNT
    ADD DL, 30H
    MOV AH, 2
    INT 21H

    ; Exit
    MOV AH, 4CH
    INT 21H

MAIN ENDP
END MAIN
