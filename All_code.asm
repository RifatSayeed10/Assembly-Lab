ASSEMBLY LAB PROBLEMS AND PREVIOUS YEAR QUESTIONS
Source: https://github.com/RifatSayeed10/Assembly-Lab
The code blocks below are copied from the supplied GitHub ZIP without editing.

========================================================================================
LAB PROBLEMS: PB2–PB29
========================================================================================


PB2: Write a simple program to show a “Hello World” message.
File: pb2.asm
----------------------------------------------------------------------------------------
.model small
.stack 100h

.data
msg db 'Hello World!$'

.code
main proc
    mov ax, @data
    mov ds, ax

    mov ah, 9
    lea dx, msg
    int 21h

    mov ah, 4ch
    int 21h
main endp
end main


PB3: Input two numbers & print them in assembly language.
File: pb3.asm
----------------------------------------------------------------------------------------
.model small
.stack 100h

.code 
 main proc
    mov ah,1
    int 21h
    mov bl,al
    
    mov ah,1
    int 21h
    mov bh,al
    
    mov ah,2
    mov dl,10
    int 21h
    mov dl,13
int 21h
    mov ah,2
    mov dl,bl
    int 21h
    
    mov ah,2
    mov dl,bh
    int 21h
    
       
    mov ah,4ch
    int 21h
    main endp
 end main
 


PB4: Implement all the operations (mov, xchg, add, sub, inc, dec, neg) in one assembly code.
File: pb4.asm
----------------------------------------------------------------------------------------

.model small
.stack 100h
.data
    resultAX dw ?
    resultBX dw ?
.code
main proc
    mov ax, @data
    mov ds, ax

    ; MOV
    mov ax, 5
    mov bx, 3

    ; XCHG
    xchg ax, bx

    ; ADD
    add ax, bx

    ; SUB
    sub ax, bx

    ; INC
    inc ax

    ; DEC
    dec bx

    ; NEG
    neg ax

    ; Save final register values in memory
    mov resultAX, ax
    mov resultBX, bx

    mov ah, 4ch
    int 21h
main endp
end main


PB5: Write a program to calculate the sum of two numbers.
File: pb5.asm
----------------------------------------------------------------------------------------

.model small
.stack 100h
.code
main proc
    mov ah, 1
    int 21h
    mov bl, al

    mov ah, 1
    int 21h
    mov bh, al

    add bl, bh             ; bl = bl + bh

    mov ah, 2
    mov dl, bl
    sub dl, 48             ; Convert ASCII result
    int 21h

exit:
    mov ah, 4ch
    int 21h
main endp
end main


PB6: Write a program which will read a character from the keyboard and display it at the beginning of the next line.
File: pb6.asm
----------------------------------------------------------------------------------------

.model small
.stack 100h
.code
main proc
    mov ah, 1
    int 21h
    mov bl, al

    ; New Line
    mov ah, 2
    mov dl, 13
    int 21h
    mov dl, 10
    int 21h

    ; Display Character
    mov ah, 2
    mov dl, bl
    int 21h

    ; Exit
    mov ah, 4ch
    int 21h
main endp
end main


PB7: Write a program to print a string.
File: pb7.asm
----------------------------------------------------------------------------------------

.model small
.stack 100h
.data
msg db 'Welcome to Assembly Language!$'
.code
main proc
    mov ax, @data
    mov ds, ax

    mov ah, 9
    lea dx, msg
    int 21h

    mov ah, 4ch
    int 21h
main endp
end main


PB8: Write a program to convert lower case letters to upper case letters.
File: pb8.asm
----------------------------------------------------------------------------------------

.MODEL SMALL
.STACK 100H
.DATA
    MSG DB 'pabna university of science and technology$'
    NL  DB 0DH,0AH,'$'
.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    LEA DX, MSG          ; show original
    MOV AH, 9
    INT 21H
    LEA DX, NL
    MOV AH, 9
    INT 21H

    LEA SI, MSG
UP:
    MOV AL, [SI]
    CMP AL, '$'
    JE  DONE
    CMP AL, 'a'
    JB  NEXT
    CMP AL, 'z'
    JA  NEXT
    SUB AL, 20H          ; convert
    MOV [SI], AL
NEXT:
    INC SI
    JMP UP
DONE:
    LEA DX, MSG
    MOV AH, 9
    INT 21H

    MOV AH, 4CH
    INT 21H
