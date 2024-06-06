;AUTHOR  : ASHUWIN P
; REG.NO : 3122225002013

CR  EQU 0DH
LF  EQU 0AH

DATA SEGMENT
    TABEL  DB '0123456789ABCDEF'
    N1     DB 0AH
    N2     DB 09H
    RESULT DB 00H
    MSG    DB 'THE SUBTRACTION RESULT IS : '
    ASCIIR DB 2 DUP(?)
           DB CR, LF, '$'
DATA ENDS

CODE SEGMENT
          ASSUME CS:CODE, DS:DATA

    START:

          MOV    AX, DATA
          MOV    DS, AX

          MOV    AL, N1
          SUB    AL, N2
          MOV    RESULT, AL

          LEA    BX, TABEL
          LEA    SI, ASCIIR

          INC    SI
          MOV    AL, RESULT
          AND    AL, 0FH
          XLAT
          MOV    [SI], AL

          DEC    SI
          MOV    AL, RESULT
          AND    AL, 0F0H
          MOV    CL, 04H
          SHR    AL, CL
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
    