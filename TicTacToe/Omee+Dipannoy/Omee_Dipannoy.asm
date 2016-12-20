.MODEL SMALL

RESULT MACRO FIRST,SECOND,THIRD
    LOCAL FUNC1
    LOCAL FUNC2
    LOCAL FUNC3
    
    
    XOR BX,BX
    MOV BX,FIRST
    ADD BX,SECOND
    ADD BX,THIRD
    
    
    CMP BX,0
    JE FUNC1
    JNE FUNC2
    
    
    FUNC1:
    CALL PLAYER1STATUS
    
    
    FUNC2:
    CMP BX,3
    JNE FUNC3
    CALL PLAYER2STATUS
    
    
    FUNC3:
    ENDM
    
    
CIRCLE MACRO C,D
    MOV AH,2
    MOV BH,0
    MOV DH,C
    MOV DL,D
    INT 10H
       
    MOV AH,9
    MOV AL,'O'
    MOV BL,5 
    MOV CX,1
    INT 10H
    ENDM

    
CROSS MACRO A,B
    MOV AH,2
    MOV BH,0
    MOV DH,A
    MOV DL,B
    INT 10H 
        
    MOV AH,9
    MOV AL,'X'
    MOV BL,2 ;colour
    MOV CX,1 ;how many times
    INT 10H
    ENDM
        

ROWFUNCTION MACRO ONE,TWO,THREE
    LOCAL STRTLN1
    MOV CX,ONE
    MOV DX,THREE
    MOV AL,4 ;red colour
    STRTLN1: 
    INT 10H
    INC CX
    CMP CX,TWO
    JNG STRTLN1
    ENDM
    
    
COLUMNFUNCTION macro EK,DUI,TIN
    LOCAL STRTLN2
    MOV CX,EK
    MOV DX,DUI
    MOV AL,4
    STRTLN2:
    INT 10H
    INC DX
    CMP DX,TIN
    JNG STRTLN2
    ENDM
    
.STACK 100H  

.DATA
    FLAG DW 0   ;flag to check P pressed or not
    FLAG2 DW 0
    ENDFLAG DW 0 ;flag to check E pressed or not
    FL DW 0  ;flag for determining whose move
    
    F1 DW 9
    F2 DW 9
    F3 DW 9
    F4 DW 9
    F5 DW 9
    F6 DW 9
    F7 DW 9
    F8 DW 9
    F9 DW 9
    
    POS DW 5
    
    QUITGAMEMESSAGE DB 'he Game has ended!!$'
    THANKSMESSAGE DB 'hank you f0r playing!!$'
    GAMEBYMESSAGE DB 'Game by: Sadman & Dip$'
    TIEMESSAGE DB 'It is a tie!!$'
    GAMENAME DB 'Tic Tac Toe$'
    PLAYGAME DB 'Play(P)$'
    EXITGAME DB 'Exit(E)$'
    
.CODE  

MODEON PROC
    MOV AH,0
    MOV AL,13H
    INT 10H
    RET
    
ROWGAME PROC
    MOV AH,0CH
    MOV AL,14 ;colour
    MOV CX,70
    MOV DX,10
    
    ROWLINE1:
        INT 10h
        INC CX
        CMP CX,250
        JNGE ROWLINE1
        
    ROWLINE1S:
        MOV CX,70
        ADD DX,60
        CMP DX,250
        JE  RETURN1
        JMP ROWLINE1
    
    RETURN1: 
        RET        
        
COLUMNGAME PROC
    MOV AH,0CH
    MOV AL,3
    MOV CX,70
    mov DX,10
    
    
    COLUMNLINE1:
        INT 10H
        INC DX
        CMP DX,190
        JNGE COLUMNLINE1
        
        
    COLUMNLINE1S:
        MOV DX,10
        ADD CX,60
        CMP CX,310
        JE RETURN2
        JMP COLUMNLINE1
        
    
    RETURN2: 
        RET
        
      
        
