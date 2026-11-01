;Ekta math equation solve korte hobe: Result = ((A * B) + C) / D ebong MUL & DIV use korte hobe. Sheshe result ta 7-segment display te pathate hobe.
;Sample Input: A = 02H, B = 03H, C = 04H, D = 02H.
;Expected Result: (2*3 + 4) / 2 = 5.

.MODEL SMALL
.DATA
    A DB 02H
    B DB 03H
    C DB 04H
    D DB 02H
    RESULT DB ?
    
    ; 7-Segment Lookup table (0 theke 9 porjonto Hex code, common cathode anujayi)
    ; 0=3F, 1=06, 2=5B, 3=4F, 4=66, 5=6D... 
    SEV_SEG_CODES DB 3FH, 06H, 5BH, 4FH, 66H, 6DH, 7DH, 07H, 7FH, 6FH

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    ; --- Step 1: (A * B) ---
    MOV AL, A          ; AL = 02H
    MUL B              ; AL = AL * B. (2 * 3 = 6). Result AX e ache (0006H)

    ; --- Step 2: + C ---
    MOV BL, C          ; BL = 04H
    MOV BH, 0          ; BX = 0004H (16-bit jog korar jonno zero-extend korlam)
    ADD AX, BX         ; AX = AX + BX (6 + 4 = 10, jeta Hex e 000AH)

    ; --- Step 3: / D ---
    MOV BL, D          ; BL = 02H
    DIV BL             ; AX ke BL diye vag. Vagfol (Quotient) thakbe AL e, Vagsesh (Remainder) AH e.
                       ; 10 / 2 = 5. Tai AL = 05H asbe.
    
    MOV RESULT, AL     ; Equation er main math result save korlam

    ; --- Step 4: 7-Segment Display Output ---
    ; Ekhon AL e ache 5. Amader 7-segment table theke 5 number index er code ta nite hobe
    LEA SI, SEV_SEG_CODES
    MOV BL, AL         ; BL = 5
    MOV BH, 0          ; BX = 5 (index)
    
    ADD SI, BX         ; Pointer ke 5 number index e soriye nilam
    MOV AL, [SI]       ; AL e aslo 5 er jonn 7-segment hex code (6DH)
    
    ; Hardware e output deya (Dhorlam 7-segment port holo 19H, tomar lab e eta onno hote pare)
    OUT 19H, AL        ; Port 19H e data pathalam jate hardware display te '5' lekha veshe uthe

    MOV AH, 4CH
    INT 21H
MAIN ENDP
END MAIN