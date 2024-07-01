.text
.globl hash
hash:
	addi $sp, $sp, -4           
	sw $a0, 0($sp)              
	move $t0, $a0 
	li $v0, 0 
	hashLoop: 
		lb $t1, 0($t0) 
		beqz $t1, exitHashLoop 
		add $v0, $t1, $v0 
		addi $t0, $t0, 1                 #Loops through string and adds value to $v0 
		j hashLoop 
		
	exitHashLoop: 
		lw $a0, 0($sp)              #Restores preserved registers and jumps back to caller 
		addi $sp, $sp 4
		jr $ra


.globl isPrime
isPrime:
	addi $sp, $sp -4 
	sw $a0, 0($sp) 
	
	li $t0, 1 
	move $t1, $a0        #Number to check 
	beq $t0, $t1, notPrime    #One is not prime 
	addi $t0, $t0, 1
	checkPrime: 
		beq $t0, $t1, true 
		div $t1, $t0 
		mfhi $t3 
		beqz $t3, notPrime 
		addi $t0, $t0, 1
		j checkPrime 
		
	true: 
		li $v0, 1 
		j endPrimeChecker 
		
	notPrime: 
		li $v0, 0 
		j endPrimeChecker
		
	endPrimeChecker: 
		lw $a0, 0($sp) 
		addi $sp, $sp 4 
		jr $ra

.globl lcm
# Use the formula lcm(a,b) = |ab|/gcd(a,b) 
lcm: 
	addi $sp, $sp, -12                    
	sw $a0, 0($sp) 
	sw $a1, 4($sp) 
	sw $ra, 8($sp)
	jal gcd 
	

	move $t0, $v0 
		
	findLCM: 
		mul $t0, $a0, $a1 
		mfhi $t0
		mflo $t1
		or $t0, $t0, $t1 
		div $t0, $v0 
		mflo $v0
		
	
	lw $a0, 0($sp) 
	lw $a1, 4($sp) 
	lw $ra, 8($sp)
	addi $sp, $sp, 12
	
	jr $ra

.globl gcd
gcd:
    addi $sp, $sp, -8
    sw $a0, 0($sp) 
    sw $a1, 4($sp) 
    gcdRecursionLabel: 
        beqz $a0, aZero              #If first number is 0, return second number
        beqz $a1, aZero1             #If second number is 0, return first number
        j findGCD
        
        aZero: 
            move $v0, $a1 
            j endGCD
            
        aZero1: 
            move $v0, $a0 
            j endGCD
            
        findGCD: 
            blt $a0, $a1, rec
            div $a0, $a1 
            mfhi $a0 
            j gcdRecursionLabel
            
            j endGCD
            
            rec: 
                div $a1, $a0 
                mfhi $a1
                j gcdRecursionLabel
                
                j endGCD
        endGCD: 
            lw $a0, 0($sp)
            lw $a1, 4($sp) 
            addi $sp, $sp, 8
            jr $ra

.globl pubkExp
pubkExp:
	addi $sp, $sp, -8
	sw $a0, 0($sp) 
	sw $ra, 4($sp) 
	move $a1, $a0 
	getRandomLoop:             #Keeps generating random numbers until the input number and random number are co-prime
		li $v0, 42 
		syscall 
		addi $a0, $a0, 1
		li $t0, 1 
		beq $a0, $t0, getRandomLoop 
		jal gcd 
		li $t0, 1 
		beq $t0, $v0, storeKey
		j getRandomLoop 
	
	storeKey: 
		move $v0, $a0 
		
	lw $a0, 0($sp) 
	lw $ra, 4($sp) 
	addi $sp, $sp, 8
	jr $ra



