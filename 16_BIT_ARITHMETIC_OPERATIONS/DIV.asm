;AUTHOR  : ASHUWIN P
; REG.NO : 3122225002013

CR  EQU 0DH
LF  EQU 0AH

DATA SEGMENT
        TABEL   DB '0123456789ABCDEF'
        LSBDIV  DW 1050H
        MSBDIV  DW 0000H
        DIVISOR DW 105H
        QUO     DW 0000H
        REM     DW 0000H
        MSG1    DB 'THE QUOTIENT IS : '
        ASCIIQ  DB 4 DUP(?)
                DB CR, LF, '$'
        MSG2    DB 'THE REMINDER IS : '
        ASCIIR  DB 4 DUP (?)
                DB CR, LF, '$'
DATA ENDS


CODE SEGMENT
              ASSUME CS:CODE, DS:DATA
        START:
              MOV    AX, DATA
              MOV    DS, AX

              MOV    AX, LSBDIV
              MOV    DX, MSBDIV
              DIV    DIVISOR
              MOV    QUO, AX
              MOV    REM, DX

              LEA    BX, TABEL
              LEA    SI, ASCIIQ

              ADD    SI, 3
              MOV    AX, QUO
              AND    AX, 0000FH
              XLAT
              MOV    [SI], AL

              DEC    SI
              MOV    AX, QUO
              AND    AX, 000F0H
              MOV    CL, 04H
              SHR    AX, CL
              XLAT
              MOV    [SI], AL

              DEC    SI
              MOV    AX, QUO
              AND    AX, 00F00H
              MOV    CL, 08H
              SHR    AX, CL
              XLAT
              MOV    [SI], AL

              DEC    SI
              MOV    AX, QUO
              AND    AX, 0F000H
              MOV    CL, 0CH
              SHR    AX, CL
              XLAT
              MOV    [SI], AL

              MOV    AH, 09H
              LEA    DX, MSG1
              INT    21H


              LEA    SI, ASCIIR

              ADD    SI, 3
              MOV    AX, REM
              AND    AX, 0000FH
              XLAT
              MOV    [SI], AL

              DEC    SI
              MOV    AX, REM
              AND    AX, 000F0H
              MOV    CL, 04H
              SHR    AX, CL
              XLAT
              MOV    [SI], AL

              DEC    SI
              MOV    AX, REM
              AND    AX, 00F00H
              MOV    CL, 08H
              SHR    AX, CL
              XLAT
              MOV    [SI], AL

              DEC    SI
              MOV    AX, REM
              AND    AX, 0F000H
              MOV    CL, 0CH
              SHR    AX, CL
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