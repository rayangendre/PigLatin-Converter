.globl main

#Program changes the user inputted word into the pig latin for

#Does implement the word starting with vowel extra credit

#if word does not start with vowel, moves first character to the end and then adds "ay"
#if word does have vowel, does not move first character and instead add "way" to the end


main:
	

#print the input message to the user
printMessage:
	#clear all of the used registers
	and t3, t3, zero	
	and t4, t4, zero
	and a7, a7, zero
	and t5, t5, zero
	and t6, t6, zero
	
	#Store ascii values 
	addi t6, t6, 0x0A	#store ascii value of enter into t6
	
	
	#prints of the input message to the user
	la, t3, input		#gets the address of the input space
	li a7, 4
	la a0, welcomeMessage	#print message
	ecall			#process print call
	
	#loop
	#processes the input one by one, reading by character
	processInput:
		#read the character
		and a7, a7, zero
		addi a7, zero, 12	
		ecall
	
		#process the character
		mv t2, a0		#move the character out of a0
		beq t2, t6, checkVowel	#if it is enter key, branch to printPigLatin
		#beq t2, t5, printMessage	#if the character is a space, branch to enter screen
	
		#store the character at correct spot in memory
		sb t2, (t3)		#store the byte into the next space
		addi t3, t3, 1		#increment address by one byte
	
		#loop
		b processInput	

		
	
checkVowel:
	and t1, t1, zero
	and t2, t2, zero	
	and t5, t5, zero
	and t4, t4, zero
	and t0, t0, zero
		
	
	
	lb t1, input	#holds first byte of input
	la t2, vowels	#holds byte address of vowels
	addi t5, t5, 5  #holds counter
	
	loop: 
		lb t4, (t2)		#load byte of vowel into t4
		beq t1, t4, addWay	#compare vowel and first character, branch to addWay
		addi t2, t2, 1		#increment address
		addi t5, t5, -1		#lower count
		addi t0, t0, 1
		beqz t5, printPigLatin  #if count is reached, no vowels present
		b loop


#print the input as Pig Latin, used as holder for loop
printPigLatin:
	#add null character to the end of the string
	and t2, t2, zero
	sb t2, (t3)
	
	#check to see if user passed an empty input
	and t3, t3, zero
	and t2, t2, zero
	la t3, input
	lb t2, (t3)
	beqz t2, printMessage	#prompt input again if the input in null
	
	
	
	#clear registers
	
	and t3, t3, zero	#clear register 3
	and t4, t4, zero
	and a7, a7, zero
	and a0, a0, zero
	
	#set values
	la t3, input		#load input address back into t3
	addi t3, t3, 1		#increment byte to next letter, skipping the first letter
	
	#print "Pig-Latin: "
	li a7, 4		#print string command
	la a0, pigLatinPrompt		#load string to print
	ecall			#print
	
	#print the input from 2 till end
	li a7, 4
	and a0, a0, zero
	add a0, a0, t3
	ecall
	
	#branch to addAY
	b addAY		

#add the first character and add -ay
addAY:
	#clear registers
	and t3, t3, zero	
	and t4, t4, zero
	and a7, a7, zero
	
	#print out first character of word
	la t3, input
	lb t4, (t3)
	mv a0, t4		#move byte to a0 to print
	li a7, 11		#load charPrint to a7
	ecall
	
	#print ay to the end of the word
	and a7, a7, zero
	li a7, 4		#print string command
	la a0, ay		#load string to print
	ecall			#print
	
	
	b printMessage		#branch to clear memory


addWay:
	#clear registers
	and t3, t3, zero
	and t2, t2, zero
	
	#store value of input
	la t3, input
	#add up to next spot
	add t3, t3, t0
	
	#add a zero to get string to print
	sb t2, (t3)
	
	#print "Pig Latin"
	li a7, 4
	la a0, pigLatinPrompt
	ecall
	#print the input
	la a0, input
	ecall
	#print way behind it
	la a0, way
	ecall
	
	b printMessage
	
	




.data
#message given at beginning of program
welcomeMessage: .string "\nEnglish word:"

#gives a 0 padding after string for printing
align: .align 2

#makes space to store integer
input: .space 20

#string to output before piglatinword
pigLatinPrompt: .string "Pig-Latin Word: "

#used to add -ay at end of the word
ay: .string "ay"

#used to add -way to end
way: .string "way"

#vowels- used to compare
vowels: .string "aeiou"


