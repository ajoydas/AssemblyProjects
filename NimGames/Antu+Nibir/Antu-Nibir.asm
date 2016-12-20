org 100h
.model small
;;top sheet draw
draw_row Macro x
    Local l1
    mov ah,0Ch
    mov al,1
    mov cx,10
    mov dx,x
L1 :int 10h
    inc cx
    cmp cx,301
    jl l1
    endm  

draw_col Macro y
    Local l2
    mov ah,0Ch
    mov al,2
    mov cx,y
    mov dx,10
L2: int 10h
    inc dx
    cmp dx,184
    jl L2
endm

draw_table Macro w    
    Local l4
    mov ah,0Ch
    mov al,1
    mov cx,20
    mov dx,w          
L4  :int 10h
     inc cx
     cmp cx,291
     jl l4
     inc dx
     mov cx,20
     cmp dx,188
     jl l4         

endm      
draw_srow Macro z
    Local l3
    mov ah,0Ch
    mov al,1
    mov cx,100
    mov dx,z
L3  :int 10h
    inc cx
    cmp cx,200
    jl L3
    endm    
;; top sheet end
draw_button macro num1
local l8,l9
    mov cx,10
    mov dx,num1
    mov ah,0ch
    mov al,1
    mov bx,num1
    add bx,10
    l8:
    l9:
    int 10h
    inc dx
    cmp dx,bx
    jl l9
    sub dx,10
    inc cx
    cmp cx,20
    jl l8
endm
draw_grid macro num,col
    local L5,l6,l7
    mov ah,0ch
    mov al,col
    mov cx,bx
    add bx,15
    mov temp,dx
    add temp,35
    mov temp2,0
    l7:
    mov cx,bx
    sub cx,15
    l5:
    l6:
    int 10h
    inc dx
    cmp dx,temp
    jl l6
    sub dx,35
    inc cx
    cmp cx,bx
    jl l5
    add bx,30
    mov cx,num
    inc temp2
    cmp temp2,cx
    jl l7

endm


.stack 100h
.data
;;top sheet 
game_name db 'NIM GAME'
name_size dw $-offset game_name

new_txt db 'START  GAME'
new_size dw $-offset new_txt

cont_txt db 'CONTINUE'
cont_size dw $-offset cont_txt

exit_txt db 'EXIT'
exit_size dw $-offset exit_txt
;;top sheet relate end
temp dw 1 ;;grid related
temp1 dw 4
temp2 dw 9 ;;grid related
temp3 dw 7
temp4 dw 5
temp5 dw 2
menu_set dw 0
sel dw 0
pc dw 0
one dw 1
two dw 3
three dw 5
four dw 7
;;antu


win dw 0
cwin_txt db '!!!COMPUTER WINS!!!'
txt1_size dw $-offset cwin_txt
iwin_txt db '***YOU WIN***'
txt2_size dw $-iwin_txt
file_name db 'save.txt',0
buffer db  6 dup(0)
handle dw ?

move db 'PC'
m_size dw $-offset move
movv db 'TURN'
mm_size dw $-offset movv

menu db 'MENU'
ng_size dw $-offset menu

save_btn db 'SAVE'
sv_size dw $-offset save_btn
                            
;error db 'ERROR'
;err_size dw $-offset error                            


.code


continue_when proc
call load
;mov one,1
;mov two,2
;mov three,3
;mov four,4
    call draw_grid_fnc
    cmp one,1
    je nxtt
    mov bx,140
    mov dx,10
    draw_grid 1,0
    nxtt:
    cmp two,3
    je nxttt
    mov cx,3
    sub cx,two
    mov temp4,cx
    mov bx,110
    mov dx,60
    draw_grid temp4,0
    nxttt:
    cmp three,5
    je nxtttt
    mov cx,5
    sub cx,three
    mov temp4,cx
    mov bx,80
    mov dx,110
    draw_grid temp4,0
    nxtttt:
    cmp four,7
    je nxttttt
    mov cx,7
    sub cx,four
    mov temp4,cx
    mov bx,50
    mov dx,160
    draw_grid temp4,0
    nxttttt:
    
    ret
continue_when endp

;;function segment
    
