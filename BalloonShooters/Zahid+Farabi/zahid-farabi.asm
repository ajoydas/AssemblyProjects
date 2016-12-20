.Model Small
draw_row Macro x,y,z
    Local L1
; draws a line in row x from col 10 to col 300
    MOV AH, 0CH
    MOV AL, 1
    MOV CX, x
    MOV DX, y
L1: INT 10h
    INC CX
    CMP CX,z
    JL L1
    EndM

draw_col Macro x,y,z
    Local L2
; draws a line col y from row 10 to row 189
    MOV AH, 0CH
    MOV AL, 1
    MOV CX, x
    MOV DX, y
L2: INT 10h
    INC DX
    CMP DX, z
    JL L2
    EndM
draw_gun_row Macro a,b,c
    Local L3
    MOV AH,0CH
    MOV AL,2
    MOV CX,a
    MOV DX,b
L3:
    INT 10h
    INC CX
    CMP CX,c
    JL L3
    EndM

draw_gun_column Macro d,e,f
    Local L4
    MOV AH,0CH
    MOV AL,2
    MOV DX,e
    MOV CX,d
L4:
    INT 10h
    DEC DX
    CMP DX,f
    JG L4
    EndM

    
draw_ball Macro x,y
    MOV DX,x
    MOV CX,y
    MOV AH, 0CH ; write pixel
    INT 10h
    INC CX      ; pixel on next col
    INT 10h
    INC DX      ; down 1 row
    INT 10h
    DEC CX      ; prev col
    INT 10h
    DEC DX 
    EndM
    
draw_bullet Macro x,y
    MOV DX,x
    MOV CX,y
    MOV AH, 0CH ; write pixel
    INT 10h
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
    EndM
   
    
.Stack 100h
.Data
new_timer_vec      dw  ?,?
old_timer_vec      dw  ?,?
timer_flag         db  0
vel_x              dw  2
vel_y              dw  3
vel_x1             dw  5
vel_y1             dw  5
GUN_COULUMN        dw  0
GUN_ROW            dw  0
BULLET_ROW         dw  0
BULLET_COULUMN     dw  0
BULLET_FLAG        dw  0
BULLET_FLAG1       dw  0
BULLET_OUT         dw  0
BALLON_ROW_TOP     dw  0
BALLON_ROW_BOTTOM  dw  0
BALLON_COULUMN     dw  0   
BALLON_ROW_TOP1    dw  0
BALLON_ROW_BOTTOM1 dw  0
BALLON_COULUMN1    dw  0  
BULLET_FLAG_ROW    dw  0 
BALLON_BLUST       dw  0
BALLON_BLUST_1     dw  0 
BALLON_ROW1        dw  0
BALLON_COULUMN_1   dw  0
BALLON_ROW2        dw  0
BALLON_COULUMN_2   dw  0
SCORE1             dw  48
SCORE2             dw  48
BALLON_OUT         dw  0
GUN_OUT_ROW1       dw  0
GUN_OUT_ROW2       dw  0
GUN_OUT_COULUMN    dw  0
.Code

set_display_mode Proc
    PUSH CX
    PUSH DX
    PUSH AX
    PUSH BX
    MOV AH, 0
    MOV AL, 04h; 320x200 4 color
    INT 10h
; select palette    
    MOV AH, 0BH
    MOV BH, 1
    MOV BL, 1
    INT 10h
; set bgd color
    MOV BH, 0
    MOV BL, 0
    INT 10h
; draw boundary
    ;draw_row 05
    ;draw_row 194
    ;draw_col 05
    ;draw_col 314
     POP BX
     POP AX
     POP DX
     POP CX 
    RET
set_display_mode EndP


set_menu Proc
    PUSH CX
    PUSH DX
    PUSH AX
    PUSH BX
    
    
    MOV AH, 0
    MOV AL, 04h; 320x200 4 color
    INT 10h
; select palette    
    MOV AH, 0BH
    MOV BH, 1
    MOV BL, 1
    INT 10h
; set bgd color
    MOV BH, 0
    MOV BL, 1
    INT 10h
; draw boundary
    draw_row 90,60,250
    draw_col 90,60,80
    draw_row 90,80,250
    draw_col 250,60,80

