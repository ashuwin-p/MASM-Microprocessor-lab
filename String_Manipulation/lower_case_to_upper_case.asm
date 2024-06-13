cr equ 0dh
lf equ 0ah

data segment
    string   db 'ind@iA9', cr, lf, '$'
    strlen   dw 07h
    message1 db 'The original string :', cr, lf, '$'
    message2 db 'The translated string :', cr, lf, '$'
    TABEL    db 48 dup(?), '0123456789', 7 dup(?), 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 6 dup(?), 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 133 dup(?)
data ends

code segment
          assume cs:code, ds:data, es:data

    start:
          mov    ax, data
          mov    ds, ax
          mov    es, ax

          mov    ah, 09h
          lea    dx, message1
          int    21h
    
          mov    ah, 09h
          lea    dx, string
          int    21h


          lea    si, string
          lea    di, string
          lea    bx, TABEL
          mov    cx, strlen
          cld

    top:  
          lodsb
          xlat
          stosb
          loop   top
    
          mov    ah, 09h
          lea    dx, message2
          int    21h
    
          mov    ah, 09h
          lea    dx, string
          int    21h

    quit: 
          mov    al, 00h
          mov    ah, 4ch
          int    21h

code ends
end start
