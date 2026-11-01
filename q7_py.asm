;Ekta 8-bit number er bhitor koyta '1' (one bit) ache ta count korte hobe shift/rotate use kore.
;Sample Input: 5AH (Binary te: 0101 1010).
;Sample Output: 4.


.MODEL SMALL
.DATA
    NUM DB 5AH         ; Number: 0101 1010
    ONES_COUNT DB 0    ; Koyta 1 pabo tar count

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    MOV AL, NUM        ; Number ta AL e nilam
    MOV CX, 8          ; 8-bit number, tai loop 8 bar ghurbe
    MOV BL, 0          ; Count korar jonno BL ke 0 kore nilam

COUNT_LOOP:
    SHR AL, 1          ; AL ke 1 bit dan dike shift korlam. Last bit CF (Carry Flag) e chole jabe
    JNC SKIP_INC       ; Jump if No Carry (Jodi CF=0 hoy, tahole increment korar dorkar nai)

    ; Jodi CF=1 hoy tahole count barabo
    INC BL             ; BL = BL + 1

SKIP_INC:
    LOOP COUNT_LOOP    ; CX theke 1 komabe ar upore jabe

    MOV ONES_COUNT, BL ; Pura 8 bit check sheshe count ta memory te save korlam

    MOV AH, 4CH
    INT 21H
MAIN ENDP
END MAIN