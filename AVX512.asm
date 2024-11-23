PUBLIC AVX512Test
EXTERN puts:PROC

.code

AVX512Test proc
    ; Function parameters:
    ; RCX = pointer to array c (output)
    ; RDX = pointer to array a (input)
    ; R8  = pointer to array b (input)

    vmovapd zmm0, zmmword ptr [rdx]  ; Load 8 double-precision elements from array a into ZMM0
    vmovapd zmm1, zmmword ptr [r8]   ; Load 8 double-precision elements from array b into ZMM1

    vaddpd zmm2, zmm0, zmm1          ; Perform element-wise addition: ZMM2 = ZMM0 + ZMM1

    vmovapd zmmword ptr [rcx], zmm2  ; Store the result from ZMM2 into array c

    ret                              ; Return to the caller
AVX512Test endp

END