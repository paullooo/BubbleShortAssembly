INCLUDE 'EMU8086.INC'        

.MODEL SMALL 

.STACK 100h ;inicaliza em 100 

.DATA ;constantes        
    ARR DB 50 DUP(?)    ;declaracao do Array

.CODE  ;codificacao
    MAIN PROC  
        PRINT "Lucio eu te amo<3: "
        PRINTN
        PRINT "Tamanho do array(1-9): "
        MOV AH,1
        INT 21h
        AND AL,0FH  ; converter para ascii para precisar converter no final       
        
        XOR CX,CX   ; inicializar com zero
        MOV CL,AL
        PUSH CX
        PUSH CX  
        LEA SI,ARR   ;Semelhante ao MOV mas carrega um endereco
        
        PRINTN        ;= system.out.println
        PRINTN        ; quebrar a linha
        PRINT "Digite os valores: "    ;printar mensagem       
     INPUT:      ;Ler os dados imputados no teclado   
         MOV AH,1
         INT 21h
        
         MOV ARR[SI],AL
         INC SI
         LOOP INPUT           
         
         POP CX       ;retira valor imputado    
         LEA SI,ARR   ;adiciona do valor imputado no Array ARR
         ADD CX,SI
        
         XOR BX,BX    ;inicalizar  
     SORT:            ;organizar o array
          SUB CX,1    ;comparacao do para o criteiro de parada das interacoes
          LEA SI,ARR  
          CMP CX,SI
          JLE EXIT    ;se as interacoes acabarem vai para o final do programa
          SWAP:
            CMP SI,CX
            JGE SORT     ;chamada de subrotina
                        
            MOV BL,ARR[SI]   ;implementacao do bubble sort
            MOV BH,ARR[SI+1]
            CMP BL,BH
            JLE INCREMENT
            
            MOV ARR[SI],BH
            MOV ARR[SI+1],BL
            INC SI ;incrementa o interacao do FOR
            JMP SWAP  
      INCREMENT:
           INC SI
           JMP SWAP
      EXIT:
           LEA SI,ARR
           POP CX
           PRINTN
           PRINTN
           PRINT "Array organizado: "
           ;PRINT "Maior Valor: "
           ;PRINT "Menor Valor: "
      OUTPUT: 
            MOV DL,ARR[SI]  ;mostrar saida no console
            MOV AH,2        ;caracter no registrador usado pelo int21h 
            INT 21h
            INC SI
            LOOP OUTPUT
     MAIN ENDP
END MAIN