LINK:    
    MOV AH, 2   ; move cursor function
    MOV DX,3088   ; row 24, col 39
    XOR BH, BH  ; page 0
    INT 10h  
    MOV AH, 09  ; display character function
    MOV BH, 0   ; page 0
    MOV BL, 1    ; blinking cyan char, red back
    MOV CX, 1  ; display one character
    MOV AL,'S'; character is 'A'
    INT 10h
    MOV AH, 2   ; move cursor function
    MOV DX,3090   ; row 24, col 39
    XOR BH, BH  ; page 0
    INT 10h  
    MOV AH, 09  ; display character function
    MOV BH, 0   ; page 0
    MOV BL, 1    ; blinking cyan char, red back
    MOV CX, 1 
    MOV AL,'T'
    INT 10h
    MOV AH, 2   ; move cursor function
    MOV DX,3091   ; row 24, col 39
    XOR BH, BH  ; page 0
    INT 10h  
    MOV AH, 09  ; display character function
    MOV BH, 0   ; page 0
    MOV BL, 1    ; blinking cyan char, red back
    MOV CX, 1 
    MOV AL,'O'
    INT 10H
     MOV AH, 2   ; move cursor function
     MOV DX,3093   ; row 24, col 39
    XOR BH, BH  ; page 0
    INT 10h  
    MOV AH, 09  ; display character function
    MOV BH, 0   ; page 0
    MOV BL, 1    ; blinking cyan char, red back
    MOV CX, 1 
    MOV AL,'S'
    INT 10H
     MOV AH, 2   ; move cursor function
     MOV DX,3094   ; row 24, col 39
    XOR BH, BH  ; page 0
    INT 10h  
    MOV AH, 09  ; display character function
    MOV BH, 0   ; page 0
    MOV BL, 1    ; blinking cyan char, red back
    MOV CX, 1 
    MOV AL,'T'
    INT 10H
     MOV AH, 2   ; move cursor function
     MOV DX,3095   ; row 24, col 39
    XOR BH, BH  ; page 0
    INT 10h  
    MOV AH, 09  ; display character function
    MOV BH, 0   ; page 0
    MOV BL, 1    ; blinking cyan char, red back
    MOV CX, 1 
    MOV AL,'A'
    INT 10H
     MOV AH, 2   ; move cursor function
     MOV DX,3096   ; row 24, col 39
    XOR BH, BH  ; page 0
    INT 10h  
    MOV AH, 09  ; display character function
    MOV BH, 0   ; page 0
    MOV BL, 1    ; blinking cyan char, red back
    MOV CX, 1 
    MOV AL,'R'
    INT 10H
     MOV AH, 2   ; move cursor function
     MOV DX,3097  ; row 24, col 39
    XOR BH, BH  ; page 0
    INT 10h  
    MOV AH, 09  ; display character function
    MOV BH, 0   ; page 0
    MOV BL, 1    ; blinking cyan char, red back
    MOV CX, 1 
    MOV AL,'T'
    INT 10H
     MOV AH, 2   ; move cursor function
     MOV DX,1968  ; row 24, col 39
    XOR BH, BH  ; page 0
    INT 10h  
    MOV AH, 09  ; display character function
    MOV BH, 0   ; page 0
    MOV BL, 1    ; blinking cyan char, red back
    MOV CX, 1 
    MOV AL,'R'
    INT 10H
     MOV AH, 2   ; move cursor function
     MOV DX,1970  ; row 24, col 39
    XOR BH, BH  ; page 0
    INT 10h  
    MOV AH, 09  ; display character function
    MOV BH, 0   ; page 0
    MOV BL, 1    ; blinking cyan char, red back
    MOV CX, 1 
    MOV AL,'T'
    INT 10H
     MOV AH, 2   ; move cursor function
     MOV DX,1971  ; row 24, col 39
    XOR BH, BH  ; page 0
    INT 10h  
    MOV AH, 09  ; display character function
    MOV BH, 0   ; page 0
    MOV BL, 1    ; blinking cyan char, red back
    MOV CX, 1 
    MOV AL,'O'
    INT 10H
     MOV AH, 2   ; move cursor function
     MOV DX,1973  ; row 24, col 39
    XOR BH, BH  ; page 0
    INT 10h  
    MOV AH, 09  ; display character function
    MOV BH, 0   ; page 0
    MOV BL, 1    ; blinking cyan char, red back
    MOV CX, 1 
    MOV AL,'R'
    INT 10H
     MOV AH, 2   ; move cursor function
     MOV DX,1974  ; row 24, col 39
    XOR BH, BH  ; page 0
    INT 10h  
    MOV AH, 09  ; display character function
    MOV BH, 0   ; page 0
    MOV BL, 1    ; blinking cyan char, red back
    MOV CX, 1 
    MOV AL,'E'
    INT 10H
     MOV AH, 2   ; move cursor function
     MOV DX,1975  ; row 24, col 39
    XOR BH, BH  ; page 0
    INT 10h  
    MOV AH, 09  ; display character function
    MOV BH, 0   ; page 0
    MOV BL, 1    ; blinking cyan char, red back
    MOV CX, 1 
    MOV AL,'S'
    INT 10H
     MOV AH, 2   ; move cursor function
     MOV DX,1976  ; row 24, col 39
    XOR BH, BH  ; page 0
    INT 10h  
    MOV AH, 09  ; display character function
    MOV BH, 0   ; page 0
    MOV BL, 1    ; blinking cyan char, red back
    MOV CX, 1 
    MOV AL,'U'
    INT 10H
     MOV AH, 2   ; move cursor function
     MOV DX,1977  ; row 24, col 39
    XOR BH, BH  ; page 0
    INT 10h  
    MOV AH, 09  ; display character function
    MOV BH, 0   ; page 0
    MOV BL, 1    ; blinking cyan char, red back
    MOV CX, 1 
    MOV AL,'M'
    INT 10H
     MOV AH, 2   ; move cursor function
     MOV DX,1978  ; row 24, col 39
    XOR BH, BH  ; page 0
    INT 10h  
    MOV AH, 09  ; display character function
    MOV BH, 0   ; page 0
    MOV BL, 1    ; blinking cyan char, red back
    MOV CX, 1 
    MOV AL,'E'
    INT 10H
   
    draw_row 90,90,250
    draw_col 90,90,110
    draw_row 90,110,250
    draw_col 250,90,110
    POP BX
    POP AX
    POP DX
    POP CX
   
    RET