BOX1 PROC
         CMP BX,1
         JNE ENDBOX1
         ROWFUNCTION 70,130,10
         ROWFUNCTION 70,130,70
         COLUMNFUNCTION 130,10,70
         COLUMNFUNCTION 70,10,70
         
         ENDBOX1:
         RET
BOX2 PROC
         CMP BX,2
         JNE ENDBOX2
         ROWFUNCTION 130,190,10
         ROWFUNCTION 130,190,70
         COLUMNFUNCTION 130,10,70
         COLUMNFUNCTION 190,10,70
        
         ENDBOX2:
         RET
BOX3 PROC
         CMP BX,3
         JNE ENDBOX3
         ROWFUNCTION 190,250,10
         ROWFUNCTION 190,250,70
         COLUMNFUNCTION 190,10,70
         COLUMNFUNCTION 250,10,70
         
         ENDBOX3: 
         RET
BOX4 PROC 
         CMP BX,4
         JNE ENDBOX4   
         ROWFUNCTION 70,130,70  
         ROWFUNCTION 70,130,130
         COLUMNFUNCTION 130,70,130
         COLUMNFUNCTION 70,70,130
         
         ENDBOX4: 
         RET
BOX5 PROC
         CMP BX,5
         JNE ENDBOX5
         ROWFUNCTION 130,190,70
         ROWFUNCTION 130,190,130
         COLUMNFUNCTION 130,70,130
         COLUMNFUNCTION 190,70,130
         
         ENDBOX5:     
         RET
BOX6 PROC
        CMP BX,6
        JNE ENDBOX6
        ROWFUNCTION 190,250,70
        ROWFUNCTION 190,250,130
        COLUMNFUNCTION 250,70,130
        COLUMNFUNCTION 190,70,130
        
        ENDBOX6:  
        RET
BOX7 PROC
        CMP BX,7
        JNE ENDBOX7
        ROWFUNCTION 70,130,130
        ROWFUNCTION 70,130,190
        COLUMNFUNCTION 70,130,190
        COLUMNFUNCTION 130,130,190
         
        ENDBOX7:
        RET  
BOX8 PROC
        CMP BX,8
        JNE ENDBOX8
        ROWFUNCTION 130,190,130
        ROWFUNCTION 130,190,190
        COLUMNFUNCTION 190,130,190
        COLUMNFUNCTION 130,130,190
        
        ENDBOX8:
        RET 
BOX9 PROC
        CMP BX,9
        JNE ENDBOX9
        ROWFUNCTION 190,250,130
        ROWFUNCTION 190,250,190
        COLUMNFUNCTION 190,130,190
        COLUMNFUNCTION 250,130,190
        
        ENDBOX9:
        RET
        
BLACKSCREEN PROC   ;clears the screen
        MOV AH,0CH
        MOV AL,0 
        MOV BH,0
        MOV DX,0
    
        PCOLb:    
        MOV CX,0
    
        COLOURPAGEb: 
        INT 10H
        INC CX  
        CMP CX,320
        JL COLOURPAGEb
        INC DX
        CMP DX,200
        JL PCOLb
        RET        
        
MAINMENU PROC     ;the main menu
        CALL BLACKSCREEN
        
        ROWFUNCTION 80,250,30
        ROWFUNCTION 80,250,165
        COLUMNFUNCTION 80,30,165
        COLUMNFUNCTION 250,30,165
        ROWFUNCTION 80,250,90
        ROWFUNCTION 80,250,130
        
        MOV AH,02
        MOV BH,0
        MOV DH,7
        MOV DL,15
        INT 10H
     
        MOV AH,9
        LEA DX,GAMENAME
        INT 21H
        
        MOV AH,02
        MOV BH,0
        MOV DH,13
        MOV DL,17
        INT 10H
     
        MOV AH,9
        LEA DX,PLAYGAME
        INT 21H
        
        MOV AH,02
        MOV BH,0
        MOV DH,18
        MOV DL,17
        INT 10H
     
        MOV AH,9
        LEA DX,EXITGAME
        INT 21H
        
        RET
        
