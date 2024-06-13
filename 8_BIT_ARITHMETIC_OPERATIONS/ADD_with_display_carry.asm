CR     EQU 0DH
LF     EQU 0AH

DATA SEGMENT
    TABEL DB '0123456789ABCDEF'
    N1    DB 02H
    N2    DB 0BH
    RESULT DB 00H
    CARRY  DB 00H
    MSG    DB 'The Result is : $'
    ASCIIR DB 3 DUP(?)
           DB CR, LF, '$'
DATA ENDS

CODE SEGMENT
    ASSUME CS:CODE, DS:DATA
START:
    MOV    AX, DATA
    MOV    DS, AX

    MOV    AL, N1
    MOV    BL, N2
    ADD    AL, BL
    MOV    RESULT, AL

    JC    INCLUDE_CARRY
    JMP    CONVERT

INCLUDE_CARRY:
    MOV    CARRY, 01H

CONVERT:
    LEA    BX, TABEL
    LEA    SI, ASCIIR
    
    ADD    SI, 2
    
    ; Convert the lower nibble of RESULT to ASCII
    MOV    AL, RESULT
    AND    AL, 0FH
    XLAT
    MOV    [SI], AL

    ; Convert the upper nibble of RESULT to ASCII
    DEC    SI
    MOV    AL, RESULT
    AND    AL, 0F0H
    MOV    CL, 04H
    SHR    AL, CL
    XLAT
    MOV    [SI], AL

    ; Convert CARRY to ASCII
    DEC    SI
    MOV    AL, CARRY
    XLAT
    MOV    [SI], AL

    ; Display the message
    MOV    AH, 09H
    LEA    DX, MSG
    INT    21H

    ; Display the result
    LEA    DX, ASCIIR
    MOV    AH, 09H
    INT    21H

QUIT:
    MOV    AH, 4CH
    INT    21H

CODE ENDS
    END START
