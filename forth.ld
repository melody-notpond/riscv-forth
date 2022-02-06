OUTPUT_ARCH( "riscv" )
OUTPUT_FORMAT( "elf64-littleriscv" )
ENTRY( _start )
SECTIONS
{
    /* text: text code section */
    . = 0x80200000;
    .text : {
        *(.text)
        *(.text*)
    }

    /* data: Initialized data segment */
    .gnu_build_id : { *(.note.gnu.build-id) }

    . = ALIGN(4096);
    .data : { *(.data .data*) }

    . = ALIGN(4096);
    .rodata : { *(.rodata .rodata*) }

    . = ALIGN(4096);
    PROVIDE( __global_pointer$ = . + (4K / 2) );
    .sdata : { *(.sdata .sdata*) }
    .sdata : { *(.bss .bss*) }
    .sdata : { *(.sbss .sbss*) }
    .debug : { *(.debug .debug*) }

    . += 0x1000;

    . = ALIGN(4096);
    . += 0x8000;
    PROVIDE(stack_top = .);

    /* End of uninitalized data segement */
}