set_menu EndP


game_over Proc
    PUSH CX
    PUSH DX
    PUSH AX
    PUSH BX
    
    
    MOV AH, 0
    MOV AL, 04h; 320x200 4 color
    INT 10h
; select palette    
    MOV AH, 0BH
    MOV BH, 1
    MOV BL, 1
    INT 10h
; set bgd color
    MOV BH, 0
    MOV BL, 1
    INT 10h
; draw boundary
    draw_row 90,90,250
    draw_col 90,90,110
    draw_row 90,110,250
    draw_col 250,90,110
   
    MOV AH, 2   ; move cursor function
    MOV DX,3088   ; row 24, col 39
    XOR BH, BH  ; page 0
    INT 10h  
    MOV AH, 09  ; display character function
    MOV BH, 0   ; page 0
    MOV BL, 1    ; blinking cyan char, red back
    MOV CX, 1  ; display one character
    MOV AL,'G'; character is 'A'
    INT 10h
    MOV AH, 2   ; move cursor function
    MOV DX,3089   ; row 24, col 39
    XOR BH, BH  ; page 0
    INT 10h  
    MOV AH, 09  ; display character function
    MOV BH, 0   ; page 0
    MOV BL, 1    ; blinking cyan char, red back
    MOV CX, 1 
    MOV AL,'A'
    INT 10h
    MOV AH, 2   ; move cursor function
    MOV DX,3090   ; row 24, col 39
    XOR BH, BH  ; page 0
    INT 10h  
    MOV AH, 09  ; display character function
    MOV BH, 0   ; page 0
    MOV BL, 1    ; blinking cyan char, red back
    MOV CX, 1 
    MOV AL,'M'
    INT 10H
     MOV AH, 2   ; move cursor function
     MOV DX,3091   ; row 24, col 39
    XOR BH, BH  ; page 0
    INT 10h  
    MOV AH, 09  ; display character function
    MOV BH, 0   ; page 0
    MOV BL, 1    ; blinking cyan char, red back
    MOV CX, 1 
    MOV AL,'E'
    INT 10H
     MOV AH, 2   ; move cursor function
     MOV DX,3093   ; row 24, col 39
    XOR BH, BH  ; page 0
    INT 10h  
    MOV AH, 09  ; display character function
    MOV BH, 0   ; page 0
    MOV BL, 1    ; blinking cyan char, red back
    MOV CX, 1 
    MOV AL,'O'
    INT 10H
     MOV AH, 2   ; move cursor function
     MOV DX,3094   ; row 24, col 39
    XOR BH, BH  ; page 0
    INT 10h  
    MOV AH, 09  ; display character function
    MOV BH, 0   ; page 0
    MOV BL, 1    ; blinking cyan char, red back
    MOV CX, 1 
    MOV AL,'V'
    INT 10H
     MOV AH, 2   ; move cursor function
     MOV DX,3095   ; row 24, col 39
    XOR BH, BH  ; page 0
    INT 10h  
    MOV AH, 09  ; display character function
    MOV BH, 0   ; page 0
    MOV BL, 1    ; blinking cyan char, red back
    MOV CX, 1 
    MOV AL,'E'
    INT 10H
     MOV AH, 2   ; move cursor function
     MOV DX,3096  ; row 24, col 39
    XOR BH, BH  ; page 0
    INT 10h  
    MOV AH, 09  ; display character function
    MOV BH, 0   ; page 0
    MOV BL, 1    ; blinking cyan char, red back
    MOV CX, 1 
    MOV AL,'R'
    INT 10H
     MOV AH, 2   ; move cursor function
     MOV DX,1966  ; row 24, col 39
    XOR BH, BH  ; page 0
    INT 10h  
    MOV AH, 09  ; display character function
    MOV BH, 0   ; page 0
    MOV BL, 1    ; blinking cyan char, red back
    MOV CX, 1 
    MOV AL,'Y'
    INT 10H
     MOV AH, 2   ; move cursor function
     MOV DX,1967  ; row 24, col 39
    XOR BH, BH  ; page 0
    INT 10h  
    MOV AH, 09  ; display character function
    MOV BH, 0   ; page 0
    MOV BL, 1    ; blinking cyan char, red back
    MOV CX, 1 
    MOV AL,'O'
    INT 10H
     MOV AH, 2   ; move cursor function
     MOV DX,1968  ; row 24, col 39
    XOR BH, BH  ; page 0
    INT 10h  
    MOV AH, 09  ; display character function
    MOV BH, 0   ; page 0
    MOV BL, 1    ; blinking cyan char, red back
    MOV CX, 1 
    MOV AL,'U'
    INT 10H
     MOV AH, 2   ; move cursor function
     MOV DX,1969  ; row 24, col 39
    XOR BH, BH  ; page 0
    INT 10h  
    MOV AH, 09  ; display character function
    MOV BH, 0   ; page 0
    MOV BL, 1    ; blinking cyan char, red back
    MOV CX, 1 
    MOV AL,'R'
    INT 10H
     MOV AH, 2   ; move cursor function
     MOV DX,1971  ; row 24, col 39
    XOR BH, BH  ; page 0
    INT 10h  
    MOV AH, 09  ; display character function
    MOV BH, 0   ; page 0
    MOV BL, 1    ; blinking cyan char, red back
    MOV CX, 1 
    MOV AL,'S'
    INT 10H
     MOV AH, 2   ; move cursor function
     MOV DX,1972  ; row 24, col 39
    XOR BH, BH  ; page 0
    INT 10h  
    MOV AH, 09  ; display character function
    MOV BH, 0   ; page 0
    MOV BL, 1    ; blinking cyan char, red back
    MOV CX, 1 
    MOV AL,'C'
    INT 10H
     MOV AH, 2   ; move cursor function
     MOV DX,1973  ; row 24, col 39
    XOR BH, BH  ; page 0
    INT 10h  
    MOV AH, 09  ; display character function
    MOV BH, 0   ; page 0
    MOV BL, 1    ; blinking cyan char, red back
    MOV CX, 1 
    MOV AL,'O'
    INT 10H
     MOV AH, 2   ; move cursor function
     MOV DX,1974  ; row 24, col 39
    XOR BH, BH  ; page 0
    INT 10h  
    MOV AH, 09  ; display character function
    MOV BH, 0   ; page 0
    MOV BL, 1    ; blinking cyan char, red back
    MOV CX, 1 
    MOV AL,'R'
    INT 10H
     MOV AH, 2   ; move cursor function
     MOV DX,1975  ; row 24, col 39
    XOR BH, BH  ; page 0
    INT 10h  
    MOV AH, 09  ; display character function
    MOV BH, 0   ; page 0
    MOV BL, 1    ; blinking cyan char, red back
    MOV CX, 1 
    MOV AL,'E'
    INT 10H
     MOV AH, 2   ; move cursor function
     MOV DX,1977  ; row 24, col 39
    XOR BH, BH  ; page 0
    INT 10h  
    MOV AH, 09  ; display character function
    MOV BH, 0   ; page 0
    MOV BL, 1    ; blinking cyan char, red back
    MOV CX, 1 
    MOV AL,'I'
    INT 10H
   
     MOV AH, 2   ; move cursor function
     MOV DX,1978  ; row 24, col 39
    XOR BH, BH  ; page 0
    INT 10h  
    MOV AH, 09  ; display character function
    MOV BH, 0   ; page 0
    MOV BL, 1    ; blinking cyan char, red back
    MOV CX, 1 
    MOV AL,'S'
    INT 10H
     MOV AH, 2   ; move cursor function
     MOV DX,1979  ; row 24, col 39
    XOR BH, BH  ; page 0
    INT 10h  
    MOV AH, 09  ; display character function
    MOV BH, 0   ; page 0
    MOV BL, 1    ; blinking cyan char, red back
    MOV CX, 1 
    MOV AL,':'
    INT 10H
     MOV AH, 2   ; move cursor function
     MOV DX,1981  ; row 24, col 39
    XOR BH, BH  ; page 0
    INT 10h  
    MOV AH, 09  ; display character function
    MOV BH, 0   ; page 0
    MOV BL, 1    ; blinking cyan char, red back
    MOV CX, 1 
    MOV AL,BYTE PTR SCORE1
    INT 10H
     MOV AH, 2   ; move cursor function
     MOV DX,1982  ; row 24, col 39
    XOR BH, BH  ; page 0
    INT 10h  
    MOV AH, 09  ; display character function
    MOV BH, 0   ; page 0
    MOV BL, 1    ; blinking cyan char, red back
    MOV CX, 1 
    MOV AL,BYTE PTR SCORE2
    INT 10H
    POP BX
    POP AX
    POP DX
    POP CX
   
    RET 
