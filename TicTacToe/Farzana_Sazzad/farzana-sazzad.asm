.Model SMALL
.Stack 100h
.DATA
PLZ DB 0
TEXT1 DB "TIC TAC TOE"
TEXTSIZE DW $-OFFSET TEXT1
O DB "O"
OS DW $-OFFSET O
X DB "X"
XS DW $-OFFSET X
WINNER1 DB "PLAYER_1 WINS!"
SZ1 DW $-OFFSET WINNER1
WINNER2 DB "PLAYER_2 WINS!"
SZ2 DW $-OFFSET WINNER2
TIE DB "DRAW!!"
SZ3 DW $-OFFSET TIE
TEMP1 DW ?
TEMP2 DW ?
ISWIN DB 0
MOVE DW 0
PLAY DB ?
RES DB 10 DUP(0)
VAR DB ?
START DB "START"
STSIZE DW $-OFFSET START
_EXIT DB "EXIT"
ESIZE DW $-OFFSET _EXIT
BACK DB "BACK"
BSZ DW $-OFFSET BACK

.Code
main Proc 

    MOV AX,@DATA
    MOV DS,AX
    MOV ES,AX
    
   _PAGE_1: 
    MOV AX,4
    INT 10h
    
    MOV AH, 0BH ;function OBh
    MOV BH,00H ;select background color
    MOV BL,8 ;iight blue 14
    INT 10H
    MOV BH,1 ; select palette
    MOV BL,1
    INT 10H
    
    TITLE_1:;;title of the game
    MOV AL,1
    MOV BH,0
    MOV BL,00111001b
    MOV CX,TEXTSIZE
    MOV DL,13
    MOV DH,5
    MOV BP,OFFSET TEXT1
    mov ah,13h
    INT 10H
    START_:
    MOV AL,1
    MOV BH,0
    MOV BL,00111001b
    MOV CX,STSIZE
    MOV DL,2
    MOV DH,10
    MOV BP,OFFSET START
    mov ah,13h
    INT 10H
    EXIT_:
    MOV AL,1
    MOV BH,0
    MOV BL,00111001b
    MOV CX,ESIZE
    MOV DL,2
    MOV DH,15
    MOV BP,OFFSET _EXIT
    mov ah,13h
    INT 10H
        
    MOV AH, 0CH
    MOV AL, 1
    MOV DX,75
    MOV CX,14
    STRL1:
        INT 10H
        INC CX
        CMP CX,62
        JNE STRL1
    MOV DX,75
    MOV CX,14
    STRL2:
        INT 10H
        INC DX
        CMP DX,95
        JNE STRL2
     STRL3:
        INT 10H
        INC CX
        CMP CX,62
        JNE STRL3
      STRL4:
        INT 10H
        DEC DX
        CMP DX,74
        JNE STRL4
        
     MOV DX,135
     MOV CX,14
       EXL1:
         INT 10H
         INC CX
         CMP CX,62
         JNE EXL1
       EXL2:
         INT 10H
         DEC DX
         CMP DX,114
         JNE EXL2
       EXL3:
          INT 10H
          DEC CX
          CMP CX,14
          JNE EXL3
        EXL4:
           INT 10H
           INC DX
           CMP DX,135
           JNE EXL4
        MOV DX,0
        MOV CX,5
        STYL1:
            INT 10H
            INC DX
            CMP DX,200
            JNE STYL1
         MOV AL,2
         MOV DX,0
         MOV CX,8
         STYL2:
            INT 10H
            INC DX
            CMP DX,200
            JNE STYL2
         MOV AL,3
         MOV DX,0
         MOV CX,11
         STYL3:
            INT 10H
            INC DX
            CMP DX,200
            JNE STYL3
         MOV AL,1
         MOV DX,5
         MOV CX,0
         STYL4:
            INT 10H
            INC CX
            CMP CX,320
            JNE STYL4
         MOV AL,2
         MOV DX,8
         MOV CX,0
         STYL5:
            INT 10H
            INC CX
            CMP CX,320
            JNE STYL5
         MOV AL,3
         MOV DX,11
         MOV CX,0
            
         STYL6:
            INT 10H
            INC CX
            CMP CX,320
            JNE STYL6
         MOV AL,1
         MOV CX,314
         MOV DX,0
         STYL7:
            INT 10H
            INC DX
            CMP DX,200
            JNE STYL7
         MOV AL,2
         MOV CX,311
         MOV DX,0
         STYL8:
            INT 10H
            INC DX
            CMP DX,200
            JNE STYL8
         MOV AL,3
         MOV CX,308
         MOV DX,0
         STYL9:
            INT 10H
            INC DX
            CMP DX,200
            JNE STYL9
         MOV AL,1
         MOV CX,0
         MOV DX,194
         STYL10:
            INT 10H
            INC CX
            CMP CX,320
            JNE STYL10
         MOV AL,2
         MOV CX,0
         MOV DX,191
         STYL11:
            INT 10H
            INC CX
            CMP CX,320
            JNE STYL11
         MOV AL,3
         MOV CX,0
         MOV DX,188
         STYL12:
            INT 10H
            INC CX
            CMP CX,320
            JNE STYL12
            
     MOUSE_INITIALIZE_1:
        MOV AX,0  ;;mouse initialize kora lage
        INT 33H
     DISPLAY_MOUSE_1:
        MOV AX,01    ;;mouse show korainor jonno
        INT 33H 
        
     PRESS_STATUS_1:
        MOV AX,03     ;;mouse press hoise kina chek kore,etai mouse press na hoile bx e 0 ashe,left button press korle 1 ashe .right dile something ashe ,ami khali left button niye chonta korsi
        INT 33H
        CMP BX,1
        JNE PRESS_STATUS_1
    ; MOV BX,0   
     SHR CX,1
     STR_CHK:
     CMP CX,14
     JL PRESS_STATUS_1
     CMP DX,75
     JL PRESS_STATUS_1
     CMP CX,62
     JG PRESS_STATUS_1
     CMP DX,95
     JG EX_CHK
     JMP NEW_GAME
 
        
     
     EX_CHK:
     CMP DX,114
     JL PRESS_STATUS_1
     CMP DX,135
     JG PRESS_STATUS_1
     JMP EXIT
     
    
    
