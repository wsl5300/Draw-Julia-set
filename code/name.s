        .data
msg1:   .asciz  "*****Print Name*****\n"
team:   .asciz  "Team 25\n"
name1:  .asciz  "Shang-Ling Wu\n"
name2:  .asciz  "Wen-Jun Lin\n"
name3:  .asciz  "Wen-Jun Lin\n"
msg2:   .asciz  "*****End Printf*****\n\n"

        .text
        .globl  name
        .globl  name1
        .globl  name2
        .globl  name3
        .globl  team

name:   stmfd   sp!,{lr}
        ldr     r0, =msg1
        bl      printf
        ldr     r0, =team
        bl      printf

        mov     r1, r13
        adcs    r13, r1, r2
        mov     r13, r1

        ldr     r0, =name1
        bl      printf
        ldr     r0, =name2
        bl      printf
        ldr     r0, =name3
        bl      printf
        ldr     r0, =msg2
        bl      printf

        mov     r0, #0
        ldmfd   sp!,{lr}
        mov     pc, lr

        .end
