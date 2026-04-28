
org 100h

.model small
.stack 100h

.data
    msg_main  db 13,10,'[MAIN] Program Running...$'
    msg_60h   db 13,10,'[INT 60h] Software ISR Executed!$'
    msg_key   db 13,10,'[INT 09h] Keyboard Captured!$'
    msg_timer db 13,10,'[INT 08h] Timer 1 Sec Passed!$'
    tick_count db 0

    ; Original addresses ko save karne ke liye variables
    old_key_off  dw ?
    old_key_seg  dw ?
    old_tim_off  dw ?
    old_tim_seg  dw ?

.code
main proc
    mov ax, @data
    mov ds, ax

    cli         
    xor ax, ax
    mov es, ax

    ; --- INT 60h Setup ---
    mov word ptr es:[60h*4], offset isr_60h
    mov word ptr es:[60h*4+2], cs

    ; --- Save & install keyboard ISR (INT 09h) ---
    mov ax, es:[9*4]
    mov old_key_off, ax
    mov ax, es:[9*4+2]
    mov old_key_seg, ax
    
    mov word ptr es:[9*4], offset isr_key
    mov word ptr es:[9*4+2], cs

    ; --- Save & install timer ISR (INT 08h) ---
    mov ax, es:[8*4]
    mov old_tim_off, ax
    mov ax, es:[8*4+2]
    mov old_tim_seg, ax

    mov word ptr es:[8*4], offset isr_timer
    mov word ptr es:[8*4+2], cs

    sti         

main_loop:
    mov ah, 09h
    lea dx, msg_main
    int 21h

    int 60h     

    ; Delay loop taake screen par text parha ja sakay
    mov cx, 0FFFFh
delay:
    nop
    loop delay

    ; Exit if 'q' is pressed (checking buffer)
    mov ah, 01h
    int 16h
    jnz exit_prog
    
    jmp main_loop

exit_prog:
    mov ax, 4c00h
    int 21h
main endp

; --- ISR Procedures (Fixed PUSH/POP) ---

isr_60h proc far
    push ax 
    push dx 
    push ds
    mov ax, @data
    mov ds, ax
    lea dx, msg_60h
    mov ah, 09h
    int 21h
    pop ds 
    pop dx 
    pop ax
    iret
isr_60h endp

isr_key proc far
    push ax 
    push dx 
    push ds
    mov ax, @data
    mov ds, ax
    lea dx, msg_key
    mov ah, 09h
    int 21h
    
    mov al, 20h
    out 20h, al
    pop ds 
    pop dx 
    pop ax
    ; Manual jump using saved offset/segment
    jmp dword ptr cs:old_key_off
isr_key endp

isr_timer proc far
    push ax 
    push dx 
    push ds
    mov ax, @data
    mov ds, ax

    inc tick_count
    cmp tick_count, 18
    jb skip_timer
    
    mov tick_count, 0
    lea dx, msg_timer
    mov ah, 09h
    int 21h

skip_timer:
    pop ds 
    pop dx 
    pop ax
    jmp dword ptr cs:old_tim_off
isr_timer endp

end main

ret