NEW_GAME:

    MOV AX,4
    INT 10h
    
    MOV AH, 0BH ;function OBh
    MOV BH,00H ;select background color
    MOV BL,8 ;iight blue 14
    INT 10H
    MOV BH,1 ; select palette
    MOV BL,1
    INT 10H
    
    MOV VAR,0
    MOV PLAY,0
    MOV MOVE,0
    MOV ISWIN,0
    MOV BX,0
    ARRAY_INI:
        CMP BX,10
        JG PRESS_STATUS
        MOV RES[BX],0
        INC BX
        JMP ARRAY_INI
        
        
        
   PRESS_STATUS:
      MOV AX,1
      INT 33H
      MOV AX,03     ;;mouse press hoise kina chek kore,etai mouse press na hoile bx e 0 ashe,left button press korle 1 ashe .right dile something ashe ,ami khali left button niye chonta korsi
      INT 33H
      CMP BX,0
      JNE PRESS_STATUS    
      MOV TEMP1,CX
      MOV TEMP2,DX
    
    TITLE:;;title of the game
    MOV AL,1
    MOV BH,1;;change
    MOV BL,00111001b
    MOV CX,TEXTSIZE
    MOV DL,15
    MOV DH,0
    MOV BP,OFFSET TEXT1
    mov ah,13h
    INT 10H
    BACK_:
    MOV AL,1
    MOV BH,1;;change
    MOV BL,00111001b
    MOV CX,BSZ
    MOV DL,2
    MOV DH,23
    MOV BP,OFFSET BACK
    mov ah,13h
    INT 10H
    
    