game_over EndP    
    

check_boundary Proc
    CMP BALLON_OUT,10
    JE EXIT7
    CMP BALLON_BLUST,1
    JE DOOM
    CMP DX,06
    JG done
    CMP DX,06
    JLE  OUT_1
         
    
DOOM:
    MOV DX,150
    MOV BALLON_ROW1,DX
    RET
EXIT7:
    CALL game_over
    MOV AH,1
    INT 21H
    MOV AH,4CH
    INT 21H
    
OUT_1:
    INC BALLON_OUT
    MOV DX,150
    MOV BALLON_ROW1,DX
 
done:
    RET 
check_boundary EndP

check_boundary1 Proc
    CMP BALLON_OUT,10
    JE EXIT8
    CMP BALLON_BLUST_1,1
    JE DOOM1
    CMP DX,06
    JG done1
    CMP DX,06
    JLE OUT_
    
DOOM1:
    MOV DX,150
    MOV BALLON_ROW2,DX
    JMP done1
OUT_:
    INC BALLON_OUT
    MOV DX,150
    MOV BALLON_ROW2,DX
    RET
    
EXIT8:
    CALL game_over
    MOV AH,1
    INT 21H
    MOV AH,4CH
    INT 21H
    
done1:
    RET 
check_boundary1 EndP

