PUBLIC AVXFoundationDetection
EXTERN puts:PROC

.code

AVXFoundationDetection proc
    push rbx               ; Save the current value of RBX on the stack (callee-saved register)

    mov eax, 7             ; Set EAX to 7 (used to query extended CPU features in CPUID)
    mov ecx, 0             ; Set ECX to 0 (sub-leaf index for CPUID function 7)

    cpuid                  ; Execute the CPUID instruction
                           ; After this, EAX, EBX, ECX, and EDX contain feature information:
                           ; EBX[16] indicates support for AVX512 Foundation instructions.

    shr ebx, 16            ; Shift EBX right by 16 bits to move the 16th bit to the least significant bit
    and ebx, 1             ; Isolate the least significant bit to check if AVX512 is supported

    mov eax, ebx           ; Move the result (1 if supported, 0 if not) into EAX for return value

    pop rbx                ; Restore the original value of RBX from the stack
    ret                    ; Return to the caller
AVXFoundationDetection endp

END