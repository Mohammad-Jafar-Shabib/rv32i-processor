# smoke.s — Phase 1 RARS smoke test (RV32I, no M extension)
#
# Purpose: prove the assembly toolchain works and exercise the instruction
# classes targeted in Phase 2: addi (li), slli, sub, sw, lw, ecall syscalls.
#
# What it does:
#   1. Computes 6 * 7 = 42 using shift-and-add ((6 << 3) - 6) — RV32I has no mul.
#   2. Pushes the result on the stack and loads it back (verifies sw/lw round-trip).
#   3. Prints the value via RARS syscall 1 (PrintInt) + newline (syscall 11).
#   4. Exits cleanly with code 0 (syscall 10).
#
# Expected RARS console output: "42" followed by a newline.
# Run in RARS:   java -jar rars.jar asm/smoke.s   (or open in the RARS GUI)

    .text
    .globl main

main:
    li      a0, 6              # a0 = 6                     (addi pseudo)
    li      a1, 7              # a1 = 7                     (addi pseudo)
    slli    t0, a0, 3          # t0 = 48  (6 << 3)
    sub     t1, t0, a0         # t1 = 42  (48 - 6 = 6 * 7)

    addi    sp, sp, -4         # make room on the stack
    sw      t1, 0(sp)          # store word: mem[sp] = 42
    lw      a0, 0(sp)          # load word:  a0 = mem[sp]   (a0 = 42)
    addi    sp, sp, 4          # restore stack pointer

    li      a7, 1              # RARS syscall 1: PrintInt(a0)
    ecall

    li      a0, 10             # '\n'
    li      a7, 11             # RARS syscall 11: PrintChar(a0)
    ecall

    li      a0, 0              # exit code 0
    li      a7, 10             # RARS syscall 10: Exit
    ecall