DRAW_GRID:    
    MOV AH, 0CH
    MOV AL, 1
    
    MOV CX,69
    MOV DX,59
    
    HOR_L1:
        INT 10h
        INC CX
        CMP CX, 259
        JLE HOR_L1
        
      MOV CX,69
      MOV DX,109
      
    HOR_L2:
        INT 10H
        INC CX
        CMP CX,259
        JLE HOR_L2
        
      MOV CX,132
      MOV DX,19
      
    VER_L3:
        INT 10H
        INC DX
        CMP DX,149
        JLE VER_L3
        
      MOV CX,195
      MOV DX,19
      
    VER_L4:
        INT 10H
        INC DX
        CMP DX,149
        JLE VER_L4
        
      MOV CX,69
      MOV DX,19
   L1:
      INT 10H
      INC DX
      CMP DX,149
      JNE L1
   L2:
      INT 10H
      INC CX
      CMP CX,259
      JNE L2
   L3:
      INT 10H
      DEC DX
      CMP DX,19
      JNE L3
      MOV CX,69
   L4:
      INT 10H
      INC CX
      CMP CX,260
      JNE L4
   MOV CX,11
   MOV DX,180
   BKL1:
        INT 10H
        INC CX
        CMP CX,51
        JNE BKL1
            
   BKL2:
        INT 10H
        INC DX
        CMP DX,195
        JNE BKL2
    BKL3:
        INT 10H
        DEC CX
        CMP CX,11
        JNE BKL3
     BKL4:
        INT 10H
        DEC DX
        CMP DX,180
        JNE BKL4
        
       ;;;line sesh 
      MOV DX,TEMP2
      MOV CX,TEMP1  
      MOUSE_POSITION:
      SHR CX,1
      BACK_BTN:
      CMP CX,11
      JL TEMP_MOUSE
      CMP CX,51
      JG COL1
      CMP DX,180
      JL TEMP_MOUSE
      CMP DX,195
      JG TEMP_MOUSE
      JMP _PAGE_1
      
      TEMP_MOUSE:
        JMP PRESS_STATUS_2
               ;;mouse pressed hoile cx  e ashe oi position er colm number,dx e row number ashe.But colm er khtre CGA r medium er jonno cx er value 2gun kore dei ,tai porer line e ryt shift kore 2 diye vag korsi
     COL1:;;CHECKING CO_ORDINATE
        
        
        CMP CX,69      ;;check hocche j mouse ki 69 # clm er age press hoise naki ,hoile kichu hobe na
        JL PRESS_STATUS_2
        CMP CX,132
        JL C1ROW1  ;; jodi 69 er ceye boro kintu 132 r ceye choto hoi to box er clm 1 e ase,ekhn dekhbe 1 number box e naki
        JMP COL2   ;;noile colm 2 dekhbe
     C1ROW1:
         CMP DX,19     ;;;kon row te ase dekhe,19 er ceye kom mane kichu korbe na
         JL PRESS_STATUS_2
        CMP DX,59   ;;19 er ceye boro 59 er ceye beshi mane box 1 press hoise
        JL  B1
        JMP C1ROW2   ;;na hoile box 4 chk korbe mane colm 1 row 2 check korbe
     B1: 
      CALL BOX1
      JMP PRESS_STATUS_2
         
     C1ROW2:
        CMP DX,109
        JL B4
        JMP C1ROW3
     B4:
        CALL BOX4
        jmp PRESS_STATUS_2
     C1ROW3:
        CMP DX,149
        JL B7
        JMP PRESS_STATUS_2
     B7: 
        CALL BOX7
        JMP PRESS_STATUS_2 ;;baki gula o same e hishab kore ashche
     COL2:
        CMP CX,195
        JL C2ROW1
        JMP COL3
      C2ROW1:
        CMP DX,19
        JL PRESS_STATUS_2
        CMP DX,59
        JL B2
        JMP C2ROW2
      B2: 
        CALL BOX2
        JMP PRESS_STATUS_2
      C2ROW2:
        CMP DX,109
        JL B5
        JMP C2ROW3
      B5: 
        CALL BOX5
        JMP PRESS_STATUS_2
      C2ROW3:
        CMP DX,149
        JL B8
        JMP PRESS_STATUS_2
      B8: 
        CALL BOX8
        JMP PRESS_STATUS_2
      COL3:
        CMP CX,259
        JL C3ROW1
        JMP PRESS_STATUS
    PRESS_STATUS_2:      ;;  ei lebel ta extra ,jump out of range ei error dur korar jonno deya 
        MOV AX,03
        INT 33H
        CMP BX,1;;;;change 1 silo
        JNE PRESS_STATUS_2
        JMP MOUSE_POSITION
        
      C3ROW1:
        CMP DX,19
        JL PRESS_STATUS_2
        CMP DX,59
        JL B3
        JMP C3ROW2
      B3:
        CALL BOX3
        JMP PRESS_STATUS_2
      C3ROW2:
        CMP DX,109
        JL B6
        JMP C3ROW3
     B6:
        CALL BOX6
        JMP PRESS_STATUS_2
     C3ROW3:
        CMP DX,149
        JL B9
        JMP PRESS_STATUS_2
     B9:
        CALL BOX9
        JMP PRESS_STATUS_2
  
     EXIT:        ;; eta exit button er jonno,jeta tui lagabi
        MOV AH, 4CH
        INT 21h