MAIN ENDP
END MAIN


PB9: Perform any operation and display flag value of that operation.
File: pb9.asm
----------------------------------------------------------------------------------------

.MODEL SMALL
.STACK 100H
.DATA
    MSG DB 'Flag byte (SF ZF - AF - PF - CF) = $'
.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    MOV AL, 05H
    SUB AL, 05H          ; operation: 5 - 5 = 0
    LAHF                 ; AH <- flag byte
    MOV BL, AH

    LEA DX, MSG
    MOV AH, 9
    INT 21H

    MOV CX, 8
PRINT:
    MOV DL, '0'
    SHL BL, 1            ; MSB -> Carry Flag
    JNC SKIP
    MOV DL, '1'
SKIP:
    MOV AH, 2
    INT 21H
    LOOP PRINT

    MOV AH, 4CH
    INT 21H
MAIN ENDP
END MAIN


PB10: Write a program to display the entire IBM instruction character set (use jump instructions).
File: pb10.asm
----------------------------------------------------------------------------------------

.model small
.stack 100h
.data
msg db 'IBM Character Set (20H - FFH):', 0dh, 0ah, '$'
.code
main proc
    mov ax, @data
    mov ds, ax

    lea dx, msg
    mov ah, 9
    int 21h

    ; Start from ASCII 20H (space)
    mov dl, 20h

again:
    mov ah, 2
    int 21h

    ; After FFH, 8-bit DL wraps to 00H
    inc dl
    jnz again

    mov ah, 4ch
    int 21h
main endp
end main


PB11: Write a program to replace the number in AX by its absolute value (use branching structure).
File: pb11.asm
----------------------------------------------------------------------------------------

.MODEL SMALL
.STACK 100H
.DATA
    MSG DB 'Absolute value = $'
.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    MOV AX, -25          ; test value (AX = FFE7H)

    CMP AX, 0
    JGE POSITIVE         ; branch: already positive
    NEG AX               ; make it positive
POSITIVE:
    MOV BX, AX           ; save result

    LEA DX, MSG
    MOV AH, 9
    INT 21H

    MOV AX, BX
    AAM                  ; AH = tens, AL = units
    ADD AH, 30H
    ADD AL, 30H
    MOV BH, AL
    MOV DL, AH
    MOV AH, 2
    INT 21H
    MOV DL, BH
    MOV AH, 2
    INT 21H

    MOV AH, 4CH
    INT 21H
MAIN ENDP
END MAIN


PB12: Read a character, and if it’s an uppercase letter, display it (use AND conditions).
File: pb12.asm
----------------------------------------------------------------------------------------

.MODEL SMALL
.STACK 100H
.DATA
    MSG1 DB 'Enter a character: $'
    MSG2 DB 0DH,0AH,'Uppercase letter: $'
    MSG3 DB 0DH,0AH,'Not an uppercase letter.$'
.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    LEA DX, MSG1
    MOV AH, 9
    INT 21H

    MOV AH, 1
    INT 21H              ; AL = input character
    MOV BL, AL

    CMP BL, 'A'          ; condition 1
    JB  NOT_UPPER
    CMP BL, 'Z'          ; condition 2
    JA  NOT_UPPER

    LEA DX, MSG2         ; both conditions satisfied
    MOV AH, 9
    INT 21H
    MOV DL, BL
    MOV AH, 2
    INT 21H
    JMP EXIT

NOT_UPPER:
    LEA DX, MSG3
    MOV AH, 9
    INT 21H
EXIT:
    MOV AH, 4CH
    INT 21H
MAIN ENDP
END MAIN


PB13: Read a character. If it’s “y” or “Y”, display it otherwise, terminate the program (use OR conditions).
File: pb13.asm
----------------------------------------------------------------------------------------

.MODEL SMALL
.STACK 100H
.DATA
    MSG1 DB 'Continue? (y/Y): $'
    MSG2 DB 0DH,0AH,'You entered: $'
    MSG3 DB 0DH,0AH,'Program terminated.$'
.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    LEA DX, MSG1
    MOV AH, 9
    INT 21H

    MOV AH, 1
    INT 21H              ; AL = input character
    MOV BL, AL

    CMP BL, 'y'          ; condition 1
    JE  SHOW
    CMP BL, 'Y'          ; condition 2
    JE  SHOW
    JMP TERMINATE        ; neither matched