.globl prikExp
prikExp:
	addi $sp, $sp, -12
	sw $a0, 0($sp) 
	sw $a1, 4($sp) 
	sw $ra, 8($sp) 
	move $t7, $a1  #Since y is required the entire time, but $a1 is written to in the function, we will store the value here 
	jal gcd 
	li $t0, 1 
	bne $t0, $v0, returnPrivateKeyError
	
	li $t0, 0              #p0 -> It will be used to store p(i-2) 
	li $t1, 1              #p1 -> It will be used to store p(i-1) 
	
	######### for p0 ############
	div $a1, $a0 
	move $a1, $a0 
	mfhi $a0 
	mflo $t2               #$t2 will be q(i-2) 
	 
	######## for p1 ###########
	div $a1, $a0 
	move $a1, $a0 
	mfhi $a0 
	mflo $t3            #$t3 will be q(i-1)  
	
	getPrikLoop: 
		beqz $a0, calculateLastP 
		### (p(i-2) - p(i-1)*q(i-2)  for p(i-2) ###
		mul $t4, $t1, $t2 
		mfhi $t4
		mflo $t5 
		or $t4, $t4, $t5 
		sub $t4, $t0, $t4 
		
		div $a1, $a0 
		move $a1, $a0 
		mfhi $a0 
		move $t2, $t3 
		mflo $t3 
		move $t0, $t1 
		blez $t4, negativeMod
		div $t4, $t7 
		mfhi $t1 
		j computeSecond 
		
		negativeMod: 
			bgtz $t4, moveMod
			add $t4, $t4, $t7
			j negativeMod
			
			moveMod: 
				move $t1, $t4 
				j computeSecond
			
		# find p (i-1) for next iteration 
		computeSecond: 	
			beqz $a0, calculateLastP
			mul $t4, $t1, $t2 
			mfhi $t4
			mflo $t5 
			or $t4, $t4, $t5 
			sub $t4, $t0, $t4 
		
			div $a1, $a0 
			move $a1, $a0 
			mfhi $a0 
			move $t2, $t3 
			
			mflo $t3 
			move $t0, $t1 
			blez $t4, negativeMod2
			div $t4, $t7 
			mfhi $t1 
			j getPrikLoop  
		
		negativeMod2: 
			bgtz $t4, moveMod2
			add $t4, $t4, $t7
			j negativeMod
			
			moveMod2: 
				move $t1, $t4 
				j getPrikLoop
	
	returnPrivateKeyError: 
		li $v0, -1 
		j returnPrivateKey 
	
	calculateLastP: 
	#########Computes the p value one last time ###########
		mul $t4, $t1, $t2 
		mfhi $t4
		mflo $t5 
		or $t4, $t4, $t5 
		sub $t4, $t0, $t4 
		
		blez $t4, negativeMod3 
		div $t4, $t7 
		mfhi $v0 
		j returnPrivateKey 
		negativeMod3:
			bgtz $t4, moveMod3 
			add $t4, $t4, $t7
			j negativeMod3
			moveMod3: 
				move $v0, $t4
				j returnPrivateKey
	##################
	  	
	returnPrivateKey:
		lw $a0, 0($sp) 
		lw $a1, 4($sp) 
		lw $ra, 8($sp) 
		addi $sp, $sp, 12
		jr $ra 

.globl encrypt
encrypt:
	addi $sp, $sp, -16
	sw $a0, 0($sp) 
	sw $a1, 4($sp) 
	sw $a2, 8($sp) 
	sw $ra, 12($sp) 
	
	#k = lcm (p-1, q-1) 
	move $a0, $a1
	move $a1, $a2
	addi $a0, $a0, -1
	addi $a1, $a1, -1 
	jal lcm 
	move $a0, $v0 
	
	jal pubkExp 
	move $v1, $v0 
	
	
	lw $a0, 0($sp) 
	lw $a1, 4($sp) 
	lw $a2, 8($sp) 
	#holds m 
	
	move $t2, $a0 
	#$t0 will hold p * q 
	mul $t0, $a1, $a2 
	mfhi $t0 
	mflo $t3 
	or $t0, $t0, $t3 
	
	move $t1, $v1 
	
	#holds e 
	addi $t1, $t1, -1 
	
	exponentLoop: 
		beqz $t1, finishEncrypt 
		#a
		div $t2, $t0 
		mfhi $t4 
		
		#a*m
		mul $t2, $a0, $t4 
		mfhi $t2 
		mflo $t3 
		or $t4, $t2, $t3 
		
		#a*m % n 
		div $t4, $t0 
		mfhi $t2 
		
		addi $t1, $t1, -1
		
		j exponentLoop 
	
	finishEncrypt: 
		move $v0, $t2   
		lw $a0, 0($sp) 
		lw $a1, 4($sp) 
		lw $a2, 8($sp) 
		lw $ra, 12($sp) 
		addi $sp, $sp, 16
		jr $ra 

	
.globl decrypt
decrypt:
	addi $sp, $sp, -20 
	sw $a0, 0($sp) 
	sw $a1, 4($sp) 
	sw $a2, 8($sp) 
	sw $a3, 12($sp) 
	sw $ra, 16($sp)
	
	# Get lcm(p-1, q-1) 
	move $a0, $a2 
	move $a1, $a3
	addi $a0, $a0, -1
	addi $a1, $a1, -1 
	jal lcm 
	move $a1, $v0 
	
	
	lw $a0, 4($sp)
	
	jal prikExp 
	
	# $t0 will hold d 
	move $t0, $v0
	
	lw $a0, 0($sp) 
	lw $t1, 8($sp) 
	lw $t3, 12($sp) 
	mul $t1, $t1, $t3 
	mfhi $t1 
	mflo $t3
	or $t1, $t1, $t3
	# $t1 will hold n
	
	addi $t0, $t0, -1
	# x
	move $t2, $a0 
	decryptLoop: 
		beqz $t0, finishDecrypt 
		#a
		div $t2, $t1
		mfhi $t4 
		
		#a*m
		mul $t2, $a0, $t4 
		mfhi $t2 
		mflo $t3 
		or $t4, $t2, $t3 
		
		#a*m % n 
		div $t4, $t1
		mfhi $t2 
		
		addi $t0, $t0, -1
		
		j decryptLoop  
	
	
	finishDecrypt: 
		move $v0, $t2 
		
		lw $a0, 0($sp) 
		lw $a1, 4($sp) 
		lw $a2, 8($sp) 
		lw $a3, 12($sp) 
		lw $ra, 16($sp) 
		addi $sp, $sp, 20 
		
		jr $ra 