check_boundary_bullet Proc
    PUSH BX
    PUSH DX
    PUSH CX
    CMP BULLET_COULUMN,300
    JG  MOVE_END
    MOV AX,BALLON_COULUMN
    CMP BULLET_COULUMN,AX
    JG BLUST
    MOV AX,BALLON_COULUMN1
    CMP BULLET_COULUMN,AX
    JG BLUST_1
    
    JMP EXIT6
MOVE_END:
    MOV BULLET_FLAG,0
    MOV BULLET_OUT,1
    MOV BX,BULLET_FLAG1
    MOV BULLET_COULUMN,BX
    JMP EXIT6
    
BLUST:
    MOV AX,BALLON_ROW_TOP
    CMP BULLET_ROW,AX
    JGE BLUST1
    JMP EXIT6

BLUST_1:
    MOV AX,BALLON_ROW_TOP1
    CMP BULLET_ROW,AX
    JGE BLUST1_1
    JMP EXIT6
BLUST1:
    MOV AX,BALLON_ROW_BOTTOM
    CMP BULLET_ROW,AX
    JLE BLUST3
    JMP EXIT6
   
BLUST1_1:
    MOV AX,BALLON_ROW_BOTTOM1
    CMP BULLET_ROW,AX
    JLE BLUST3_1
    JMP EXIT6
BLUST3:
    MOV BALLON_BLUST,1
    INC SCORE2 
    MOV BULLET_FLAG,0
    MOV BULLET_OUT,1
    MOV BX,BULLET_FLAG1
    MOV BULLET_COULUMN,BX
    CMP SCORE2,57
    JE INCREASE
    JMP EXIT6
    