Load proc
    lea dx,file_name
    mov al,0
    mov ah,3dh
    int 21h
    jc xxxxx
    mov handle,ax    
    lea dx,buffer
    mov bx,handle
    mov ah,3Fh
    mov al,0
    mov cx,6
    int 21h   
    
    lea si,buffer
    mov dl,[si]
    sub dl,'0'
    mov dh,0
    mov one,dx     
    mov dl,[si+1]
    sub dl,'0'
    mov dh,0
    mov two,dx     
    
    mov dl,[si+2]
    sub dl,'0'
    mov dh,0
    mov three,dx    
    
    mov dl,[si+3]
    sub dl,'0'
    mov dh,0
    mov four,dx
                    
    mov dl,[si+4]
    sub dl,'0'
    mov dh,0
    mov pc,dx
                 
    mov dl,[si+5]
    sub dl,'0'
    mov dh,0
    mov sel,dx
    jmp close
     XXXXX:
     draw_row 4
    
    
    close:    
    mov bx,handle
    mov ah,3eh
    int 21h
    ret   
load endp    
    
    
    
    
    
    
    
    
    
top_sheet_fnc proc
draw_row 10    
    ;draw_row 189
    draw_table 184
    draw_col 100
    draw_col 200    
     
     
    draw_srow 50    
    draw_srow 70    
    draw_srow 95    
    draw_srow 120
    draw_srow 145
     
        
    print_Title:
    MOV AL,1
    MOV BH,0
    MOV BL,00111001b
    MOV CX,name_size
    MOV DL,15
    MOV DH,7
    MOV BP,OFFSET game_name
    mov ah,13h
    int 10h
    
    print_start:
    mov al,1
    mov bh,0
    mov bl,00111010b
    mov cx,new_size
    mov dl,13
    mov dh,10
    mov bp,offset new_txt
    mov ah,13h
    int 10h
    
    print_cont:
    mov al,1
    mov bh,0
    mov bl,00111010b
    mov cx,cont_size
    mov dl,15
    mov dh,13
    mov bp,offset cont_txt
    mov ah,13h
    int 10h
    
    print_exit:
    mov al,1
    mov bh,0
    mov bl,00111001b
    mov cx,exit_size
    mov dl,17
    mov dh,16
    mov bp,offset exit_txt
    mov ah,13h
    int 10h
    
    Mouse_start:
    mov ax,0
    int 33h
    
    ShowMouse:
    mov ax,1
    int 33h
     
    CheckingClicked:
        mov ax,3
        int 33h
        cmp bx,1
        jne checkingClicked
    shr cx,1
    Pos_Check:
    cmp cx,100
    jl CheckingClicked
    cmp cx,200
    jg  CheckingClicked
    cmp dx,70
    jl CheckingClicked
    cmp dx,145
    jg CheckingClicked
    cmp dx,95
    jl  new_game 
    cmp dx,120
    jl  continue
    cmp dx,145
    jle exit
    
    
  
    mov ah,0
    mov al,04h
    int 10h    
    mov ah,0bh
    mov bh,0
    mov bl,0Fh
    int 10h  
    
    mov ah,0bh
    mov bh,1
    mov bl,0
    int 10h       
    new_game:
    call set
    mov ah,0
    mov al,04h
    int 10h    
    mov ah,0bh
    mov bh,1;;change
    mov bl,0Fh
    int 10h   
    
    mov ah,0bh
    mov bh,1
    mov bl,0
    int 10h
    
    call draw_grid_fnc
    call mouse_fnc
    jmp cxp
    
    continue:
    mov ah,0
    mov al,04h
    int 10h
    
    mov ah,0bh
    mov bh,1;;done change 
    mov bl,0Fh
    int 10h
    
    
    mov ah,0bh
    mov bh,1
    mov bl,0
    int 10h    
;;one,two,three,four,sel,pc -- load

    ;call load  
    call continue_when
    call mouse_fnc
    jmp cxp
    
    exit:
    
    mov ah,4ch
    int 21h
    
    ;;code
    cxp:
    ret
top_sheet_fnc endp    
    

row_check proc
    mov dx,0
    mov cx,0
    mov bx,0
    add cx,one
    add cx,two
    add cx,three
    add cx,four
    
    cmp one,1
    jne m_m20
    inc dx
    inc bx
    m_m20:
    cmp two,1
    jl m_m21
    jne m_40
    inc bx
    m_40:
    inc dx
    ;inc bx
    m_m21:
    cmp three,1
    jl m_m22
    jne m_41
    inc bx
    m_41:
    inc dx
    m_m22:
    cmp four ,1
    jl m_m23 
    
    jne m_140
    inc bx
    m_140:
    inc dx
    m_m23:
    ret
row_check endp