ENDGAMEPROCESS PROC ;ending game by some finishing words
        CALL BLACKSCREEN
        
        MOV AH,02
        MOV BH,0
        MOV DH,5
        MOV DL,10
        INT 10H
     
        MOV AH,9
        MOV AL,'T'
        MOV BL,2
        MOV CX,1
        INT 10H
        
        MOV AH,02
        MOV BH,0
        MOV DH,5
        MOV DL,11
        INT 10H
     
        MOV AH,9
        LEA DX,QUITGAMEMESSAGE
        INT 21H
        
        MOV AH,02
        MOV BH,0
        MOV DH,8
        MOV DL,9
        INT 10H
     
        MOV AH,9
        MOV AL,'T'
        MOV BL,2
        MOV CX,1
        INT 10H
        
        MOV AH,02
        MOV BH,0
        MOV DH,8
        MOV DL,10
        INT 10H
     
        MOV AH,9
        LEA DX,THANKSMESSAGE
        INT 21H
        
        MOV AH,02
        MOV BH,0
        MOV DH,22
        MOV DL,10
        INT 10H
     
        MOV AH,9
        LEA DX,GAMEBYMESSAGE
        INT 21H
        RET
        
CIRCLEASSIGN proc
    XOR BX,BX
    MOV BX,F1
    CMP BX,0
    JE M1
    JNE N1
    M1:
    CIRCLE 5,12
    
    N1:
    XOR BX,BX
    MOV BX,F2
    CMP BX,0
    je M2
    JNE N2
    M2:
    CIRCLE 5,20
   
    N2:
    XOR BX,BX
    MOV BX,F3
    CMP BX,0
    je M3
    JNE N3
    M3:
    CIRCLE 5,27
    
    N3:
    
    XOR BX,BX
    MOV BX,F4
    CMP BX,0
    je M4
    JNE N4
    M4:
    CIRCLE 13,12
    
    N4:
    XOR BX,BX
    MOV BX,F5
    CMP BX,0
    je M5
    JNE N5
    M5:
    CIRCLE 13,20
    
    N5:
    XOR BX,BX
    MOV BX,F6
    CMP BX,0
    je  M6
    JNE N6
    M6:
    CIRCLE 13,27
    
    N6:
    XOR BX,BX
    MOV BX,F7
    cmp bx,0
    je M7
    JNE N7
    M7:
    CIRCLE 20,12
    
    N7:
    XOR BX,BX
    mov bx,F8
    CMP BX,0
    je M8
    JNE N8
    M8:
    CIRCLE 20,20
    
    N8:
    XOR BX,BX
    MOV BX,F9
    CMP BX,0
    je M9
    JNE LAST
    M9:
    CIRCLE 20,27
    
    
    LAST:
    RET
    
        
CROSSASSIGN proc
    XOR BX,BX
    MOV BX,F1
    CMP BX,1
    je G1
    JNE H1
    G1:
    CROSS 5,12
    
    H1:
    XOR BX,BX
    MOV BX,F2
    CMP BX,1
    je  G2
    JNE H2
    G2:
    CROSS 5,20
    
    H2:
    XOR BX,BX
    MOV BX,F3
    CMP BX,1
    je G3
    JNE H3
    G3:
    CROSS 5,27
    
    H3:
    
    XOR BX,BX
    MOV BX,F4
    CMP BX,1
    je G4
    JNE H4
    G4:
    CROSS 13,12
    
    H4:
    XOR BX,BX
    MOV BX,F5
    CMP BX,1
    je G5
    JNE H5
    G5:
    CROSS 13,20
    
    H5:
    XOR BX,BX
    MOV BX,F6
    CMP BX,1
    je  G6
    JNE H6
    G6:
    CROSS 13,27
    
    H6:
    XOR BX,BX
    MOV BX,F7
    CMP BX,1
    je G7
    jne H7
    G7:
    CROSS 20,12
    
    H7:
    XOR BX,BX
    MOV BX,F8
    CMP BX,1
    je G8
    JNE H8
    G8:
    CROSS 20,20
    
    H8:
    XOR BX,BX
    MOV BX,F9
    CMP BX,1
    je G9
    JNE LAST2
    G9:
    CROSS 20,27
    
    
    LAST2:
    RET
   
    
