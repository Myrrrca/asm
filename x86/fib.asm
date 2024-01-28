
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h

mov ax, 1
mov dx, 0
add ax, dx
mov cl, 10
call add2num
mov si, offset numbers
loop_2:
cmp cl, 0
jz loop_2_out
mov ax, [si]
call d2str
;inc si
;mov [si], 32
mov ah, 9
int 21h
dec cl
inc si
inc si
jmp loop_2

loop_2_out:

ret

add2num:
pusha

mov di, offset numbers
    
add2num_loop:
cmp cl, 0
jz add2num_out
mov [di], ax
mov bx, ax
add ax, dx  
inc di
inc di
mov dx, bx
dec cl
jmp add2num_loop
    

add2num_out:
mov [di], '$' 

popa
ret 

d2str: ;number to str converter    
;ax - number
;returns adress of str in dx
pusha
mov cx, sp     
d2str_loop:
    mov dx, 0
    mov bx, 10
    div bx
    push dx
    cmp ax, 0
    jz d2str_out
    jmp d2str_loop  

d2str_out:
mov di, offset str 

d2str_loop2:
cmp cx, sp
jz d2str_out2
pop dx
add dx, 48
mov [di], dx

inc di
jmp d2str_loop2

d2str_out2:
inc di
mov [di], 32
mov [di], '$'
popa 
mov dx, offset str
ret  
    
numbers: dw '0','0','0','0','0','0','0','0','0','0','0' 
str: db 0,0,0,0,0,0 

end