        .data
msg1:   .asciz  "*****Input ID*****\n"
str:    .asciz  "%d"

msg2:   .asciz  "** Please Enter Member 1 ID:**\n"
num1:   .word   0
msg3:   .asciz  "** Please Enter Member 2 ID:**\n"
num2:   .word   0
msg4:   .asciz  "** Please Enter Member 3 ID:**\n"
num3:   .word   0

msg5:   .asciz  "** Please Enter Command **\n"
p:      .asciz  "p"
pstr:   .asciz  "%s"
pp:     .space  90

msg6:   .asciz  "*****Print Team Member ID and ID Summation*****\n"
all:    .asciz  "%d\n%d\n%d\n\n"
sumstr: .asciz  "ID Summation = %d\n"
sum:    .word   0
msg7:   .asciz  "*****End Print*****\n\n"

        .text
        .globl id
        .globl num1
        .globl num2
        .globl num3
        .globl sum
        .globl sumstr

id:     stmfd   sp!, {lr}
        ldr     r0, =msg1
        bl      printf

        ldr     r0, =msg2
        bl      printf
        ldr     r0, =str
        ldr     r1, =num1
        bl      scanf

        ldr     r0, =msg3
        bl      printf
        ldr     r0, =str
        ldr     r1, =num2
        bl      scanf

        ldr     r0, =msg4
        bl      printf
        ldr     r0, =str
        ldr     r1, =num3
        bl      scanf

        ldr     r0, =msg5
        bl      printf

        ldr     r0, =pstr
        ldr     r1, =pp
        bl      scanf

        ldr     r0, =p
        ldr     r1, =pp
        ldrb    r0, [r0]
        ldrb    r1, [r1]

        cmp     r0, r1
        blne    end1

        ldreq   r0, =msg6
        bl      printf

        ldrvc   r0, =all
        ldr     r1, =num1
        ldr     r1, [r1, #0]!
        ldr     r2, =num2
        ldr     r2, [r2]
        ldr     r3, =num3
        ldr     r3, [r3]
        bl      printf

        ldr     r1, =num1
        ldr     r1, [r1]
        ldr     r2, =num2
        ldr     r2, [r2]

        sub     r1, r1, #0
        add     r1, r1, r2, lsl #0
        ldr     r2, =num3
        ldr     r2, [r2]
        add     r1, r1, r2

        ldr     r3, =sum
        str     r1, [r3]
        ldr     r1, =sum
        ldr     r1, [r1]

        ldr     r0, =sumstr
        bl      printf

end1:   ldr     r0, =msg7
        bl      printf

        mov     r0, #0
        ldmfd   sp!, {lr}
        mov     pc, lr

        .end
