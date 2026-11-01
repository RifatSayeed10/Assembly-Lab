;Ekta number er factorial ber korte hobe CALL ebong RET use kore. Sathe Stack (PUSH/POP) use kora mandatory.
;Sample Input: N = 4.
;Sample Output: Factorial = 24 (Hexadecimal e 18H).


.MODEL SMALL
.DATA
    N DB 4             ; Number jetaar factorial ber korbo
    FACT_RES DB ?      ; Result save korar jonno

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    MOV CL, N          ; CL = 4 (Loop counter hisabe use korbo)
    MOV CH, 0          ; CX = 0004H
    
    CALL FACT_PROC     ; Factorial ber korar procedure ta call korlam
    
    MOV FACT_RES, AL   ; Procedure theke AL e result asbe, seta save korlam

    MOV AH, 4CH
    INT 21H
MAIN ENDP

; --- User Defined Procedure ---
FACT_PROC PROC
    PUSH CX            ; Stack e CX er man (4) save korlam (Question er requirement!)
    MOV AX, 1          ; Multiplication er jonno initial man 1 hote hoy (0 hole gunfol 0 hobe)

FACT_LOOP:
    MUL CX             ; AX = AX * CX (Prothome 1*4, tarpor 4*3, 12*2, 24*1)
    LOOP FACT_LOOP     ; CX komabe ar loop korbe jotokhon na CX = 0 hoy

    POP CX             ; Kaj sheshe Stack theke CX er ager man ferot anlam
    RET                ; Main function e ferot (return) jao
FACT_PROC ENDP
END MAIN