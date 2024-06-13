CR     EQU 0DH    ; ASCII carriage return character
LF     EQU 0AH    ; ASCII line feed character

DATA SEGMENT
    STRING1 DB 'malayalam'   ; Original string to check for palindrome
    STRLEN  EQU $ - STRING1  ; Length of STRING1
    MESSAGE1 DB 'The given word is palindrome'
            DB CR, LF, '$'  ; Message for palindrome
    MESSAGE2 DB 'The given word is not palindrome'
            DB CR, LF, '$'  ; Message for not palindrome
    STRING2 DB 9 DUP(?)  ; Placeholder for reversed string (adjusted to match STRING1)
DATA ENDS

CODE SEGMENT
    ASSUME CS:CODE, DS:DATA, ES:DATA
START:
    MOV AX, DATA   ; Initialize data segment
    MOV DS, AX
    MOV ES, AX

    ; Copy STRING1 in reverse order to STRING2
    LEA SI, STRING1  ; SI points to start of STRING1
    LEA DI, STRING2 + STRLEN - 1  ; DI points to end of STRING2
    MOV CX, STRLEN   ; CX = length of STRING1
TOP:
    CLD               ; Ensure direction flag is cleared (forward movement)
    LODSB             ; Load byte from SI into AL, increment SI
    STD               ; Set direction flag to reverse movement
    STOSB             ; Store AL at DI, decrement DI
    LOOP TOP          ; Repeat for CX times

    ; Compare original STRING1 with reversed STRING2 to check palindrome
    LEA SI, STRING1   ; SI points to start of STRING1
    LEA DI, STRING2   ; DI points to start of STRING2
    CLD               ; Ensure direction flag is cleared (forward movement)
    MOV CX, STRLEN    ; CX = length of STRING1
    REPE CMPSB        ; Compare byte at SI with byte at DI, repeat while equal
    JNZ NOTPALINDROME ; Jump if not all bytes matched (not a palindrome)

    ; If palindrome
    MOV AH, 09H       ; Print function
    LEA DX, MESSAGE1   ; Load address of palindrome message
    INT 21H           ; Call DOS interrupt to print message
    JMP QUIT          ; Jump to end

NOTPALINDROME:
    ; If not palindrome
    MOV AH, 09H       ; Print function
    LEA DX, MESSAGE2   ; Load address of not palindrome message
    INT 21H           ; Call DOS interrupt to print message

QUIT:
    MOV AL, 0         ; Set AL = 0 (return code)
    MOV AH, 4CH       ; DOS function to terminate program
    INT 21H           ; Call DOS interrupt to exit

CODE ENDS
    END START