main EndP
SET_MOVE PROC;;k kokhn move dibe set hocche

    PUSH BX
    INC MOVE
    CMP MOVE,1
    JE PLAYER_1
    CMP MOVE,2
    JE PLAYER_2
    CMP MOVE,3
    JE PLAYER_1
    CMP MOVE,4
    JE PLAYER_2
    CMP MOVE,5
    JE PLAYER_1
    CMP MOVE,6
    JE PLAYER_2
    CMP MOVE,7
    JE PLAYER_1
    CMP MOVE,8
    JE PLAYER_2
    CMP MOVE,9
    JE PLAYER_1
    JMP RETURN_M
    
    PLAYER_1:
         MOV PLAY,1
         MOV BL,5  
        MOV AL,1
        MOV BH,1;change
        MOV CX,OS
        MOV BP,OFFSET O
        mov ah,13h
        INT 10H  
        JMP RETURN_M
     PLAYER_2:
        MOV PLAY,2
        MOV BL,7 
       MOV AL,1
       MOV BH,1;;change
       MOV CX,XS
       MOV BP,OFFSET X
       mov ah,13h
       INT 10H
       JMP RETURN_M
     RETURN_M:
        POP BX
        RET  
      
SET_MOVE ENDP
BOX1 PROC
    PUSH BX
    MOV VAR,1;each box er jonno ekta variable rakhsi jate pore checking e kon box e move hoise ta dekhe check korte pari
    MOV BX,1
    CMP RES[BX],0;res namok array r 1 number position e 0 thaka mane ekhono ei box e kono move hoi nai,player_1 move dile 1 boshbe ,playr_2 hole 2 boshbe
    JNE RETURN_B1;jodi 0 na thake mane oikhane r move dite parbo na
    MOV DH,5;POSITION SET
    MOV DL,12;POSITION SET
    CALL SET_MOVE;;move k dibe ber kortese
    CMP PLAY,1;player_1 dise naki 2 dise
    JE P1BOX1
    JMP P2BOX1
    
    P1BOX1:
    MOV RES[BX],1;player_1 dise dekhe res er 1 number position e 1
        JMP CK1
    P2BOX1:
    MOV RES[BX],2;player 2 er jonno 2
        
    CK1:
    CALL CHECK    ;jitbe naki check hocche
    RETURN_B1:
        POP BX
        RET
BOX1 ENDP
BOX2 PROC;;baki sob box eke
     PUSH BX
     MOV VAR,2
     MOV BX,2
     CMP RES[BX],0
     JNE RETURN_B2
     MOV DH,5;POSITION SET
     MOV DL,20;POSITION SET
     CALL SET_MOVE
     CMP PLAY,1
     JE P1BOX2
     JMP P2BOX2
     
     P1BOX2:
        MOV RES[BX],1
        JMP CK2
     P2BOX2:
        MOV RES[BX],2
        
     CK2:
        CALL CHECK
     
     RETURN_B2:
        POP BX
        RET
BOX2 ENDP
BOX3 PROC
    PUSH BX
    MOV VAR,3
    MOV BX,3
    CMP RES[BX],0
    JNE RETURN_B3
    MOV DH,5
    MOV DL,28
    CALL SET_MOVE
    CMP PLAY,1
    JE P1BOX3
    JMP P2BOX3
    P1BOX3:
        MOV RES[BX],1
        JMP CK3
    P2BOX3:
        MOV RES[BX],2
    CK3:
        CALL CHECK
    RETURN_B3:
        POP BX
        RET