SHOW:
    LEA DX, MSG2
    MOV AH, 9
    INT 21H
    MOV DL, BL
    MOV AH, 2
    INT 21H
    JMP EXIT

TERMINATE:
    LEA DX, MSG3
    MOV AH, 9
    INT 21H
EXIT:
    MOV AH, 4CH
    INT 21H
MAIN ENDP
END MAIN


PB14: Write a program to invert all bits of a 16-bit number stored in memory.
File: pb14.asm
----------------------------------------------------------------------------------------

.MODEL SMALL
.STACK 100H
.DATA
    NUM DW 1234H
.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX
    NOT NUM            ; invert all 16 bits in memory
    MOV BX, NUM        ; BX = EDCBH
    MOV AH, 4CH
    INT 21H
MAIN ENDP
END MAIN


PB15: Input a lowercase English letter and convert it into uppercase using a logic operation.
File: pb15.asm
----------------------------------------------------------------------------------------

.MODEL SMALL
.STACK 100H

.DATA
MSG DB 'Enter lowercase letter: $'

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    MOV AH, 9
    LEA DX, MSG
    INT 21H

    MOV AH, 1
    INT 21H

    AND AL, 11011111B

    MOV DL, AL
    MOV AH, 2
    INT 21H

    MOV AH, 4CH
    INT 21H
MAIN ENDP
END MAIN


PB16: Convert an ASCII digit into its numerical value.
File: pb16.asm
----------------------------------------------------------------------------------------

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


PB17: Write assembly code to multiply the unsigned value in AX by 2 using a shift instruction.
File: pb17.asm
----------------------------------------------------------------------------------------

.MODEL SMALL
.STACK 100H
.DATA
    NUM   DW 25
    MSG1  DB 'Original value: $'
    MSG2  DB 0DH,0AH,'After multiplying by 2: $'

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    LEA DX, MSG1
    MOV AH, 9
    INT 21H
    MOV AX, NUM
    CALL PRINT_DEC      ; print original value

    LEA DX, MSG2
    MOV AH, 9
    INT 21H
    MOV AX, NUM
    SHL AX, 1           ; AX = AX * 2
    CALL PRINT_DEC      ; print result

    MOV AH, 4CH
    INT 21H
MAIN ENDP

PRINT_DEC PROC          ; prints AX in decimal
    XOR CX, CX
    MOV BX, 10
DIV_LOOP:
    XOR DX, DX
    DIV BX              ; AX = AX/10, DX = remainder
    PUSH DX
    INC CX
    CMP AX, 0
    JNE DIV_LOOP
PRINT_LOOP:
    POP DX
    ADD DL, '0'
    MOV AH, 2
    INT 21H
    LOOP PRINT_LOOP
    RET
PRINT_DEC ENDP

END MAIN


PB18: Write assembly code to divide the unsigned value in BX by 8.
File: pb18.asm
----------------------------------------------------------------------------------------

.MODEL SMALL
.STACK 100H
.DATA
    NUM   DW 200
    MSG1  DB 'Original value: $'
    MSG2  DB 0DH,0AH,'After dividing by 8: $'

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    LEA DX, MSG1
    MOV AH, 9
    INT 21H
    MOV AX, NUM
    CALL PRINT_DEC     

    LEA DX, MSG2
    MOV AH, 9
    INT 21H
    MOV BX, NUM
    MOV CL, 3           ; 2^3 = 8
    SHR BX, CL          ; BX = BX / 8
    MOV AX, BX
    CALL PRINT_DEC      ; print result

    MOV AH, 4CH
    INT 21H
MAIN ENDP

PRINT_DEC PROC          ; prints AX in decimal
    XOR CX, CX
    MOV BX, 10
DIV_LOOP:
    XOR DX, DX
    DIV BX
    PUSH DX
    INC CX
    CMP AX, 0
    JNE DIV_LOOP
PRINT_LOOP:
    POP DX
    ADD DL, '0'
    MOV AH, 2
    INT 21H
    LOOP PRINT_LOOP
    RET
PRINT_DEC ENDP

END MAIN


PB19: Write assembly code to rotate the contents of BX 4 positions left.
File: pb19.asm
----------------------------------------------------------------------------------------

