;AUTHOR  : ASHUWIN P
; REG.NO : 3122225002013

CR  EQU 0DH
LF  EQU 0AH

DATA SEGMENT
    TABEL  DB '0123456789ABCDEF'
    N1     DB 08H
    N2     DB 05H
    MSG    DB 'THE MULTIPLICATION RESULT IS : '
    ASCIIR DB 2 DUP(?)
           DB CR, LF, '$'
DATA ENDS

CODE SEGMENT
          ASSUME CS:CODE, DS:DATA

    START:

          MOV    AX, DATA
          MOV    DS, AX

          MOV    AL, N1
          MUL    N2
          AAM

          LEA    BX, TABEL
          LEA    SI, ASCIIR

          INC    SI
          AND    AL, 0FH
          XLAT
          MOV    [SI], AL

          DEC    SI
          MOV    AL, AH
          AND    AL, 0FH
          XLAT
          MOV    [SI], AL


          MOV    AH, 09H
          LEA    DX, MSG
          INT    21H

    QUIT: 
          MOV    AL, 00H
          MOV    AH, 04CH
          INT    21H

CODE ENDS
    END START

