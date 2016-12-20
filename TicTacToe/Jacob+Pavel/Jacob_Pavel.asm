.Model Small
draw_row Macro x
    Local l1
    MOV AH, 0CH
    MOV CX, 70
    MOV DX, x
L1: INT 10h
    INC CX
    CMP CX, 250
    JL L1
    EndM

draw_col Macro y
    Local l2
    MOV AH, 0CH
    MOV CX, y
    MOV DX, 10
L2: INT 10h
    INC DX
    CMP DX, 190
    JL L2
    EndM

.Stack 100h
.Data 
A DB 9 DUP(0)
curx dw ?
cury dw ?
xx dw ?
xy dw ?
ox dw ?
oy dw ?
col db ?
now db 0
res db 0,0,0,0,0,0,0,0,0
px dw 4 
wtl db 0
m1 db "player 1 wins this round$"
m2 db "player 2 wins this round$"
m3 db "Round $"
m4 db "Score $"
m5 db "Press enter for next round$"
m10 db "Press 's' to save the game$"
m6 db "Round Drawn$"
m7 db "Match Drawn at $"
m8 db "Player 1 wins the match with $"
m9 db "Player 2 wins the match with $"
sm1 db "Welcome to TIC-TAC-TOE$"
sm2 db "Press enter to start the game$"
sm3 db "Rules:$"
sm4 db "Total 8 rounds. Player 1 starts first   round. Player 2 starts 2nd round and so on. Winner of most number of rounds winsthe match.$"
sm5 db "How to Play:$"
sm6 db "Use directional keys to select a block. Press enter to put 'X' or 'O' in the    block$"
sm7 db "Press 's' to start previously saved game$"
gaps db "       $"
gap db "                          $"
jst db 0
round db 0
scr1 db 0
scr2 db 0
emni db '$'
fm db 1
svr db ?
svs1 db ?
svs2 db ?
FILENAME DB "Save.txt",0
BUFFER DB 0,0,0,0
wbuf db 5,3,1
HANDLE DW ?
.Code
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX   ;INITIALIZE DS
    MOV ES,AX   ; AND ES
      ;READ FILENAME
    LEA DX,FILENAME ;DX HAS FILENAME OFFSE
    MOV AL,0        ; ACCESS CODE 0 FOR READING
    CALL OPEN       ;OPEN FILE
    ;JC OPEN_ERROR   ;EXIT IF ERROR 
    MOV HANDLE,AX   ;SAVE HANDLE
    
    
    
    LEA DX, BUFFER ; DX PTS TO BUFFER
    MOV BX,HANDLE ;GET HANDLE
    CALL READ    ;READ FILE. AX = BYTES READ
    
    call close 
    
    call str_msg
    strt:
    CALL set_display_mode
    input:
    mov ah,0h
    int 16h
    cmp ah,72
    je c1
    cmp ah,75
    je c2
    cmp ah,77
    je c3
    cmp ah,80
    je c4
    cmp ah,28
    je cc
    jmp input
    c1:
    cmp cury,11
    je input
    mov col,0
    call draw_block
    mov col,1
    sub cury,60
    call draw_block
    sub px,3
    jmp input
   c4:
   cmp cury,131
    je input
    mov col,0
    call draw_block
    mov col,1
    add cury,60
    call draw_block
    add px,3
    jmp input
    input1: jmp input
    cc: jmp c5
    c2:
    cmp curx,71
    je input
    mov col,0
    call draw_block
    mov col,1
    sub curx,60
    call draw_block
    sub px,1
    jmp input
    c3:
    cmp curx,191
    je input1
    mov col,0
    call draw_block
    mov col,1
    add curx,60
    call draw_block
    add px,1
    jmp input
    c5:
    mov col,1
    mov bx,px
    cmp res[bx],0
    jne input1
    cmp now,1
    je oo
    mov bx,curx
    mov xx,bx
    add xx,1
    mov bx,cury
    add bx,1
    mov xy,bx
    call draw_x
    inc jst
    mov now,1
    mov bx,px
    mov res[bx],1
    call check
    cmp wtl,0
    jne sesh
    cmp jst,9
    je draw
    jmp input
oo:
    mov bx,curx
    mov ox,bx
    add ox,1
    mov bx,cury
    mov oy,bx
    add oy,1
    call draw_o
    inc jst
    mov now,0
    mov bx,px
    mov res[bx],2
    call check
    cmp wtl,0
    jne sesh
    cmp jst,9
    je draw
    jmp input
draw:
call reset
mov ah,5
mov al,2
int 10h
lea dx,m6
mov ah,9
int 21h
lea dx,gap
int 21h
jmp rnd

