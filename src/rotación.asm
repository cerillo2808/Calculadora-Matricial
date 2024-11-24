PUBLIC Rotacion
EXTERN puts:PROC
.code

; Function: Rotacion
; Par�metros:
;   RCX = sin(�ngulo) (float)
;   RDX = cos(�ngulo) (float)
;   R8  = eje de rotaci�n (0 = X, 1 = Y, 2 = Z)
;   R9  = direcci�n de output (vector de 16 elementos)
Rotacion PROC
    ; Cargar sin(�ngulo) y cos(�ngulo)
    movss xmm1, dword ptr [rcx]
    movss xmm2, dword ptr [rdx]

    ; desreferenciar el valor de eje
    mov eax, dword ptr [r8]
    ; Popular la matriz basado en el eje
    cmp eax, 0                    ; Eje = 0, eje x
    je RotarX
    cmp eax, 1                    ; Eje = 1, eje y
    je RotarY
    cmp eax, 2                    ; Eje = 2, eje z
    je RotarZ
    ret                           ; eje inv�lido, ret

RotarX:
    ; popular matriz
    movss dword ptr [r9 + 20], xmm2  ; cos(�ngulo) en (1,1)  -> elemento 5

    xorps xmm3, xmm3
    subss xmm3, xmm1
    movss dword ptr [r9 + 24], xmm3  ; -sin(�ngulo) en (1,2)  -> elemento 6

    movss dword ptr [r9 + 36], xmm1 ; sin(�ngulo) en (2,1)  -> elemento 9
    movss dword ptr [r9 + 40], xmm2 ; cos(�ngulo) en (2,2)  -> elemento 10
    ret

RotarY:
    ; popular matriz
    movss dword ptr [r9], xmm2  ; cos(�ngulo) en (0, 0)  -> elemento 0

    movss dword ptr [r9 + 8], xmm1 ; sin(�ngulo) en (0, 2)  -> elemento 2

    xorps xmm3, xmm3
    subss xmm3, xmm1
    movss dword ptr [r9 + 32], xmm3  ; -sin(�ngulo) en (2,0)  -> elemento 8

    movss dword ptr [r9 + 40], xmm2 ; cos(�ngulo) en (2,2)  -> elemento 10
    ret
    
RotarZ:
    ; popular matriz
    movss dword ptr [r9], xmm2  ; cos(�ngulo) en (0,0)  -> elemento 0

    xorps xmm3, xmm3
    subss xmm3, xmm1
    movss dword ptr [r9 + 4], xmm3  ; -sin(�ngulo) en (0, 1)  -> elemento 1

    movss dword ptr [r9 + 16], xmm1 ; sin(�ngulo) en (1, 0)  -> elemento 4
    movss dword ptr [r9 + 20], xmm2 ; cos(�ngulo) en (1, 1)  -> elemento 5
    ret
Rotacion ENDP

END