.MODEL SMALL
.STACK 100H
.DATA
    MSG1 DB 'Before ROL : $'
    MSG2 DB 0DH,0AH,'After ROL  : $'
.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    MOV BX, 1234H

    LEA DX, MSG1
    MOV AH, 9
    INT 21H
    CALL PRINT_BIN

    MOV CL, 4
    ROL BX, CL           ; 1234H -> 2341H

    LEA DX, MSG2
    MOV AH, 9
    INT 21H
    CALL PRINT_BIN

    MOV AH, 4CH
    INT 21H
MAIN ENDP

PRINT_BIN PROC           ; prints BX in binary, BX preserved
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    MOV CX, 16
PB_NEXT:
    MOV DL, '0'
    SHL BX, 1
    JNC PB_SKIP
    MOV DL, '1'
PB_SKIP:
    MOV AH, 2
    INT 21H
    LOOP PB_NEXT
    POP DX
    POP CX
    POP BX
    POP AX
    RET
PRINT_BIN ENDP

END MAIN


PB20: Write an assembly program that reverses all 8 bits of AL.
File: pb20.asm
----------------------------------------------------------------------------------------

;Reverse all 8 bits of AL
.MODEL SMALL
.STACK 100H
.DATA
    MSG1 DB 'Original AL : $'
    MSG2 DB 0DH,0AH,'Reversed AL : $'
.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    LEA DX, MSG1
    MOV AH, 9
    INT 21H
    MOV AL, 0B2H         ; 10110010
    MOV BL, AL
    CALL PRINT8

    XOR BL, BL           ; BL will collect reversed bits
    MOV CX, 8
REV:
    SHL AL, 1            ; MSB of AL -> CF
    RCR BL, 1            ; CF -> MSB of BL (older bits move right)
    LOOP REV
    MOV AL, BL           ; AL = reversed byte

    LEA DX, MSG2
    MOV AH, 9
    INT 21H
    CALL PRINT8          ; prints BL (same as AL)

    MOV AH, 4CH
    INT 21H
MAIN ENDP

PRINT8 PROC              ; prints BL in binary, BL preserved
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    MOV CX, 8
P8_NEXT:
    MOV DL, '0'
    SHL BL, 1
    JNC P8_SKIP
    MOV DL, '1'
P8_SKIP:
    MOV AH, 2
    INT 21H
    LOOP P8_NEXT
    POP DX
    POP CX
    POP BX
    POP AX
    RET
PRINT8 ENDP

END MAIN


PB21: Write an assembly program to input five numbers, display them in original and reverse order using the stack, and calculate their sum and average.
File: pb21.asm
----------------------------------------------------------------------------------------

;Input five numbers, show original and reverse order using the stack, then sum and average
.MODEL SMALL
.STACK 100H
.DATA
    NUMS DB 5 DUP(?)
    MSG1 DB 'Enter 5 single-digit numbers: $'
    MSG2 DB 0DH,0AH,'Original order : $'
    MSG3 DB 0DH,0AH,'Reverse order  : $'
    MSG4 DB 0DH,0AH,'Sum           = $'
    MSG5 DB 0DH,0AH,'Average       = $'
.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    LEA DX, MSG1
    MOV AH, 9
    INT 21H

    LEA SI, NUMS
    MOV CX, 5
    XOR BX, BX           ; BX = sum
INPUT:
    MOV AH, 1
    INT 21H              ; AL = ASCII digit
    MOV [SI], AL         ; store in array
    INC SI
    SUB AL, 30H
    XOR AH, AH
    ADD BX, AX           ; sum += digit
    MOV DL, ' '
    MOV AH, 2
    INT 21H
    LOOP INPUT

    ; ---- original order ----
    LEA DX, MSG2
    MOV AH, 9
    INT 21H
    LEA SI, NUMS
    MOV CX, 5
SHOW1:
    MOV DL, [SI]
    MOV AH, 2
    INT 21H
    MOV DL, ' '
    MOV AH, 2
    INT 21H
    INC SI
    LOOP SHOW1

    ; ---- push all onto stack ----
    LEA SI, NUMS
    MOV CX, 5
PUSHLP:
    MOV AL, [SI]
    XOR AH, AH
    PUSH AX
    INC SI
    LOOP PUSHLP

    ; ---- pop = reverse order ----
    LEA DX, MSG3
    MOV AH, 9
    INT 21H
    MOV CX, 5