sesh:
call reset
mov ah,5
mov al,2
int 10h
cmp wtl,1
jg pl2
add scr1,1
lea dx,m1
mov ah,9
int 21h
jmp rnd

pl2:
add scr2,1
lea dx,m2
mov ah,9
int 21h

rnd:
MOV AH,2
MOV DL,0DH
INT 21H
MOV DL,0AH
INT 21H
MOV AH,2
MOV DL,0DH
INT 21H
MOV DL,0AH
INT 21H
lea dx,m4
    mov ah,9
    int 21h
    mov dl,scr1
    add dl,'0'
    mov ah,2
    int 21h
    mov dl,":"
    mov ah,2
    int 21h
    mov dl,scr2
    add dl,'0'
    mov ah,2
    int 21h
    MOV AH,2
    MOV DL,0DH
INT 21H
MOV DL,0AH
INT 21H
MOV AH,2
MOV DL,0DH
INT 21H
MOV DL,0AH
INT 21H
cmp round,8
je result
lea dx,m5
mov ah,9
int 21h
MOV AH,2
MOV DL,0DH
INT 21H
MOV DL,0AH
INT 21H
MOV AH,2
MOV DL,0DH
INT 21H
MOV DL,0AH
INT 21H
lea dx,m10
mov ah,9
int 21h
wat:
mov ah,0h
int 16h
cmp ah,28
je srt1
cmp al,'s'
je willsave
jmp wat
willsave:
call savepl   ; ACCESS CODE 0 FOR READING
jmp wat
srt1: jmp strt
result:
MOV AH,2
    MOV DL,0DH
INT 21H
MOV DL,0AH
INT 21H
mov bl,scr1
cmp bl,scr2
jg win1
jl win2
lea dx,m7
mov ah,9
int 21h
lea dx,m4
    mov ah,9
    int 21h
    mov dl,scr1
    add dl,'0'
    mov ah,2
    int 21h
    mov dl,":"
    mov ah,2
    int 21h
    mov dl,scr2
    add dl,'0'
    mov ah,2
    int 21h
    jmp fin
win1:
lea dx,m8
mov ah,9
int 21h
lea dx,m4
    mov ah,9
    int 21h
    mov dl,scr1
    add dl,'0'
    mov ah,2
    int 21h
    mov dl,":"
    mov ah,2
    int 21h
    mov dl,scr2
    add dl,'0'
    mov ah,2
    int 21h
    jmp fin
win2:
lea dx,m9
mov ah,9
int 21h
lea dx,m4
    mov ah,9
    int 21h
    mov dl,scr1
    add dl,'0'
    mov ah,2
    int 21h
    mov dl,":"
    mov ah,2
    int 21h
    mov dl,scr2
    add dl,'0'
    mov ah,2
    int 21h
    jmp fin   
fin:
mov ah,4ch
int 21h
main endp

CLOSE PROC NEAR
    MOV AH,3EH
    INT 21H
    RET
    CLOSE ENDP

str_msg proc
    MOV AH, 0
    MOV AL, 04h
    INT 10h 
    MOV AH, 0BH
    MOV BH, 1
    MOV BL, 0
    INT 10h
    MOV BH, 0
    MOV BL, 0
    INT 10h
    MOV AH,2
MOV DL,0DH
INT 21H
MOV DL,0AH
INT 21H
mov ah,9
lea dx,sm1
int 21h
mov cx,3
lp2:
MOV AH,2
MOV DL,0DH
INT 21H
MOV DL,0AH
INT 21H
Loop lp2
mov ah,9
lea dx,sm2
int 21h
mov cx,2
lp7:
MOV AH,2
MOV DL,0DH
INT 21H
MOV DL,0AH
INT 21H
Loop lp7
mov ah,9
lea dx,sm7
int 21h
mov cx,8
lp:
MOV AH,2
MOV DL,0DH
INT 21H
MOV DL,0AH
INT 21H
Loop lp
mov ah,9
lea dx,sm3
int 21h
MOV AH,2
MOV DL,0DH
INT 21H
MOV DL,0AH
INT 21H
mov ah,9
lea dx,sm4
int 21h
mov cx,2
lp1:
MOV AH,2
MOV DL,0DH
INT 21H
MOV DL,0AH
INT 21H
loop lp1
mov ah,9
lea dx,sm5
int 21h
MOV AH,2
MOV DL,0DH
INT 21H
MOV DL,0AH
INT 21H
mov ah,9
lea dx,sm6
int 21h
mov ah,2 
again:
mov ah,0h
    int 16h
    cmp ah,28
    je rt
    cmp al,73h
    je sv
    jmp again
