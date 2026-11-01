;Find the maximum number from an array of 5 unsigned 8-bit numbers 
;(12H, 45H, 23H, 67H, 34H) using register indirect addressing and the LOOP instruction.

.MODEL SMALL
.STACK 100H

.DATA
    ARRAY DB 12H, 45H, 23H, 67H, 34H  ; Define array of 5 bytes
    MAX_VAL DB ?                      ; Variable to store the max value

.CODE
MAIN PROC
    ; 1. Initialize Data Segment
    MOV AX, @DATA
    MOV DS, AX

    ; 2. Setup Pointers and Counters
    LEA SI, ARRAY      ; Load Effective Address of ARRAY into SI (Pointer)
    MOV CX, 5          ; Set Loop Counter to 5 (Number of elements)
    
    ; 3. Initial Assumption
    MOV AL, [SI]       ; Load the first element into AL as the initial MAX
    INC SI             ; Point SI to the next element
    DEC CX             ; Decrement counter since we already processed the first element

FIND_MAX_LOOP:
    ; 4. Compare and Update
    CMP AL, [SI]       ; Compare current MAX (AL) with the next array element ([SI])
    JAE SKIP_UPDATE    ; Jump if Above or Equal (AL >= [SI]), meaning no update needed
    
    ; If AL < [SI], update MAX
    MOV AL, [SI]       ; New maximum found, store it in AL

SKIP_UPDATE:
    INC SI             ; Move pointer to the next element in the array
    LOOP FIND_MAX_LOOP ; Decrement CX, if CX != 0, jump back to FIND_MAX_LOOP

    ; 5. Store Result
    MOV MAX_VAL, AL    ; Store the final maximum value into memory variable

    ; Exit Program
    MOV AH, 4CH
    INT 21H
MAIN ENDP
END MAIN