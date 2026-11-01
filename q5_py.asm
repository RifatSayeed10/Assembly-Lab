;Ekta 6 element er array theke shudhu Even (jor) number gulo khuje tader jogfol (sum) ber korte hobe. Ekhane Conditional jump ebong loop use korte hobe.
;Sample Input: 02H, 05H, 08H, 03H, 06H, 01H.
;Sample Output: Sum = 10H (karon 02H + 08H + 06H = 10H)


.MODEL SMALL
.DATA
    ARRAY DB 02H, 05H, 08H, 03H, 06H, 01H  ; 6 ta number er array
    SUM DB 0                               ; Jogfol rakhar jonno variable

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    LEA SI, ARRAY      ; SI pointer ke array er prothom ghore point korlam
    MOV CX, 6          ; Loop 6 bar ghurbe karon element 6 ta
    MOV BL, 0          ; BL register ke amra final sum rakhar jonno use korbo, tai 0 kore nilam

CHECK_EVEN_LOOP:
    MOV AL, [SI]       ; Array er current number ta AL e nilam
    
    ; Even kina check kora
    TEST AL, 01H       ; AL er last bit check korbe. (Last bit 1 hole odd, 0 hole even)
    JNZ SKIP_ADD       ; Jump if Not Zero. Jodi odd (bijor) hoy, tahole jog korar dorkar nai, SKIP e chole jao

    ; Jodi Zero hoy (mane even/jor), tahole nicher line ta execute hobe
    ADD BL, AL         ; Current number ta (AL) BL (Sum) er sathe jog korlam

SKIP_ADD:
    INC SI             ; Pointer ke porer array element e niye gelam
    LOOP CHECK_EVEN_LOOP ; CX 1 komabe, 0 na hole abar loop e jabe

    MOV SUM, BL        ; Pura loop shesh hole final jogfol ta SUM variable e save korlam

    MOV AH, 4CH
    INT 21H
MAIN ENDP
END MAIN