sv:
mov dl,buffer[0]
sub dl,'0'
mov round,dl
mov dl,buffer[1]
sub dl,'0'
mov scr1,dl
mov dl,buffer[2]
sub dl,'0'
mov scr2,dl
mov dl,buffer[3]
sub dl,'0'
mov fm,dl
rt: ret
str_msg endp

savepl proc
    MOV AX,@DATA
    MOV DS,AX   ;INITIALIZE DS
    MOV ES,AX   ; AND ES
    lea si,buffer
    mov cl,round
    add cl,30h
    mov [si],cl
   
    lea si,buffer
    mov cl,scr1
    add cl,30h
    mov [si+1],cl
   
    lea si,buffer
    mov cl,scr2
    add cl,30h
    mov [si+2],cl
    
    lea si,buffer
    mov cl,fm
    add cl,30h
    mov [si+3],cl

   
   
    lea dx,FILENAME
    mov al,1
    mov ah,3dh
    int 21h
    JC errr
    mov handle,ax
    lea dx,buffer    
    mov ah,40h
    mov bx,handle
    mov cx,4
    int 21h
    mov ah,3eh
    int 21h
    jmp gogo
    errr:
    lea dx,m1
    mov ah,9
    int 21h
    mov dl,al
    add dl,'0'
    mov ah,2
    int 21h
    gogo:
    ret
    savepl endp
OPEN PROC NEAR
    
    
    MOV AH,3DH
    MOV AL,0
    INT 21H
    RET 
    OPEN ENDP

READ PROC NEAR
    
    PUSH CX
    MOV AH,3FH
    MOV CX,4
    INT 21H
    POP CX
    RET
    READ ENDP
reset proc
   mov al,0
   draw_row 10
   draw_row 70
   draw_row 130
   draw_row 190
   draw_col 70
   draw_col 130
   draw_col 190
   draw_col 250
   mov col,0
   call draw_block
   mov ox,72
   mov oy,12
   mov xx,72
   mov xy,12
   cmp res[0],1
   je rex
   jl cmp2
   call draw_o
   jmp cmp2
   rex:
   call draw_x
   CMP2:
   mov ox,132
   mov oy,12
   mov xx,132
   mov xy,12
   cmp res[1],1
   je rex2
   jl cmp3
   call draw_o
   jmp cmp3
   rex2:
   call draw_x
   CMP3:
   mov ox,192
   mov oy,12
   mov xx,192
   mov xy,12
   cmp res[2],1
   je rex3
   jl cmp4
   call draw_o
   jmp cmp4
   rex3:
   call draw_x
   CMP4:
   mov ox,72
   mov oy,72
   mov xx,72
   mov xy,72
   cmp res[3],1
   je rex4
   jl cmp5
   call draw_o
   jmp cmp5
   rex4:
   call draw_x
   CMP5:
   mov ox,132
   mov oy,72
   mov xx,132
   mov xy,72
   cmp res[4],1
   je rex5
   jl cmp6
   call draw_o
   jmp cmp6
   rex5:
   call draw_x
   CMP6:
   mov ox,192
   mov oy,72
   mov xx,192
   mov xy,72
   cmp res[5],1
   je rex6
   jl cmp7
   call draw_o
   jmp cmp7
   rex6:
   call draw_x
   CMP7:
   mov ox,72
   mov oy,132
   mov xx,72
   mov xy,132
   cmp res[6],1
   je rex7
   jl cmp8
   call draw_o
   jmp cmp8
   rex7:
   call draw_x
   CMP8:
   mov ox,132
   mov oy,132
   mov xx,132
   mov xy,132
   cmp res[7],1
   je rex8
   jl cmp9
   call draw_o
   jmp cmp9
   rex8:
   call draw_x
   CMP9:
   mov ox,192
   mov oy,132
   mov xx,192
   mov xy,132
   cmp res[8],1
   je rex9
   jl cmp10
   call draw_o
   jmp cmp10
   rex9:
   call draw_x
   CMP10:
   RET
   RESET ENDP
   
draw_block proc
    MOV AH,0CH
    MOV AL,col
    MOV CX,curx
    MOV DX,cury
    XOR BX,BX
B2: INT 10H
    INC DX
    INC BX
    CMP BX,58
    JL B2
    MOV DX,cury
    ADD CX,58
    XOR BX,BX
B1: INT 10H
    INC DX
    INC BX
    CMP BX,58
    JL B1
    MOV DX,cury
    MOV CX,curx
    XOR BX,BX
B3: INT 10H
    INC CX
    INC BX
    CMP BX,58
    JL B3
    MOV CX,curx
    ADD DX,58
    XOR BX,BX
