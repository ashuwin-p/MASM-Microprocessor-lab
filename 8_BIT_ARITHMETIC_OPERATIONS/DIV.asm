;AUTHOR  : ASHUWIN P
; REG.NO : 3122225002013

CR  EQU 0DH
LF  EQU 0AH

DATA SEGMENT
        TABEL DB '0123456789ABCDEF'
        N1    DW 12H
        N2    DB 0AH
        QUO   DB 00H
        REM   DB 00H
        MSG1  DB 'THE QUOTIENT IS : '
        ASQUO DB 2 DUP(?)
              DB CR, LF, '$'

        MSG2  DB 'THE REMINDER IS : '
        ASREM DB 2 DUP(?)
              DB CR, LF, '$'
DATA ENDS

CODE SEGMENT
              ASSUME CS:CODE, DS:DATA

        START:
              MOV    AX, DATA
              MOV    DS, AX

              MOV    AX, N1
              DIV    N2
              MOV    QUO, AL
              MOV    REM, AH

              LEA    BX, TABEL
              LEA    SI, ASQUO

              INC    SI
              MOV    AL, QUO
              AND    AL, 0FH
              XLAT
              MOV    [SI], AL

              DEC    SI
              MOV    AL, QUO
              AND    AL, 0F0H
              MOV    CL, 04H
              SHR    AL, CL
              XLAT
              MOV    [SI], AL

              MOV    AH, 09H
              LEA    DX, MSG1
              INT    21H


              LEA    SI, ASREM

              INC    SI
              MOV    AL, REM
              AND    AL, 0FH
              XLAT
              MOV    [SI], AL

              DEC    SI
              MOV    AL, REM
              AND    AL, 0F0H
              MOV    CL, 04H
              SHR    AL, CL
              XLAT
              MOV    [SI], AL

              MOV    AH, 09H
              LEA    DX, MSG2
              INT    21H

        QUIT: 
              MOV    AL, 00H
              MOV    AH, 04CH
              INT    21H

CODE ENDS
    END START





