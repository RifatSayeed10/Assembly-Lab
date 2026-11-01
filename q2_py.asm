;Reverse a string ("HELLO") 
;stored in memory using string instructions (LODSB and STOSB), and SI and DI registers.
;Simpler Approach (Copying to reversed buffer)

.MODEL SMALL
.STACK 100H

.DATA
    STR1 DB 'HELLO'       ; Original String
    LEN  EQU $-STR1       ; Calculate length of STR1 (5)
    STR2 DB LEN DUP(?)    ; Buffer to hold reversed string

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX
    MOV ES, AX         ; String instructions require ES for destination (DI)

    ; 1. Setup Pointers
    LEA SI, STR1       ; SI points to start of original string
    ADD SI, LEN - 1    ; Move SI to point to the LAST character ('O')
    
    LEA DI, STR2       ; DI points to start of destination buffer
    
    MOV CX, LEN        ; Loop counter = string length (5)
    
    ; Ensure Direction Flag is clear (so LODSB/STOSB naturally increment/decrement appropriately)
    CLD                ; Clear Direction Flag (we'll manually handle SI decrement)

REVERSE_LOOP:
    ; 2. Load from end, Store at beginning
    ; We can't use LODSB easily here because we want SI to go backwards
    ; So we'll do the memory access manually
    
    MOV AL, [SI]       ; Load character from current end position
    STOSB              ; Store AL at [DI] and automatically increment DI
    
    DEC SI             ; Manually move source pointer backwards
    LOOP REVERSE_LOOP  ; Repeat for all characters

    ; Exit Program
    MOV AH, 4CH
    INT 21H
MAIN ENDP
END MAIN