BOX3 ENDP
BOX4 PROC
    PUSH BX
    MOV VAR,4
    MOV BX,4
    CMP RES[BX],0
    JNE RETURN_B4
    MOV DH,10
    MOV DL,12
    CALL SET_MOVE
    CMP PLAY,1
    JE P1BOX4
    JMP P2BOX4
    P1BOX4:
        MOV RES[BX],1
        JMP CK4
    P2BOX4:
        MOV RES[BX],2
    CK4:
        CALL CHECK
    RETURN_B4:
        POP BX
        RET
BOX4 ENDP
BOX5 PROC
    PUSH BX
    MOV VAR,5
    MOV BX,5
    CMP RES[BX],0
    JNE RETURN_B5
    MOV DH,10
    MOV DL,20
    CALL SET_MOVE
    CMP PLAY,1
    JE P1BOX5
    JMP P2BOX5
    P1BOX5:
        MOV RES[BX],1
        JMP CK5
    P2BOX5:
        MOV RES[BX],2
    CK5:
        CALL CHECK
    
    RETURN_B5:
        POP BX
        RET
BOX5 ENDP
BOX6 PROC
        PUSH BX
        MOV VAR,6
        MOV BX,6
        CMP RES[BX],0
        JNE RETURN_B6
        MOV DH,10
        MOV DL,28
        CALL SET_MOVE
        
        CMP PLAY,1
        JE P1BOX6
        JMP P2BOX6
        P1BOX6:
            MOV RES[BX],1
            JMP CK6
        P2BOX6:
            MOV RES[BX],2
        CK6:
            CALL CHECK
        
        RETURN_B6:
           POP  BX
            RET
BOX6 ENDP

BOX7 PROC
        PUSH BX
        MOV VAR,7
        MOV BX,7
        CMP RES[BX],0
        JNE RETURN_B7
        MOV DH,16
        MOV DL,12
        CALL SET_MOVE 
        CMP PLAY,1
        JE P1BOX7
        JMP P2BOX7
        P1BOX7:
            MOV RES[BX],1
            JMP CK7
        P2BOX7:
            MOV RES[BX],2
        CK7:
            CALL CHECK
        RETURN_B7:
           POP BX
           RET
           
BOX7 ENDP
BOX8 PROC
    PUSH BX
    MOV VAR,8
    MOV BX,8
    CMP RES[BX],0
    JNE RETURN_B8
    MOV DH,16
    MOV DL,20
    CALL SET_MOVE
    
    CMP PLAY,1
    JE P1BOX8
    JMP P2BOX8
    P1BOX8:
        MOV RES[BX],1
        JMP CK8
    P2BOX8:
        MOV RES[BX],2
    CK8:
        CALL CHECK
    
    RETURN_B8:
        POP BX
        RET
BOX8 ENDP
BOX9 PROC   
        PUSH BX
        MOV VAR,9
        MOV BX,9
        CMP RES[BX],0
        JNE RETURN_B9
        MOV DH,16
        MOV DL,28
        CALL SET_MOVE
        CMP PLAY,1
        JE P1BOX9
        JMP P2BOX9
        P1BOX9:
            MOV RES[BX],1
            JMP CK9
        P2BOX9:
            MOV RES[BX],2
        CK9:
           CALL CHECK 
    
        RETURN_B9:
            POP BX
            RET
BOX9 ENDP