POPLP:
    POP DX               ; DL = ASCII digit
    MOV AH, 2
    INT 21H
    MOV DL, ' '
    MOV AH, 2
    INT 21H
    LOOP POPLP

    ; ---- sum ----
    LEA DX, MSG4
    MOV AH, 9
    INT 21H
    MOV AX, BX
    CALL PRINT_DEC

    ; ---- average ----
    LEA DX, MSG5
    MOV AH, 9
    INT 21H
    MOV AX, BX
    MOV CL, 5
    DIV CL               ; AL = quotient, AH = remainder
    MOV BH, AH           ; save remainder
    XOR AH, AH
    CALL PRINT_DEC       ; integer part
    MOV DL, '.'
    MOV AH, 2
    INT 21H
    MOV AL, BH
    SHL AL, 1            ; remainder * 2 = first decimal digit (since /5)
    ADD AL, 30H
    MOV DL, AL
    MOV AH, 2
    INT 21H

    MOV AH, 4CH
    INT 21H
MAIN ENDP

PRINT_DEC PROC
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    XOR CX, CX
    MOV BX, 10
PD_DIV:
    XOR DX, DX
    DIV BX
    PUSH DX
    INC CX
    CMP AX, 0
    JNE PD_DIV
PD_SHOW:
    POP DX
    ADD DL, 30H
    MOV AH, 2
    INT 21H
    LOOP PD_SHOW
    POP DX
    POP CX
    POP BX
    POP AX
    RET
PRINT_DEC ENDP

END MAIN


PB22: Write an assembly program to input two unsigned numbers, multiply them using MUL, and display the product.
File: pb22.asm
----------------------------------------------------------------------------------------

.MODEL SMALL
.STACK 100H
.DATA
    MSG1 DB 'Enter first number (0-9)  : $'
    MSG2 DB 0DH,0AH,'Enter second number (0-9) : $'
    MSG3 DB 0DH,0AH,'Product = $'
.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    LEA DX, MSG1
    MOV AH, 9
    INT 21H
    MOV AH, 1
    INT 21H
    SUB AL, 30H
    MOV BL, AL           ; BL = first number

    LEA DX, MSG2
    MOV AH, 9
    INT 21H
    MOV AH, 1
    INT 21H
    SUB AL, 30H          ; AL = second number

    MUL BL               ; AX = AL * BL (unsigned)
    MOV BX, AX           ; save product

    LEA DX, MSG3
    MOV AH, 9
    INT 21H
    MOV AX, BX
    CALL PRINT_DEC

    MOV AH, 4CH
    INT 21H
MAIN ENDP

PRINT_DEC PROC
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    XOR CX, CX
    MOV BX, 10
PD_DIV:
    XOR DX, DX
    DIV BX
    PUSH DX
    INC CX
    CMP AX, 0
    JNE PD_DIV
PD_SHOW:
    POP DX
    ADD DL, 30H
    MOV AH, 2
    INT 21H
    LOOP PD_SHOW
    POP DX
    POP CX
    POP BX
    POP AX
    RET
PRINT_DEC ENDP

END MAIN


PB23: Write an assembly program to input two signed integers, divide them using IDIV with proper sign extension, and display the quotient and remainder.
File: pb23.asm
----------------------------------------------------------------------------------------

.MODEL SMALL
.STACK 100H
.DATA
    MSG1 DB 'Enter dividend (e.g. -7): $'
    MSG2 DB 0DH,0AH,'Enter divisor  (e.g. 2) : $'
    MSG3 DB 0DH,0AH,'Quotient  = $'
    MSG4 DB 0DH,0AH,'Remainder = $'
    MSG5 DB 0DH,0AH,'Error: division by zero.$'
.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    LEA DX, MSG1
    MOV AH, 9
    INT 21H
    CALL READ_NUM
    MOV BH, AL           ; BH = dividend

    LEA DX, MSG2
    MOV AH, 9
    INT 21H
    CALL READ_NUM
    MOV BL, AL           ; BL = divisor

    CMP BL, 0
    JE  DIV_ZERO

    MOV AL, BH
    CBW                  ; sign-extend AL into AX
    IDIV BL              ; AL = quotient, AH = remainder
    MOV CX, AX           ; CL = quotient, CH = remainder

    LEA DX, MSG3
    MOV AH, 9
    INT 21H
    MOV AL, CL
    CALL PRINT_SIGNED

    LEA DX, MSG4
    MOV AH, 9
    INT 21H
    MOV AL, CH
    CALL PRINT_SIGNED
    JMP EXIT

