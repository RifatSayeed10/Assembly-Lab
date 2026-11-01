.MODEL SMALL
.STACK 100H
.DATA
    SEG7 DB 3FH,06H,5BH,4FH,66H,6DH,7DH,07H,7FH,6FH ; 0-9 (bits gfedcba)
    ROWS DB 00H,' ',01H,'_',00H,' '   ; row 1:      a
         DB 20H,'|',40H,'_',02H,'|'   ; row 2:  f  g  b
         DB 10H,'|',08H,'_',04H,'|'   ; row 3:  e  d  c
    NUM  DB 8 DUP(0)
    M1   DB 'Enter a number (max 8 digits): $'
.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX
    LEA DX, M1
    MOV AH, 9
    INT 21H
    XOR DI, DI         ; DI = number of digits
IN1:
    MOV AH, 1
    INT 21H
    CMP AL, 0DH        ; Enter -> stop reading
    JE  SHOW
    SUB AL, 30H
    CMP AL, 9
    JA  IN1            ; skip non-digits
    MOV NUM[DI], AL
    INC DI
    CMP DI, 8
    JB  IN1
SHOW:
    CMP DI, 0
    JE  EXIT
    MOV AH, 2          ; new line
    MOV DL, 0DH
    INT 21H
    MOV DL, 0AH
    INT 21H
    XOR BX, BX         ; BX = row start in ROWS (0, 6, 12)
ROW:
    XOR SI, SI         ; SI = digit index
DIG:
    MOV AL, NUM[SI]
    PUSH BX
    LEA BX, SEG7
    XLAT               ; AL = SEG7[AL] = segment code
    POP BX
    MOV DH, AL
    PUSH BX
    MOV CX, 3          ; 3 places in each row
POS:
    MOV DL, ' '
    TEST DH, ROWS[BX]  ; is this segment ON?
    JZ  PUT
    MOV DL, ROWS[BX+1]
PUT:
    MOV AH, 2
    INT 21H
    ADD BX, 2
    LOOP POS
    POP BX
    MOV DL, ' '        ; gap between digits
    INT 21H
    INC SI
    CMP SI, DI
    JB  DIG
    MOV DL, 0DH
    INT 21H
    MOV DL, 0AH
    INT 21H
    ADD BX, 6          ; next row
    CMP BX, 18
    JB  ROW
EXIT:
    MOV AH, 4CH
    INT 21H
MAIN ENDP
END MAIN