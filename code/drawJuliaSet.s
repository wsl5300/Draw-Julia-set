                .data
cX:             .word 0
cY:             .word 0
frame:          .word 0
maxIter:        .word 255
num_1000:       .word 1000
num_1500:       .word 1500
num_4000000:    .word 4000000

                .text
                .globl  drawJuliaSet

drawJuliaSet:   mov     r3, sp
                stmfd   sp!, {r4-r8, lr}

                ldr     r4, =cX
                str     r0, [r4]
                ldr     r4, =cY
                str     r1, [r4]
                ldr     r4, =frame
                ldr     r3, [r3]
                str     r3, [r4]

                mov     r4, #0          @ r4 = x, x = 0

loopX:          cmp     r4, #640
                bge     Xdone
                mov     r5, #0          @ r5 = y, y = 0

loopY:          cmp     r5, #480
                bge     Ydone

                ldr     r1, =num_1500
                ldr     r1, [r1]         @ r1 = 1500
                sub     r0, r4, #320     @ r0 = X - 320
                mul     r0, r0, r1       @ r0 = r0 * 1500
                mov     r1, #320         @ r1 = 320
                bl      __aeabi_idiv     @ r0 = r0 / r1
                mov     r6, r0           @ r6 = zx

                ldr     r1, =num_1000
                ldr     r1, [r1]         @ r1 = 1000
                sub     r0, r5, #240     @ r0 = X - 240
                mul     r0, r0, r1       @ r0 = r0 * 1000
                mov     r1, #240         @ r1 = 240
                bl      __aeabi_idiv     @ r0 = r0 / r1
                mov     r7, r0           @ r7 = zy

                ldr     r8, =maxIter
                ldr     r8, [r8]

loop:           mul     r0, r6, r6       @ r0 = zx * zx
                mul     r1, r7, r7       @ r1 = zy * zy
                add     r2, r0, r1
                ldr     r3, =num_4000000
                ldr     r3, [r3]

                cmp     r2, r3           @ > 4000000
                bge     done             @ Condition Execution ge

                cmplt   r8, #0           @ maxIter > 0 (Condition lt)
                ble     done             @ Condition Execution le

                sub     r0, r0, r1
                ldr     r1, =num_1000
                ldr     r1, [r1]
                bl      __aeabi_idiv
                mov     r3, r0

                ldr     r2, =cX
                ldr     r2, [r2]
                add     r3, r3, r2

                mul     r0, r6, r7
                mov     r2, #2
                mul     r0, r2

                ldr     r1, =num_1000
                ldr     r1, [r1]
                stmfd   sp!, {r3}         @ store tmp
                bl      __aeabi_idiv
                ldmfd   sp!, {r3}
                mov     r7, r0

                ldr     r2, =cY
                ldr     r2, [r2]
                add     r7, r7, r2        @ r7 = zY

                mov     r6, r3            @ r6 = zX

                sub     r8, r8, #1        @ i--
                b       loop

done:           and     r8, r8, #0xff
                orr     r8, r8, r8, lsl #8  @ oprand2 <shift> <imm>

                ldr     r0, =0xffff
                bic     r8, r0, r8

                ldr     r0, =frame
                ldr     r0, [r0]
                mov     r1, #1280
                mul     r1, r1, r5
                add     r0, r0, r1
                add     r0, r0, r4, lsl #1

                strh    r8, [r0]

                add     r5, r5, #1        @ y++
                b       loopY

Ydone:          add     r4, r4, #1        @ x++
                b       loopX

Xdone:          adds    r14, r0, r15      @ !!
                ldmfd   sp!, {r4-r8, lr}
                mov     pc, lr