DIV_ZERO:
    LEA DX, MSG5
    MOV AH, 9
    INT 21H
EXIT:
    MOV AH, 4CH
    INT 21H
MAIN ENDP

READ_NUM PROC            ; reads [-]digit, returns signed value in AL
    PUSH BX
    XOR BL, BL           ; BL = 0 means positive
    MOV AH, 1
    INT 21H
    CMP AL, '-'
    JNE RN_DIGIT
    MOV BL, 1            ; negative
    MOV AH, 1
    INT 21H
RN_DIGIT:
    SUB AL, 30H
    CMP BL, 1
    JNE RN_DONE
    NEG AL
RN_DONE:
    POP BX
    RET
READ_NUM ENDP

PRINT_SIGNED PROC        ; prints signed byte in AL
    PUSH AX
    PUSH DX
    CMP AL, 0
    JGE PS_POS
    PUSH AX
    MOV DL, '-'
    MOV AH, 2
    INT 21H
    POP AX
    NEG AL
PS_POS:
    XOR AH, AH
    CALL PRINT_DEC
    POP DX
    POP AX
    RET
PRINT_SIGNED ENDP

PRINT_DEC PROC
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    XOR CX, CX
    MOV BX, 10
PD_DIV:
    XOR DX, DX
    DIV BX
    PUSH DX
    INC CX
    CMP AX, 0
    JNE PD_DIV
PD_SHOW:
    POP DX
    ADD DL, 30H
    MOV AH, 2
    INT 21H
    LOOP PD_SHOW
    POP DX
    POP CX
    POP BX
    POP AX
    RET
PRINT_DEC ENDP

END MAIN


PB24: Write an assembly program to find the GCD of two positive integers using repeated division and remainder operations.
File: pb24.asm
----------------------------------------------------------------------------------------

.MODEL SMALL
.STACK 100H
.DATA
    MSG1 DB 'Enter first number  : $'
    MSG2 DB 0DH,0AH,'Enter second number : $'
    MSG3 DB 0DH,0AH,'GCD = $'
.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    LEA DX, MSG1
    MOV AH, 9
    INT 21H
    CALL READ_DEC
    MOV BX, AX           ; BX = first number

    LEA DX, MSG2
    MOV AH, 9
    INT 21H
    CALL READ_DEC
    MOV CX, AX           ; CX = second number

    MOV AX, BX           ; A
    MOV BX, CX           ; B
GCD_LOOP:
    CMP BX, 0
    JE  FOUND
    XOR DX, DX
    DIV BX               ; DX = A mod B
    MOV AX, BX           ; A = B
    MOV BX, DX           ; B = remainder
    JMP GCD_LOOP

FOUND:
    MOV CX, AX           ; save GCD
    LEA DX, MSG3
    MOV AH, 9
    INT 21H
    MOV AX, CX
    CALL PRINT_DEC

    MOV AH, 4CH
    INT 21H
MAIN ENDP

READ_DEC PROC            ; reads digits until Enter, returns AX
    PUSH BX
    PUSH CX
    PUSH DX
    XOR BX, BX           ; BX = number so far
RD_LOOP:
    MOV AH, 1
    INT 21H
    CMP AL, 0DH          ; Enter?
    JE  RD_END
    SUB AL, 30H
    XOR AH, AH
    MOV CX, AX           ; CX = digit
    MOV AX, BX
    MOV DX, 10
    MUL DX               ; AX = number * 10
    ADD AX, CX           ; + digit
    MOV BX, AX
    JMP RD_LOOP
RD_END:
    MOV AX, BX
    POP DX
    POP CX
    POP BX
    RET
READ_DEC ENDP

PRINT_DEC PROC
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    XOR CX, CX
    MOV BX, 10
PD_DIV:
    XOR DX, DX
    DIV BX
    PUSH DX
    INC CX
    CMP AX, 0
    JNE PD_DIV
PD_SHOW:
    POP DX
    ADD DL, 30H
    MOV AH, 2
    INT 21H
    LOOP PD_SHOW
    POP DX
    POP CX
    POP BX
    POP AX
    RET
PRINT_DEC ENDP

END MAIN