CIRCLEFUNCTION proc
    MOV BX,POS
    CMP BX,1
    JNE T1
    
    MOV BX,F1
    CMP BX,9
    JNE T1
    CMP BX,1
    je T1
    MOV BX,0
    mov F1,bx
    INC FL
    
    T1:
    MOV BX,POS
    CMP BX,2
    jne T2
    
    MOV BX,F2
    CMP BX,9
    jne T2
    CMP BX,1
    je T2
    MOV BX,0
    mov F2,bx
    INC FL
    
    T2:
    MOV BX,POS
    CMP BX,3
    JNE T3
    
    MOV BX,F3
    CMP BX,9
    JNE T3
    CMP BX,1
    je T3
    MOV BX,0
    mov F3,bx
    INC FL
    
    T3:
    MOV BX,POS
    CMP BX,4
    JNE T4
    
    MOV BX,F4
    CMP BX,9
    JNE T4
    CMP BX,1
    je T4
    MOV BX,0
    mov F4,bx
    INC FL
    
    T4:
    MOV BX,POS
    CMP BX,5
    JNE T5
    
    MOV BX,F5
    CMP BX,9
    JNE T5
    CMP BX,1
    je T5
    MOV BX,0
    mov F5,bx
    INC FL
    
    T5:
    MOV BX,POS
    CMP BX,6
    jne T6
    
    MOV BX,F6
    CMP BX,9
    JNE T6
    CMP BX,1
    je T6
    MOV BX,0
    mov F6,bx
    INC FL
    
    T6:
    MOV BX,POS
    CMP BX,7
    JNE T7
    
    MOV BX,F7
    CMP BX,9
    JNE T7
    CMP BX,1
    je T7
    MOV BX,0
    mov F7,bx
    INC FL
    
    T7:
    MOV BX,POS
    CMP BX,8
    JNE T8
    
    MOV BX,F8
    CMP BX,9
    JNE T8
    CMP BX,1
    je T8
    MOV BX,0
    mov F8,bx
    INC FL
    
    T8:
    MOV BX,POS
    CMP BX,9
    JNE T9
    
    MOV BX,F9
    CMP BX,9
    JNE T9
    CMP BX,1
    je T9
    MOV BX,0
    mov F9,bx
    INC FL
    
    T9:
    RET
    
    
CROSSFUNCTION proc
    MOV BX,POS
    CMP BX,1
    JNE U1
    
    MOV BX,F1
    CMP BX,9
    JNE U1
    CMP BX,0
    je U1
    MOV BX,1
    mov F1,bx
    DEC FL
    
    U1:
    MOV BX,POS
    CMP BX,2
    JNE U2
    
    MOV BX,F2
    CMP BX,9
    JNE U2
    CMP BX,0
    je U2
    MOV BX,1
    mov F2,bx
    DEC FL
    
    U2:
    MOV BX,POS
    CMP BX,3
    JNE U3
    
    MOV BX,F3
    CMP BX,9
    JNE U3
    CMP BX,0
    je U3
    MOV BX,1
    mov F3,bx
    DEC FL
    
    U3:
    MOV BX,POS
    CMP BX,4
    JNE U4
    
    MOV BX,F4
    CMP BX,9
    JNE U4
    CMP BX,0
    je U4
    MOV BX,1
    mov F4,bx
    DEC FL
    
    U4:
    MOV BX,POS
    CMP BX,5
    jne U5
    
    MOV BX,F5
    CMP BX,9
    JNE U5
    CMP BX,0
    je U5
    MOV BX,1
    mov F5,bx
    DEC FL
    
    U5:
    MOV BX,POS
    CMP BX,6
    JNE U6
    
    MOV BX,F6
    CMP BX,9
    JNE U6
    CMP BX,0
    je U6
    MOV BX,1
    mov F6,bx
    DEC FL
    
    U6:
    MOV BX,POS
    CMP BX,7
    JNE U7
    
    MOV BX,F7
    CMP BX,9
    JNE U7
    CMP BX,0
    je U7
    MOV BX,1
    mov F7,bx
    DEC FL
    
    U7:
    MOV BX,POS
    CMP BX,8
    JNE U8
    
    MOV BX,F8
    CMP BX,9
    JNE U8
    CMP BX,0
    je U8
    MOV BX,1
    mov F8,bx
    DEC FL
    
    U8:
    MOV BX,POS
    CMP BX,9
    JNE U9
    
    MOV BX,F9
    CMP BX,9
    JNE U9
    CMP BX,0
    je U9
    MOV BX,1
    mov F9,bx
    DEC FL
    
    U9:
    RET
    
    