B4: INT 10H
    INC CX
    INC BX
    CMP BX,58
    JL B4
    ret
    draw_block endp

draw_x proc
    MOV AH,0CH
    MOV AL,col
    MOV CX,xx
    MOV DX,xy
    XOR BX,BX
x1: int 10h
    inc cx
    inc dx
    inc bx
    cmp bx,58
    jl x1
    MOV CX,xx
    MOV DX,xy
    XOR BX,BX
    add cx,58
x2: int 10h
    dec cx
    inc dx
    inc bx
    cmp bx,58  
    jl x2
    ret
    draw_x endp

draw_o proc
    MOV AH,0CH
    MOV AL,col
    MOV CX,ox
    MOV DX,oy
    add cx,19
    XOR BX,BX
o1: int 10h
    inc cx
    inc bx
    cmp bx,18
    jl o1
    XOR BX,BX
o2: int 10h
    inc cx
    inc dx
    inc bx
    cmp bx,19  
    jl o2
    XOR BX,BX
o3: int 10h
    inc dx
    inc bx
    cmp bx,18  
    jl o3
    XOR BX,BX
o4: int 10h
    dec cx
    inc dx
    inc bx
    cmp bx,19  
    jl o4
    XOR BX,BX
o5: int 10h
    dec cx
    inc bx
    cmp bx,18  
    jl o5
    XOR BX,BX
o6: int 10h
    dec cx
    dec dx
    inc bx
    cmp bx,19  
    jl o6
    XOR BX,BX
o7: int 10h
    dec dx
    inc bx
    cmp bx,18  
    jl o7
    XOR BX,BX
o8: int 10h
    inc cx
    dec dx
    inc bx
    cmp bx,19  
    jl o8
    ret
    draw_O endp

check proc
cmp now,1
je mm2
mov dl,2
jmp cst
mm2: mov dl,1
cst:
xor bx,bx
rr1:
cmp bx,3
je winr1
cmp res[bx],dl
jne rr2s
inc bx
jmp rr1

rr2s:
mov bx,3
rr2:
cmp bx,6
je winr
cmp res[bx],dl
jne rr3s
inc bx
jmp rr2

winr1:
jmp winr

rr3s:
mov bx,6
rr3:
cmp bx,9
je winr
cmp res[bx],dl
jne cc1s
inc bx
jmp rr3

cc1s:
mov bx,0
cc1:
cmp bx,9
je winr
cmp res[bx],dl
jne cc2s
add bx,3
jmp cc1

cc2s:
mov bx,1
cc2:
cmp bx,10
je winr
cmp res[bx],dl
jne cc3s
add bx,3
jmp cc2

cc3s:
mov bx,2
cc3:
cmp bx,11
je winr
cmp res[bx],dl
jne dc1s
add bx,3
jmp cc3

dc1s:
xor bx,bx
dc1:
cmp bx,12
je winr
cmp res[bx],dl
jne dc2s
add bx,4
jmp dc1

dc2s:
mov bx,2
dc2:
cmp bx,8
je winr
cmp res[bx],dl
jne ree
add bx,2
jmp dc2

winr:
mov wtl,dl

ree:
ret

check endp
    
set_display_mode Proc
    add round,1
    MOV AH, 0
    MOV AL, 04h
    INT 10h    
    MOV AH, 0BH
    MOV BH, 1
    MOV BL, 0
    INT 10h
    MOV BH, 0
    MOV BL, 0
    INT 10h
    lea dx,m3
    mov ah,9
    int 21h
    mov dl,round
    add dl,'0'
    mov ah,2
    int 21h
    lea dx,gaps
    mov ah,9
    int 21h
    lea dx,m4
    mov ah,9
    int 21h
    mov dl,scr1
    add dl,'0'
    mov ah,2
    int 21h
    mov dl,":"
    mov ah,2
    int 21h
    mov dl,scr2
    add dl,'0'
    mov ah,2
    int 21h
    
    mov al,2
    draw_row 10
    draw_row 70
    draw_row 130
    draw_row 190
    draw_col 70
    draw_col 130
    draw_col 190
    draw_col 250
    mov curx,131
    mov cury,71
    mov px,4
    mov jst,0
    mov wtl,0
    xor bx,bx
    cmp fm,0
    je p2m
    mov now,0
    mov fm,0
    jmp clr
    p2m:
    mov now,1
    mov fm,1
    clr:
    cmp bx,9
    je done
    mov res[bx],0
    inc bx
    jmp clr
    done:
    mov col,1
    call draw_block 
    
    
    RET
set_display_mode EndP
    END MAIN