PUBLIC MatrizxVector, Escalamiento
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

; Función ensamblador: Escalamiento con multiplicación acumuladora
; Parámetros:
;   RCX = escalaX (float)
;   RDX = escalaY (float)
;   R8  = escalaZ (float)
;   R9  = dirección de la matriz acumuladora (4x4 en fila mayor)

Escalamiento PROC
    ; Crear matriz de escalamiento en registros xmm
    movss xmm0, dword ptr [rcx]          ; Cargar escalaX en xmm0
    shufps xmm0, xmm0, 0h                ; Replicar escalaX en todos los componentes de xmm0
    movss xmm1, dword ptr [rdx]          ; Cargar escalaY en xmm1
    shufps xmm1, xmm1, 0h                ; Replicar escalaY en todos los componentes de xmm1
    movss xmm2, dword ptr [r8]           ; Cargar escalaZ en xmm2
    shufps xmm2, xmm2, 0h                ; Replicar escalaZ en todos los componentes de xmm2
    movaps xmm3, xmmword ptr [r9 + 48]   ; Cargar última fila (para preservar w)

    ; Primera fila de la matriz acumuladora (escala X)
    movaps xmm4, xmmword ptr [r9]        ; Cargar fila 1
    mulps xmm4, xmm0                     ; Escalar con escalaX
    movaps xmmword ptr [r9], xmm4        ; Guardar en acumuladora

    ; Segunda fila de la matriz acumuladora (escala Y)
    movaps xmm5, xmmword ptr [r9 + 16]   ; Cargar fila 2
    mulps xmm5, xmm1                     ; Escalar con escalaY
    movaps xmmword ptr [r9 + 16], xmm5   ; Guardar en acumuladora

    ; Tercera fila de la matriz acumuladora (escala Z)
    movaps xmm6, xmmword ptr [r9 + 32]   ; Cargar fila 3
    mulps xmm6, xmm2                     ; Escalar con escalaZ
    movaps xmmword ptr [r9 + 32], xmm6   ; Guardar en acumuladora

    ; Cuarta fila de la matriz acumuladora (preservar w)
    movaps xmmword ptr [r9 + 48], xmm3   ; Restaurar fila 4

    ret
Escalamiento ENDP
END