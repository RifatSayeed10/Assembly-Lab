.MODEL SMALL
.STACK 100H
.CODE
MAIN PROC
    MOV DL, '3'     ; DL = '3'
    ADD DL, 2       ; DL = '5'
    MOV AH, 2       ; 2 = "একটা অক্ষর দেখাও"
    INT 21H         ; DOS-কে ডাকো -> স্ক্রিনে DL দেখায়
    MOV AH, 4CH     ; 4CH = "প্রোগ্রাম শেষ"
    INT 21H         ; return 0;
MAIN ENDP
END MAIN