CHECK PROC
     ;; START:
        PUSH BX
        PUSH CX
        PUSH DX
        PUSH AX
        
      CHECKING_1:
      CMP VAR,1;;var 1 mane 1 number box e move hoise so eijonno 123 or 159 or 147 position e same thaka mane jitse
        JE _1
        JMP CHECKING_2
        _1:
            CALL CHK_123
            CALL CHK_159
            CALL CHK_147
            CALL TIE_CKR
            JMP RETURN_CHK
      CHECKING_2:
      CMP VAR,2;;ager motoi sob 
         JE _2
         JMP CHECKING_3
         _2:
            CALL CHK_123
            CALL CHK_258
            CALL TIE_CKR
            JMP RETURN_CHK
      CHECKING_3:
          CMP VAR,3
          JE _3
          JMP CHECKING_4
          _3:
            CALL CHK_123
            CALL CHK_357
            CALL CHK_369
            CALL TIE_CKR
            JMP RETURN_CHK
      CHECKING_4:
          CMP VAR,4
          JE _4
          JMP CHECKING_5
          _4:
             CALL CHK_147
             CALL CHK_456
             CALL TIE_CKR
             JMP RETURN_CHK
      CHECKING_5:
           CMP VAR,5
           JE _5
           JMP CHECKING_6
           _5:
              CALL CHK_258
              CALL CHK_159
              CALL CHK_357
              CALL CHK_456
              CALL TIE_CKR;;tie hoise kina chk kortese
              JMP RETURN_CHK
      CHECKING_6:
           CMP VAR,6
           JE _6
           JMP CHECKING_7
           _6:
              CALL CHK_456
              CALL CHK_369
              CALL TIE_CKR
              JMP RETURN_CHK
      CHECKING_7:
            CMP VAR,7
            JE _7
            JMP CHECKING_8
            _7:
                CALL CHK_147
                CALL CHK_789
                CALL CHK_357
                CALL TIE_CKR
                JMP RETURN_CHK 
     CHECKING_8:
         CMP VAR,8
         JE _8
         JMP CHECKING_9
         _8:
             CALL CHK_258
             CALL CHK_789
             CALL TIE_CKR
             JMP RETURN_CHK
     CHECKING_9:
        CMP VAR,9
        JE _9
        JMP CHECKING_9
        _9:
            CALL CHK_159
            CALL CHK_789
            CALL CHK_369
            CALL TIE_CKR
            JMP RETURN_CHK 
     RETURN_CHK:
        POP AX
        POP DX
        POP CX
        POP BX
        RET
CHECK ENDP
TIE_CKR PROC
     PUSH AX
     PUSH BX
     PUSH CX
     PUSH DX
     CMP MOVE,9;;tie bujhbo 9 number move e
     JNE RETURN_TIE
     CMP ISWIN,1;;jodi dekhi iswin 1 tokhon r tie chek korboi na
     JE RETURN_TIE
     DRAW:
         MOV BL,1  ;;tie print kore screen e
         MOV AL,1
         MOV BH,1
         MOV CX,SZ3
         MOV DH,21
         MOV DL,16
         MOV BP,OFFSET TIE
         mov ah,13h
         INT 10H   
       
    RETURN_TIE:
        POP DX
        POP CX
        POP BX
        POP AX
        RET  
TIE_CKR ENDP

WIN PROC
        PUSH AX
        PUSH BX
        PUSH CX
        PUSH DX
        MOV BX,0
      TOP:
        INC BX     ;;eikhane jokhon ashbe ter mane already jite gesi so array r sob position e 3 boshai rakhsi jate jiter por keo press korle oikhane kono move na hoi
        CMP BX,10
        JE WINCHK
        MOV RES[BX],3
        JMP TOP
        
      WINCHK:
        MOV ISWIN,1;;is win 0 mane jiti nai ekhono,1 mane jitsi
        CMP PLAY,1     ;;play 1 mane player 1 jitse
        JE WIN1
        JMP WIN2
        WIN1:       ;;player_1 jitse eta print kore
         MOV BL,1  
         MOV AL,1
         MOV BH,1
         MOV CX,SZ1
         MOV DH,21
         MOV DL,16
         MOV BP,OFFSET WINNER1
         mov ah,13h
         INT 10H
         JMP RETURN_WIN
      WIN2:
         MOV BL,1  
         MOV AL,1
         MOV BH,1
         MOV CX,SZ2
         MOV DH,21
         MOV DL,16
         MOV BP,OFFSET WINNER2   ;;player _2 jitse print kore
         mov ah,13h
         INT 10H            
         JMP RETURN_WIN
         
       RETURN_WIN:
            POP DX
            POP CX
            POP BX
            POP AX
            RET
         
WIN ENDP

