.Model Small
draw_row Macro x
    Local l1
; draws a line in row x from col 10 to col 300
    MOV AH, 0CH
    MOV AL, 1
    MOV CX, 10
    MOV DX, x
L1: INT 10h
    INC CX
    CMP CX, 301
    JL L1
    EndM

draw_col Macro y
    Local l2
; draws a line col y from row 10 to row 189
    MOV AH, 0CH
    MOV AL, 1
    MOV CX, y
    MOV DX, 10
L2: INT 10h
    INC DX
    CMP DX, 190
    JL L2
    EndM

.Stack 100h
.Data
new_timer_vec   dw  ?,?
old_timer_vec   dw  ?,?
timer_flag  db  0
vel_x       dw  3
vel_y       dw  0
ColCX dw 165,158, 100 dup (150)
RowDX dw 100,100, 100 dup (100)
Len dw 4
CurrLen dw '?'
headcx dw '?'
headdx dw '?'
lastpressed db 'd'
FoodArrayCx dw 201,147,15,249,276,180,84,147,15,249,0
FoodArrayDX dw 22,49,151,40,121,136,142,115,85,112,0
tailcx dw '?'
taildx dw '?'
points dw 4
score dw 0
flag dw 0
gameovermsg db "OOPS!! your snake died! :P ", 0
.Code

set_display_mode Proc
; sets display mode and draws boundary
    MOV AH, 0
    MOV AL, 04h; 320x200 4 color
    INT 10h
; select palette    
    MOV AH, 0BH
    MOV BH, 1
    MOV BL, 0
    INT 10h
; set bgd color
    MOV BH, 0
    MOV BL, 10; cyan
    INT 10h
; draw boundary
    draw_row 10
    draw_row 189
    draw_col 10
    draw_col 300
    
    RET
set_display_mode EndP



readchar proc
    mov ah, 01H
    int 16H
    jnz keybdpressed
    xor dl, dl
    ret
keybdpressed:
    ;extract the keystroke from the buffer
    mov ah, 00H
    int 16H
    mov dl,al
    ret
readchar endp                    
         

keyboardfunctions proc
    
    call readchar
    cmp dl, 0
    je HelpNext_14
    
    
    cmp lastpressed,'d'
    je LastWasD
    cmp lastpressed,'a'
    je LastWasA
    cmp lastpressed,'s'
    je LastWasS
    cmp lastpressed,'w'
    je LastWasW
    
LastWasD:
    cmp dl,'a'
    je HelpNext_14
    jmp valid    
LastWasA:
    cmp dl,'d'
    je next_14
    jmp valid
LastWasW:
    cmp dl,'s'
    je HelpNext_14
    jmp valid 
LastWasS:
    cmp dl,'w'
    je HelpNext_14
    jmp valid
    
HelpNext_14:
    jmp next_14
    
valid:
;   so a key was pressed, which key was pressed then?
    mov lastpressed,dl
    cmp dl, 'w'
    jne next_11
    mov bx, 0
    mov vel_x,bx
    mov bx,3
    neg bx
    mov vel_y,bx
    ret
next_11:
    cmp dl, 's'
    jne next_12
    mov bx,3
    mov vel_y,bx
    mov bx,0
    mov vel_x,bx
    ret
next_12:
    cmp dl, 'a'
    jne next_13

    mov bx, 3
    neg bx
    mov vel_x,bx
    mov bx,0
    mov vel_y,bx
    ret
next_13:
    cmp dl, 'd'
    jne next_14

    mov bx, 3
    mov vel_x,bx
    mov bx,0
    mov vel_y,bx
next_14:    
    
    ret        
keyboardfunctions endp













display_food proc
; displays ball at col CX and row DX with color given in AL
; input: AL = color of ball
;    CX = col
;    DX = row
    
    
    
    MOV AH, 0CH ; write pixel
    INT 10h
    lea si,foodarraycx
    lea di,foodarraydx
    mov bx,points
    mov cx,[si+bx]
    mov dx,[di+bx]
    
    int 10h 
    INC CX      ; pixel on next col
    INT 10h
    INC CX
    INT 10h
    INC DX      ; down 1 row
    INT 10h
    INC DX
    INT 10h
    DEC CX      ; prev col
    INT 10h
    DEC CX
    INT 10h
    DEC DX 
    INT 10h
    DEC DX
    INT 10H

    
  
    RET 
display_food EndP




display_ball Proc
; displays ball at col CX and row DX with color given in AL
; input: AL = color of ball
;    CX = col
;    DX = row
    
    lea si, colcx
    lea di, rowdx
    
  ;  mov cx,[si]
  ;  mov dx,[di]
    
     mov bx,0
    
     MOV AH, 0CH ; write pixel
     INT 10h
ShowBody:      
    cmp bx,len
    je jmpRet
    mov cx,[si+bx]
    mov dx,[di+bx]   
    int 10h 
    INC CX      ; pixel on next col
    INT 10h
    INC CX
    INT 10h
    INC DX      ; down 1 row
    INT 10h
    INC DX
    INT 10h
    DEC CX      ; prev col
    INT 10h
    DEC CX
    INT 10h
    DEC DX 
    INT 10h
    DEC DX
    INT 10H
    inc bx
    inc bx
    jmp ShowBody
   
JmpRet:
    CALL Display_Food
    RET 
display_ball EndP






timer_tick Proc
    PUSH DS
    PUSH AX
    
    MOV AX, Seg timer_flag
    MOV DS, AX
    MOV timer_flag, 1
    
    POP AX
    POP DS
    
    IRET
