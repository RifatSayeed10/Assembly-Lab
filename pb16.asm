.MODEL SMALL
.STACK 100H

.DATA
MSG DB 'Enter digit: $'
MSG2 DB 0DH,0AH,'Numerical value: $'
NUM DB ?

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    ; Display message
    MOV AH, 9
    LEA DX, MSG
    INT 21H

    ; Input digit
    MOV AH, 1
    INT 21H

    ; Convert ASCII to number
    SUB AL, '0'
    MOV NUM, AL

    ; Display result message
    MOV AH, 9
    LEA DX, MSG2
    INT 21H

    ; Print numerical value
    MOV DL, NUM
    ADD DL, '0'
    MOV AH, 2
    INT 21H

    ; Exit
    MOV AH, 4CH
    INT 21H

MAIN ENDP
END MAIN