WIN_LOSE proc
    RESULT F1,F2,F3
    RESULT F4,F5,F6
    RESULT F7,F8,F9
    RESULT F1,F4,F7
    RESULT F2,F5,F8
    RESULT F3,F6,F9
    RESULT F1,F5,F9
    RESULT F3,F5,F7
    RET
    
    
ANOTHER PROC
    CALL MODEON
    CMP FLAG,1
    JNE FINISH  ;if P hasn't been pressed then do not go to the main game 
    THEN:
    CALL ROWGAME ;the game board
    CALL COLUMNGAME
    
    XOR BX,BX
    mov bx,POS
    
    
    CALL BOX1
    CALL BOX2
    CALL BOX3
    CALL BOX4   ;the select box
    CALL BOX5
    CALL BOX6
    CALL BOX7
    CALL BOX8  
    CALL BOX9 
   
    
    CALL CIRCLEASSIGN
    CALL CROSSASSIGN
    CALL WIN_LOSE
    CALL TIEGAME
    
    FINISH:
    RET
    
SETTING PROC
     MOV AH,0
     INT 16H
     RET

GAME PROC
     CALL SETTING
     
     CMP FLAG,0
     JNE MAINGAME
     PLAY:     
     CMP AH,25
     JE FLAGINC  ;if P is pressed then increment the flag so that it does't go to the main menu again
     JMP BREAKF
     
     FLAGINC:
     INC FLAG
     JMP MAINGAME
     
     
     MAINGAME:
     
     CMP AH,18
     JE INCENDFLAG
     JMP NEXTKEY
     
     INCENDFLAG:
     INC ENDFLAG
     JMP BREAKF
     
     NEXTKEY:
     CMP AH,77
     JE TURNRIGHT
     CMP AH,32
     JE TURNRIGHT
     
     CMP AH,75
     JE TURNLEFT
     CMP AH,30
     JE TURNLEFT
     
     CMP AH,80
     JE TURNDOWN
     CMP AH,31
     JE TURNDOWN
     
     CMP AH,72
     JE TURNUP
     CMP AH,17
     JE TURNUP
     
     CMP AH,2 
     JE CIRC
     CMP AH,3
     JE CROS
     JMP BREAKF
  
     
     CIRC:
     CMP FL,1   ;checks if player 2's move is done or not(fl=2 means the move is of player 2)  
     JE BREAKF
     CALL CIRCLEFUNCTION
     JMP BREAKF
     
     
     CROS:
     CMP FL,0   ;checks if player 1's move is done or not(fl=0 means the move is of player 1) 
     JE BREAKF
     CALL CROSSFUNCTION ;otherwise
     JMP BREAKF
     
     TURNRIGHT:
     mov bx,POS
     inc bx
     mov POS,bx
     JMP BREAKF
     
     TURNLEFT:
     mov bx,POS
     dec bx
     mov POS,bx
     JMP BREAKF
     
     TURNUP:
     mov bx,POS
     sub bx,3
     cmp bx,0
     mov POS,bx
     JMP BREAKF
     
     TURNDOWN:
     mov bx,POS
     add bx,3
     mov POS,bx

     BREAKF:
     CALL ANOTHER
     RET  
    


