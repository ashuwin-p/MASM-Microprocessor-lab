;AUTHOR  : ASHUWIN P
; REG.NO : 3122225002013

CR  EQU 0DH
LF  EQU 0AH

DATA SEGMENT
    TABEL  DB '0123456789ABCDEF'
    N1     DW 2005H
    N2     DW 2024H
    RESULT DW 00000H
    MSG    DB 'THE ADDITION RESULT IS : '
    ASCIIR DB 4 DUP(?)
           DB CR, LF, '$'
DATA ENDS

CODE SEGMENT
          ASSUME CS:CODE, DS:DATA
    START:
          MOV    AX, DATA
          MOV    DS, AX


          MOV    AX, N1
          ADD    AX, N2
          MOV    RESULT, AX

          LEA    BX, TABEL
          LEA    SI, ASCIIR

          ADD    SI, 3
          MOV    AX, RESULT
          AND    AX, 0000FH
          XLAT
          MOV    [SI], AL

          DEC    SI
          MOV    AX, RESULT
          AND    AX, 000F0H
          MOV    CL, 04H
          SHR    AX, CL
          XLAT
          MOV    [SI], AL

          DEC    SI
          MOV    AX, RESULT
          AND    AX, 00F00H
          MOV    CL, 08H
          SHR    AX, CL
          XLAT
          MOV    [SI], AL

          DEC    SI
          MOV    AX, RESULT
          AND    AX, 0F000H
          MOV    CL, 0CH
          SHR    AX, CL
          XLAT
          MOV    [SI], AL

          MOV    AH, 09H
          LEA    DX, MSG
          INT    21H

    QUIT: 
          MOV    AL, 00
          MOV    AH, 04CH
          INT    21H

CODE ENDS
    END START
