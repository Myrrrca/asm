
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h
    
    
    call saveGreet1
    mov ah, 9
    int 21h      ;print greet1
    
    call inputNum1
    mov cx, dx   ;cx - adress of num1 (ackii)
    
    mov ah, 2
    mov dl, 10
    int 21h 
    mov ah, 02h
    mov dl, 13
    int 21h
    call saveGreet2
    mov ah, 9
    int 21h      ;print greet2
    
    call inputNum2
    mov bx, dx   ;bx - adress of num2 (ackii) 
    
    mov ah, 2
    mov dl, 10
    int 21h 
    mov ah, 02h
    mov dl, 13
    int 21h
    call saveGreet3
    mov ah, 9
    int 21h      ;print greet3
    
    call add2num
    mov ah, 9
    int 21h      ;print num3
    
    
    
    
    
ret

char2strTest: ;char to str converter  
;ax - char (ackii)
;returns adress of str in dx
pusha

mov di, offset strTest

mov [di], ax
inc di
mov [di], '$'

popa 
mov dx, offset strTest
ret                    
            
strTest: db 0, 0

inputNum1: ;takes number (ackii)
;8 numbers at max 
;returns adress of str in dx (as ackii)
pusha

mov bx, 0 ;counter

loopNum1:
mov ah, 7
int 21h

cmp al, 13
jz loopNum1_out  ;enter pressed? 
 
mov ah, 0  ;ax - char(ackii)

mov di, offset strToShow

mov [di], ax
;mov cx, [di]  ;cx - char(ackii)
inc di
mov [di], '$'

mov di, offset num1Str
add di, bx
mov [di], ax  

mov dx, offset strToShow 
mov ah, 9
int 21h

add bx, 1


jmp loopNum1:
 
loopNum1_out:
inc di
mov [di], '$'

popa
 
mov dx, offset num1Str
ret                    
            
strToShow: db 0, 0
num1Str: db 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 


inputNum2: ;takes number (ackii)
;8 numbers at max 
;returns adress of str in dx (as ackii)
pusha

mov bx, 0 ;counter

loopNum2:
mov ah, 7
int 21h

cmp al, 13
jz loopNum2_out  ;enter pressed? 
 
mov ah, 0  ;ax - char(ackii)

mov di, offset strToShow2

mov [di], ax
;mov cx, [di]  ;cx - char(ackii)
inc di
mov [di], '$'

mov di, offset num1Str2
add di, bx
mov [di], ax  

mov dx, offset strToShow2 
mov ah, 9
int 21h

add bx, 1


jmp loopNum2:
 
loopNum2_out:
inc di
mov [di], '$'

popa
 
mov dx, offset num1Str2
ret                    
            
strToShow2: db 0, 0
num1Str2: db 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 
 

saveGreet1: ;saves greet1 in memory
;returns adress of greet1 in dx 
pusha   

popa

mov dx, offset greet1

ret

greet1: db "Enter the first value (one number):  $",


saveGreet2: ;saves greet2 in memory
;returns adress of greet2 in dx 
pusha   

popa

mov dx, offset greet2

ret

greet2: db "Enter the second value (one number): $",


saveGreet3: ;saves greet3 in memory
;returns adress of greet3 in dx 
pusha   

popa

mov dx, offset greet3

ret

greet3: db "Result of num1 + num2: $",


add2num: ;addes num1 (as ackii) with num2 (as ackii)
;cx - adress of num1
;bx - adress of num2
;returns adress of result in dx (as ackii)  

pusha 
mov dx, 0     ;counter
 
loopAdd2num1: 
mov di, cx
add di, dx  
cmp [di], '$'
jz loopAdd2num1_out


sub [di], 48
mov ax, [di]   
mov ah, 0      ;ax - num1 (decimal)

mov di, bx
add di, dx
cmp [di], '$'
jz loopAdd2num1_out
sub [di], 48   
add [di], ax   ;[di] - (num1 + num2) (decimal)
add [di], 48
mov ax, [di]   
mov ah, 0      ;ax - (num1 + num2) (ascii)
push ax

inc dx
jmp loopAdd2num1

loopAdd2num1_out:

mov di, offset nADDn
pop ax

loopAdd2num2: 


mov [di], ax 
inc di
cmp dx, 1 
jz loopAdd2num2_out

pop ax
dec dx
jmp loopAdd2num2

loopAdd2num2_out:

mov di + 0, '$'

popa

mov dx, offset nADDn

ret

nADDn: db 0, 0, 0, 0, 0, 0, 0, 0, 0, 0


  

end




