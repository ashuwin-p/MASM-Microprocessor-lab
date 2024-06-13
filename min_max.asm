CR EQU 0DH
LF EQU 0AH

DATA SEGMENT
    TABEL     DB '0123456789ABCDEF'
    ARRAY     DB 10H, 85H, 96H, 5H, 63H, 15H, 2H, 45H
    MINIMUM   DB 00H
    MAXIMUM   DB 00H
    MSG1      DB "Maximum : "
    max_ascii DB 2 DUP(?)
              DB CR, LF, '$'
    MSG2      DB "Minimum : "
    min_ascii DB 2 DUP(?)
              DB CR, LF, '$'

DATA ENDS

CODE SEGMENT
           ASSUME CS:CODE, DS:DATA
    START: 
           MOV    AX, DATA
           MOV    DS, AX
        
           LEA    SI, ARRAY
           MOV    CX, 07H
           MOV    AL, [SI]

    MAXI:  
           INC    SI
           CMP    AL, [SI]
           JC     SWAP1
           LOOP   MAXI
           JMP    NEXT
        
    SWAP1: 
           XCHG   AL, [SI]
           LOOP   MAXI
           JMP    NEXT
        
    NEXT:  
           MOV    MAXIMUM, AL

           LEA    SI, ARRAY
           MOV    CX, 07H
           MOV    AL, [SI]

    MINI:  
           INC    SI
           CMP    AL, [SI]
           JNC    SWAP2
           LOOP   MINI
           JMP    FINISH
        
    SWAP2: 
           XCHG   AL, [SI]
           LOOP   MINI
           JMP    FINISH
        
    FINISH:
           MOV    MINIMUM, AL

           LEA    BX, TABEL

    ; conversion of maximum
            
           LEA    SI, max_ascii
            
           INC    SI
           MOV    AL, MAXIMUM
           AND    AL, 0FH
           XLAT
           MOV    [SI], AL

           DEC    SI
           MOV    AL, MAXIMUM
           AND    AL, 0F0H
           MOV    CL, 04H
           SHR    AL, CL
           XLAT
           MOV    [SI], AL

           MOV    AH, 09H
           LEA    DX, MSG1
           INT    21H

    ; conversion of minimum
            
           LEA    SI, min_ascii
            
           INC    SI
           MOV    AL, MINIMUM
           AND    AL, 0FH
           XLAT
           MOV    [SI], AL

           DEC    SI
           MOV    AL, MINIMUM
           AND    AL, 0F0H
           MOV    CL, 04H
           SHR    AL, CL
           XLAT
           MOV    [SI], AL

           MOV    AH, 09H
           LEA    DX, MSG2
           INT    21H
        
    QUIT:  
           MOV    AL, 00
           MOV    AH, 04CH
           INT    21H
CODE ENDS
END START