BLUST3_1:
    MOV BALLON_BLUST_1,1
    INC SCORE2
    MOV BULLET_FLAG,0
    MOV BULLET_OUT,1
    MOV BX,BULLET_FLAG1
    MOV BULLET_COULUMN,BX
    CMP SCORE2,57
    JE INCREASE
    JMP EXIT6
 
INCREASE:
    INC SCORE1
    MOV SCORE2,48
EXIT6:
    POP CX
    POP DX
    POP BX
    RET
check_boundary_bullet EndP


display_ball Proc
    
    draw_ball DX,CX
    INC CX
    INC CX
    draw_ball DX,CX
    ADD CX,2
    draw_ball DX,CX
    INC CX
    INC CX
    draw_ball DX,CX
    ADD CX,2
    ADD DX,2
    draw_ball DX,CX
    ADD CX,2
    ADD DX,2
    draw_ball DX,CX
    ADD CX,2
    ADD DX,2
    draw_ball DX,CX
    ADD DX,2
    draw_ball DX,CX
    ADD DX,2
    draw_ball DX,CX
    ADD DX,2
    draw_ball DX,CX
    ADD DX,2
    draw_ball DX,CX
    SUB CX,2
    ADD DX,2
    draw_ball DX,CX
    SUB CX,2
    ADD DX,2
    draw_ball DX,CX
    SUB CX,2
    ADD DX,2
    MOV BALLON_ROW_BOTTOM,DX
    draw_ball DX,CX
    SUB CX,2
    draw_ball DX,CX
    SUB CX,2
    draw_ball DX,CX
    SUB CX,2
    draw_ball DX,CX
    SUB DX,2
    SUB CX,2
    draw_ball DX,CX
    SUB DX,2
    SUB CX,2
    draw_ball DX,CX
    SUB CX,2
    MOV BALLON_COULUMN,CX
   ; SUB BALLON_COULUMN,2
    SUB DX,2
    draw_ball DX,CX
    SUB DX,2
    draw_ball DX,CX
    SUB DX,2
    draw_ball DX,CX
    SUB DX,2
    draw_ball DX,CX
    SUB DX,2
    draw_ball DX,CX
    ADD CX,2
    SUB DX,2
    draw_ball DX,CX
    ADD CX,2
    SUB DX,2
    draw_ball DX,CX
    SUB  dx,2
    ADD CX,2
    PUSH DX
    PUSH CX
    MOV BALLON_ROW_TOP,DX
    ADD CX,4
    ADD DX,20
    draw_ball DX,CX
    ADD DX,2
    draw_ball DX,CX
    ADD DX,2
    draw_ball DX,CX
    ADD DX,2
    draw_ball DX,CX
    POP CX
    POP DX
    RET 
display_ball EndP


display_ball1 Proc

    draw_ball DX,CX
    INC CX
    INC CX
    draw_ball DX,CX
    ADD CX,2
    draw_ball DX,CX
    INC CX
    INC CX
    draw_ball DX,CX
    ADD CX,2
    ADD DX,2
    draw_ball DX,CX
    ADD CX,2
    ADD DX,2
    draw_ball DX,CX
    ADD CX,2
    ADD DX,2
    draw_ball DX,CX
    ADD DX,2
    draw_ball DX,CX
    ADD DX,2
    draw_ball DX,CX
    ADD DX,2
    draw_ball DX,CX
    ADD DX,2
    draw_ball DX,CX
    SUB CX,2
    ADD DX,2
    draw_ball DX,CX
    SUB CX,2
    ADD DX,2
    draw_ball DX,CX
    SUB CX,2
    ADD DX,2
    MOV BALLON_ROW_BOTTOM1,DX
    draw_ball DX,CX
    SUB CX,2
    draw_ball DX,CX
    SUB CX,2
    draw_ball DX,CX
    SUB CX,2
    draw_ball DX,CX
    SUB DX,2
    SUB CX,2
    draw_ball DX,CX
    SUB DX,2
    SUB CX,2
    draw_ball DX,CX
    SUB CX,2
    MOV BALLON_COULUMN1,CX
    SUB DX,2
    draw_ball DX,CX
    SUB DX,2
    draw_ball DX,CX
    SUB DX,2
    draw_ball DX,CX
    SUB DX,2
    draw_ball DX,CX
    SUB DX,2
    draw_ball DX,CX
    ADD CX,2
    SUB DX,2
    draw_ball DX,CX
    ADD CX,2
    SUB DX,2
    draw_ball DX,CX
    SUB  dx,2
    ADD CX,2
    PUSH DX
    PUSH CX
    MOV BALLON_ROW_TOP1,DX
    ADD CX,4
    ADD DX,20
    draw_ball DX,CX
    ADD DX,2
    draw_ball DX,CX
    ADD DX,2
    draw_ball DX,CX
    ADD DX,2
    draw_ball DX,CX
    POP CX
    POP DX
    RET 