TIEGAME PROC
     CMP F1,9
     JE FIN
     CMP F2,9
     JE FIN
     CMP F3,9
     JE FIN
     CMP F4,9
     JE FIN
     CMP F5,9
     JE FIN
     CMP F6,9
     JE FIN
     CMP F7,9
     JE FIN
     CMP F8,9
     JE FIN
     CMP F9,9
     JE FIN
     JMP TIESTATUS
    
     FIN:
     RET
     
    

     
PLAYER1STATUS PROC
        CALL BLACKSCREEN
        
        MOV AH,02
        MOV BH,0
        MOV DH,7
        MOV DL,15
        INT 10H
     
        MOV AH,9
        MOV AL,'G'
        MOV BL,14 
        MOV CX,1
        INT 10H
        
        MOV AH,02
        MOV BH,0
        MOV DH,7
        MOV DL,16
        INT 10H
     
        MOV AH,9
        MOV AL,'a'
        MOV BL,3 
        MOV CX,1
        INT 10H
        
        MOV AH,02
        MOV BH,0
        MOV DH,7
        MOV DL,17
        INT 10H
     
        MOV AH,9
        MOV AL,'m'
        MOV BL,1 
        MOV CX,1
        INT 10H
        
        MOV AH,02
        MOV BH,0
        MOV DH,7
        MOV DL,18
        INT 10H
     
        MOV AH,9
        MOV AL,'e'
        MOV BL,9
        MOV CX,1
        INT 10H
        
        MOV AH,02
        MOV BH,0
        MOV DH,7
        MOV DL,19
        INT 10H
     
        MOV AH,9
        MOV AL,' '
        MOV BL,1 
        MOV CX,1
        INT 10H
        
        MOV AH,02
        MOV BH,0
        MOV DH,7
        MOV DL,20
        INT 10H
        
        MOV AH, 9
        MOV AL, 'O'
        MOV BL, 14
        MOV CX, 1
        INT 10H
        
        MOV AH,02
        MOV BH,0
        MOV DH,7
        MOV DL,21
        INT 10H
     
        MOV AH,9
        MOV AL,'v'
        MOV BL,3 
        MOV CX,1
        INT 10H
        
        MOV AH,02
        MOV BH,0
        MOV DH,7
        MOV DL,22
        INT 10h
     
        MOV AH,9
        MOV AL,'e'
        MOV BL,1 
        MOV CX,1
        INT 10H
        
        MOV AH,02
        MOV BH,0
        MOV DH,7
        MOV DL,23
        INT 10H
     
        MOV AH,9
        MOV AL,'r'
        MOV BL,9
        MOV CX,1
        INT 10H
        
        
        MOV AH,02
        MOV BH,0
        MOV DH,12
        MOV DL,14
        INT 10H
     
        MOV AH,9
        MOV AL,'P'
        MOV BL,14 
        MOV CX,1
        INT 10H
         
        MOV AH,02
        MOV BH,0
        MOV DH,12
        MOV DL,15
        INT 10H 
       
        
        MOV AH,9
        MOV AL,'l'
        MOV BL,3
        MOV CX,1
        INT 10H
        
        MOV AH,02
        MOV BH,0
        MOV DH,12
        MOV DL,16
        INT 10H 
        
        
        MOV AH,9
        MOV AL,'a'
        MOV BL,1 
        MOV CX,1
        INT 10H
        
        MOV AH,02
        MOV BH,0
        MOV DH,12
        MOV DL,17
        INT 10H  
       
        
        MOV AH,9
        MOV AL,'y'
        MOV BL,9 
        MOV CX,1
        INT 10H
        
        MOV AH,02
        MOV BH,0
        MOV DH,12
        MOV DL,18
        INT 10H
        
        
        MOV AH,9
        MOV AL,'e'
        MOV BL,9 
        MOV CX,1
        INT 10H
        
        MOV AH,02
        MOV BH,0
        MOV DH,12
        MOV DL,19
        INT 10H
        
        
        MOV AH,9
        MOV AL,'r'
        MOV BL,9
        MOV CX,1
        INT 10H
        
        MOV AH,02
        MOV BH,0
        MOV DH,12
        MOV DL,20
        INT 10H  
        MOV AH,9
        MOV AL,'1'
        MOV BL,4
        MOV CX,1
        INT 10H
        
        MOV AH,02
        MOV BH,0
        MOV DH,12
        MOV DL,21
        INT 10H
        
        
        MOV AH,9
        MOV AL,' '
        MOV BL,1 
        MOV CX,1
        INT 10H
        
        MOV AH,02
        MOV BH,0
        MOV DH,12
        MOV DL,22
        INT 10H
        
        
        MOV AH, 9
        MOV AL,'W'
        MOV BL,14 
        MOV CX,1
        INT 10H
        
        MOV AH,02
        MOV BH,0
        MOV DH,12
        MOV DL,23
        INT 10H 
        
        
        MOV AH,9
        MOV AL,'i'
        MOV BL,3 
        MOV CX,1
        INT 10H
        
        MOV AH,02
        MOV BH,0
        MOV DH,12
        MOV DL,24
        INT 10H
        
        
        MOV AH, 9
        MOV AL,'n'
        MOV BL,1 
        MOV CX,1
        INT 10H
        
        MOV AH,02
        MOV BH,0
        MOV DH,12
        MOV DL,25
        INT 10H  
       
        
        MOV AH,9
        MOV AL,'s'
        MOV BL,9
        MOV CX,1
        INT 10H
        RET
        
