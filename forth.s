.section .text
.global _start

_start:
    # Initialise stack pointer
    la sp, stack_top
    mv fp, sp

    # Init gp, whatever that is
    .option push
    .option norelax
    lla gp, __global_pointer$
    .option pop

    # Print out uwu
    li a0, 'u'
    jal sbi_console_putchar
    li a0, 'w'
    jal sbi_console_putchar
    li a0, 'u'
    jal sbi_console_putchar

    # Loop forever
finish:
    j finish


# EIDs are stored in a7
# FIDs are stored in a6

# sbi_console_putchar(char) -> void
# Puts a character onto the UART port.
sbi_console_putchar:
    li a6, 0
    li a7, 1
    ecall
    ret


# sbi_console_getchar() -> int
# Gets a character from the UART port.
sbi_console_getchar:
    li a6, 0
    li a7, 2
    ecall
    ret
