.global _start
_start:
	
	@ UTC - CECS - ENEE 4710 - Dr. JW Bruce
	@ Davey Dickhut: HW3 20-09-2026
	
	@ <^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^>
	@ <=======Section 1: Three-Register Format=========>
	@ <vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv>
	
	MOV r0, #0				@ Zero-Out all used registers
	MOV r1, #0				@ Zero-Out all used registers
	MOV r2, #0				@ Zero-Out all used registers
	MOV r3, #0				@ Zero-Out all used registers
	MOV r4, #0				@ Zero-Out all used registers
	MOV r5, #0 				@ Zero-Out all used registers
		
	@ ADD(S) demo
	
	MOV r0, #1				@ Load 1 into r0
	MOV r1, #1				@ Load 1 into r1
	
	MOV r3, #0x70000000		@ Load Large, Positive, 2'C Number into r3
	MOV r4, #0x7FFFFFFF		@ Load Another Large, Positive, 2'C Number into r4
	
	ADD r2, r0, r1			@ Add r0 and r1, load value into r2: 1 + 1 = 2
	
	
	ADDS r5, r3, r4			@ Add r3 and r4 into r5. This will cause an overflow, setting the condition bits 'N' and 'V'
	
	@ SUB(S) Demo
	
	MOV r0, #0			@ Zero-Out all used registers
	MOV r1, #0			@ ~~
	MOV r2, #0			@ ~~
	MOV r3, #0			@ ~~
	MOV r4, #0			@ ~~
	MOV r5, #0 			@ Zero-Out all used registers
	
	MOV r1, #1					@ Load 1 into r1
	MOV r2, #2					@ Load 2 into r2
	
	SUB r5, r1, r2				@ Subtracting 1 from 2. Operation does not set 'NOT BORROW' bit, despite there being no borrow involved
	
	SUBS r5, r0, r2				@ Subtracting 2 from 0 will set the 'N' bit and clear the 'NOT BORROW' bit
	
	SUBS r7, r1, r1				@ Subtracting two identical numbers will set the zero conditional bit
	SUBS r4, r1, r0				@ Subtracting 0 from 1 will set the NOT BORROW bit
	
	@ AND(S)/EOR(S) Demo
	
	MOV r0, #0				@ Zero-Out all used registers
	MOV r1, #0				@ ~~
	MOV r2, #0				@ ~~
	MOV r3, #0				@ ~~
	MOV r4, #0				@ ~~
	MOV r5, #0 				@ Zero-Out all used registers
	
	MOV r0, #0x6666			@ Put indicated bit pattern into bottom 2 bytes of r0
	MOVT r0, #0x6666		@ Put indicated bit pattern into top 2 bytes of r0
	MOV r1, #0x9999			@ Put indicated bit pattern into bottom 2 bytes of r1
	MOVT r1, #0x9999		@ Put indicated bit pattern into top 2 bytes of r1
	
	AND r2, r1, r0			@ AND-ing these two numbers will find the locations where there is a bit set by each number (no bit locations shared: all unset)
	
	EOR r3, r1, r0			@ EOR-ing these two numbers will find the locations where there is a bit set by one number (no bit locations shared: all set)
	
	@ Setting all bits in r2 and unsetting all bits in r3 creates a convenient pair of constants for the following demo
	
	ANDS r4, r2, r3			@ Running this command in the 'SET' configuration will set Z bit
	
	EORS r4, r2, r3			@ Running this command in the 'SET' configuration will set N bit
	
	
	@ <^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^>
	@ <===SECTION 2: Register with Immediate Constant===>
	@ <vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv>
	
	MOV r0, #0					@ Zero-Out all used registers
	MOV r1, #0					@ ~~
	MOV r2, #0					@ ~~
	MOV r3, #0					@ ~~
	MOV r4, #0					@ ~~
	MOV r5, #0 					@ Zero-Out all used registers
	
	@ ADD(S) demo
	
	MOV r0, #1					@ Load 1 into r0

	ADD r1, r0, #1				@ Add 1 to r0, load value into r2: 1 + 1 = 2
	
	MOV r3, #0x70000000			@ Load Large, Positive, 2'C Number into r3
	
	ADDS r5, r3, #0x7FFFFFFF	@ Add r3 and $2^31-1$ into r5. This will cause an overflow, setting the condition bits 'N' and 'V'
	
	@ SUB(S) Demo
	
	MOV r0, #0					@ Zero-Out all used registers
	MOV r1, #0					@ ~~
	MOV r2, #0					@ ~~
	MOV r3, #0					@ ~~
	MOV r4, #0					@ ~~
	MOV r5, #0 					@ Zero-Out all used registers
	
	MOV r1, #1					@ Load 1 into r1
	MOV r2, #2					@ Load 2 into r2
	
	SUBS r7, r1, #1				@ Subtracting two identical numbers will set the zero conditional bit
	
	SUB r5, r1, #2				@ Subtracting 2 from 1 will not change CARRY bit
	
	SUBS r5, r0, #2				@ Subtracting 2 from 0 will set N, unset C bit
	
	SUBS r4, r1, #0				@ Subtracting 0 from 1 will set the NOT BORROW bit
	
	@ AND(S)/EOR(S) Demo
	
	MOV r0, #0					@ Zero-Out all used registers
	MOV r1, #0					@ ~~
	MOV r2, #0					@ ~~
	MOV r3, #0					@ ~~
	MOV r4, #0					@ ~~
	MOV r5, #0 					@ Zero-Out all used registers
	
	MOV r1, #0x99				@ Initial value to compare to 0x66
	MVN r3, #0					@ Fill r3 with ones (Unsets, then inverts all bits in register)
	
	AND r4, r1, #0x66			@ AND-ing these two numbers will find the locations where there is a bit set by each number (bottom byte of r4 unset)
	
	EOR r5, r1, #0x66			@ EOR-ing these two numbers will find the locations where there is a bit set by one number (bottom byte of r5 set)
	
	ANDS r4, r3, #0				@ Running this command in the 'SET' configuration will set Z bit
	
	EORS r4, r3, #0				@ Running this command in the 'SET' configuration will set N bit
	
	@ SECTION 3: MOV/MVN
	
	MOV r0, #0				@ Zero-Out all used registers
	MOV r1, #0				@ ~~
	MOV r2, #0				@ ~~
	MOV r3, #0				@ ~~
	MOV r4, #0				@ ~~
	MOV r5, #0				@ Zero-Out all used registers
	
	MOV r0, #0x6666			@ Put bit pattern 011001100110 into BOTTOM two bytes of r0
	MVT r0, #0x6666			@ Put bit pattern 011001100110 into TOP two bytes of r0
	MOVS r1, r2				@ Put #0x0 from register two into register one, setting zero bit
	MVN r3, #0				@ Fill r3 with ones (Unsets, then inverts all bits in register)
	MVNS r1, #0				@ Fill r1 with ones and set negative bit
	


	@ SECTION 4: Flexible second operand

	MOV r0, #0					@ Zero-Out all used registers
	MOV r1, #0					@ ~~
	MOV r2, #0					@ ~~
	MOV r3, #0					@ ~~
	MOV r4, #0					@ ~~
	MOV r5, #0 					@ Zero-Out all used registers
	
	MOV r0, #3					@ Put 3 into register 0
	MOV r1, #3					@ Put 3 into register 1

	ADD r2, r1, r0, LSL #3		@ Add 3 and 3, shift result 3 bits leftward

	ADDS r3, r1, r0, LSL #30	@ Move a 1 to MSb location, setting N flag
	
	SUB r4, r3, r2, ASR #4 		@ Subtract large number from small number, arithmetic shift right 3 positions@ 1 remains in MSb, N bit not set

	SUBS r5, r3, r2, ASR #4 	@ Subtract large number from small number, arithmetic shift right 3 positions@ 1 remains in MSb, N and NOT CARRY bits set
	
	ORR r6, r3, r4, ROR #2		@ Finds all locations where r3 or r4 have a bit, roll result 2 locations Right
	ORRS r7, r3, r4, ROR #2		@ Finds all locations where r3 or r4 have a bit, roll result 2 locations Right, sets negative bit
	
	@ SECTION 5: FLAG SETTING OPS

	MOV r0, #0				@ Zero-Out all used registers
	MOV r1, #0				@ ~~
	MOV r2, #0				@ ~~
	MOV r3, #0				@ ~~
	MOV r4, #0				@ ~~
	MOV r5, #0				@ Zero-Out all used registers

	MOV r0, #3				@ Put 3 into register 0
	MOV r1, #3				@ Put 3 into register 1

	CMP r0, r1				@ Computes 3-3, sets Z flag and 'NOT BORROW' flag, as op requires no borrow
	CMP r0, #4				@ Computes 3-4 sets N flag, unsets C flag

	TST r0, #3				@ Computes 3 to 3, unsets Z flag, as result is true
	
	TEQ r0, #3				@ Computes 3 XOR 3, sets Z flag due to equivalence
	

	@ SECTION 6: Memory Addressing formats

	@ Part A: Register offset
	
	MOV r0, #0			@ Zero-Out all used registers
    MOV r1, #0 			@ ~~
	MOV r2, #0 			@ Zero-Out all used registers

	MOV r1, #4			@ For jump
	MOV r2, #0x00001234	@ Information to store

	STR r2, [r0, r1]	@ STORE r2 in r0+r1 memory location
	LDR r3, [r0, r1]	@ READ previously written data to r3

	@ Part B: Immediate Offset

	MOV r0, #0			@ Zero-Out all used registers
	MOV r1, #0			@ ~~
	MOV r2, #0			@ Zero-Out all used registers
                
	MOV r1, #0x00001234	@ Data to be written
                
	STR r1, [r0, #8]	@ STORE r1 in r0+8 memory location
	LDR r2, [r0, #8]	@ READ previously written data in r0+8, store in r2

	@ Part C: Pre-Indexed Addressing

	MOV r0, #0
	MOV r1, #0
	MOV r2, #0

	MOV r1, #0x00001234 @ Information to store

	STR r1, [r0, #8]!	@ STORE r1 to r0+8 memory location. Update r0 to r0+8
	LDR r2, [r0]		@ READ previously written data, store in r2


	@ Part D: Post-Indexed Addressing

	MOV r0, #0			@ Zero-Out all used registers
	MOV r1, #0			@ ~~
	MOV r2, #0			@ Zero-Out all used registers
	
	MOV r1, #0x5678		@ Information to store in bottom 2 memory bytes
	MOVT r1 #0x1234		@ Information to store in top 2 memory bytes
	MOV r3, #0xBEEF		@ Data to overwrite in final operation
	
	STR r0, [r0], #8	@ STORE r0 at r0[k] addressed memory. r0[k+1] = r0[k] + 8
	STR r1, [r0]		@ STORE r1 to r0[k+1] addressed memory
	LDR r2, [r0]		@ READ previously written data (r1), store in r2
	LDR r3, [#0]		@ r0[k]'th memory location has #0x0 stored
	
	@ Part E: Scaled Register Offset
	
	MOV r0, #0				@ Zero-Out all used registers
	MOV r1, #0				@ ""
	MOV r2, #0				@ ""
	MOV r3, #0				@ ""
	MOV r4, #0				@ Zero-Out all used registers
	
	MOV r1, #1				@ Offset to be scaled
	
	MOV r2, #0x5678			@ Information to store in bottom 2 memory bytes
	MOVT r2 #0x1234			@ Information to store in top 2 memory bytes
	
	@ Store information from r2 to memory location 0x0 + r1*2^2=0x4:
	STR r2, [r0, r1, LSL #2] 
	
	@ Using immediate offset addressing to confirm that the data was written to the correct address
	LDR r3, [r0, #4]
	
	@ Zero-Out r3
	MOV r3, #0
	
	@ Using Scaled Register Offset addressing to confirm that syntax works for both load and store operations, while also demonstrating writeback functionality
	LDR r3, [r0, r1, LSL #2]!
	
	@ Demonstrate that address register was updated
	LDR r4, [r0]
	

freeze: B freeze