PLAYER2STATUS PROC
        CALL BLACKSCREEN
        
        MOV AH,02
        MOV BH,0
        MOV DH,7
        MOV DL,15
        INT 10H
     
        MOV AH,9
        MOV AL,'G'
        MOV BL,14 
        MOV CX,1
        INT 10H
        
        MOV AH,02
        MOV BH,0
        MOV DH,7
        MOV DL,16
        INT 10H
     
        MOV AH,9
        MOV AL,'a'
        MOV BL,3 
        MOV CX,1
        INT 10H
        
        MOV AH,02
        MOV BH,0
        MOV DH,7
        MOV DL,17
        INT 10H
     
        MOV AH,9
        MOV AL,'m'
        MOV BL,1 
        MOV CX,1
        INT 10H
        
        MOV AH,02
        MOV BH,0
        MOV DH,7
        MOV DL,18
        INT 10H
     
        MOV AH,9
        MOV AL,'e'
        MOV BL,9
        MOV CX,1
        INT 10H
        
        MOV AH,02
        MOV BH,0
        MOV DH,7
        MOV DL,19
        INT 10H
     
        MOV AH,9
        MOV AL,' '
        MOV BL,1 
        MOV CX,1
        INT 10H
        
        MOV AH,02
        MOV BH,0
        MOV DH,7
        MOV DL,20
        INT 10H
        
        MOV AH, 9
        MOV AL, 'O'
        MOV BL, 14
        MOV CX, 1
        INT 10H
        
        MOV AH,02
        MOV BH,0
        MOV DH,7
        MOV DL,21
        INT 10H
     
        MOV AH,9
        MOV AL,'v'
        MOV BL,3 
        MOV CX,1
        INT 10H
        
        MOV AH,02
        MOV BH,0
        MOV DH,7
        MOV DL,22
        INT 10h
     
        MOV AH,9
        MOV AL,'e'
        MOV BL,1 
        MOV CX,1
        INT 10H
        
        MOV AH,02
        MOV BH,0
        MOV DH,7
        MOV DL,23
        INT 10H
     
        MOV AH,9
        MOV AL,'r'
        MOV BL,9
        MOV CX,1
        INT 10H
        
        
        MOV AH,02
        MOV BH,0
        MOV DH,12
        MOV DL,14
        INT 10H
     
        MOV AH,9
        MOV AL,'P'
        MOV BL,14 
        MOV CX,1
        INT 10H
         
        MOV AH,02
        MOV BH,0
        MOV DH,12
        MOV DL,15
        INT 10H 
       
        
        MOV AH,9
        MOV AL,'l'
        MOV BL,3
        MOV CX,1
        INT 10H
        
        MOV AH,02
        MOV BH,0
        MOV DH,12
        MOV DL,16
        INT 10H 
        
        
        MOV AH,9
        MOV AL,'a'
        MOV BL,1 
        MOV CX,1
        INT 10H
        
        MOV AH,02
        MOV BH,0
        MOV DH,12
        MOV DL,17
        INT 10H  
       
        
        MOV AH,9
        MOV AL,'y'
        MOV BL,9 
        MOV CX,1
        INT 10H
        
        MOV AH,02
        MOV BH,0
        MOV DH,12
        MOV DL,18
        INT 10H
        
        
        MOV AH,9
        MOV AL,'e'
        MOV BL,9 
        MOV CX,1
        INT 10H
        
        MOV AH,02
        MOV BH,0
        MOV DH,12
        MOV DL,19
        INT 10H
        
        
        MOV AH,9
        MOV AL,'r'
        MOV BL,9
        MOV CX,1
        INT 10H
        
        MOV AH,02
        MOV BH,0
        MOV DH,12
        MOV DL,20
        INT 10H  
        MOV AH,9
        MOV AL,'2'
        MOV BL,4
        MOV CX,1
        INT 10H
        
        MOV AH,02
        MOV BH,0
        MOV DH,12
        MOV DL,21
        INT 10H
        
        
        MOV AH,9
        MOV AL,' '
        MOV BL,1 
        MOV CX,1
        INT 10H
        
        MOV AH,02
        MOV BH,0
        MOV DH,12
        MOV DL,22
        INT 10H
        
        
        MOV AH, 9
        MOV AL,'W'
        MOV BL,14 
        MOV CX,1
        INT 10H
        
        MOV AH,02
        MOV BH,0
        MOV DH,12
        MOV DL,23
        INT 10H 
        
        
        MOV AH,9
        MOV AL,'i'
        MOV BL,3 
        MOV CX,1
        INT 10H
        
        MOV AH,02
        MOV BH,0
        MOV DH,12
        MOV DL,24
        INT 10H
        
        
        MOV AH, 9
        MOV AL,'n'
        MOV BL,1 
        MOV CX,1
        INT 10H
        
        MOV AH,02
        MOV BH,0
        MOV DH,12
        MOV DL,25
        INT 10H  
       
        
        MOV AH,9
        MOV AL,'s'
        MOV BL,9
        MOV CX,1
        INT 10H
        RET