PB25: Write an assembly program to concatenate two strings and display the combined string.
File: pb25.asm
----------------------------------------------------------------------------------------

.MODEL SMALL
.STACK 100H
.DATA
    S1  DB 'Hello, $'
    S2  DB 'World!$'
    RES DB 20 DUP(?)
.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX
    MOV ES, AX         ; STOSB writes to ES:DI
    CLD
    LEA SI, S1
    LEA DI, RES
C1: LODSB              ; AL = [SI], SI++
    CMP AL, '$'
    JE  C2             ; end of string 1
    STOSB              ; [DI] = AL, DI++
    JMP C1
C2: LEA SI, S2
C3: LODSB
    STOSB
    CMP AL, '$'        ; copy string 2 including '$'
    JNE C3
    LEA DX, RES
    MOV AH, 9
    INT 21H
    MOV AH, 4CH
    INT 21H
MAIN ENDP
END MAIN


PB26: Recursion implementation using assembly language.
File: pb26.asm
----------------------------------------------------------------------------------------

.MODEL SMALL
.STACK 100H
.DATA
    M1 DB 'Enter n (0-8): $'
    M2 DB 0DH,0AH,'Factorial = $'
.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX
    LEA DX, M1
    MOV AH, 9
    INT 21H
    MOV AH, 1
    INT 21H
    SUB AL, 30H
    XOR AH, AH
    MOV CX, AX         ; CX = n
    CALL FACT          ; AX = n!
    MOV BX, AX
    LEA DX, M2
    MOV AH, 9
    INT 21H
    MOV AX, BX
    MOV BX, 10
    XOR CX, CX
P1: XOR DX, DX
    DIV BX
    PUSH DX            ; remainder = next digit
    INC CX
    OR  AX, AX
    JNZ P1
P2: POP DX
    ADD DL, '0'
    MOV AH, 2
    INT 21H
    LOOP P2
    MOV AH, 4CH
    INT 21H
MAIN ENDP

FACT PROC              ; in: CX = n, out: AX = n!
    CMP CX, 1
    JA  REC
    MOV AX, 1          ; base case: 0! = 1! = 1
    RET
REC:
    PUSH CX            ; save n
    DEC CX
    CALL FACT          ; AX = (n-1)!
    POP CX             ; restore n
    MUL CX             ; AX = n * (n-1)!
    RET
FACT ENDP
END MAIN


PB27: Dot Matrix Manipulation.
File: pb27.asm
----------------------------------------------------------------------------------------

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


PB28: Seven Segment Display.
File: pb28.asm
----------------------------------------------------------------------------------------

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


PB29: Report on Project (Hybrid sort).
File: pb29.asm
----------------------------------------------------------------------------------------



========================================================================================
PREVIOUS YEAR QUESTIONS: Q1–Q8
========================================================================================


Q1: Maximum Number from Array
File: q1_py.asm
----------------------------------------------------------------------------------------

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


Q2: String Reverse using String Instructions
File: q2_py.asm
----------------------------------------------------------------------------------------

.MODEL SMALL
.STACK 100H

.DATA
STR DB 'HELLO'
REV DB 5 DUP(?),'$'
MSG DB 'Reversed String: $'

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX
    MOV ES, AX

    LEA SI, STR
    LEA DI, REV+4

    MOV CX, 5
    CLD

L1:
    LODSB
    STOSB
    SUB DI, 2
    LOOP L1

    ; Display message
    LEA DX, MSG
    MOV AH, 9
    INT 21H

    ; Display reversed string
    LEA DX, REV
    MOV AH, 9
    INT 21H

    MOV AH, 4CH
    INT 21H

MAIN ENDP
END MAIN


Q3: Address Calculation & Tracing
File: q3_py.asm
----------------------------------------------------------------------------------------



Q4: Loop Execution Trace
File: q4_py.asm
----------------------------------------------------------------------------------------



Q5: Sum of Even Numbers in Array
File: q5_py.asm
----------------------------------------------------------------------------------------

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


Q6: Factorial using Procedure
File: q6_py.asm
----------------------------------------------------------------------------------------

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


Q7: Count Number of 1s in a Byte
File: q7_py.asm
----------------------------------------------------------------------------------------

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


Q8: Arithmetic Expression + 7-Segment Display
File: q8_py.asm
----------------------------------------------------------------------------------------

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