;;done this fnc
draw_grid_fnc proc ;;grid draw only
    draw_button 25
    draw_button 75
    draw_button 125
    draw_button 175

    mov bx,140
    mov dx,10
    draw_grid 1,2
    mov bx,110
    mov dx,60
    draw_grid 3,2
    mov bx,80
    mov dx,110
    draw_grid 5,2
    mov bx,50
    mov dx,160
    draw_grid 7,2
    mov bx,250
    mov dx,100
    draw_grid 1,3
    mov bx,265
    mov dx,100
    draw_grid 1,3
    mov bx,280
    mov dx,100
    draw_grid 1,3
    
    mov bx,305
    mov dx,165
    draw_grid 1,1
    mov bx,290
    mov dx,165
    draw_grid 1,1
    mov bx,275
    mov dx,165
    draw_grid 1,1
    
    mov bx,250
    mov dx,0
    draw_grid 1,1
    mov bx,265
    mov dx,0
    draw_grid 1,1
    mov bx,280
    mov dx,0
    draw_grid 1,1
    
    pc___mov:
    MOV AL,1
    MOV BH,0
    MOV BL,11000011b
    MOV CX,m_size
    MOV DL,33 ;; col num of move
    MOV DH,13  ;; row num of move
    MOV BP,OFFSET move
    mov ah,13h
    int 10h
    MOV CX,mm_size
    MOV DL,32 ;; col num of move
    MOV DH,15  ;; row num of move
    MOV BP,OFFSET movv
    mov ah,13h
    int 10h
    
    mov al,1
    mov bh,0
    mov bl,11000001b
    mov cx,ng_size
    mov dl,35 ;; col num of new game 
    mov dh,22 ;; row num of new game
    mov bp,offset menu
    mov ah,13h
    int 10h
    
    
    mov al,1
    mov bh,0
    mov bl,11000111b
    mov cx,sv_size
    mov dl,32 ;; col num of save button
    mov dh,2 ;; row num of save button
    mov bp,offset save_btn
    mov ah,13h
    int 10h
    
    ret
draw_grid_fnc endp


mouse_fnc proc
    
    lvl:
    
    mov ax,1
    int 33h
    mov ax,3
    int 33h
    cmp bx,1
    jne click
    call menu_click
    cmp menu_set,1
    jne ppp
    ret
     
    ppp:
    call mouse_operation
    cmp win,1
    jl click
    call pc_win
    ret
    click:
    dec temp3
    mov bx,0
    xor cx,cx
    xor dx,dx
    jmp lvl
    ret
mouse_fnc endp

menu_click proc
    cmp cx,550 
    jl rent
    cmp dx,165
    jl rent
    mov menu_set,1
    rent:
    ret
menu_click endp

mouse_operation proc

    
    
    cmp cx,500
    jl m_m
    cmp cx,590
    jg return1
    cmp dx,100
    jl m_m
    cmp dx,135
    jg m_m
    cmp pc ,0
    jne return1
    call pc_move
    mov sel,0
    mov pc,1
    call row_check
    cmp cx,1
    jne return1
    mov win,2
    
    return1:
    
    ret
    m_m:
    CMP CX,500
    JL M_M7777
    CMP CX,590
    JG M_M7777
    cmp dx,35
    jg m_m7777
    call save_fnc
    ret
    m_m7777:
    
    
    
    cmp cx,20
    jl return1
    cmp cx,40
    jg  return1
    ;
    
    cmp dx,25
    jl return1
    
    cmp dx,35
    jg m_m1
    
    
    
    cmp one,0
    je return1
    cmp sel,0
    jne c_p1
    mov sel,1
    c_p1:
    
    cmp sel,1
    jne return1
    
    mov bx,140
    mov dx,10
    draw_grid 1,0
    mov one,0
    mov pc,0
    return2:
    ret
    
    m_m1:
    cmp dx,75
    jl return2
    cmp dx,85
    jg m_m2;ioio1
    cmp two,0
    je return2
    cmp sel,0
    jne c_p2
    mov sel,2
    c_p2:
    cmp sel,2
    jne return2
    dec two
    
    c_p3:
    mov temp4,3
    mov cx,two
    sub temp4,cx
    mov bx,110
    mov dx,60
    draw_grid temp4,0
    call delay 
    return3: 
    ret
    m_m2:
    cmp dx,125
    jl return3
    cmp dx,135
    jg m_m3;ioio22
    cmp three,0
    je return3
    cmp sel,0
    jne c_p4
    mov sel,3
    c_p4:
    cmp sel,3
    jne return3
    ;jmp ioio2
    ;ioio22:
    ;jmp m_m3
    ;ioio2:
    
    dec three
    
    mov temp4,5
    mov cx,three
    sub temp4,cx
    mov bx,80
    mov dx,110
    draw_grid temp4,0
    call delay 
    return4:
    ret
    m_m3:
    
    cmp dx,175
    jl return4
    cmp dx,185
    jg return4
    cmp four,0
    je return4
    cmp sel,0
    jne c_p6
    mov sel,4
    c_p6:
    cmp sel,4
    jne return4
    
    dec four
    mov temp4,7
    mov cx,four
    sub temp4,cx
    mov bx,50
    mov dx,160
    draw_grid temp4,0
    call delay 
    return5:
    ret