display_ball1 EndP


display_gun Proc
    PUSH CX
    PUSH DX
    PUSH BX
    XOR CX,CX
    XOR DX,DX
    XOR BX,BX
    MOV CX,20
    ADD CX,GUN_COULUMN
    MOV GUN_OUT_COULUMN,CX
    MOV DX,100
    ADD DX,GUN_ROW
    MOV GUN_OUT_ROW2,DX
    MOV BX,30
    ADD BX,GUN_COULUMN
    draw_gun_row CX,DX,BX
    
    MOV CX,30
    ADD CX,GUN_COULUMN
    MOV DX,100
    ADD DX,GUN_ROW
    MOV BX,87
    ADD BX,GUN_ROW
    draw_gun_column CX,DX,BX
   
    MOV CX,30
    ADD CX,GUN_COULUMN
    MOV DX,92
    ADD DX,GUN_ROW
    MOV BX,35
    ADD BX,GUN_COULUMN
    draw_gun_row CX,DX,BX
    
    MOV CX,30
    ADD CX,GUN_COULUMN
    MOV DX,87
    ADD DX,GUN_ROW
    MOV BULLET_ROW,DX
    SUB BULLET_ROW,5
    MOV BX,60
    ADD BX,GUN_COULUMN
    MOV BULLET_COULUMN,BX
    ADD BULLET_COULUMN,2
    draw_gun_row CX,DX,BX
  
    MOV CX,35
    ADD CX,GUN_COULUMN
    MOV DX,92
    ADD DX,GUN_ROW
    MOV BX,87
    ADD BX,GUN_ROW
    draw_gun_column CX,DX,BX
 
    MOV CX,20
    ADD CX,GUN_COULUMN
    MOV DX,100
    ADD DX,GUN_ROW
    MOV BX,80
    ADD BX,GUN_ROW
    draw_gun_column CX,DX,BX
    MOV CX,20
    ADD CX,GUN_COULUMN
    MOV DX,80
    ADD DX,GUN_ROW
    MOV GUN_OUT_ROW1,DX
    MOV BX,60
    ADD BX,GUN_COULUMN
    draw_gun_row CX,DX,BX
EXIT3:    
    POP BX
    POP DX
    POP CX
    RET
display_gun EndP

display_bullet Proc
    PUSH CX
    PUSH DX
    PUSH AX
    draw_bullet BULLET_ROW,BULLET_COULUMN
    POP AX
    POP DX
    POP CX
    RET
display_bullet EndP

move_bullet Proc
    PUSH CX
    PUSH DX
    PUSH AX
    MOV AL,0
    CALL display_bullet
    ADD BULLET_COULUMN,15
    CALL check_boundary_bullet
    CMP BULLET_OUT,1
    JE EXIT4
    
test_timer1:
    CMP timer_flag, 1
    JNE test_timer1
    MOV timer_flag, 0
    MOV AL, 3
    CALL display_bullet
    
EXIT4:
    POP AX
    POP DX
    POP CX
    RET
move_bullet EndP

   
move_ball Proc

    MOV AL,0
    CALL display_ball
    SUB DX,vel_y
    MOV BALLON_ROW1,DX
    CALL check_boundary

test_timer:
    CMP timer_flag, 1
    JNE test_timer
    MOV timer_flag, 0
    MOV AL, 3
    CALL display_ball
    MOV BALLON_BLUST,0
    RET 
move_ball EndP


move_ball1 Proc

    MOV AL,0
    CALL display_ball1
    SUB DX,vel_y1
    MOV BALLON_ROW2,DX
    CALL check_boundary1

test_timer2:
    CMP timer_flag, 1
    JNE test_timer2
    MOV timer_flag, 0
    MOV AL, 3
    CALL display_ball1
    MOV BALLON_BLUST_1,0
    RET 
move_ball1 EndP



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



setup_int Proc

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

