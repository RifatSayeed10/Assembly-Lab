CSE 3210 - 8086 Assembly Lab Programs (Problems 02-12)
Assembler style: MASM/TASM, .MODEL SMALL

File mapping
------------
pb2.asm  - Hello World (repository: hello.asm)
pb3.asm  - Input two characters and print them (repository: input_twonum.asm)
pb4.asm  - MOV, XCHG, ADD, SUB, INC, DEC, NEG (created; no matching repo file)
pb5.asm  - Sum of two input digits (repository: sum.asm)
pb6.asm  - Input a character and display it on the next line (repository: newline.asm)
pb7.asm  - Print a string (repository: string.asm)
pb8.asm  - Convert lowercase to uppercase (repository: lower.asm)
pb9.asm  - Display Carry Flag (repository: carry.asm)
pb10.asm - Display character codes 20H through FFH (created; no matching repo file)
pb11.asm - Absolute value and display (repository: absolute.asm)
pb12.asm - Check and display uppercase input (repository: ckupper.asm)

Source and changes
------------------
- Repository-matched programs follow the corresponding public repository source:
  https://github.com/RifatSayeed10/Asm-tasm
- pb3.asm uses the repository program structure, but the newline sequence is
  CR (0DH) followed by LF (0AH), the standard DOS order.
- pb4.asm and pb10.asm were written for the missing problems.

Important limitations
---------------------
- pb3.asm accepts two single characters; it does not parse multi-digit numbers.
- pb5.asm is the repository's simple ASCII-addition version. It prints a
  correct single-character digit result only when the sum is 0 through 9.
  A sum of 10 through 18 needs a two-digit output routine.
- pb8.asm converts lowercase a-z; other characters are printed unchanged.
- pb9.asm displays only the Carry Flag value from the operation.
- pb10.asm starts at 20H and runs through FFH. Control/extended character
  appearance depends on the DOS emulator's code page; 7FH is non-printing.
- pb11.asm uses the repository's AAM-based two-digit output and test value -25.
  It is intended for absolute values from 0 through 99.
- pb4.asm stores the final AX and BX values in RESULTAX and RESULTBX memory
  variables; it does not print those values.

Open each .asm file in an 8086 MASM/TASM-compatible emulator.