mouse_operation endp



fun_time proc
    mov cx,four;
    cmp cx,two
    jG t3;
    mov cx,two
    t3:
    cmp cx,three
    jG t4
    mov cx,three
    t4:
    mov temp4,cx
    
    
    
    mov ah,00h
    int 1Ah
    
    mov ax,dx
    
    xor dx,dx
    ;sub ax,1
    ;mul bx
    mov cx,temp4
    div cx
    cmp dx,0
    jg rnt
    mov dx,1
    rnt:
    ret
fun_time endp

save_fnc proc
    convert:
    lea si,buffer
    mov cx,one
    add cl,30h
    mov [si],cl
    
    lea si,buffer
    mov cx,two
    add cl,30h
    mov [si+1],cl
    
    lea si,buffer
    mov cx,three
    add cl,30h
    mov [si+2],cl
    
    lea si,buffer
    mov cx,four
    add cl,30h
    mov [si+3],cl
    
    lea si,buffer
    mov cx,pc
    add cl,30h
    mov [si+4],cl
    
    lea si,buffer
    mov cx,sel
    add cl,30h
    mov [si+5],cl
    
    
    lea dx,file_name
    mov al,1
    mov ah,3dh
    int 21h
    mov handle,ax 
    lea dx,buffer    
    mov ah,40h
    mov bx,handle
    mov cx,6
    int 21h
    mov ah,3eh
    int 21h
    ret
save_fnc endp



pc_move proc
    call row_check
    cmp dx,2
    jl one_op111
    je two_op111 
   cmp dx,3
    je three_op111
    cmp bx,3
    je nxt20
    call brute
    ret
    nxt20:
    cmp two,1
    jle nxt21
    mov bx,110
    mov dx,60
    draw_grid 3,0
    mov two,0
    ret
    
    one_op111:
    jmp one_op
    two_op111:
    jmp two_op
    three_op111:
    jmp three_op
    
    nxt21:
    cmp three,1
    jle nxt22
    mov bx,80
    mov dx,110
    draw_grid 5,0
    mov three,0
    ret
    nxt22:
    mov bx,50
    mov dx,160
    draw_grid 7,0
    mov four,0
    ret
    
    two_op:
    jmp two_op_2
    three_op:
    jmp three_op_3
    
    one_op:
    cmp two,1
    jle nxt10
    mov bx,110
    mov dx,60
    draw_grid 2,0
    mov two,1
    ret
    
    nxt10:
    cmp three,1
    jle nxt11
    mov bx,80
    mov dx,110
    draw_grid 4,0
    mov three,1
    ret
    nxt2089:
    jmp nxt20
    nxt11:
    mov bx,50
    mov dx,160
    draw_grid 6,0
    mov four,1
    ret
    one_opop:
    jmp one_op
    two_op_2:
    cmp bx,1
    je nxt2089
    call brute
    ret
    three_op_3:
    cmp bx,2
    je one_opop;
    call brute
    ret
pc_move endp



xor_op proc
    mov bx,two
    xor bx,one
    xor bx,three
    xor bx,four
    ret
xor_op endp