CHK_123 PROC     ;;eikhane jei jei combinition er jonno same array r positione same number thakle jitbe seita chk hocche
          PUSH BX
          PUSH DX
          
          MOV BX,1
          MOV DL,RES[BX]
          MOV BX,2
          CMP DL,RES[BX]
          JE CHK_123_1
          JMP RETURN_123;;jodi 1st ei different hoi to ber hoye jacchi
       CHK_123_1:
          MOV BX,3
          CMP DL,RES[BX]
          JE WIN_123
          JMP RETURN_123
          
        WIN_123:
            CALL WIN
        
        RETURN_123:
            POP DX
            POP BX
            RET
CHK_123 ENDP
CHK_456 PROC
            PUSH BX
            PUSH DX
    
            MOV BX,4
            MOV DL,RES[BX]
            MOV BX,5
            CMP DL,RES[BX]
            JE CHK_456_1
            JMP RETURN_456
         CHK_456_1:
            MOV BX,6
            CMP DL,RES[BX]
            JE WIN_456
            JMP RETURN_456
         WIN_456:
            CALL WIN
         RETURN_456:
            POP DX
            POP BX
            RET
            
CHK_456 ENDP
CHK_789 PROC
        PUSH BX
        PUSH DX
        MOV BX,7
        MOV DL,RES[BX]
        MOV BX,8
        CMP DL,RES[BX]
        JE CHK_789_1
        JMP RETURN_789
     CHK_789_1:
        MOV BX,9
        CMP DL,RES[BX]
        JE WIN_789
        JMP RETURN_789
     WIN_789:
        CALL WIN
        
      RETURN_789:
        POP DX
        POP BX
        RET
CHK_789 ENDP
CHK_147 PROC
            PUSH BX
            PUSH DX
            MOV BX,1
            MOV DL,RES[BX]
            MOV BX,4
            CMP DL,RES[BX]
            JE CHK_147_1
            JMP RETURN_147
         CHK_147_1:
            MOV BX,7
            CMP DL,RES[BX]
            JE WIN_147
            JMP RETURN_147
         WIN_147:
             CALL WIN
         
            
         RETURN_147:
            POP DX
            POP BX
            RET
CHK_147 ENDP
CHK_258 PROC
            PUSH BX
            PUSH DX
            MOV BX,2
            MOV DL,RES[BX]
            MOV BX,5
            CMP DL,RES[BX]
            JE CHK_258_1
            JMP RETURN_258
        CHK_258_1:
            MOV BX,8
            CMP DL,RES[BX]
            JE WIN_258
            JMP RETURN_258
        WIN_258:
            CALL WIN
        RETURN_258:
            POP DX
            POP BX
            RET
CHK_258 ENDP
CHK_369  PROC
            PUSH BX
            PUSH DX
            MOV BX,3
            MOV DL,RES[BX]
            MOV BX,6
            CMP DL, RES[BX]
            JE CHK_369_1
            JMP RETURN_369
        CHK_369_1:
            MOV BX,9
            CMP DL,RES[BX]
            JE WIN_369
            JMP RETURN_369
            
        WIN_369:
             CALL WIN   
        RETURN_369:
            POP DX
            POP BX
            RET
CHK_369 ENDP
CHK_159 PROC  
            PUSH BX
            PUSH DX
            MOV BX,1
            MOV DL,RES[BX]
            MOV BX,5
            CMP DL,RES[BX]
            JE CHK_159_1
            JMP RETURN_159
         CHK_159_1:
            MOV BX,9
            CMP DL,RES[BX]
            JE WIN_159
            JMP RETURN_159
          WIN_159:
             CALL WIN
             
          RETURN_159:
              POP DX
              POP BX
              RET
CHK_159 ENDP
CHK_357 PROC
            PUSH BX
            PUSH DX
            MOV BX,3
            MOV DL,RES[BX]
            MOV BX,5
            CMP DL,RES[BX]
            JE CHK_357_1
            JMP RETURN_357
         CHK_357_1:
            MOV BX,7
            CMP DL,RES[BX]
            JE WIN_357
            JMP RETURN_357
         WIN_357:
             CALL WIN
            
         RETURN_357:
            POP DX
            POP BX
            RET  
            
CHK_357 ENDP
End main
      
      
     
        
       