MOVE_GUN Proc
    PUSH DX
    PUSH CX
    PUSH BX
    PUSH AX
    MOV AH,0FH
    INT 10H
    MOV AH,0
    INT 10H
    POP AX
    CMP AH,72
    JE UP
    CMP AH,75
    JE LEFT
    CMP AH,77
    JE RIGHT
    CMP AH,80
    JE DOWN
    JMP EXIT
    
UP:
    CMP GUN_OUT_ROW1,06
    JL test_time
    SUB GUN_ROW,5
    JMP test_time
    
DOWN:
    CMP GUN_OUT_ROW2,193
    JG test_time
    ADD GUN_ROW,5
    JMP test_time
    
LEFT:
    CMP GUN_OUT_COULUMN,06
    JL test_time
    SUB GUN_COULUMN,5
    JMP test_time
    
RIGHT:
    
    ADD GUN_COULUMN,5
    JMP test_time

test_time:
    CMP timer_flag, 1
    JNE test_time
    MOV timer_flag, 0
    MOV AL, 3
    CALL display_gun
EXIT:
    POP BX
    POP CX
    POP DX
    RET
MOVE_GUN EndP


main Proc
    MOV AX,@data
    MOV DS,AX
    MOV ES,AX
    CALL set_display_mode
START:
    CALL set_menu
    MOV AH,0
    INT 16H
    CMP AH,1Fh
    JE SET
    JMP START    
    
MENU:
    CALL set_menu 
    MOV AH,0
    INT 16H
    CMP AH,1Fh
    JE SET
    CMP AH,13h
    JE temp
    JMP MENU
SET:
    
    CALL set_display_mode
    
    MOV new_timer_vec, offset timer_tick
    MOV new_timer_vec+2, CS
    MOV AL, 1CH; interrupt type
    LEA DI, old_timer_vec
    LEA SI, new_timer_vec
    CALL setup_int
    
    MOV CX,270
    MOV DX,150
    MOV BALLON_ROW1,DX
    MOV BALLON_COULUMN_1,CX
    MOV AL,5
    CALL display_ball
    MOV CX,220
    MOV DX,150
    MOV BALLON_ROW2,DX
    MOV BALLON_COULUMN_2,CX
    CALL display_ball1
    PUSH DX
    PUSH CX
    CALL display_gun
    POP CX
    POP DX
    JMP tt
    
temp:
    CALL set_display_mode
    CALL display_gun
    jmp tt

INPUT:

    MOV AH,0
    INT 16H
    CMP AL,0
    JE tt1
    CMP AH,1Fh
    JE tt3
    CMP AH,19h
    JE MENU
tt:
    MOV AH, 2   ; move cursor function
    MOV DX,0292   ; row 24, col 39
    XOR BH, BH  ; page 0
    INT 10h  
    MOV AH, 09  ; display character function
    MOV BH, 0   ; page 0
    MOV BL, 1    ; blinking cyan char, red back
    MOV CX, 1  ; display one character
    MOV AL,BYTE PTR SCORE1; character is 'A'
    INT 10h
    MOV AH, 2   ; move cursor function
    MOV DX,0293   ; row 24, col 39
    XOR BH, BH  ; page 0
    INT 10h  
    MOV AH, 09  ; display character function
    MOV BH, 0   ; page 0
    MOV BL, 1    ; blinking cyan char, red back
    MOV CX, 1  ; display one character
    MOV AL,BYTE PTR SCORE2; character is 'A'
    INT 10h
    CMP timer_flag, 1
    JNE tt
    MOV timer_flag, 0
    MOV DX,BALLON_ROW1
    MOV CX,BALLON_COULUMN_1
    CALL move_ball
    MOV DX,BALLON_ROW2
    MOV CX,BALLON_COULUMN_2
    CALL move_ball1
    
    PUSH CX
    PUSH DX
    CMP BULLET_FLAG,1
    JE BULLET_MOVE
    POP DX
    POP CX
    MOV AH,01H
    INT 16H
    JNZ INPUT
    JMP tt2
    
tt2:
    CMP timer_flag, 1
    JNE tt2
    MOV timer_flag, 0
    JMP tt
tt1:
    CALL MOVE_GUN
    JMP tt2
tt3:
    CALL  display_bullet
    MOV BX,BULLET_COULUMN
    MOV BULLET_FLAG1,BX
    MOV BULLET_FLAG,1
    MOV BULLET_OUT,0 
    JMP tt2
  
BULLET_MOVE:
    CALL move_bullet
    JMP tt2
    
main EndP
End main







