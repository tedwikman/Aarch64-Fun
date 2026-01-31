// Hello world in Aarch64

.text	// Begin the text/code section (RO)

.global _main
.align 2

_main:
	stp x29, x30, [sp, #-16]!	// Store the return address (x30) on the stack
	bl _print
	
					// Exit program
	mov x0, #0			// Arg 0: Return status 0 (success)
	ldp x29, x30, [sp], #16		// Load the return address back to x30
	ret

_print:
	mov x0, #1			// Arg 0: 1 - StdOut
	adrp x1, helloString@PAGE	// Arg 1: Address of string
	add x1, x1, helloString@PAGEOFF // 
	mov x2, #13			// Arg 2: Length of string
	mov x16, #4			// Syscall no. 4, "write"
	svc #0x80			// Supervisor call (invoke it all to kernel)
	ret				// Return function

.data 	// Begin the data section (RW)
helloString: .ascii "Hello World \n"
