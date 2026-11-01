.MODEL SMALL
.STACK 100H
.DATA
    PAT DB 7CH,42H,42H,7CH,40H,40H,40H,00H  ; letter P, 1 byte = 1 row
    M1  DB 'Original pattern:',0DH,0AH,'$'
    M2  DB 0DH,0AH,'After shift right (SHR):',0DH,0AH,'$'
    M3  DB 0DH,0AH,'After invert (NOT):',0DH,0AH,'$'
.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX
    LEA DX, M1
    CALL DRAW

    LEA SI, PAT        ; move every row one dot right
    MOV CX, 8
SH: SHR BYTE PTR [SI], 1
    INC SI
    LOOP SH
    LEA DX, M2
    CALL DRAW

    LEA SI, PAT        ; turn ON dots OFF and OFF dots ON
    MOV CX, 8
IV: NOT BYTE PTR [SI]
    INC SI
    LOOP IV
    LEA DX, M3
    CALL DRAW

    MOV AH, 4CH
    INT 21H
MAIN ENDP

DRAW PROC              ; prints title (DX) and the 8x8 matrix
    MOV AH, 9
    INT 21H
    LEA SI, PAT
    MOV BH, 8          ; 8 rows
ROW:
    MOV BL, [SI]       ; BL = one row (8 dots)
    MOV CX, 8
COL:
    MOV DL, '.'
    SHL BL, 1          ; leftmost dot -> CF
    JNC OFF
    MOV DL, '*'        ; bit 1 = LED ON
OFF:
    MOV AH, 2
    INT 21H
    MOV DL, ' '
    INT 21H
    LOOP COL
    MOV DL, 0DH
    INT 21H
    MOV DL, 0AH
    INT 21H
    INC SI
    DEC BH
    JNZ ROW
    RET
DRAW ENDP
END MAIN