timer_tick EndP

outdec proc
    push ax
    push bx
    push cx
    push dx
    
    or ax,ax
    jge @end_if1
    
    push ax
    mov dl,'-'
    mov ah,2
    int 21h
    pop ax
    neg ax
    
@end_if1:
    xor cx,cx
    mov bx,10d

@repeat1:
    xor dx,dx
    div bx
    push dx
    inc cx
    
    or ax,ax
    jne @repeat1
    
    mov ah,2
    
@print_loop:
    pop dx
    or dl,30h
    int 21h
    loop @print_loop
    
    pop dx
    pop cx
    pop bx
    pop ax
    
    ret
    
outdec endp



ATE_FOOD proc
    lea si,Foodarraycx
    lea di,foodarraydx
    mov bx,points
checkx:
     mov cx,headcx
     mov ax,[si+bx]
     cmp ax,cx
     je checky
     ret
checky:
     mov dx,headdx
     mov ax,[di+bx]
     cmp ax,dx
     je IncreaseLength
     ret
IncreaseLength:
    
    mov ax,score
    add ax,10
    mov score,ax
    mov bx,len
    mov ax,tailcx
    mov [si+bx],ax
    mov ax,taildx
    mov [di+bx],ax
    add bx,2
    mov len,bx
    
    mov al,0
    call display_food
    mov al,3
    
    mov bx,points
    add bx,2
    mov points,bx
    ret
    
ATE_FOOD EndP


move_ball Proc
; erase ball at current position and display at new position
; input: CX = col of ball position
;    DX = rwo of ball position
; erase ball
    
    MOV AL, 0
    CALL display_ball
    
    CALL keyboardfunctions 
    ; get new position


    LEA si,colcx
    lea di,rowdx
    
    mov bx,[si+0]
    add bx,vel_x
    mov headcx,bx
    
    mov bx,[di+0]
    add bx,vel_y
    mov headdx,bx
    
    ;new co-ordinate is saved in headcx and headdx
    mov bx,len
    sub bx,2
    mov ax,[si+bx]
    mov tailcx,ax
    mov ax,[di+bx]
    mov taildx,ax
    jmp shift
    


    
    ;SHIFT ALL THE ELEMENT TO LEFT BY ONE
Shift:
    mov cx,[si+bx-2]
    mov [si+bx],cx
    mov ax,[di+bx-2]
    mov [di+bx],ax
    dec bx
    dec bx
    cmp bx,2
    jge Shift
    
;now push head in array
    
    mov bx,headcx
    mov [si],bx
    
    mov bx,headdx
    mov [di],bx
    
    
    mov CX, headcx
    mov DX, headdx
    mov [si+0],cx
    mov [di+0],dx

; check boundary
    CALL ATE_FOOD
    mov cx,headcx
    mov dx,headdx
    CALL check_boundary
    
; wait for 1 timer tick to display ball
test_timer:
    CMP timer_flag, 1
    JNE test_timer
    MOV timer_flag, 0
    MOV AL, 3
    CALL display_ball
    CALL display_food
    RET 
move_ball EndP

check_boundary Proc
; determine if ball is outside screen, if so move it back in and 
; change ball direction
; input: CX = col of ball
;    DX = row of ball
; output: CX = valid col of ball
;     DX = valid row of ball
; check col value
    CMP CX, 13
    JG LP1
    jmp Quit
     
LP1:    
    CMP CX, 296
    JL LP2
    jmp Quit
    ; check row value
LP2:    
    CMP DX, 13
    JG LP3
    jmp Quit
    
LP3:    
    CMP DX, 185
    JL done
    jmp Quit
Quit:
    mov flag,1
    

    
done:
    RET 
check_boundary EndP

setup_int Proc
; save old vector and set up new vector
; input: al = interrupt number
;    di = address of buffer for old vector
;    si = address of buffer containing new vector
; save old interrupt vector
    MOV AH, 35h ; get vector
    INT 21h
    MOV [DI], BX    ; save offset
    MOV [DI+2], ES  ; save segment
; setup new vector
    MOV DX, [SI]    ; dx has offset
    PUSH DS     ; save ds
    MOV DS, [SI+2]  ; ds has the segment number
    MOV AH, 25h ; set vector
    INT 21h
    POP DS
    RET
setup_int EndP









main Proc
    MOV AX, @data
    MOV DS, AX
    
; set graphics display mode & draw border
    CALL set_display_mode
; set up timer interrupt vector
    MOV new_timer_vec, offset timer_tick
    MOV new_timer_vec+2, CS
    MOV AL, 1CH; interrupt type
    LEA DI, old_timer_vec
    LEA SI, new_timer_vec
    CALL setup_int
; start ball at col = 298, row = 100
; for the rest of the program CX = ball row, DX = ball col
    ;lea si,colcx
    ;lea di,rowdx
    ;MOV CX, [si+0]
    ;MOV DX, [di+0]
    ;MOV AL, 3
    ;CALL display_ball
    
; wait for timer tick before moving the ball
tt:
    cmp flag,1
    je ses
    CMP timer_flag, 1
    JNE tt
    MOV timer_flag, 0
    CALL move_ball
tt2:
    CMP timer_flag, 1
    JNE tt2
    MOV timer_flag, 0
    JMP tt
    
ses:
        
mov ah,2
mov ax,score
;add dl,30h
;int 21h
call outdec

main EndP
End main