TIESTATUS PROC
        CALL BLACKSCREEN
        MOV AH,02
        MOV BH,0
        MOV DH,10
        MOV DL,14
        INT 10H
     
        MOV AH,9
        LEA DX,TIEMESSAGE
        INT 21H
        RET
        
        
MAIN PROC 
    MOV AX,@DATA
    MOV DS,AX   
    
    
    CALL MODEON
    
    
    CMP FLAG,1
    ;JNE CMPFLAG2
    JNE MENU    ;P hasn't been pressed yet
    
    CALL ROWGAME  ;the game board
    CALL COLUMNGAME
    JMP LOOPGAME
    
    ;CMPFLAG2:
    ;CMP FLAG2,0
    ;JG LOOPGAME
    ;INC FLAG2
    MENU:
    CALL MAINMENU
    
    LOOPGAME:
    CALL GAME 
    
    CMP ENDFLAG,0  ;checks if E has been pressed or not
    JG ENDTT
    
    CMP FLAG,0
    ;JE CMPFLAG2
    JE MENU        ;if P hasn't been pressed,remain on the mainmenu
    
    JMP LOOPGAME
    
    ENDTT:
    CALL ENDGAMEPROCESS
    
    ENDGAME:
    MOV AH,0
    INT 16h  
        
    MOV AX,3
    INT 10h

    MOV AH,4CH  
    INT 21h 
    MAIN ENDP
    END MAIN