 
.MODEL SMALL
.STACK 100H
.DATA    

MSG1 DB 10,13,'                .....WELCOME TO JR_QUIZ Buzzer.....$'
MSG2 DB 10,13,'Rules : $'
MSG3 DB 10,13,'*. For Every Correct answer you will get 1 point.$'
MSG4 DB 10,13, '*. This is a buzzer round , you get 5 seconds to answer.$'
MSG5 DB 10,13, 'Press Enter to start the quiz : $'
MSG6 DB 10,13, 'Right Answer....$'
MSG7 DB 10,13, 'Wrong Answer....$'
MSG8 DB 10,13, 'You have successfully completed your quiz.$'
MSG9 DB 10,13, 'Your Total obtained point is : $'
MSG10 DB 10,13, 'Team to Answer : $' 
MSG11 DB 10,13, '                    ***Thank you.! ***$'
MSG12 DB 10,13, 'Press your Buzzers...!$'
MSG13 DB 10,13, 'Enter your Answer : $'
MSG14 DB 10,13, '   QUESTION PASSES  $'
MSG15 DB 10,13,'       SCORES     $'
MSG16 DB 10,13,'TEAM 1 - $'
MSG17 DB 10,13,'TEAM 2 - $'
MSG18 DB 10,13,'TEAM 3 - $'
MSG19 DB 10,13,'TEAM 4 - $'
Q1 DB 10,13, '1. 2+3=?$'
QA1 DB 10,13, '   a) 5    b) 6    c) 7$'
Q2 DB  10,13,'2. 5+6=?$'
QA2 DB  10,13,'   a) 10    b) 11    c) 12$'
Q3 DB  10,13,'3. 15-12=?$'
QA3 DB  10,13,'   a) 5    b) 1    c) 3$'
Q4 DB  10,13,'4. 3*6=?$'
QA4 DB  10,13,'   a) 10    b) 18    c) 12$'
Q5 DB  10,13,'5. 6/3=?$'
QA5 DB  10,13,'   a) 2    b) 1    c) 12$'
Q6 DB  10,13,'6. 8-8=?$'
QA6 DB  10,13,'   a) -1    b) -2    c) 0$'
Q7 DB  10,13,'7. 3*12=?$'
QA7 DB  10,13,'   a) 33    b) 36    c) 38$'
Q8 DB  10,13,'8. 9*9=?$'
QA8 DB  10,13,'   a) 72    b) 91    c) 81$'
Q9 DB  10,13,'9. 11+13=?$'
QA9 DB  10,13,'   a) 24    b) 26    c) 19$'
Q10 DB  10,13,'10. 56/8=?$'
QA10 DB  10,13,'   a) 7    b) 9    c) 6$'
a dw 4 dup(?) 
score1 dw ?
score2 dw ?
score3 dw ?
score4 dw ? 
tal db ?
tah db ?
tbl db ?
tbh db ?
tcl db ?
tch db ?
tdl db ?
tdh db ? 
tcx dw ?
tdx dw ?
tbx dw ?
buzAh db 0
buzDh db 0
mov score1,0
mov score2,0
mov score3,0
mov score4,0
mov tbx,0
.CODE   

prints macro xx,yy
    lea dx,xx
    mov ah,yy
    int 21h
endm 


main proc
    mov ax,@data
    mov ds,ax
    mov bx,offset a
    prints MSG1,09h
    prints MSG2,09h
    prints MSG3,09h
    prints MSG4,09h
    prints MSG5,09h
    mov ah,1
    int 21h
    
    sprinter macro xx
        mov ah,2
        mov dx,xx
        add dx,30h
        int 21h
    endm
    
    Ques1:
    mov bx,0
    prints Q1,09h
    prints QA1,09h 
    prints MSG12,09h
    mov cx,4
    mov ah,1
    scans1:
        int 21h
        mov a[bx],ax
        mov buzAh,AH
        mov buzDh,DL
        MOV AH,2
        MOV DL, 07H
        INT 21H
        mov ah,buzAh
        mov dl,buzDh
        inc bx    
        loop scans1 
        MOV AH,2
        MOV DL, 07H
        INT 21H    
    prints MSG10,09h    
    mov bx,0
    mov ah,2
    mov dx,a[bx]
    int 21h
    mov tdx,dx
    prints MSG13,09h
    ;mov tal,al
    mov tah,ah
    mov tbx,bx
    
    mov tcx,cx
    mov al,'x'
    mov ah,02ch        ; Get current second         
    int 021h
    mov bh,dh          ; Store current second   
    readloop:
    mov ah,02ch      ; Call function 02C of INT 021 to get new time
    int 021h
    sub dh,05h         ; Subtract 05 from new second. Giving 5 Secs for input.
                        ; For if old second in BH=05 and new second in DH-5=1,
                        ; four more
                        ; seconds must pass.
    cmp bh,dh                    
    je endprog         ; Exit when DH is finally equal to BH.
                     ; Example BH=05 and DH - 05 = 05, then DH = 0F and 
                     ; 05 - 0F = Five Seconds
    mov ah,06h          ; Function 06h of INT 021 will directly read from the Stdin/Stdout
    mov dl,255           ; Move 0ff into the DL register to read from the keyboard
    int 21h              
    jz readloop
    endprog:
    mov cx,tcx
    
    mov ah,tah
    mov bx,tbx
     
    cmp al,'a'
    jz right1
    jnz wrong1
    mov cx,0
    right1:
        prints MSG6,09h
        mov dx,tdx
        cmp dl,'1'
        jz team11
        cmp dl,'2'
        jz team12
        cmp dl,'3'
        jz team13
        cmp dl,'4'
        jz team14
        
        team11:
            call Apositive
            jmp Ques2
        team12:
            call Bpositive
            jmp Ques2
        team13:
            call Cpositive
            jmp Ques2
        team14:
            call Dpositive
            jmp Ques2
        
        
    wrong1:
        inc cx
        prints MSG7,09h
        mov dx,tdx             
        cmp dl,'1'
        jz team21
        cmp dl,'2'
        jz team22
        cmp dl,'3'
        jz team23
        cmp dl,'4'
        jz team24
        
        team21:
            call Anegative
            jmp conti1
        team22:
            call Bnegative
            jmp conti1
        team23:
            call Cnegative
            jmp conti1
        team24:
            call Dnegative
            jmp conti1
        
        conti1:                 
        inc bx
        prints MSG10,09h 
        mov ah,2
        mov dx,a[bx]
        int 21h
        mov tdx,dx
        prints MSG13,09h
        ;mov ah,1
        ;int 21h
    mov tah,ah
    mov tbx,bx
    
    mov tcx,cx
    mov al,'x'
    mov ah,02ch        ; Get current second         
    int 021h
    mov bh,dh          ; Store current second   
    readloop2:
    mov ah,02ch      ; Call function 02C of INT 021 to get new time
    int 021h
    sub dh,05h         ; Subtract 05 from new second. Giving 5 Secs for input.
                        ; For if old second in BH=05 and new second in DH-5=1,
                        ; four more
                        ; seconds must pass.
    cmp bh,dh                    
    je endprog2         ; Exit when DH is finally equal to BH.
                     ; Example BH=05 and DH - 05 = 05, then DH = 0F and 
                     ; 05 - 0F = Five Seconds
    mov ah,06h          ; Function 06h of INT 021 will directly read from the Stdin/Stdout
    mov dl,255           ; Move 0ff into the DL register to read from the keyboard
    int 21h              
    jz readloop2
    endprog2:
    mov cx,tcx
    mov dx,tdx
    mov ah,tah
    mov bx,tbx       
        ;
        ;
        ;
        cmp al,'a'
        jz right1
        jnz wrong1
        cmp cx,4
        jz pass1
        
        jnz Ques2
        
    pass1: 
    
        jmp Ques2 
        
        
    Ques2:
 ;   prints MSG14,09h
 ;  sprinter score1