brute proc
    call xor_op
    cmp bx,0
     je nxt4002
     mov cx,one
     mov one ,0
     call xor_op
     cmp bx,0
     jne nxt
     mov bx,140
     mov dx,10
     draw_grid 1,0
     ret
     nxt4002:
     jmp nxt4001
     nxt:
     mov one,cx
     mov cx,two
     mov temp1,cx
     cek:
     dec two
     call xor_op
     cmp bx,0
     je done
     cmp two,0
     jg cek
     mov cx,temp1
     mov two,cx
     jmp nxt2
     done:
     mov temp4,3
     mov cx,two
     sub temp4,cx
     mov bx,110
     mov dx,60
     draw_grid temp4,0
     ret
     nxt4001:
     jmp nxt400
     nxt2:
     
     mov cx,three
     mov temp1,cx
     cek1:
     dec three
     call xor_op
     cmp bx,0
     je done1
     cmp three,0
     jg cek1
     mov cx,temp1
     mov three,cx
     jmp nxt3
     done1:
     mov temp4,5
     mov cx,three
     sub temp4,cx
     mov bx,80
     mov dx,110
     draw_grid temp4,0
     ret
     
     nxt3:
     
     
     mov cx,four
     mov temp1,cx
     cek2:
     dec four
     call xor_op
     cmp bx,0
     je done2
     cmp temp1,0
     jg cek2
     ;mov cx,temp1
     ;mov four,cx
     ;jmp nxt400
     done2:
     mov temp4,7
     mov cx,four
     sub temp4,cx
     mov bx,50
     mov dx,160
     draw_grid temp4,0
     ret
     nxt400:
     call fun_time
     ;mov dx,1
     
     ;mov cx,50
     ;mov bx,200
     ;draw_grid 2,1
     
     cmp one,dx
     jne nxt500
     mov temp4,dx
     mov bx,140
     mov dx,10
     draw_grid temp4,0
     dec one
     ret
     
     nxt500:
     cmp two,dx
     jl nxt600
     sub two,dx
     mov temp4,3
     mov cx,two
     sub temp4,cx
     mov bx,110
     mov dx,60
     draw_grid temp4,0
     
     ret
     
     nxt600:
     cmp three,dx
     jl nxt700
     sub three,dx
     mov cx,three
     mov temp4,5
     sub temp4,cx
     mov bx,80
     mov dx,110
     draw_grid temp4,0
     
     ret
     nxt700:
     sub four,dx
     mov cx,four
     mov temp4,7
     sub temp4,cx
     mov bx,50
     mov dx,160
     draw_grid temp4,0
     
     nxt8:     
     ret
brute endp

delay proc
    mov pc,0
    mov bx,1000
    
    m_m13:
    mov cx,1000
    m_m12:
    loop m_m12
    
    dec bx
    cmp bx,0
    jne m_m13
    call row_check
    cmp cx,1
    jne m_m33
    mov win,1
    
    m_m33:
    ret
delay endp


pc_win proc
    mov cx,1000
    
    lll2:
    mov bx,500
    lll1:
    dec bx
    cmp bx,0
    jg lll1
    loop lll2
    
    
    
    mov ah,0
    mov al,04h
    int 10h
    
    mov ah,0bh
    mov bh,0
    mov bl,0Fh
    int 10h
    
    
    mov ah,0bh
    mov bh,1
    mov bl,0
    int 10h
    
    draw_row 10
    draw_row 30
    draw_row 169    
    draw_row 189    
    draw_col 20
    draw_col 40
    draw_col 280
    draw_col 300
    
    cmp win,2
    je Computer
    cmp win,1
    je I_win
    
    Computer:;;title of the game
    
    MOV AL,1
    MOV BH,0
    MOV BL,00111010b
    MOV CX,txt1_size
    MOV DL,12
    MOV DH,13
    MOV BP,OFFSET cwin_txt
    mov ah,13h
    INT 10H
    ret
    
    I_win:;;title of the game
    
    MOV AL,1
    MOV BH,0
    MOV BL,00111010b
    MOV CX,txt2_size
    MOV DL,15
    MOV DH,13
    MOV BP,OFFSET iwin_txt
    mov ah,13h
    INT 10H 
ret
pc_win endp

set proc
    mov one,1
    mov two,3
    mov three,5
    mov four ,7
    mov pc,0
    mov sel,0
    mov temp4,0
    mov temp3,0
    mov win,0
    ret
set endp




main proc
    mov ax,@data
    mov ds,ax
    mov es,ax 
    
    
    restart:
    call set
    ;set display mode
    mov ah,0
    mov al,04h
    int 10h
  
    mov ah,0bh
    mov bh,1;;chane done
    mov bl,0Fh
    int 10h
    
    mov ah,0bh
    mov bh,1
    mov bl,0
    int 10h
    
    
    call top_sheet_fnc
    
    mov temp4,9
    cmp menu_set,1
    je popo
    
    del:
    call delay 
    dec temp4
    cmp temp4,0
    jg del 
    popo:
    call delay
    mov menu_set,0
    jmp restart

    ; mov ah,4Ch
    ;int 21h
    
    
     
main endp 
end main

