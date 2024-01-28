
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h
    
    loopTest:
    mov ah, 7 
    int 21h
    cmp al, 13
    jz loopTest_out
    mov ah, 0
    call char2strTest
    mov ah, 9
    int 21h
    dec bl
    jmp loopTest
    
    loopTest_out:
    
    mov ah, 2
    mov dl, 10
    int 21h 
    mov ah, 02h
    mov dl, 13
    int 21h
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
    
    mov ax, 1
    call add2num ;dx - adress of num3
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
num1Str: db 0, 0, 0, 0, 0, 0, 0, 0, 0 


inputNum2: ;takes number (ackii)
;8 numbers at max 
;returns adress of str in dx (as ackii)
pusha

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
num1Str2: db 0, 0, 0, 0, 0, 0, 0, 0, 0 
 

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


add2num: ;addes num1 with num2 
;cx - adress of num1 (ackii)
;bx - adress of num2 (ackii)
;returns adress of result in dx (as ackii)  
pusha 

push bx

add2num_main:      

mov di, offset count
cmp [di], 0
jz endAdd2Num
cmp [di], 1
jz doNum2

doNum1:
mov di, cx     ;cx - adress of num1
push cx
;push cx
jmp doNumStart

doNum2:
pop bx 
mov di, bx     ;bx - adress of num2
push bx 
;push bx
jmp doNumStart

doNumStart: 

cvtNum1ToDec_loop:  ;converts num (as str) from ackii to decimal (as str)
cmp [di], '$'
jz cvtNum1ToDec_loop_out     
sub [di], 48        
inc di

jmp cvtNum1ToDec_loop 

cvtNum1ToDec_loop_out:
mov di, count
cmp [di], 1
jz doNum2_2


doNum1_2:
pop cx;
mov di, cx     ;;adress of num1 (as decimal str)
jmp doNumStart2

doNum2_2:
pop bx 
mov di, bx     ;;adress of num2 (as decimal str)
jmp doNumStart2

doNumStart2:

;mov ax, 0       ;prev_number
mov cx, 10
;mov dx, 0
;mov bx, 0
      


;mov bx, [di]    ;bx - current_last_visible_number
cmp di+1, '$'   ;if bx - last number
jz  cvtNum1ToDec2_loop_out  ;end loop
mov dx, 0       ;for mul down

mov al, [di]    
mov ah, 0       ;ax keeps first number
;mov cx, 10
mul cx          ;(dx) ax - current (last) number * 10       

inc di
mov bl, [di]    
mov bh, 0       ;bx - second number
add bx, ax      ;now bx - our current number (xx number in decimal)

mov dx, 0
cvtNum1ToDec2_loop:

;mov di, offset count
;cmp [di], 1
;jz doNum2_2

;mov bx, [di]   ;bx - current_last_visible_number
cmp di+1, '$'   ;if bx - last number
jz  cvtNum1ToDec2_loop_out  ;end loop 
;mov dx, 0

mov ax, bx      ;ax keeps current number (now previous)
;mov cx, 10
mul cx          ;(dx) ax - current (last) number * 10       

inc di
add ax, [di]    ;ax - our current actual number (xxx number and more)
sub ah, [di+1]  ;kostil' from add operation above
mov bx, ax      ;now bx - our (maybe) final number 
push bx

inc dx
jmp cvtNum1ToDec2_loop

cvtNum1ToDec2_loop_out:

mov di, offset count 
cmp [di], 1
jz saveNum2 

saveNum1:
;pop cx
mov di, offset num1
jmp wNumInMem

saveNum2:
;pop bx
mov di, offset num2
jmp wNumInMem

wNumInMem:

;pop bx
;mov [di+1], bl
mov [di], bx

pop bx
loopMakeBXfree:
cmp dx, 0
jz loopMakeBXfree_out
pop bx
dec dx
jmp loopMakeBXfree

loopMakeBXfree_out:



mov di, offset count
cmp [di], 1
jz saveNum2_2

saveNum1_2:
mov cx, offset num1
jmp checkLastNum

saveNum2_2:
mov bx, offset num2
jmp checkLastNum

checkLastNum:
mov di, count
dec [di]
cmp [di], 0
jz  endAdd2Num
jmp add2num_main

endAdd2Num:     ;num3 - num1+num2 
mov di, offset num1
mov ax, [di]
mov di, offset num2
mov bx, [di]
add ax, bx
mov di, offset num3
mov [di], ax


popa

mov dx, offset num3

ret

num1: db 0, 0
num2: db 0, 0
count: db 2
num3: db 0, 0


  

end