;        prints MSG17,09h
;        sprinter score2
;        prints MSG18,09h
;        sprinter score3
;        prints MSG19,09h
;        sprinter score4     prints MSG16,09h 
        
    mov bx,0
    prints Q2,09h
    prints QA2,09h 
    prints MSG12,09h
    mov cx,4
    mov ah,1
    scans2:
        int 21h
        mov a[bx],ax
        mov buzAh,AH
        mov buzDh,DL
        MOV AH,2
        MOV DL, 07H
        INT 21H
        mov ah,buzAh
        mov dl,buzDh
        inc bx
        loop scans2
        MOV AH,2
        MOV DL, 07H
        INT 21H
    mov bx,0
    prints MSG10,09h    
    mov ah,2
    mov dx,a[bx]
    int 21h
    
    mov tdx,dx
    prints MSG13,09h
    ;mov ah,1
    ;int 21h
    mov tah,ah
    mov tbx,bx
    mov tcx,cx
    mov al,'x'
    mov ah,02ch        ; Get current second         
    int 021h
    mov bh,dh          ; Store current second   
    readloop3:
    mov ah,02ch      ; Call function 02C of INT 021 to get new time
    int 021h
    sub dh,05h         ; Subtract 05 from new second. Giving 5 Secs for input.
                        ; For if old second in BH=05 and new second in DH-5=1,
                        ; four more
                        ; seconds must pass.
    cmp bh,dh                    
    je endprog3         ; Exit when DH is finally equal to BH.
                     ; Example BH=05 and DH - 05 = 05, then DH = 0F and 
                     ; 05 - 0F = Five Seconds
    mov ah,06h          ; Function 06h of INT 021 will directly read from the Stdin/Stdout
    mov dl,255           ; Move 0ff into the DL register to read from the keyboard
    int 21h              
    jz readloop3
    endprog3:
    mov cx,tcx
    mov ah,tah
    mov bx,tbx
    ;
    ;
    cmp al,'b'
    jz right2
    jnz wrong2
    mov cx,0
    right2:
        prints MSG6,09h
        mov dx,tdx
        cmp dl,'1'
        jz team31
        cmp dl,'2'
        jz team32
        cmp dl,'3'
        jz team33
        cmp dl,'4'
        jz team34
        
        team31:
            call Apositive
            jmp Ques3
        team32:
            call Bpositive
            jmp Ques3
        team33:
            call Cpositive
            jmp Ques3
        team34:
            call Dpositive
            jmp Ques3 
        jmp Exit
        
    wrong2:
        inc cx
        prints MSG7,09h
        mov dx,tdx
        inc bx 
        cmp dl,'1'
        jz team41
        cmp dl,'2'
        jz team42
        cmp dl,'3'
        jz team43
        cmp dl,'4'
        jz team44
        
        team41:
            call Anegative
            jmp conti2
        team42:
            call Bnegative
            jmp conti2
        team43:
            call Cnegative
            jmp conti2
        team44:
            call Dnegative
            jmp conti2
        
        conti2:
        prints MSG10,09h
        mov ah,2
        mov dx,a[bx]
        int 21h
        mov tdx,dx
        prints MSG13,09h
        ;mov ah,1
        ;int 21h
    mov tah,ah
    mov tbx,bx    
    mov tcx,cx
    mov al,'x'
    mov ah,02ch        ; Get current second         
    int 021h
    mov bh,dh          ; Store current second   
    readloop4:
    mov ah,02ch      ; Call function 02C of INT 021 to get new time
    int 021h
    sub dh,05h         ; Subtract 05 from new second. Giving 5 Secs for input.
                        ; For if old second in BH=05 and new second in DH-5=1,
                        ; four more
                        ; seconds must pass.
    cmp bh,dh                    
    je endprog4         ; Exit when DH is finally equal to BH.
                     ; Example BH=05 and DH - 05 = 05, then DH = 0F and 
                     ; 05 - 0F = Five Seconds
    mov ah,06h          ; Function 06h of INT 021 will directly read from the Stdin/Stdout
    mov dl,255           ; Move 0ff into the DL register to read from the keyboard
    int 21h              
    jz readloop4
    endprog4:
    mov cx,tcx
    
    mov ah,tah
    mov bx,tbx
    ;
    ;
        cmp al,'b'
        jz right2
        jnz wrong2
        cmp cx,4
        jz pass2
        jnz Ques3
         
    pass2:
        prints MSG14,09h
        jnz Ques3
        
        
    ;Ques3    
        
    Ques3:
    mov bx,0
    prints Q3,09h
    prints QA3,09h 
    prints MSG12,09h
    mov cx,4
    mov ah,1
    scans3:
        int 21h
        mov a[bx],ax  
        mov buzAh,AH
        mov buzDh,DL
        MOV AH,2
        MOV DL, 07H
        INT 21H
        mov ah,buzAh
        mov dl,buzDh
        inc bx
        loop scans3
        MOV AH,2
        MOV DL, 07H
        INT 21H
    mov bx,0
    prints MSG10,09h    
    mov ah,2
    mov dx,a[bx]
    int 21h
    mov tdx,dx
    prints MSG13,09h
    ;mov ah,1
    ;int 21h
        mov tah,ah
    mov tbx,bx
    
    mov tcx,cx
    mov al,'x'
    mov ah,02ch        ; Get current second         
    int 021h
    mov bh,dh          ; Store current second   
    readloop5:
    mov ah,02ch      ; Call function 02C of INT 021 to get new time
    int 021h
    sub dh,05h         ; Subtract 05 from new second. Giving 5 Secs for input.
                        ; For if old second in BH=05 and new second in DH-5=1,
                        ; four more
                        ; seconds must pass.
    cmp bh,dh                    
    je endprog5         ; Exit when DH is finally equal to BH.
                     ; Example BH=05 and DH - 05 = 05, then DH = 0F and 
                     ; 05 - 0F = Five Seconds
    mov ah,06h          ; Function 06h of INT 021 will directly read from the Stdin/Stdout
    mov dl,255           ; Move 0ff into the DL register to read from the keyboard
    int 21h              
    jz readloop5
    endprog5:
    mov cx,tcx
    
    mov ah,tah
    mov bx,tbx
    ;
    ;
    cmp al,'b'
    jz right3
    jnz wrong3
    mov cx,0
    right3:
        prints MSG6,09h
        mov dx,tdx
        cmp dl,'1'
        jz team51
        cmp dl,'2'
        jz team52
        cmp dl,'3'
        jz team53
        cmp dl,'4'
        jz team54
        
        team51:
            call Apositive
            jmp Ques4
        team52:
            call Bpositive
            jmp Ques4
        team53:
            call Cpositive
            jmp Ques4
        team54:
            call Dpositive
            jmp Ques4
        jmp Exit
        
    wrong3:
        inc cx
        prints MSG7,09h
        mov dx,tdx
        inc bx 
        cmp dl,'1'
        jz team61
        cmp dl,'2'
        jz team62
        cmp dl,'3'
        jz team63
        cmp dl,'4'
        jz team64
        
        team61:
            call Anegative
            jmp conti3
        team62:
            call Bnegative
            jmp conti3
        team63:
            call Cnegative
            jmp conti3
        team64:
            call Dnegative
            jmp conti3
        
        conti3:
        prints MSG10,09h
        mov ah,2
        mov dx,a[bx]
        int 21h
        mov tdx,dx
        prints MSG13,09h
        ;mov ah,1
        ;int 21h
            mov tah,ah
    mov tbx,bx
    ;mov tdx,dx
    mov tcx,cx
    mov al,'x'
    mov ah,02ch        ; Get current second         
    int 021h
    mov bh,dh          ; Store current second   
    readloop6:
    mov ah,02ch      ; Call function 02C of INT 021 to get new time
    int 021h
    sub dh,05h         ; Subtract 05 from new second. Giving 5 Secs for input.
                        ; For if old second in BH=05 and new second in DH-5=1,
                        ; four more
                        ; seconds must pass.
    cmp bh,dh                    
    je endprog6         ; Exit when DH is finally equal to BH.
                     ; Example BH=05 and DH - 05 = 05, then DH = 0F and 
                     ; 05 - 0F = Five Seconds
    mov ah,06h          ; Function 06h of INT 021 will directly read from the Stdin/Stdout
    mov dl,255           ; Move 0ff into the DL register to read from the keyboard
    int 21h              
    jz readloop6
    endprog6:
    mov cx,tcx
    mov dx,tdx
    mov ah,tah
    mov bx,tbx
        ;
        ;
        cmp al,'b'
        jz right3
        jnz wrong3
        cmp cx,4
        jz pass3
        jnz Ques4
         
    pass3:
        prints MSG14,09h
        jnz Ques4
        
        
       ;End Ques3  
       
       
    ;Ques4   
       
    Ques4:
    mov bx,0
    prints Q4,09h
    prints QA4,09h 
    prints MSG12,09h
    mov cx,4
    mov ah,1
    scans4:
        int 21h
        mov a[bx],ax
        mov buzAh,AH
        mov buzDh,DL
        MOV AH,2
        MOV DL, 07H
        INT 21H
        mov ah,buzAh
        mov dl,buzDh
        inc bx
        loop scans4
        MOV AH,2
        MOV DL, 07H
        INT 21H
    mov bx,0
    prints MSG10,09h    
    mov ah,2
    mov dx,a[bx]
    int 21h
    mov tdx,dx;;##########
    prints MSG13,09h
    ;mov ah,1
    ;int 21h
        mov tah,ah
    mov tbx,bx
    
    mov tcx,cx
    mov al,'x'
    mov ah,02ch        ; Get current second         
    int 021h
    mov bh,dh          ; Store current second   
    readloop7:
    mov ah,02ch      ; Call function 02C of INT 021 to get new time
    int 021h
    sub dh,05h         ; Subtract 05 from new second. Giving 5 Secs for input.
                        ; For if old second in BH=05 and new second in DH-5=1,
                        ; four more
                        ; seconds must pass.
    cmp bh,dh                    
    je endprog7         ; Exit when DH is finally equal to BH.
                     ; Example BH=05 and DH - 05 = 05, then DH = 0F and 
                     ; 05 - 0F = Five Seconds
    mov ah,06h          ; Function 06h of INT 021 will directly read from the Stdin/Stdout
    mov dl,255           ; Move 0ff into the DL register to read from the keyboard
    int 21h              
    jz readloop7
    endprog7:
    mov cx,tcx
    
    mov ah,tah
    mov bx,tbx
    ;
    ;
    cmp al,'b'
    jz right4
    jnz wrong4
    mov cx,0
    right4:
        prints MSG6,09h
        mov dx,tdx
        cmp dl,'1'
        jz team71
        cmp dl,'2'
        jz team72
        cmp dl,'3'
        jz team73
        cmp dl,'4'
        jz team74
        
        team71:
            call Apositive
            jmp Ques5
        team72:
            call Bpositive
            jmp Ques5
        team73:
            call Cpositive
            jmp Ques5
        team74:
            call Dpositive
            jmp Ques5 
        jmp Exit
        
    wrong4:
        inc cx
        prints MSG7,09h
        inc bx
        mov dx,tdx 
        cmp dl,'1'
        jz team81
        cmp dl,'2'
        jz team82
        cmp dl,'3'
        jz team83
        cmp dl,'4'
        jz team84
        
        team81:
            call Anegative
            jmp conti4
        team82:
            call Bnegative
            jmp conti4
        team83:
            call Cnegative
            jmp conti4
        team84:
            call Dnegative
            jmp conti4
        
        conti4:
        prints MSG10,09h
        mov ah,2
        mov dx,a[bx]
        int 21h
        mov tdx,dx;#######
        prints MSG13,09h
        ;mov ah,1
        ;int 21h
            mov tah,ah
    mov tbx,bx
    
    mov tcx,cx
    mov al,'x'
    mov ah,02ch        ; Get current second         
    int 021h
    mov bh,dh          ; Store current second   
    readloop8:
    mov ah,02ch      ; Call function 02C of INT 021 to get new time
    int 021h
    sub dh,05h         ; Subtract 05 from new second. Giving 5 Secs for input.
                        ; For if old second in BH=05 and new second in DH-5=1,
                        ; four more
                        ; seconds must pass.
    cmp bh,dh                    
    je endprog8         ; Exit when DH is finally equal to BH.
                     ; Example BH=05 and DH - 05 = 05, then DH = 0F and 
                     ; 05 - 0F = Five Seconds
    mov ah,06h          ; Function 06h of INT 021 will directly read from the Stdin/Stdout
    mov dl,255           ; Move 0ff into the DL register to read from the keyboard
    int 21h              
    jz readloop8
    endprog8:
    mov cx,tcx
    mov dx,tdx
    mov ah,tah
    mov bx,tbx
        ;
        ;
        cmp al,'b'
        jz right4
        jnz wrong4
        cmp cx,4
        jz pass4
        jnz Ques5
         
    pass4:
        prints MSG14,09h
        jnz Ques5                                  
        
        ;EndQues4 
        
    ;Ques5    
                
    Ques5:
    mov bx,0
    prints Q5,09h
    prints QA5,09h 
    prints MSG12,09h
    mov cx,4
    mov ah,1
    scans5:
        int 21h
        mov a[bx],ax
        mov buzAh,AH
        mov buzDh,DL
        MOV AH,2
        MOV DL, 07H
        INT 21H
        mov ah,buzAh
        mov dl,buzDh
        inc bx
        loop scans5
        MOV AH,2
        MOV DL, 07H
        INT 21H
    mov bx,0
    prints MSG10,09h    
    mov ah,2
    mov dx,a[bx]
    int 21h
    mov tdx,dx
    prints MSG13,09h
    ;mov ah,1
    ;int 21h
    mov tah,ah
    mov tbx,bx    
    mov tcx,cx
    mov al,'x'
    mov ah,02ch        ; Get current second         
    int 021h
    mov bh,dh          ; Store current second   
    readloop9:
    mov ah,02ch      ; Call function 02C of INT 021 to get new time
    int 021h
    sub dh,05h         ; Subtract 05 from new second. Giving 5 Secs for input.
                        ; For if old second in BH=05 and new second in DH-5=1,
                        ; four more
                        ; seconds must pass.
    cmp bh,dh                    
    je endprog9         ; Exit when DH is finally equal to BH.
                     ; Example BH=05 and DH - 05 = 05, then DH = 0F and 
                     ; 05 - 0F = Five Seconds
    mov ah,06h          ; Function 06h of INT 021 will directly read from the Stdin/Stdout
    mov dl,255           ; Move 0ff into the DL register to read from the keyboard
    int 21h              
    jz readloop9
    endprog9:
    mov cx,tcx
    
    mov ah,tah
    mov bx,tbx
        ;
        ;
    cmp al,'b'
    jz right5
    jnz wrong5
    mov cx,0
    right5:
        prints MSG6,09h
        mov dx,tdx
        cmp dl,'1'
        jz team91
        cmp dl,'2'
        jz team92
        cmp dl,'3'
        jz team93
        cmp dl,'4'
        jz team94
        
        team91:
            call Apositive
            jmp Ques6
        team92:
            call Bpositive
            jmp Ques6
        team93:
            call Cpositive
            jmp Ques6
        team94:
            call Dpositive
            jmp Ques6 
        jmp Exit
        
    wrong5:
        inc cx
        prints MSG7,09h
        inc bx
        mov dx,tdx 
        cmp dl,'1'
        jz team101
        cmp dl,'2'
        jz team102
        cmp dl,'3'
        jz team103
        cmp dl,'4'
        jz team104
        
        team101:
            call Anegative
            jmp conti5
        team102:
            call Bnegative
            jmp conti5
        team103:
            call Cnegative
            jmp conti5
        team104:
            call Dnegative
            jmp conti5
        
        conti5:
        prints MSG10,09h
        mov ah,2
        mov dx,a[bx]
        int 21h 
        mov tdx,dx
        prints MSG13,09h
        ;mov ah,1
        ;int 21h
    mov tah,ah
    mov tbx,bx
    
    mov tcx,cx
    mov al,'x'
    mov ah,02ch        ; Get current second         
    int 021h
    mov bh,dh          ; Store current second   
    readloop10:
    mov ah,02ch      ; Call function 02C of INT 021 to get new time
    int 021h
    sub dh,05h         ; Subtract 05 from new second. Giving 5 Secs for input.
                        ; For if old second in BH=05 and new second in DH-5=1,
                        ; four more
                        ; seconds must pass.
    cmp bh,dh                    
    je endprog10         ; Exit when DH is finally equal to BH.
                     ; Example BH=05 and DH - 05 = 05, then DH = 0F and 
                     ; 05 - 0F = Five Seconds
    mov ah,06h          ; Function 06h of INT 021 will directly read from the Stdin/Stdout
    mov dl,255           ; Move 0ff into the DL register to read from the keyboard
    int 21h              
    jz readloop10
    endprog10:
    mov cx,tcx
    mov dx,tdx
    mov ah,tah
    mov bx,tbx
        ;
        ;

        cmp al,'b'
        jz right5
        jnz wrong5
        cmp cx,4
        jz pass5
        jnz Ques6
         
    pass5:
        prints MSG14,09h
        jnz Ques6  
        
        
        
    ;Ques6
    
    Ques6:
    mov bx,0
    prints Q6,09h
    prints QA6,09h 
    prints MSG12,09h
    mov cx,4
    mov ah,1
    scans6:
        int 21h
        mov a[bx],ax 
        mov buzAh,AH
        mov buzDh,DL
        MOV AH,2
        MOV DL, 07H
        INT 21H
        mov ah,buzAh
        mov dl,buzDh
        inc bx
        loop scans6
        MOV AH,2
        MOV DL, 07H
        INT 21H
    mov bx,0
    prints MSG10,09h    
    mov ah,2
    mov dx,a[bx]
    int 21h
    mov tdx,dx
    prints MSG13,09h
    ;mov ah,1
    ;int 21h
        mov tah,ah
    mov tbx,bx
    
    mov tcx,cx
    mov al,'x'
    mov ah,02ch        ; Get current second         
    int 021h
    mov bh,dh          ; Store current second   
    readloop11:
    mov ah,02ch      ; Call function 02C of INT 021 to get new time
    int 021h
    sub dh,05h         ; Subtract 05 from new second. Giving 5 Secs for input.
                        ; For if old second in BH=05 and new second in DH-5=1,
                        ; four more
                        ; seconds must pass.
    cmp bh,dh                    
    je endprog11         ; Exit when DH is finally equal to BH.
                     ; Example BH=05 and DH - 05 = 05, then DH = 0F and 
                     ; 05 - 0F = Five Seconds
    mov ah,06h          ; Function 06h of INT 021 will directly read from the Stdin/Stdout
    mov dl,255           ; Move 0ff into the DL register to read from the keyboard
    int 21h              
    jz readloop11
    endprog11:
    mov cx,tcx
    mov dx,tdx
    mov ah,tah
    mov bx,tbx
        ;
        ;

    cmp al,'b'
    jz right6
    jnz wrong6
    mov cx,0
    right6:
        prints MSG6,09h
        mov dx,tdx
        cmp dl,'1'
        jz team111
        cmp dl,'2'
        jz team112
        cmp dl,'3'
        jz team113
        cmp dl,'4'
        jz team114
        
        team111:
            call Apositive
            jmp Ques7
        team112:
            call Bpositive
            jmp Ques7
        team113:
            call Cpositive
            jmp Ques7
        team114:
            call Dpositive
            jmp Ques7 
        jmp Exit
        
    wrong6:
        inc cx
        prints MSG7,09h
        mov dx,tdx
        inc bx 
        cmp dl,'1'
        jz team121
        cmp dl,'2'
        jz team122
        cmp dl,'3'
        jz team123
        cmp dl,'4'
        jz team124
        
        team121:
            call Anegative
            jmp conti6
        team122:
            call Bnegative
            jmp conti6
        team123:
            call Cnegative
            jmp conti6
        team124:
            call Dnegative
            jmp conti6
        
        conti6:
        prints MSG10,09h
        mov ah,2
        mov dx,a[bx]
        int 21h
        prints MSG13,09h
        ;mov ah,1
        ;int 21h
            mov tah,ah
    mov tbx,bx
    mov tdx,dx
    mov tcx,cx
    mov al,'x'
    mov ah,02ch        ; Get current second         
    int 021h
    mov bh,dh          ; Store current second   
    readloop12:
    mov ah,02ch      ; Call function 02C of INT 021 to get new time
    int 021h
    sub dh,05h         ; Subtract 05 from new second. Giving 5 Secs for input.
                        ; For if old second in BH=05 and new second in DH-5=1,
                        ; four more
                        ; seconds must pass.
    cmp bh,dh                    
    je endprog12         ; Exit when DH is finally equal to BH.
                     ; Example BH=05 and DH - 05 = 05, then DH = 0F and 
                     ; 05 - 0F = Five Seconds
    mov ah,06h          ; Function 06h of INT 021 will directly read from the Stdin/Stdout
    mov dl,255           ; Move 0ff into the DL register to read from the keyboard
    int 21h              
    jz readloop12
    endprog12:
    mov cx,tcx
    mov dx,tdx
    mov ah,tah
    mov bx,tbx
        ;
        ;
        cmp al,'b'
        jz right6
        jnz wrong6
        cmp cx,4
        jz pass6
        jnz Ques7
         
    pass6:
        prints MSG14,09h
        jnz Ques7
        
        
     ;EndQues6
     
     
    ;Ques7
     
     
    Ques7:
    mov bx,0
    prints Q7,09h
    prints QA7,09h 
    prints MSG12,09h
    mov cx,4
    mov ah,1
    scans7:
        int 21h
        mov a[bx],ax   
        mov buzAh,AH
        mov buzDh,DL
        MOV AH,2
        MOV DL, 07H
        INT 21H
        mov ah,buzAh
        mov dl,buzDh
        inc bx
        loop scans7
        MOV AH,2
        MOV DL, 07H
        INT 21H
    mov bx,0
    prints MSG10,09h    
    mov ah,2
    mov dx,a[bx]
    int 21h
    mov tdx,dx
    prints MSG13,09h
    ;mov ah,1
    ;int 21h
        mov tah,ah
    mov tbx,bx
    
    mov tcx,cx
    mov al,'x'
    mov ah,02ch        ; Get current second         
    int 021h
    mov bh,dh          ; Store current second   
    readloop13:
    mov ah,02ch      ; Call function 02C of INT 021 to get new time
    int 021h
    sub dh,05h         ; Subtract 05 from new second. Giving 5 Secs for input.
                        ; For if old second in BH=05 and new second in DH-5=1,
                        ; four more
                        ; seconds must pass.
    cmp bh,dh                    
    je endprog13         ; Exit when DH is finally equal to BH.
                     ; Example BH=05 and DH - 05 = 05, then DH = 0F and 
                     ; 05 - 0F = Five Seconds
    mov ah,06h          ; Function 06h of INT 021 will directly read from the Stdin/Stdout
    mov dl,255           ; Move 0ff into the DL register to read from the keyboard
    int 21h              
    jz readloop13
    endprog13:
    mov cx,tcx
    
    mov ah,tah
    mov bx,tbx
        ;
        ;

    cmp al,'b'
    jz right7
    jnz wrong7
    mov cx,0
    right7:
        prints MSG6,09h
        mov dx,tdx
        cmp dl,'1'
        jz team131
        cmp dl,'2'
        jz team132
        cmp dl,'3'
        jz team133
        cmp dl,'4'
        jz team134
        
        team131:
            call Apositive
            jmp Ques8
        team132:
            call Bpositive
            jmp Ques8
        team133:
            call Cpositive
            jmp Ques8
        team134:
            call Dpositive
            jmp Ques8 
        jmp Exit
        
    wrong7:
        inc cx
        prints MSG7,09h
        mov dx,tdx
        inc bx 
        cmp dl,'1'
        jz team141
        cmp dl,'2'
        jz team142
        cmp dl,'3'
        jz team143
        cmp dl,'4'
        jz team144
        
        team141:
            call Anegative
            jmp conti7
        team142:
            call Bnegative
            jmp conti7
        team143:
            call Cnegative
            jmp conti7
        team144:
            call Dnegative
            jmp conti7
        
        conti7:
        prints MSG10,09h
        mov ah,2
        mov dx,a[bx]
        int 21h 
         mov tdx,dx
        prints MSG13,09h
        ;mov ah,1
        ;int 21h
            mov tah,ah
    mov tbx,bx
   
    mov tcx,cx
    mov al,'x'
    mov ah,02ch        ; Get current second         
    int 021h
    mov bh,dh          ; Store current second   
    readloop14:
    mov ah,02ch      ; Call function 02C of INT 021 to get new time
    int 021h
    sub dh,05h         ; Subtract 05 from new second. Giving 5 Secs for input.
                        ; For if old second in BH=05 and new second in DH-5=1,
                        ; four more
                        ; seconds must pass.
    cmp bh,dh                    
    je endprog14         ; Exit when DH is finally equal to BH.
                     ; Example BH=05 and DH - 05 = 05, then DH = 0F and 
                     ; 05 - 0F = Five Seconds
    mov ah,06h          ; Function 06h of INT 021 will directly read from the Stdin/Stdout
    mov dl,255           ; Move 0ff into the DL register to read from the keyboard
    int 21h              
    jz readloop14
    endprog14:
    mov cx,tcx
    mov dx,tdx
    mov ah,tah
    mov bx,tbx
        ;
        ;

        cmp al,'b'
        jz right7
        jnz wrong7
        cmp cx,4
        jz pass7
        jnz Ques8
         
    pass7:
        prints MSG14,09h
        jnz Ques8       
        
    ;EndQues7
    
        
    ;Ques8   
    
    
    Ques8:
    mov bx,0
    prints Q8,09h
    prints QA8,09h 
    prints MSG12,09h
    mov cx,4
    mov ah,1
    scans8:
        int 21h
        mov a[bx],ax 
        mov buzAh,AH
        mov buzDh,DL
        MOV AH,2
        MOV DL, 07H
        INT 21H
        mov ah,buzAh
        mov dl,buzDh
        inc bx
        loop scans8
        MOV AH,2
        MOV DL, 07H
        INT 21H
    mov bx,0
    prints MSG10,09h    
    mov ah,2
    mov dx,a[bx]
    int 21h
    mov tdx,dx
    prints MSG13,09h
    ;mov ah,1
    ;int 21h
        mov tah,ah
    mov tbx,bx
    
    mov tcx,cx
    mov al,'x'
    mov ah,02ch        ; Get current second         
    int 021h
    mov bh,dh          ; Store current second   
    readloop15:
    mov ah,02ch      ; Call function 02C of INT 021 to get new time
    int 021h
    sub dh,05h         ; Subtract 05 from new second. Giving 5 Secs for input.
                        ; For if old second in BH=05 and new second in DH-5=1,
                        ; four more
                        ; seconds must pass.
    cmp bh,dh                    
    je endprog15         ; Exit when DH is finally equal to BH.
                     ; Example BH=05 and DH - 05 = 05, then DH = 0F and 
                     ; 05 - 0F = Five Seconds
    mov ah,06h          ; Function 06h of INT 021 will directly read from the Stdin/Stdout
    mov dl,255           ; Move 0ff into the DL register to read from the keyboard
    int 21h              
    jz readloop15
    endprog15:
    mov cx,tcx
    
    mov ah,tah
    mov bx,tbx
        ;
        ;
    cmp al,'b'
    jz right8
    jnz wrong8
    mov cx,0
    right8:
        prints MSG6,09h
        mov dx,tdx
        cmp dl,'1'
        jz team151
        cmp dl,'2'
        jz team152
        cmp dl,'3'
        jz team153
        cmp dl,'4'
        jz team154
        
        team151:
            call Apositive
            jmp Ques9
        team152:
            call Bpositive
            jmp Ques9
        team153:
            call Cpositive
            jmp Ques9
        team154:
            call Dpositive
            jmp Ques9 
        jmp Exit
        
    wrong8:
        inc cx
        prints MSG7,09h
        inc bx
        mov dx,tdx 
        cmp dl,'1'
        jz team161
        cmp dl,'2'
        jz team162
        cmp dl,'3'
        jz team163
        cmp dl,'4'
        jz team164
        
        team161:
            call Anegative
            jmp conti8
        team162:
            call Bnegative
            jmp conti8
        team163:
            call Cnegative
            jmp conti8
        team164:
            call Dnegative
            jmp conti8
        
        conti8:
        prints MSG10,09h
        mov ah,2
        mov dx,a[bx]
        int 21h
        mov tdx,dx
        prints MSG13,09h
        ;mov ah,1
        ;int 21h
            mov tah,ah
    mov tbx,bx
    
    mov tcx,cx
    mov al,'x'
    mov ah,02ch        ; Get current second         
    int 021h
    mov bh,dh          ; Store current second   
    readloop16:
    mov ah,02ch      ; Call function 02C of INT 021 to get new time
    int 021h
    sub dh,05h         ; Subtract 05 from new second. Giving 5 Secs for input.
                        ; For if old second in BH=05 and new second in DH-5=1,
                        ; four more
                        ; seconds must pass.
    cmp bh,dh                    
    je endprog16         ; Exit when DH is finally equal to BH.
                     ; Example BH=05 and DH - 05 = 05, then DH = 0F and 
                     ; 05 - 0F = Five Seconds
    mov ah,06h          ; Function 06h of INT 021 will directly read from the Stdin/Stdout
    mov dl,255           ; Move 0ff into the DL register to read from the keyboard
    int 21h              
    jz readloop16
    endprog16:
    mov cx,tcx
    mov dx,tdx
    mov ah,tah
    mov bx,tbx
        ;
        ;

        cmp al,'b'
        jz right8
        jnz wrong8
        cmp cx,4
        jz pass8
        jnz Ques9
         
    pass8:
        prints MSG14,09h
        jnz Ques9      
        
        
        
    ;End Ques8
    
    ;Ques9
    
    
    Ques9:
    mov bx,0
    prints Q9,09h
    prints QA9,09h 
    prints MSG12,09h
    mov cx,4
    mov ah,1
    scans9:
        int 21h
        mov a[bx],ax
        mov buzAh,AH
        mov buzDh,DL
        MOV AH,2
        MOV DL, 07H
        INT 21H
        mov ah,buzAh
        mov dl,buzDh
        inc bx
        loop scans9
        MOV AH,2
        MOV DL, 07H
        INT 21H
    mov bx,0
    prints MSG10,09h    
    mov ah,2
    mov dx,a[bx]
    int 21h
    mov tdx,dx
    prints MSG13,09h
    ;mov ah,1
    ;int 21h
        mov tah,ah
    mov tbx,bx
    
    mov tcx,cx
    mov al,'x'
    mov ah,02ch        ; Get current second         
    int 021h
    mov bh,dh          ; Store current second   
    readloop17:
    mov ah,02ch      ; Call function 02C of INT 021 to get new time
    int 021h
    sub dh,05h         ; Subtract 05 from new second. Giving 5 Secs for input.
                        ; For if old second in BH=05 and new second in DH-5=1,
                        ; four more
                        ; seconds must pass.
    cmp bh,dh                    
    je endprog17         ; Exit when DH is finally equal to BH.
                     ; Example BH=05 and DH - 05 = 05, then DH = 0F and 
                     ; 05 - 0F = Five Seconds
    mov ah,06h          ; Function 06h of INT 021 will directly read from the Stdin/Stdout
    mov dl,255           ; Move 0ff into the DL register to read from the keyboard
    int 21h              
    jz readloop17
    endprog17:
    mov cx,tcx
    
    mov ah,tah
    mov bx,tbx
        ;
        ;

    cmp al,'b'
    jz right9
    jnz wrong9
    mov cx,0
    right9:
        prints MSG6,09h
        mov dx,tdx
        cmp dl,'1'
        jz team171
        cmp dl,'2'
        jz team172
        cmp dl,'3'
        jz team173
        cmp dl,'4'
        jz team174
        
        team171:
            call Apositive
            jmp Ques10
        team172:
            call Bpositive
            jmp Ques10
        team173:
            call Cpositive
            jmp Ques10
        team174:
            call Dpositive
            jmp Ques10 
        jmp Exit
        
    wrong9:
        inc cx
        prints MSG7,09h
        inc bx
        mov dx,tdx 
        cmp dl,'1'
        jz team181
        cmp dl,'2'
        jz team182
        cmp dl,'3'
        jz team183
        cmp dl,'4'
        jz team164
        
        team181:
            call Anegative
            jmp conti9
        team182:
            call Bnegative
            jmp conti9
        team183:
            call Cnegative
            jmp conti9
        team184:
            call Dnegative
            jmp conti9
        
        conti9:
        prints MSG10,09h
        mov ah,2
        mov dx,a[bx]
        int 21h
        prints MSG13,09h
        ;mov ah,1
        ;int 21h
            mov tah,ah
    mov tbx,bx
    mov tdx,dx
    mov tcx,cx
    mov al,'x'
    mov ah,02ch        ; Get current second         
    int 021h
    mov bh,dh          ; Store current second   
    readloop18:
    mov ah,02ch      ; Call function 02C of INT 021 to get new time
    int 021h
    sub dh,05h         ; Subtract 05 from new second. Giving 5 Secs for input.
                        ; For if old second in BH=05 and new second in DH-5=1,
                        ; four more
                        ; seconds must pass.
    cmp bh,dh                    
    je endprog18         ; Exit when DH is finally equal to BH.
                     ; Example BH=05 and DH - 05 = 05, then DH = 0F and 
                     ; 05 - 0F = Five Seconds
    mov ah,06h          ; Function 06h of INT 021 will directly read from the Stdin/Stdout
    mov dl,255           ; Move 0ff into the DL register to read from the keyboard
    int 21h              
    jz readloop18
    endprog18:
    mov cx,tcx
    mov dx,tdx
    mov ah,tah
    mov bx,tbx
        ;
        ;
        cmp al,'b'
        jz right9
        jnz wrong9
        cmp cx,4
        jz pass9
        jnz Ques10
         
    pass9:
        prints MSG14,09h
        jnz Ques10
        
        
    ;End Ques9        
    
    
    
    ;Ques10
    
    Ques10:
    mov bx,0
    prints Q10,09h
    prints QA10,09h 
    prints MSG12,09h
    mov cx,4
    mov ah,1
    scans10:
        int 21h
        mov a[bx],ax 
        mov buzAh,AH
        mov buzDh,DL
        MOV AH,2
        MOV DL, 07H
        INT 21H
        mov ah,buzAh
        mov dl,buzDh
        inc bx
        loop scans10
        MOV AH,2
        MOV DL, 07H
        INT 21H      

    mov bx,0
    prints MSG10,09h    
    mov ah,2
    mov dx,a[bx]
    int 21h
    mov tdx,dx
    prints MSG13,09h
    ;mov ah,1
    ;int 21h
        mov tah,ah
    mov tbx,bx
    
    mov tcx,cx
    mov al,'x'
    mov ah,02ch        ; Get current second         
    int 021h
    mov bh,dh          ; Store current second   
    readloop19:
    mov ah,02ch      ; Call function 02C of INT 021 to get new time
    int 021h
    sub dh,05h         ; Subtract 05 from new second. Giving 5 Secs for input.
                        ; For if old second in BH=05 and new second in DH-5=1,
                        ; four more
                        ; seconds must pass.
    cmp bh,dh                    
    je endprog19         ; Exit when DH is finally equal to BH.
                     ; Example BH=05 and DH - 05 = 05, then DH = 0F and 
                     ; 05 - 0F = Five Seconds
    mov ah,06h          ; Function 06h of INT 021 will directly read from the Stdin/Stdout
    mov dl,255           ; Move 0ff into the DL register to read from the keyboard
    int 21h              
    jz readloop19
    endprog19:
    mov cx,tcx
    
    mov ah,tah
    mov bx,tbx
        ;
        ;
    cmp al,'b'
    jz right10
    jnz wrong10
    mov cx,0
    right10:
        prints MSG6,09h
        mov dx,tdx
        cmp dl,'1'
        jz team191
        cmp dl,'2'
        jz team192
        cmp dl,'3'
        jz team193
        cmp dl,'4'
        jz team194
        
        team191:
            call Apositive
            jmp Exit
        team192:
            call Bpositive
            jmp Exit
        team193:
            call Cpositive
            jmp Exit
        team194:
            call Dpositive
            jmp Exit 
        jmp Exit
        
    wrong10:
        inc cx
        prints MSG7,09h
        mov dx,tdx
        inc bx 
        cmp dl,'1'
        jz team201
        cmp dl,'2'
        jz team202
        cmp dl,'3'
        jz team203
        cmp dl,'4'
        jz team204
        
        team201:
            call Apositive
            jmp conti10
        team202:
            call Bpositive
            jmp conti10
        team203:
            call Cpositive
            jmp conti10
        team204:
            call Dpositive
            jmp conti10
        
        conti10:
        prints MSG10,09h
        mov ah,2
        mov dx,a[bx]
        int 21h
        prints MSG13,09h
        ;mov ah,1
        ;int 21h
            mov tah,ah
    mov tbx,bx
    mov tdx,dx
    mov tcx,cx
    mov al,'x'
    mov ah,02ch        ; Get current second         
    int 021h
    mov bh,dh          ; Store current second   
    readloop20:
    mov ah,02ch      ; Call function 02C of INT 021 to get new time
    int 021h
    sub dh,05h         ; Subtract 05 from new second. Giving 5 Secs for input.
                        ; For if old second in BH=05 and new second in DH-5=1,
                        ; four more
                        ; seconds must pass.
    cmp bh,dh                    
    je endprog20         ; Exit when DH is finally equal to BH.
                     ; Example BH=05 and DH - 05 = 05, then DH = 0F and 
                     ; 05 - 0F = Five Seconds
    mov ah,06h          ; Function 06h of INT 021 will directly read from the Stdin/Stdout
    mov dl,255           ; Move 0ff into the DL register to read from the keyboard
    int 21h              
    jz readloop20
    endprog20:
    mov cx,tcx
    mov dx,tdx
    mov ah,tah
    mov bx,tbx
        ;
        ;
        cmp al,'b'
        jz right10
        jnz wrong10
        cmp cx,4
        jz pass10
        jnz exit
         
    pass10:
        prints MSG14,09h
        jnz exit
        
        
    ;Ques 10    

Exit:  
    prints MSG8,09h  
    
    prints MSG15,09h
    prints MSG16,09h 
    sprinter score1
    prints MSG17,09h
    sprinter score2
    prints MSG18,09h
    sprinter score3
    prints MSG19,09h
    sprinter score4 
    
    hlt    
        
endp

   
Apositive:
    add score1,1
    ret
Bpositive:
    add score2,1
    ret
Cpositive:
    add score3,1
    ret
Dpositive:
    add score4,1
    ret   
    
Anegative:
    sub score1,1
    ret
Bnegative:
    sub score2,1
    ret
Cnegative:
    sub score3,1
    ret
Dnegative:
    sub score4,1
    ret
