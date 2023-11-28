org 0x7C00

;takes string from input, saved and prints it
        ;lea di, string
        mov di, [string]

        loop1:
          mov ah, 0
          int 0x16
          mov ah, 0x0e
          int 0x10
          mov [di], al  ;save char in mem
          cmp al, 0x0d
          jz loop1_out
          inc di
          jmp loop1

        loop1_out:
          mov byte [di], 0

          mov ah, 0x0e
          mov al, 0x0a
          int 0x10
          mov al, 0xd
          int 0x10    ;newline

        mov di, string

        loop2:        ;output string from mem
          mov al, [di]
          cmp al, 0x0
          jz loop2_out
          int 0x10
          inc di
          jmp loop2

        loop2_out:

        mov ah, 0x0e
        mov al, 0x0a
        int 0x10
        mov al, 0xd
        int 0x10    ;newline

        

;takes bx (as binary) and prints it in decimal
        mov bx, 0x4c2f 
        ;mov bl, 0x4c
        ;mov bh, 0x2f
        mov ax, bx
        mov dx, 0
        mov bx, 10
        mov cx, 0     ;saving current stack position
        loop3:
          div bx
          push dx   
          mov dx, 0
          cmp ax, 0
          jz loop3_out
          inc cx
          jmp loop3

        loop3_out:

        pop dx
        mov di, [num1]
        loop4:
          add dx, 48
          mov [di], dx
          inc di
          cmp cx, 0   ;do until stack goes right back
          jz loop4_out
          dec cx
          pop dx
          jmp loop4

        loop4_out:

        mov byte [di], 0
        mov di, [num1]
        mov ah, 0x0e
        loop5:         ;output num1 from mem
          mov al, [di]
          cmp al, 0x0
          jz loop5_out
          int 0x10
          inc di
          jmp loop5

        loop5_out:

        mov ah, 0x0e
        mov al, 0x0a
        int 0x10
        mov al, 0xd
        int 0x10    ;newline

;takes string from input and prints it using stack
       loop6:
          mov ah, 0
          int 0x16
          mov ah, 0x0e
          int 0x10 
          push ax
          cmp al, 0x0d
          jz loop6_out
          jmp loop6

        loop6_out:
          mov byte [di], 0

          mov ah, 0x0e
          mov al, 0x0a
          int 0x10
          mov al, 0xd
          int 0x10    ;newline


        loop7:        ;output string from stack
          cmp al, 0x0
          jz loop7_out
          int 0x10 
          pop ax
          jmp loop7

        loop7_out:

        




jmp $

string: db 0 dup(16)
num1: db 0 dup(16)


times 510 - ($ - $$) db 0
db 0x55, 0xAA
