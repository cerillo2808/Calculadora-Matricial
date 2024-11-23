PUBLIC MatrizxVector
EXTERN puts:PROC

.code

; Función ensamblador
; Parámetros:
;   RCX = dirección de la matriz (4x4 en fila mayor)
;   RDX = dirección del vector original (4x1)
;   R8  = dirección del vector resultado (4x1)

MatrizxVector PROC
    ; Cargar la matriz y el vector en registros SIMD
    movaps xmm0, xmmword ptr [rdx]      ; Cargar el vector (x, y, z, w) en xmm0

    ; Calcular fila 1
    movaps xmm1, xmmword ptr [rcx]      ; Fila 1 de la matriz
    mulps xmm1, xmm0                    ; Multiplicar elemento a elemento
    haddps xmm1, xmm1                   ; Sumar pares de elementos
    haddps xmm1, xmm1                   ; Sumar los resultados
    movss dword ptr [r8], xmm1          ; Guardar el resultado en el vector salida

    ; Calcular fila 2
    movaps xmm1, xmmword ptr [rcx + 16] ; Fila 2 de la matriz
    mulps xmm1, xmm0                    ; Multiplicar elemento a elemento
    haddps xmm1, xmm1                   ; Sumar pares de elementos
    haddps xmm1, xmm1                   ; Sumar los resultados
    movss dword ptr [r8 + 4], xmm1      ; Guardar el resultado en el vector salida

    ; Calcular fila 3
    movaps xmm1, xmmword ptr [rcx + 32] ; Fila 3 de la matriz
    mulps xmm1, xmm0                    ; Multiplicar elemento a elemento
    haddps xmm1, xmm1                   ; Sumar pares de elementos
    haddps xmm1, xmm1                   ; Sumar los resultados
    movss dword ptr [r8 + 8], xmm1      ; Guardar el resultado en el vector salida

    ; Calcular fila 4
    movaps xmm1, xmmword ptr [rcx + 48] ; Fila 4 de la matriz
    mulps xmm1, xmm0                    ; Multiplicar elemento a elemento
    haddps xmm1, xmm1                   ; Sumar pares de elementos
    haddps xmm1, xmm1                   ; Sumar los resultados
    movss dword ptr [r8 + 12], xmm1     ; Guardar el resultado en el vector salida

    ret
MatrizxVector ENDP
END