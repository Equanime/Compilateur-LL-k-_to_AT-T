			# Original was produced by the CERI Compiler and modified by Angelo Adragna L2 CMI Informatique
	.data
	.align 8
FormatString1:	.string "%lld"	# used by printf to display 64-bit signed integers
FormatString2:	.string "%lf"	# used by printf to display 64-bit floating point numbers
FormatString3:	.string "%c"	# used by printf to display a 8-bit single character
TrueString:	.string "TRUE"	# used by printf to display the boolean value TRUE
FalseString:	.string "FALSE"	# used by printf to display the boolean value FALSE
SautDeLigne:	.string ""	# used by printf to display the boolean value FALSE
T2sizeArray:	.quad 24		#taille tableau
T2:	.space 24		#allocation de la taille du tableau
TsizeArray:	.quad 16		#taille tableau
T:	.space 16		#allocation de la taille du tableau
TDsizeArray:	.quad 16		#taille tableau
TD:	.space 16		#allocation de la taille du tableau
SsizeArray:	.quad 56		#taille tableau
S:	.space 56		#allocation de la taille du tableau
i:	.quad 0		#INTEGER
j:	.quad 0		#INTEGER
k:	.quad 0		#INTEGER
x:	.quad 0		#INTEGER
y:	.quad 0		#INTEGER
z:	.quad 0		#INTEGER
b:	.quad 0		#BOOLEAN
f:	.quad 0		#BOOLEAN
false:	.quad 0		#BOOLEAN
t:	.quad 0		#BOOLEAN
true:	.quad 0		#BOOLEAN
c:	.byte 0 		#CHAR
e:	.byte 0 		#CHAR
d:	.double 0.0		#DOUBLE
double:	.double 0.0		#DOUBLE
double1:	.double 0.0		#DOUBLE
double2:	.double 0.0		#DOUBLE
	.text		# The following lines contain the program
	.globl main	# The main function must be visible from outside
main:			# The main function body :
	.cfi_startproc
	pushq %rbp	# Save the position of the stack's top
Begin1:
	push $1	#INTEGER
	pop j
	push $9	#INTEGER
	push $7	#INTEGER
	push $13	#INTEGER
	movq T2sizeArray,%rax	# Initialise rax à sizeArray
	leaq T2, %rsi		#copie l'addresse de l'idArray dans rsi
fillArray_T2:
	subq $8,%rax 		#diminue la taille du compteur de 8 octets
	popq (%rsi,%rax)	# stock dans T[taille du compteur-1]
	cmpq $0, %rax 		# comparaison compteur
	jne fillArray_T2
	push $6	#INTEGER
	push $5	#INTEGER
	movq TsizeArray,%rax	# Initialise rax à sizeArray
	leaq T, %rsi		#copie l'addresse de l'idArray dans rsi
fillArray_T:
	subq $8,%rax 		#diminue la taille du compteur de 8 octets
	popq (%rsi,%rax)	# stock dans T[taille du compteur-1]
	cmpq $0, %rax 		# comparaison compteur
	jne fillArray_T
	subq $8,%rsp			# allouer 8 octets sur le sommet de la pile pour DOUBLE
	movl	$1717986918, (%rsp)	# Conversion de 6.1 (partie haute de 32 bits)
	movl	$1075340902, 4(%rsp)	# Conversion de 6.1 (partie basse de 32 bits)
	subq $8,%rsp			# allouer 8 octets sur le sommet de la pile pour DOUBLE
	movl	$3435973837, (%rsp)	# Conversion de 5.2 (partie haute de 32 bits)
	movl	$1075104972, 4(%rsp)	# Conversion de 5.2 (partie basse de 32 bits)
	movq TDsizeArray,%rax	# Initialise rax à sizeArray
	leaq TD, %rsi		#copie l'addresse de l'idArray dans rsi
fillArray_TD:
	subq $8,%rax 		#diminue la taille du compteur de 8 octets
	popq (%rsi,%rax)	# stock dans T[taille du compteur-1]
	cmpq $0, %rax 		# comparaison compteur
	jne fillArray_TD
	movq $0, %rax
	movb $'b',%al
	push %rax	# push a 64-bit version of 'b'
	movq $0, %rax
	movb $'o',%al
	push %rax	# push a 64-bit version of 'o'
	movq $0, %rax
	movb $'n',%al
	push %rax	# push a 64-bit version of 'n'
	movq $0, %rax
	movb $'j',%al
	push %rax	# push a 64-bit version of 'j'
	movq $0, %rax
	movb $'o',%al
	push %rax	# push a 64-bit version of 'o'
	movq $0, %rax
	movb $'u',%al
	push %rax	# push a 64-bit version of 'u'
	movq $0, %rax
	movb $'r',%al
	push %rax	# push a 64-bit version of 'r'
	movq SsizeArray,%rax	# Initialise rax à sizeArray
	leaq S, %rsi		#copie l'addresse de l'idArray dans rsi
fillArray_S:
	subq $8,%rax 		#diminue la taille du compteur de 8 octets
	popq (%rsi,%rax)	# stock dans T[taille du compteur-1]
	cmpq $0, %rax 		# comparaison compteur
	jne fillArray_S
	 xorq %rbx, %rbx		#reset de rbx
print_array2:
	pushq T2(,%rbx)		#id de tableau
	pop %rsi		# L'entier a afficher
	movq $FormatString1, %rdi		# "%llu\n"
	movl	$0, %eax
	call printf@PLT
	movq $32, %rsi 		# 32 est le code asci de l'espace
	movq $FormatString3, %rdi	# "%c\n"
	call printf@PLT
	addq $8, %rbx		# j'incremente rbx d'une case soit 8 octets pour passer à la valeur suivante
	cmpq T2sizeArray, %rbx
	jne print_array2
	xorq %rbx, %rbx 		# reset mon compteur rbx
	movq $0, %rax
	movb $' ',%al
	push %rax	# push a 64-bit version of ' '
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
	 xorq %rbx, %rbx		#reset de rbx
print_array3:
	pushq T(,%rbx)		#id de tableau
	pop %rsi		# L'entier a afficher
	movq $FormatString1, %rdi		# "%llu\n"
	movl	$0, %eax
	call printf@PLT
	movq $32, %rsi 		# 32 est le code asci de l'espace
	movq $FormatString3, %rdi	# "%c\n"
	call printf@PLT
	addq $8, %rbx		# j'incremente rbx d'une case soit 8 octets pour passer à la valeur suivante
	cmpq TsizeArray, %rbx
	jne print_array3
	xorq %rbx, %rbx 		# reset mon compteur rbx
	movq $0, %rax
	movb $' ',%al
	push %rax	# push a 64-bit version of ' '
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
	 xorq %rbx, %rbx		#reset de rbx
print_array4:
	pushq TD(,%rbx)		#id de tableau
	movsd	(%rsp), %xmm0		# &stack top -> %xmm0
	movsd %xmm0, (%rsp)
	pop %rsi		# Le double a afficher
	movq $FormatString2, %rdi		# "%lf\n"
	movq	$1, %rax		# DOUBLE
	call	printf@PLT
	movq $32, %rsi 		# 32 est le code asci de l'espace
	movq $FormatString3, %rdi	# "%c\n"
	call printf@PLT
	addq $8, %rbx		# j'incremente rbx d'une case soit 8 octets pour passer à la valeur suivante
	cmpq TDsizeArray, %rbx
	jne print_array4
	xorq %rbx, %rbx 		# reset mon compteur rbx
	movq $0, %rax
	movb $' ',%al
	push %rax	# push a 64-bit version of ' '
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
	 xorq %rbx, %rbx		#reset de rbx
print_array5:
	pushq S(,%rbx)		#id de tableau
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
	movq $32, %rsi 		# 32 est le code asci de l'espace
	movq $FormatString3, %rdi	# "%c\n"
	call printf@PLT
	addq $8, %rbx		# j'incremente rbx d'une case soit 8 octets pour passer à la valeur suivante
	cmpq SsizeArray, %rbx
	jne print_array5
	xorq %rbx, %rbx 		# reset mon compteur rbx
	movq $0, %rax
	movb $'\n',%al
	push %rax	# push a 64-bit version of '\n'
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
	push $0	#INTEGER
	pop i
TestFor7:
	push $2	#INTEGER
	movq i,%rax 		#indice du for
	popq %rbx	#la fonction printf modifier rsp donc je l'ajoute à un endroit non modifer par prinf, soit r12
	cmpq %rbx,%rax	#je compare avec la borne de fin de if dans r12
	ja FinFor7
	leaq T2,%rsi 		#je copie l'addresse du tableau
	movq i,%rax		#Initialise rax avec la taille du tableau, la taille est une variable
	movq $8,%rbx		# Initialise rbx à 8
	mulq %rbx		# Multiplie the contenu de rax par 8, car une 1 case fait 8 octets
	pushq (%rsi,%rax)		# stock a l'indice donne par rax dans le tableau 
	pop %rsi		# L'entier a afficher
	movq $FormatString1, %rdi		# "%llu\n"
	movl	$0, %eax
	call printf@PLT
	incq i
	jmp TestFor7
FinFor7:
	movq $0, %rax
	movb $'\n',%al
	push %rax	# push a 64-bit version of '\n'
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
	push $1	#INTEGER
	leaq T2,%rsi 		#je copie l'addresse du tableau
	movq j,%rax	# Initialise rbx à 0
	movq $8,%rbx	# Initialise rbx à 0
	mulq %rbx	# Multiply the content of rax by 8
	pop %rbx	#stocke la valeur a ajouter dans le tableau, dans rbx
	movq %rbx,(%rsi,%rax)	# stock dans T[indice]
	 xorq %rbx, %rbx		#reset de rbx
print_array11:
	pushq T2(,%rbx)		#id de tableau
	pop %rsi		# L'entier a afficher
	movq $FormatString1, %rdi		# "%llu\n"
	movl	$0, %eax
	call printf@PLT
	movq $32, %rsi 		# 32 est le code asci de l'espace
	movq $FormatString3, %rdi	# "%c\n"
	call printf@PLT
	addq $8, %rbx		# j'incremente rbx d'une case soit 8 octets pour passer à la valeur suivante
	cmpq T2sizeArray, %rbx
	jne print_array11
	xorq %rbx, %rbx 		# reset mon compteur rbx
FinBegin1:
	movq $0, %rax
	movb $'\n',%al
	push %rax	# push a 64-bit version of '\n'
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
Begin15:
	push $10	#INTEGER
	pop x
	push $20	#INTEGER
	pop y
	movq $0, %rax
	movb $'c',%al
	push %rax	# push a 64-bit version of 'c'
	pop c
	push $3	#INTEGER
	push $3	#INTEGER
	pop %rax
	pop %rbx
	cmpq %rax, %rbx		#comparer op1 et op2 INTEGER
	je Vrai16		# If equal
	push $0		# False
	jmp Suite16
Vrai16:	push $0xFFFFFFFFFFFFFFFF		# True
Suite16:
	pop t
	push $3	#INTEGER
	push $3	#INTEGER
	pop %rax
	pop %rbx
	cmpq %rax, %rbx		#comparer op1 et op2 INTEGER
	je Vrai17		# If equal
	push $0		# False
	jmp Suite17
Vrai17:	push $0xFFFFFFFFFFFFFFFF		# True
Suite17:
	pop %rax		#procedure de NOT
	not %rax
	push %rax		#NOT %rax
	pop f
	push $0xFFFFFFFFFFFFFFFF	#TRUE
	pop true
	push $0	#FALSE
	pop false
	subq $8,%rsp			# allouer 8 octets sur le sommet de la pile pour DOUBLE
	movl	$2576980378, (%rsp)	# Conversion de 13.3 (partie haute de 32 bits)
	movl	$1076533657, 4(%rsp)	# Conversion de 13.3 (partie basse de 32 bits)
	pop double
	movq $0, %rax
	movb $'=',%al
	push %rax	# push a 64-bit version of '='
	pop e
	push $1	#INTEGER
	pop i
TestFor18:
	push $3	#INTEGER
	movq i,%rax 		#indice du for
	popq %rbx	#la fonction printf modifier rsp donc je l'ajoute à un endroit non modifer par prinf, soit r12
	cmpq %rbx,%rax	#je compare avec la borne de fin de if dans r12
	ja FinFor18
Begin19:
	movq $0, %rax
	movb $'i',%al
	push %rax	# push a 64-bit version of 'i'
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
	movq $0, %rax
	movb $'=',%al
	push %rax	# push a 64-bit version of '='
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
	push i		#Identifier
	pop %rsi		# L'entier a afficher
	movq $FormatString1, %rdi		# "%llu\n"
	movl	$0, %eax
	call printf@PLT
	movq $0, %rax
	movb $' ',%al
	push %rax	# push a 64-bit version of ' '
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
	push $1	#INTEGER
	pop j
TestFor21:
	push $3	#INTEGER
	movq j,%rax 		#indice du for
	popq %rbx	#la fonction printf modifier rsp donc je l'ajoute à un endroit non modifer par prinf, soit r12
	cmpq %rbx,%rax	#je compare avec la borne de fin de if dans r12
	ja FinFor21
Begin22:
	movq $0, %rax
	movb $'j',%al
	push %rax	# push a 64-bit version of 'j'
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
	movq $0, %rax
	movb $'=',%al
	push %rax	# push a 64-bit version of '='
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
	push j		#Identifier
	pop %rsi		# L'entier a afficher
	movq $FormatString1, %rdi		# "%llu\n"
	movl	$0, %eax
	call printf@PLT
	movq $0, %rax
	movb $' ',%al
	push %rax	# push a 64-bit version of ' '
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
FinBegin22:
	incq j
	jmp TestFor21
FinFor21:
	movq $0, %rax
	movb $' ',%al
	push %rax	# push a 64-bit version of ' '
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
	push $3	#INTEGER
	pop j
TestFor27:
	push $1	#INTEGER
	movq j,%rax
	popq %rbx	#la fonction printf modifier rsp donc je l'ajoute à un endroit non modifer par prinf, soit r12
	cmpq %rbx,%rax	#je compare avec la borne de fin de if dans r12
	jb FinFor27
Begin28:
	movq $0, %rax
	movb $'j',%al
	push %rax	# push a 64-bit version of 'j'
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
	movq $0, %rax
	movb $'=',%al
	push %rax	# push a 64-bit version of '='
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
	push j		#Identifier
	pop %rsi		# L'entier a afficher
	movq $FormatString1, %rdi		# "%llu\n"
	movl	$0, %eax
	call printf@PLT
	movq $0, %rax
	movb $' ',%al
	push %rax	# push a 64-bit version of ' '
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
FinBegin28:
	decq j
	jmp TestFor27
FinFor27:
	movq $0, %rax
	movb $'\n',%al
	push %rax	# push a 64-bit version of '\n'
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
TestIf33:
	push x		#Identifier
	push $10	#INTEGER
	pop %rax
	pop %rbx
	cmpq %rax, %rbx		#comparer op1 et op2 INTEGER
	je Vrai34		# If equal
	push $0		# False
	jmp Suite34
Vrai34:	push $0xFFFFFFFFFFFFFFFF		# True
Suite34:
	pop %rax
	cmpq $0,%rax
	je Else33
	movq $0, %rax
	movb $'x',%al
	push %rax	# push a 64-bit version of 'x'
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
	movq $0, %rax
	movb $'=',%al
	push %rax	# push a 64-bit version of '='
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
	push x		#Identifier
	pop %rsi		# L'entier a afficher
	movq $FormatString1, %rdi		# "%llu\n"
	movl	$0, %eax
	call printf@PLT
	movq $0, %rax
	movb $'\n',%al
	push %rax	# push a 64-bit version of '\n'
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
	jmp FinIf33
Else33:
FinIf33:
TestIf37:
	push x		#Identifier
	push $10	#INTEGER
	pop %rax
	pop %rbx
	cmpq %rax, %rbx		#comparer op1 et op2 INTEGER
	je Vrai38		# If equal
	push $0		# False
	jmp Suite38
Vrai38:	push $0xFFFFFFFFFFFFFFFF		# True
Suite38:
	pop %rax		#procedure de NOT
	not %rax
	push %rax		#NOT %rax
	pop %rax
	cmpq $0,%rax
	je Else37
	movq $0, %rax
	movb $'E',%al
	push %rax	# push a 64-bit version of 'E'
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
	movq $0, %rax
	movb $'\n',%al
	push %rax	# push a 64-bit version of '\n'
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
	jmp FinIf37
Else37:
	movq $0, %rax
	movb $'x',%al
	push %rax	# push a 64-bit version of 'x'
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
	movq $0, %rax
	movb $'=',%al
	push %rax	# push a 64-bit version of '='
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
	push x		#Identifier
	pop %rsi		# L'entier a afficher
	movq $FormatString1, %rdi		# "%llu\n"
	movl	$0, %eax
	call printf@PLT
	movq $0, %rax
	movb $'\n',%al
	push %rax	# push a 64-bit version of '\n'
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
FinIf37:
	push $1	#INTEGER
	pop k
TestWhile42:
	push k		#Identifier
	push $3	#INTEGER
	pop %rax
	pop %rbx
	cmpq %rax, %rbx		#comparer op1 et op2 INTEGER
	jb Vrai43		# If below
	push $0		# False
	jmp Suite43
Vrai43:	push $0xFFFFFFFFFFFFFFFF		# True
Suite43:
	pop %rax
	cmpq $0,%rax
	je FinWhile42
Begin44:
	movq $0, %rax
	movb $'k',%al
	push %rax	# push a 64-bit version of 'k'
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
	movq $0, %rax
	movb $'=',%al
	push %rax	# push a 64-bit version of '='
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
	push k		#Identifier
	pop %rsi		# L'entier a afficher
	movq $FormatString1, %rdi		# "%llu\n"
	movl	$0, %eax
	call printf@PLT
	movq $0, %rax
	movb $' ',%al
	push %rax	# push a 64-bit version of ' '
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
	push k		#Identifier
	push $1	#INTEGER
	pop %rbx 		#procedure ADD INTEGER
	pop %rax
	addq	%rbx, %rax	# ADD
	push %rax
	pop k
FinBegin44:
	jmp TestWhile42
FinWhile42:
	movq $0, %rax
	movb $'\n',%al
	push %rax	# push a 64-bit version of '\n'
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
	push i		#Identifier
CaseStatement49:
	popq %rdx
CaseStatement49_TestCase0:
	push $1	#INTEGER
	popq %rbx
	cmpq %rbx, %rdx
	je CaseStatement49_Case0
	push $2	#INTEGER
	popq %rbx
	cmpq %rbx, %rdx
	je CaseStatement49_Case0
	jmp CaseStatement49_TestCase1
CaseStatement49_Case0:
	movq $0, %rax
	movb $'i',%al
	push %rax	# push a 64-bit version of 'i'
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
	movq $0, %rax
	movb $'=',%al
	push %rax	# push a 64-bit version of '='
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
	push i		#Identifier
	pop %rsi		# L'entier a afficher
	movq $FormatString1, %rdi		# "%llu\n"
	movl	$0, %eax
	call printf@PLT
	movq $0, %rax
	movb $' ',%al
	push %rax	# push a 64-bit version of ' '
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
	jmp EndCaseStatement49
CaseStatement49_TestCase1:
	push $3	#INTEGER
	popq %rbx
	cmpq %rbx, %rdx
	je CaseStatement49_Case1
	jmp CaseStatement49_TestCase2
CaseStatement49_Case1:
	movq $0, %rax
	movb $'i',%al
	push %rax	# push a 64-bit version of 'i'
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
	movq $0, %rax
	movb $'=',%al
	push %rax	# push a 64-bit version of '='
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
	push i		#Identifier
	pop %rsi		# L'entier a afficher
	movq $FormatString1, %rdi		# "%llu\n"
	movl	$0, %eax
	call printf@PLT
	movq $0, %rax
	movb $' ',%al
	push %rax	# push a 64-bit version of ' '
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
	jmp EndCaseStatement49
CaseStatement49_TestCase2:
	push $4	#INTEGER
	popq %rbx
	cmpq %rbx, %rdx
	je CaseStatement49_Case2
	jmp CaseStatement49_TestCase3
CaseStatement49_Case2:
	movq $0, %rax
	movb $'i',%al
	push %rax	# push a 64-bit version of 'i'
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
	movq $0, %rax
	movb $'=',%al
	push %rax	# push a 64-bit version of '='
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
	push i		#Identifier
	pop %rsi		# L'entier a afficher
	movq $FormatString1, %rdi		# "%llu\n"
	movl	$0, %eax
	call printf@PLT
	movq $0, %rax
	movb $' ',%al
	push %rax	# push a 64-bit version of ' '
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
CaseStatement49_TestCase3:
	movq $0, %rax
	movb $' ',%al
	push %rax	# push a 64-bit version of ' '
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
EndCaseStatement49:
	movq $0, %rax
	movb $'\n',%al
	push %rax	# push a 64-bit version of '\n'
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
	movq $0, %rax
	movb $'\n',%al
	push %rax	# push a 64-bit version of '\n'
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
FinBegin19:
	incq i
	jmp TestFor18
FinFor18:
FinBegin15:
Begin58:
	push $10	#INTEGER
	pop x
	push $20	#INTEGER
	pop y
	movq $0, %rax
	movb $'c',%al
	push %rax	# push a 64-bit version of 'c'
	pop c
	push $3	#INTEGER
	push $3	#INTEGER
	pop %rax
	pop %rbx
	cmpq %rax, %rbx		#comparer op1 et op2 INTEGER
	je Vrai59		# If equal
	push $0		# False
	jmp Suite59
Vrai59:	push $0xFFFFFFFFFFFFFFFF		# True
Suite59:
	pop t
	push $3	#INTEGER
	push $3	#INTEGER
	pop %rax
	pop %rbx
	cmpq %rax, %rbx		#comparer op1 et op2 INTEGER
	je Vrai60		# If equal
	push $0		# False
	jmp Suite60
Vrai60:	push $0xFFFFFFFFFFFFFFFF		# True
Suite60:
	pop %rax		#procedure de NOT
	not %rax
	push %rax		#NOT %rax
	pop f
	push $0xFFFFFFFFFFFFFFFF	#TRUE
	pop true
	push $0	#FALSE
	pop false
	subq $8,%rsp			# allouer 8 octets sur le sommet de la pile pour DOUBLE
	movl	$2576980378, (%rsp)	# Conversion de 13.3 (partie haute de 32 bits)
	movl	$1076533657, 4(%rsp)	# Conversion de 13.3 (partie basse de 32 bits)
	pop double
	movq $0, %rax
	movb $'=',%al
	push %rax	# push a 64-bit version of '='
	pop e
TestWhile61:
	push i		#Identifier
	push $0	#INTEGER
	pop %rax
	pop %rbx
	cmpq %rax, %rbx		#comparer op1 et op2 INTEGER
	jne Vrai62		# If different
	push $0		# False
	jmp Suite62
Vrai62:	push $0xFFFFFFFFFFFFFFFF		# True
Suite62:
	pop %rax
	cmpq $0,%rax
	je FinWhile61
	push $0	#INTEGER
	pop i
	jmp TestWhile61
FinWhile61:
TestWhile64:
	push i		#Identifier
	push $3	#INTEGER
	pop %rax
	pop %rbx
	cmpq %rax, %rbx		#comparer op1 et op2 INTEGER
	jb Vrai65		# If below
	push $0		# False
	jmp Suite65
Vrai65:	push $0xFFFFFFFFFFFFFFFF		# True
Suite65:
	pop %rax
	cmpq $0,%rax
	je FinWhile64
Begin66:
	movq $0, %rax
	movb $'i',%al
	push %rax	# push a 64-bit version of 'i'
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
	movq $0, %rax
	movb $'=',%al
	push %rax	# push a 64-bit version of '='
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
	push i		#Identifier
	pop %rsi		# L'entier a afficher
	movq $FormatString1, %rdi		# "%llu\n"
	movl	$0, %eax
	call printf@PLT
	movq $0, %rax
	movb $' ',%al
	push %rax	# push a 64-bit version of ' '
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
	push $1	#INTEGER
	pop j
TestFor68:
	push $3	#INTEGER
	movq j,%rax 		#indice du for
	popq %rbx	#la fonction printf modifier rsp donc je l'ajoute à un endroit non modifer par prinf, soit r12
	cmpq %rbx,%rax	#je compare avec la borne de fin de if dans r12
	ja FinFor68
Begin69:
	movq $0, %rax
	movb $'j',%al
	push %rax	# push a 64-bit version of 'j'
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
	movq $0, %rax
	movb $'=',%al
	push %rax	# push a 64-bit version of '='
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
	push j		#Identifier
	pop %rsi		# L'entier a afficher
	movq $FormatString1, %rdi		# "%llu\n"
	movl	$0, %eax
	call printf@PLT
	movq $0, %rax
	movb $' ',%al
	push %rax	# push a 64-bit version of ' '
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
FinBegin69:
	incq j
	jmp TestFor68
FinFor68:
	movq $0, %rax
	movb $' ',%al
	push %rax	# push a 64-bit version of ' '
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
	push $3	#INTEGER
	pop j
TestFor74:
	push $1	#INTEGER
	movq j,%rax
	popq %rbx	#la fonction printf modifier rsp donc je l'ajoute à un endroit non modifer par prinf, soit r12
	cmpq %rbx,%rax	#je compare avec la borne de fin de if dans r12
	jb FinFor74
Begin75:
	movq $0, %rax
	movb $'j',%al
	push %rax	# push a 64-bit version of 'j'
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
	movq $0, %rax
	movb $'=',%al
	push %rax	# push a 64-bit version of '='
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
	push j		#Identifier
	pop %rsi		# L'entier a afficher
	movq $FormatString1, %rdi		# "%llu\n"
	movl	$0, %eax
	call printf@PLT
	movq $0, %rax
	movb $' ',%al
	push %rax	# push a 64-bit version of ' '
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
FinBegin75:
	decq j
	jmp TestFor74
FinFor74:
	movq $0, %rax
	movb $'\n',%al
	push %rax	# push a 64-bit version of '\n'
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
TestIf80:
	push x		#Identifier
	push $10	#INTEGER
	pop %rax
	pop %rbx
	cmpq %rax, %rbx		#comparer op1 et op2 INTEGER
	je Vrai81		# If equal
	push $0		# False
	jmp Suite81
Vrai81:	push $0xFFFFFFFFFFFFFFFF		# True
Suite81:
	pop %rax
	cmpq $0,%rax
	je Else80
	movq $0, %rax
	movb $'x',%al
	push %rax	# push a 64-bit version of 'x'
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
	movq $0, %rax
	movb $'=',%al
	push %rax	# push a 64-bit version of '='
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
	push x		#Identifier
	pop %rsi		# L'entier a afficher
	movq $FormatString1, %rdi		# "%llu\n"
	movl	$0, %eax
	call printf@PLT
	movq $0, %rax
	movb $'\n',%al
	push %rax	# push a 64-bit version of '\n'
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
	jmp FinIf80
Else80:
FinIf80:
TestIf84:
	push x		#Identifier
	push $10	#INTEGER
	pop %rax
	pop %rbx
	cmpq %rax, %rbx		#comparer op1 et op2 INTEGER
	je Vrai85		# If equal
	push $0		# False
	jmp Suite85
Vrai85:	push $0xFFFFFFFFFFFFFFFF		# True
Suite85:
	pop %rax		#procedure de NOT
	not %rax
	push %rax		#NOT %rax
	pop %rax
	cmpq $0,%rax
	je Else84
	movq $0, %rax
	movb $'E',%al
	push %rax	# push a 64-bit version of 'E'
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
	movq $0, %rax
	movb $'\n',%al
	push %rax	# push a 64-bit version of '\n'
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
	jmp FinIf84
Else84:
	movq $0, %rax
	movb $'x',%al
	push %rax	# push a 64-bit version of 'x'
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
	movq $0, %rax
	movb $'=',%al
	push %rax	# push a 64-bit version of '='
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
	push x		#Identifier
	pop %rsi		# L'entier a afficher
	movq $FormatString1, %rdi		# "%llu\n"
	movl	$0, %eax
	call printf@PLT
	movq $0, %rax
	movb $'\n',%al
	push %rax	# push a 64-bit version of '\n'
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
FinIf84:
	push $1	#INTEGER
	pop k
TestWhile89:
	push k		#Identifier
	push $3	#INTEGER
	pop %rax
	pop %rbx
	cmpq %rax, %rbx		#comparer op1 et op2 INTEGER
	jb Vrai90		# If below
	push $0		# False
	jmp Suite90
Vrai90:	push $0xFFFFFFFFFFFFFFFF		# True
Suite90:
	pop %rax
	cmpq $0,%rax
	je FinWhile89
Begin91:
	movq $0, %rax
	movb $'k',%al
	push %rax	# push a 64-bit version of 'k'
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
	movq $0, %rax
	movb $'=',%al
	push %rax	# push a 64-bit version of '='
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
	push k		#Identifier
	pop %rsi		# L'entier a afficher
	movq $FormatString1, %rdi		# "%llu\n"
	movl	$0, %eax
	call printf@PLT
	movq $0, %rax
	movb $' ',%al
	push %rax	# push a 64-bit version of ' '
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
	push k		#Identifier
	push $1	#INTEGER
	pop %rbx 		#procedure ADD INTEGER
	pop %rax
	addq	%rbx, %rax	# ADD
	push %rax
	pop k
FinBegin91:
	jmp TestWhile89
FinWhile89:
	movq $0, %rax
	movb $'\n',%al
	push %rax	# push a 64-bit version of '\n'
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
	push i		#Identifier
CaseStatement96:
	popq %rdx
CaseStatement96_TestCase0:
	push $1	#INTEGER
	popq %rbx
	cmpq %rbx, %rdx
	je CaseStatement96_Case0
	push $2	#INTEGER
	popq %rbx
	cmpq %rbx, %rdx
	je CaseStatement96_Case0
	jmp CaseStatement96_TestCase1
CaseStatement96_Case0:
	movq $0, %rax
	movb $'i',%al
	push %rax	# push a 64-bit version of 'i'
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
	movq $0, %rax
	movb $'=',%al
	push %rax	# push a 64-bit version of '='
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
	push i		#Identifier
	pop %rsi		# L'entier a afficher
	movq $FormatString1, %rdi		# "%llu\n"
	movl	$0, %eax
	call printf@PLT
	movq $0, %rax
	movb $' ',%al
	push %rax	# push a 64-bit version of ' '
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
	jmp EndCaseStatement96
CaseStatement96_TestCase1:
	push $3	#INTEGER
	popq %rbx
	cmpq %rbx, %rdx
	je CaseStatement96_Case1
	jmp CaseStatement96_TestCase2
CaseStatement96_Case1:
	movq $0, %rax
	movb $'i',%al
	push %rax	# push a 64-bit version of 'i'
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
	movq $0, %rax
	movb $'=',%al
	push %rax	# push a 64-bit version of '='
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
	push i		#Identifier
	pop %rsi		# L'entier a afficher
	movq $FormatString1, %rdi		# "%llu\n"
	movl	$0, %eax
	call printf@PLT
	movq $0, %rax
	movb $' ',%al
	push %rax	# push a 64-bit version of ' '
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
	jmp EndCaseStatement96
CaseStatement96_TestCase2:
	push $4	#INTEGER
	popq %rbx
	cmpq %rbx, %rdx
	je CaseStatement96_Case2
	jmp CaseStatement96_TestCase3
CaseStatement96_Case2:
	movq $0, %rax
	movb $'i',%al
	push %rax	# push a 64-bit version of 'i'
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
	movq $0, %rax
	movb $'=',%al
	push %rax	# push a 64-bit version of '='
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
	push i		#Identifier
	pop %rsi		# L'entier a afficher
	movq $FormatString1, %rdi		# "%llu\n"
	movl	$0, %eax
	call printf@PLT
	movq $0, %rax
	movb $' ',%al
	push %rax	# push a 64-bit version of ' '
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
CaseStatement96_TestCase3:
	movq $0, %rax
	movb $' ',%al
	push %rax	# push a 64-bit version of ' '
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
EndCaseStatement96:
	movq $0, %rax
	movb $'\n',%al
	push %rax	# push a 64-bit version of '\n'
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
	movq $0, %rax
	movb $'\n',%al
	push %rax	# push a 64-bit version of '\n'
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
	push i		#Identifier
	push $1	#INTEGER
	pop %rbx 		#procedure ADD INTEGER
	pop %rax
	addq	%rbx, %rax	# ADD
	push %rax
	pop i
FinBegin66:
	jmp TestWhile64
FinWhile64:
FinBegin58:
	push $12	#INTEGER
	pop x
	push $6	#INTEGER
	pop y
	push x		#Identifier
CaseStatement105:
	popq %rdx
CaseStatement105_TestCase0:
	push $14	#INTEGER
	popq %rbx
	cmpq %rbx, %rdx
	je CaseStatement105_Case0
	jmp CaseStatement105_TestCase1
CaseStatement105_Case0:
	push x		#Identifier
	push $1	#INTEGER
	pop %rbx		#procedure SUB INTEGER
	pop %rax
	subq	%rbx, %rax	# SUB
	push %rax
	pop x
	jmp EndCaseStatement105
CaseStatement105_TestCase1:
	push y		#Identifier
	push $6	#INTEGER
	pop %rbx 		#procedure ADD INTEGER
	pop %rax
	addq	%rbx, %rax	# ADD
	push %rax
	popq %rbx
	cmpq %rbx, %rdx
	je CaseStatement105_Case1
	jmp CaseStatement105_TestCase2
CaseStatement105_Case1:
	push y		#Identifier
CaseStatement106:
	popq %rdx
CaseStatement106_TestCase0:
	push $6	#INTEGER
	popq %rbx
	cmpq %rbx, %rdx
	je CaseStatement106_Case0
	jmp CaseStatement106_TestCase1
CaseStatement106_Case0:
	push $203	#INTEGER
	pop x
TestFor107:
	push $200	#INTEGER
	movq x,%rax
	popq %rbx	#la fonction printf modifier rsp donc je l'ajoute à un endroit non modifer par prinf, soit r12
	cmpq %rbx,%rax	#je compare avec la borne de fin de if dans r12
	jb FinFor107
Begin108:
	movq $0, %rax
	movb $'x',%al
	push %rax	# push a 64-bit version of 'x'
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
	push x		#Identifier
	pop %rsi		# L'entier a afficher
	movq $FormatString1, %rdi		# "%llu\n"
	movl	$0, %eax
	call printf@PLT
	movq $0, %rax
	movb $'\n',%al
	push %rax	# push a 64-bit version of '\n'
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
FinBegin108:
	decq x
	jmp TestFor107
FinFor107:
CaseStatement106_TestCase1:
	push x		#Identifier
	push $10	#INTEGER
	pop %rbx 		#procedure ADD INTEGER
	pop %rax
	addq	%rbx, %rax	# ADD
	push %rax
	pop x
EndCaseStatement106:
CaseStatement105_TestCase2:
	push x		#Identifier
	push $10	#INTEGER
	pop %rbx 		#procedure ADD INTEGER
	pop %rax
	addq	%rbx, %rax	# ADD
	push %rax
	pop x
EndCaseStatement105:
	movq $0, %rax
	movb $'\n',%al
	push %rax	# push a 64-bit version of '\n'
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
Begin113:
	push $10	#INTEGER
	pop i
	push $3	#INTEGER
	pop j
	push i		#Identifier
	push j		#Identifier
	pop %rbx 		#procedure ADD INTEGER
	pop %rax
	addq	%rbx, %rax	# ADD
	push %rax
	pop k
	movq $0, %rax
	movb $'k',%al
	push %rax	# push a 64-bit version of 'k'
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
	movq $0, %rax
	movb $'=',%al
	push %rax	# push a 64-bit version of '='
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
	push k		#Identifier
	pop %rsi		# L'entier a afficher
	movq $FormatString1, %rdi		# "%llu\n"
	movl	$0, %eax
	call printf@PLT
	movq $0, %rax
	movb $'\n',%al
	push %rax	# push a 64-bit version of '\n'
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
	push i		#Identifier
	push j		#Identifier
	pop %rbx		#procedure SUB INTEGER
	pop %rax
	subq	%rbx, %rax	# SUB
	push %rax
	pop k
	movq $0, %rax
	movb $'k',%al
	push %rax	# push a 64-bit version of 'k'
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
	movq $0, %rax
	movb $'=',%al
	push %rax	# push a 64-bit version of '='
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
	push k		#Identifier
	pop %rsi		# L'entier a afficher
	movq $FormatString1, %rdi		# "%llu\n"
	movl	$0, %eax
	call printf@PLT
	movq $0, %rax
	movb $'\n',%al
	push %rax	# push a 64-bit version of '\n'
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
	push j		#Identifier
	push i		#Identifier
	pop %rbx		#procedure SUB INTEGER
	pop %rax
	subq	%rbx, %rax	# SUB
	push %rax
	pop k
	movq $0, %rax
	movb $'k',%al
	push %rax	# push a 64-bit version of 'k'
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
	movq $0, %rax
	movb $'=',%al
	push %rax	# push a 64-bit version of '='
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
	push k		#Identifier
	pop %rsi		# L'entier a afficher
	movq $FormatString1, %rdi		# "%llu\n"
	movl	$0, %eax
	call printf@PLT
	movq $0, %rax
	movb $'\n',%al
	push %rax	# push a 64-bit version of '\n'
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
	push i		#Identifier
	push j		#Identifier
	pop %rbx		#procedure de MUL INTEGER
	pop %rax
	mulq	%rbx
	push %rax	# MUL
	pop k
	movq $0, %rax
	movb $'k',%al
	push %rax	# push a 64-bit version of 'k'
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
	movq $0, %rax
	movb $'=',%al
	push %rax	# push a 64-bit version of '='
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
	push k		#Identifier
	pop %rsi		# L'entier a afficher
	movq $FormatString1, %rdi		# "%llu\n"
	movl	$0, %eax
	call printf@PLT
	movq $0, %rax
	movb $'\n',%al
	push %rax	# push a 64-bit version of '\n'
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
	push i		#Identifier
	push j		#Identifier
	pop %rbx		#procedure de MOD
	pop %rax
	movq $0, %rdx
	div %rbx
	push %rdx	# MOD
	pop k
	movq $0, %rax
	movb $'k',%al
	push %rax	# push a 64-bit version of 'k'
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
	movq $0, %rax
	movb $'=',%al
	push %rax	# push a 64-bit version of '='
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
	push k		#Identifier
	pop %rsi		# L'entier a afficher
	movq $FormatString1, %rdi		# "%llu\n"
	movl	$0, %eax
	call printf@PLT
	movq $0, %rax
	movb $'\n',%al
	push %rax	# push a 64-bit version of '\n'
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
	push i		#Identifier
	push j		#Identifier
	pop %rbx 		#procedure de DIV INTEGER
	pop %rax
	movq $0, %rdx
	div %rbx
	push %rax	# DIV
	pop k
	movq $0, %rax
	movb $'k',%al
	push %rax	# push a 64-bit version of 'k'
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
	movq $0, %rax
	movb $'=',%al
	push %rax	# push a 64-bit version of '='
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
	push k		#Identifier
	pop %rsi		# L'entier a afficher
	movq $FormatString1, %rdi		# "%llu\n"
	movl	$0, %eax
	call printf@PLT
	movq $0, %rax
	movb $'\n',%al
	push %rax	# push a 64-bit version of '\n'
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
	push i		#Identifier
	pop k
	push i		#Identifier
	push j		#Identifier
	pop %rax
	pop %rbx
	cmpq %rax, %rbx		#comparer op1 et op2 INTEGER
	ja Vrai120		# If above
	push $0		# False
	jmp Suite120
Vrai120:	push $0xFFFFFFFFFFFFFFFF		# True
Suite120:
	pop b
	movq $0, %rax
	movb $'b',%al
	push %rax	# push a 64-bit version of 'b'
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
	movq $0, %rax
	movb $'=',%al
	push %rax	# push a 64-bit version of '='
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
	push b		#Identifier
	pop %rdx		# Zero : False, non-zero : true
	cmpq $0, %rdx
	je False122
	movq $TrueString, %rdi		# "TRUE\n"
	jmp Next122
False122:
	movq $FalseString, %rdi		# "FALSE\n"
Next122:
	call	printf@PLT
	movq $0, %rax
	movb $'\n',%al
	push %rax	# push a 64-bit version of '\n'
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
	push i		#Identifier
	push j		#Identifier
	pop %rax
	pop %rbx
	cmpq %rax, %rbx		#comparer op1 et op2 INTEGER
	jae Vrai122		# If above or equal
	push $0		# False
	jmp Suite122
Vrai122:	push $0xFFFFFFFFFFFFFFFF		# True
Suite122:
	pop b
	movq $0, %rax
	movb $'b',%al
	push %rax	# push a 64-bit version of 'b'
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
	movq $0, %rax
	movb $'=',%al
	push %rax	# push a 64-bit version of '='
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
	push b		#Identifier
	pop %rdx		# Zero : False, non-zero : true
	cmpq $0, %rdx
	je False124
	movq $TrueString, %rdi		# "TRUE\n"
	jmp Next124
False124:
	movq $FalseString, %rdi		# "FALSE\n"
Next124:
	call	printf@PLT
	movq $0, %rax
	movb $'\n',%al
	push %rax	# push a 64-bit version of '\n'
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
	push i		#Identifier
	push $10	#INTEGER
	pop %rax
	pop %rbx
	cmpq %rax, %rbx		#comparer op1 et op2 INTEGER
	jae Vrai124		# If above or equal
	push $0		# False
	jmp Suite124
Vrai124:	push $0xFFFFFFFFFFFFFFFF		# True
Suite124:
	pop b
	movq $0, %rax
	movb $'b',%al
	push %rax	# push a 64-bit version of 'b'
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
	movq $0, %rax
	movb $'=',%al
	push %rax	# push a 64-bit version of '='
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
	push b		#Identifier
	pop %rdx		# Zero : False, non-zero : true
	cmpq $0, %rdx
	je False126
	movq $TrueString, %rdi		# "TRUE\n"
	jmp Next126
False126:
	movq $FalseString, %rdi		# "FALSE\n"
Next126:
	call	printf@PLT
	movq $0, %rax
	movb $'\n',%al
	push %rax	# push a 64-bit version of '\n'
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
	push i		#Identifier
	push j		#Identifier
	pop %rax
	pop %rbx
	cmpq %rax, %rbx		#comparer op1 et op2 INTEGER
	jb Vrai126		# If below
	push $0		# False
	jmp Suite126
Vrai126:	push $0xFFFFFFFFFFFFFFFF		# True
Suite126:
	pop b
	movq $0, %rax
	movb $'b',%al
	push %rax	# push a 64-bit version of 'b'
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
	movq $0, %rax
	movb $'=',%al
	push %rax	# push a 64-bit version of '='
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
	push b		#Identifier
	pop %rdx		# Zero : False, non-zero : true
	cmpq $0, %rdx
	je False128
	movq $TrueString, %rdi		# "TRUE\n"
	jmp Next128
False128:
	movq $FalseString, %rdi		# "FALSE\n"
Next128:
	call	printf@PLT
	movq $0, %rax
	movb $'\n',%al
	push %rax	# push a 64-bit version of '\n'
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
	push i		#Identifier
	push j		#Identifier
	pop %rax
	pop %rbx
	cmpq %rax, %rbx		#comparer op1 et op2 INTEGER
	jbe Vrai128		# If below or equal
	push $0		# False
	jmp Suite128
Vrai128:	push $0xFFFFFFFFFFFFFFFF		# True
Suite128:
	pop b
	movq $0, %rax
	movb $'b',%al
	push %rax	# push a 64-bit version of 'b'
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
	movq $0, %rax
	movb $'=',%al
	push %rax	# push a 64-bit version of '='
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
	push b		#Identifier
	pop %rdx		# Zero : False, non-zero : true
	cmpq $0, %rdx
	je False130
	movq $TrueString, %rdi		# "TRUE\n"
	jmp Next130
False130:
	movq $FalseString, %rdi		# "FALSE\n"
Next130:
	call	printf@PLT
	movq $0, %rax
	movb $'\n',%al
	push %rax	# push a 64-bit version of '\n'
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
	push i		#Identifier
	push $10	#INTEGER
	pop %rax
	pop %rbx
	cmpq %rax, %rbx		#comparer op1 et op2 INTEGER
	jbe Vrai130		# If below or equal
	push $0		# False
	jmp Suite130
Vrai130:	push $0xFFFFFFFFFFFFFFFF		# True
Suite130:
	pop b
	movq $0, %rax
	movb $'b',%al
	push %rax	# push a 64-bit version of 'b'
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
	movq $0, %rax
	movb $'=',%al
	push %rax	# push a 64-bit version of '='
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
	push b		#Identifier
	pop %rdx		# Zero : False, non-zero : true
	cmpq $0, %rdx
	je False132
	movq $TrueString, %rdi		# "TRUE\n"
	jmp Next132
False132:
	movq $FalseString, %rdi		# "FALSE\n"
Next132:
	call	printf@PLT
	movq $0, %rax
	movb $'\n',%al
	push %rax	# push a 64-bit version of '\n'
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
	push $0xFFFFFFFFFFFFFFFF	#TRUE
	pop true
	movq $0, %rax
	movb $'t',%al
	push %rax	# push a 64-bit version of 't'
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
	movq $0, %rax
	movb $'=',%al
	push %rax	# push a 64-bit version of '='
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
	push true		#Identifier
	pop %rdx		# Zero : False, non-zero : true
	cmpq $0, %rdx
	je False133
	movq $TrueString, %rdi		# "TRUE\n"
	jmp Next133
False133:
	movq $FalseString, %rdi		# "FALSE\n"
Next133:
	call	printf@PLT
	movq $0, %rax
	movb $'\n',%al
	push %rax	# push a 64-bit version of '\n'
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
	push $0	#FALSE
	pop false
	movq $0, %rax
	movb $'f',%al
	push %rax	# push a 64-bit version of 'f'
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
	movq $0, %rax
	movb $'=',%al
	push %rax	# push a 64-bit version of '='
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
	push false		#Identifier
	pop %rdx		# Zero : False, non-zero : true
	cmpq $0, %rdx
	je False134
	movq $TrueString, %rdi		# "TRUE\n"
	jmp Next134
False134:
	movq $FalseString, %rdi		# "FALSE\n"
Next134:
	call	printf@PLT
	movq $0, %rax
	movb $'\n',%al
	push %rax	# push a 64-bit version of '\n'
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
	push i		#Identifier
	push j		#Identifier
	pop %rax
	pop %rbx
	cmpq %rax, %rbx		#comparer op1 et op2 INTEGER
	je Vrai134		# If equal
	push $0		# False
	jmp Suite134
Vrai134:	push $0xFFFFFFFFFFFFFFFF		# True
Suite134:
	pop false
	movq $0, %rax
	movb $'f',%al
	push %rax	# push a 64-bit version of 'f'
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
	movq $0, %rax
	movb $'=',%al
	push %rax	# push a 64-bit version of '='
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
	push false		#Identifier
	pop %rdx		# Zero : False, non-zero : true
	cmpq $0, %rdx
	je False136
	movq $TrueString, %rdi		# "TRUE\n"
	jmp Next136
False136:
	movq $FalseString, %rdi		# "FALSE\n"
Next136:
	call	printf@PLT
	movq $0, %rax
	movb $'\n',%al
	push %rax	# push a 64-bit version of '\n'
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
	push i		#Identifier
	push j		#Identifier
	pop %rax
	pop %rbx
	cmpq %rax, %rbx		#comparer op1 et op2 INTEGER
	jne Vrai136		# If different
	push $0		# False
	jmp Suite136
Vrai136:	push $0xFFFFFFFFFFFFFFFF		# True
Suite136:
	pop true
	movq $0, %rax
	movb $'t',%al
	push %rax	# push a 64-bit version of 't'
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
	movq $0, %rax
	movb $'=',%al
	push %rax	# push a 64-bit version of '='
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
	push true		#Identifier
	pop %rdx		# Zero : False, non-zero : true
	cmpq $0, %rdx
	je False138
	movq $TrueString, %rdi		# "TRUE\n"
	jmp Next138
False138:
	movq $FalseString, %rdi		# "FALSE\n"
Next138:
	call	printf@PLT
	movq $0, %rax
	movb $'\n',%al
	push %rax	# push a 64-bit version of '\n'
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
	push true		#Identifier
	push true		#Identifier
	pop %rbx		#procedure OR
	pop %rax
	orq	%rbx, %rax	# OR
	push %rax
	pop b
	movq $0, %rax
	movb $'b',%al
	push %rax	# push a 64-bit version of 'b'
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
	movq $0, %rax
	movb $'=',%al
	push %rax	# push a 64-bit version of '='
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
	push b		#Identifier
	pop %rdx		# Zero : False, non-zero : true
	cmpq $0, %rdx
	je False139
	movq $TrueString, %rdi		# "TRUE\n"
	jmp Next139
False139:
	movq $FalseString, %rdi		# "FALSE\n"
Next139:
	call	printf@PLT
	movq $0, %rax
	movb $'\n',%al
	push %rax	# push a 64-bit version of '\n'
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
	push true		#Identifier
	push false		#Identifier
	pop %rbx		#procedure OR
	pop %rax
	orq	%rbx, %rax	# OR
	push %rax
	pop b
	movq $0, %rax
	movb $'b',%al
	push %rax	# push a 64-bit version of 'b'
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
	movq $0, %rax
	movb $'=',%al
	push %rax	# push a 64-bit version of '='
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
	push b		#Identifier
	pop %rdx		# Zero : False, non-zero : true
	cmpq $0, %rdx
	je False140
	movq $TrueString, %rdi		# "TRUE\n"
	jmp Next140
False140:
	movq $FalseString, %rdi		# "FALSE\n"
Next140:
	call	printf@PLT
	movq $0, %rax
	movb $'\n',%al
	push %rax	# push a 64-bit version of '\n'
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
	push false		#Identifier
	push false		#Identifier
	pop %rbx		#procedure OR
	pop %rax
	orq	%rbx, %rax	# OR
	push %rax
	pop b
	movq $0, %rax
	movb $'b',%al
	push %rax	# push a 64-bit version of 'b'
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
	movq $0, %rax
	movb $'=',%al
	push %rax	# push a 64-bit version of '='
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
	push b		#Identifier
	pop %rdx		# Zero : False, non-zero : true
	cmpq $0, %rdx
	je False141
	movq $TrueString, %rdi		# "TRUE\n"
	jmp Next141
False141:
	movq $FalseString, %rdi		# "FALSE\n"
Next141:
	call	printf@PLT
	movq $0, %rax
	movb $'\n',%al
	push %rax	# push a 64-bit version of '\n'
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
	push true		#Identifier
	push true		#Identifier
	pop %rbx 		#procedure de AND
	pop %rax
	mulq	%rbx
	push %rax	# AND
	pop b
	movq $0, %rax
	movb $'b',%al
	push %rax	# push a 64-bit version of 'b'
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
	movq $0, %rax
	movb $'=',%al
	push %rax	# push a 64-bit version of '='
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
	push b		#Identifier
	pop %rdx		# Zero : False, non-zero : true
	cmpq $0, %rdx
	je False142
	movq $TrueString, %rdi		# "TRUE\n"
	jmp Next142
False142:
	movq $FalseString, %rdi		# "FALSE\n"
Next142:
	call	printf@PLT
	movq $0, %rax
	movb $'\n',%al
	push %rax	# push a 64-bit version of '\n'
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
	push true		#Identifier
	push false		#Identifier
	pop %rbx 		#procedure de AND
	pop %rax
	mulq	%rbx
	push %rax	# AND
	pop b
	movq $0, %rax
	movb $'b',%al
	push %rax	# push a 64-bit version of 'b'
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
	movq $0, %rax
	movb $'=',%al
	push %rax	# push a 64-bit version of '='
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
	push b		#Identifier
	pop %rdx		# Zero : False, non-zero : true
	cmpq $0, %rdx
	je False143
	movq $TrueString, %rdi		# "TRUE\n"
	jmp Next143
False143:
	movq $FalseString, %rdi		# "FALSE\n"
Next143:
	call	printf@PLT
	movq $0, %rax
	movb $'\n',%al
	push %rax	# push a 64-bit version of '\n'
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
	push false		#Identifier
	push false		#Identifier
	pop %rbx 		#procedure de AND
	pop %rax
	mulq	%rbx
	push %rax	# AND
	pop b
	movq $0, %rax
	movb $'b',%al
	push %rax	# push a 64-bit version of 'b'
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
	movq $0, %rax
	movb $'=',%al
	push %rax	# push a 64-bit version of '='
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
	push b		#Identifier
	pop %rdx		# Zero : False, non-zero : true
	cmpq $0, %rdx
	je False144
	movq $TrueString, %rdi		# "TRUE\n"
	jmp Next144
False144:
	movq $FalseString, %rdi		# "FALSE\n"
Next144:
	call	printf@PLT
	movq $0, %rax
	movb $'\n',%al
	push %rax	# push a 64-bit version of '\n'
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
	movq $0, %rax
	movb $'A',%al
	push %rax	# push a 64-bit version of 'A'
	pop c
	movq $0, %rax
	movb $'c',%al
	push %rax	# push a 64-bit version of 'c'
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
	movq $0, %rax
	movb $'=',%al
	push %rax	# push a 64-bit version of '='
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
	push c		#Identifier
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
	movq $0, %rax
	movb $'\n',%al
	push %rax	# push a 64-bit version of '\n'
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
	subq $8,%rsp			# allouer 8 octets sur le sommet de la pile pour DOUBLE
	movl	$1374389535, (%rsp)	# Conversion de 3.14 (partie haute de 32 bits)
	movl	$1074339512, 4(%rsp)	# Conversion de 3.14 (partie basse de 32 bits)
	pop double1
	movq $0, %rax
	movb $'d',%al
	push %rax	# push a 64-bit version of 'd'
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
	movq $0, %rax
	movb $'1',%al
	push %rax	# push a 64-bit version of '1'
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
	movq $0, %rax
	movb $'=',%al
	push %rax	# push a 64-bit version of '='
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
	push double1		#Identifier
	movsd	(%rsp), %xmm0		# &stack top -> %xmm0
	movsd %xmm0, (%rsp)
	pop %rsi		# Le double a afficher
	movq $FormatString2, %rdi		# "%lf\n"
	movq	$1, %rax		# DOUBLE
	call	printf@PLT
	movq $0, %rax
	movb $'\n',%al
	push %rax	# push a 64-bit version of '\n'
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
	subq $8,%rsp			# allouer 8 octets sur le sommet de la pile pour DOUBLE
	movl	$4123168604, (%rsp)	# Conversion de 10.93 (partie haute de 32 bits)
	movl	$1076223016, 4(%rsp)	# Conversion de 10.93 (partie basse de 32 bits)
	pop double2
	movq $0, %rax
	movb $'d',%al
	push %rax	# push a 64-bit version of 'd'
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
	movq $0, %rax
	movb $'2',%al
	push %rax	# push a 64-bit version of '2'
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
	movq $0, %rax
	movb $'=',%al
	push %rax	# push a 64-bit version of '='
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
	push double2		#Identifier
	movsd	(%rsp), %xmm0		# &stack top -> %xmm0
	movsd %xmm0, (%rsp)
	pop %rsi		# Le double a afficher
	movq $FormatString2, %rdi		# "%lf\n"
	movq	$1, %rax		# DOUBLE
	call	printf@PLT
	movq $0, %rax
	movb $'\n',%al
	push %rax	# push a 64-bit version of '\n'
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
	push double1		#Identifier
	push double2		#Identifier
	fldl	8(%rsp)		#procedure ADD DOUBLE
	fldl	(%rsp)	# first operand -> %st(0) ; second operand -> %st(1)
	faddp	%st(0),%st(1)	# %st(0) <- op1 + op2 ; %st(1)=null
	fstpl 8(%rsp)
	addq	$8, %rsp	# result on stack's top
	pop d
	movq $0, %rax
	movb $'d',%al
	push %rax	# push a 64-bit version of 'd'
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
	movq $0, %rax
	movb $'=',%al
	push %rax	# push a 64-bit version of '='
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
	push d		#Identifier
	movsd	(%rsp), %xmm0		# &stack top -> %xmm0
	movsd %xmm0, (%rsp)
	pop %rsi		# Le double a afficher
	movq $FormatString2, %rdi		# "%lf\n"
	movq	$1, %rax		# DOUBLE
	call	printf@PLT
	movq $0, %rax
	movb $'\n',%al
	push %rax	# push a 64-bit version of '\n'
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
	push double1		#Identifier
	push double2		#Identifier
	fldl	(%rsp)		#procedure SUB DOUBLE
	fldl	8(%rsp)	# first operand -> %st(0) ; second operand -> %st(1)
	fsubp	%st(0),%st(1)	# %st(0) <- op1 - op2 ; %st(1)=null
	fstpl 8(%rsp)
	addq	$8, %rsp	# result on stack's top
	pop d
	movq $0, %rax
	movb $'d',%al
	push %rax	# push a 64-bit version of 'd'
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
	movq $0, %rax
	movb $'=',%al
	push %rax	# push a 64-bit version of '='
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
	push d		#Identifier
	movsd	(%rsp), %xmm0		# &stack top -> %xmm0
	movsd %xmm0, (%rsp)
	pop %rsi		# Le double a afficher
	movq $FormatString2, %rdi		# "%lf\n"
	movq	$1, %rax		# DOUBLE
	call	printf@PLT
	movq $0, %rax
	movb $'\n',%al
	push %rax	# push a 64-bit version of '\n'
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
	push double2		#Identifier
	push double1		#Identifier
	fldl	(%rsp)		#procedure SUB DOUBLE
	fldl	8(%rsp)	# first operand -> %st(0) ; second operand -> %st(1)
	fsubp	%st(0),%st(1)	# %st(0) <- op1 - op2 ; %st(1)=null
	fstpl 8(%rsp)
	addq	$8, %rsp	# result on stack's top
	pop d
	movq $0, %rax
	movb $'d',%al
	push %rax	# push a 64-bit version of 'd'
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
	movq $0, %rax
	movb $'=',%al
	push %rax	# push a 64-bit version of '='
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
	push d		#Identifier
	movsd	(%rsp), %xmm0		# &stack top -> %xmm0
	movsd %xmm0, (%rsp)
	pop %rsi		# Le double a afficher
	movq $FormatString2, %rdi		# "%lf\n"
	movq	$1, %rax		# DOUBLE
	call	printf@PLT
	movq $0, %rax
	movb $'\n',%al
	push %rax	# push a 64-bit version of '\n'
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
	push double1		#Identifier
	push double2		#Identifier
	fldl	8(%rsp)		#procedure de MUL DOUBLE
	fldl	(%rsp)	# premier operande -> %st(0) ; deuxième operande -> %st(1)
	fmulp	%st(0),%st(1)	#%st(0) <- op1 + op2 ; %st(1)=null
	fstpl 8(%rsp)
	addq	$8, %rsp	# resultat au sommet de la pile
	pop d
	movq $0, %rax
	movb $'d',%al
	push %rax	# push a 64-bit version of 'd'
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
	movq $0, %rax
	movb $'=',%al
	push %rax	# push a 64-bit version of '='
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
	push d		#Identifier
	movsd	(%rsp), %xmm0		# &stack top -> %xmm0
	movsd %xmm0, (%rsp)
	pop %rsi		# Le double a afficher
	movq $FormatString2, %rdi		# "%lf\n"
	movq	$1, %rax		# DOUBLE
	call	printf@PLT
	movq $0, %rax
	movb $'\n',%al
	push %rax	# push a 64-bit version of '\n'
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
	push double1		#Identifier
	push double2		#Identifier
	fldl	(%rsp)			#procedure de DIV DOUBLE
	fldl	8(%rsp)	# premier operande -> %st(0) ; deuxième operande -> %st(1)
	fdivp	%st(0),%st(1)	#	%st(0) <- op1 + op2 ; %st(1)=null
	fstpl 8(%rsp)
	addq	$8, %rsp	# resultat au sommet de la pile
	pop d
	movq $0, %rax
	movb $'d',%al
	push %rax	# push a 64-bit version of 'd'
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
	movq $0, %rax
	movb $'=',%al
	push %rax	# push a 64-bit version of '='
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
	push d		#Identifier
	movsd	(%rsp), %xmm0		# &stack top -> %xmm0
	movsd %xmm0, (%rsp)
	pop %rsi		# Le double a afficher
	movq $FormatString2, %rdi		# "%lf\n"
	movq	$1, %rax		# DOUBLE
	call	printf@PLT
	movq $0, %rax
	movb $'\n',%al
	push %rax	# push a 64-bit version of '\n'
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
	push double1		#Identifier
	pop d
	push double1		#Identifier
	push double2		#Identifier
	fldl	(%rsp)	# charger le premier operande dans le registre %st(0)
	fldl	8(%rsp)	# charger le deuxieme operande dans le registre %st(1)
	 addq $16, %rsp	# depiler les deux operandes
	fcomip %st(1)		# comparer op1 et op2 DOUBLE
	faddp %st(1)
	ja Vrai152		# If above
	push $0		# False
	jmp Suite152
Vrai152:	push $0xFFFFFFFFFFFFFFFF		# True
Suite152:
	pop b
	movq $0, %rax
	movb $'b',%al
	push %rax	# push a 64-bit version of 'b'
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
	movq $0, %rax
	movb $'=',%al
	push %rax	# push a 64-bit version of '='
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
	push b		#Identifier
	pop %rdx		# Zero : False, non-zero : true
	cmpq $0, %rdx
	je False154
	movq $TrueString, %rdi		# "TRUE\n"
	jmp Next154
False154:
	movq $FalseString, %rdi		# "FALSE\n"
Next154:
	call	printf@PLT
	movq $0, %rax
	movb $'\n',%al
	push %rax	# push a 64-bit version of '\n'
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
	push double1		#Identifier
	push double2		#Identifier
	fldl	(%rsp)	# charger le premier operande dans le registre %st(0)
	fldl	8(%rsp)	# charger le deuxieme operande dans le registre %st(1)
	 addq $16, %rsp	# depiler les deux operandes
	fcomip %st(1)		# comparer op1 et op2 DOUBLE
	faddp %st(1)
	jae Vrai154		# If above or equal
	push $0		# False
	jmp Suite154
Vrai154:	push $0xFFFFFFFFFFFFFFFF		# True
Suite154:
	pop b
	movq $0, %rax
	movb $'b',%al
	push %rax	# push a 64-bit version of 'b'
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
	movq $0, %rax
	movb $'=',%al
	push %rax	# push a 64-bit version of '='
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
	push b		#Identifier
	pop %rdx		# Zero : False, non-zero : true
	cmpq $0, %rdx
	je False156
	movq $TrueString, %rdi		# "TRUE\n"
	jmp Next156
False156:
	movq $FalseString, %rdi		# "FALSE\n"
Next156:
	call	printf@PLT
	movq $0, %rax
	movb $'\n',%al
	push %rax	# push a 64-bit version of '\n'
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
	push double1		#Identifier
	subq $8,%rsp			# allouer 8 octets sur le sommet de la pile pour DOUBLE
	movl	$0, (%rsp)	# Conversion de 10 (partie haute de 32 bits)
	movl	$1076101120, 4(%rsp)	# Conversion de 10 (partie basse de 32 bits)
	fldl	(%rsp)	# charger le premier operande dans le registre %st(0)
	fldl	8(%rsp)	# charger le deuxieme operande dans le registre %st(1)
	 addq $16, %rsp	# depiler les deux operandes
	fcomip %st(1)		# comparer op1 et op2 DOUBLE
	faddp %st(1)
	jae Vrai156		# If above or equal
	push $0		# False
	jmp Suite156
Vrai156:	push $0xFFFFFFFFFFFFFFFF		# True
Suite156:
	pop b
	movq $0, %rax
	movb $'b',%al
	push %rax	# push a 64-bit version of 'b'
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
	movq $0, %rax
	movb $'=',%al
	push %rax	# push a 64-bit version of '='
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
	push b		#Identifier
	pop %rdx		# Zero : False, non-zero : true
	cmpq $0, %rdx
	je False158
	movq $TrueString, %rdi		# "TRUE\n"
	jmp Next158
False158:
	movq $FalseString, %rdi		# "FALSE\n"
Next158:
	call	printf@PLT
	movq $0, %rax
	movb $'\n',%al
	push %rax	# push a 64-bit version of '\n'
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
	push double1		#Identifier
	push double2		#Identifier
	fldl	(%rsp)	# charger le premier operande dans le registre %st(0)
	fldl	8(%rsp)	# charger le deuxieme operande dans le registre %st(1)
	 addq $16, %rsp	# depiler les deux operandes
	fcomip %st(1)		# comparer op1 et op2 DOUBLE
	faddp %st(1)
	jb Vrai158		# If below
	push $0		# False
	jmp Suite158
Vrai158:	push $0xFFFFFFFFFFFFFFFF		# True
Suite158:
	pop b
	movq $0, %rax
	movb $'b',%al
	push %rax	# push a 64-bit version of 'b'
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
	movq $0, %rax
	movb $'=',%al
	push %rax	# push a 64-bit version of '='
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
	push b		#Identifier
	pop %rdx		# Zero : False, non-zero : true
	cmpq $0, %rdx
	je False160
	movq $TrueString, %rdi		# "TRUE\n"
	jmp Next160
False160:
	movq $FalseString, %rdi		# "FALSE\n"
Next160:
	call	printf@PLT
	movq $0, %rax
	movb $'\n',%al
	push %rax	# push a 64-bit version of '\n'
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
	push double1		#Identifier
	push double2		#Identifier
	fldl	(%rsp)	# charger le premier operande dans le registre %st(0)
	fldl	8(%rsp)	# charger le deuxieme operande dans le registre %st(1)
	 addq $16, %rsp	# depiler les deux operandes
	fcomip %st(1)		# comparer op1 et op2 DOUBLE
	faddp %st(1)
	jbe Vrai160		# If below or equal
	push $0		# False
	jmp Suite160
Vrai160:	push $0xFFFFFFFFFFFFFFFF		# True
Suite160:
	pop b
	movq $0, %rax
	movb $'b',%al
	push %rax	# push a 64-bit version of 'b'
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
	movq $0, %rax
	movb $'=',%al
	push %rax	# push a 64-bit version of '='
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
	push b		#Identifier
	pop %rdx		# Zero : False, non-zero : true
	cmpq $0, %rdx
	je False162
	movq $TrueString, %rdi		# "TRUE\n"
	jmp Next162
False162:
	movq $FalseString, %rdi		# "FALSE\n"
Next162:
	call	printf@PLT
	movq $0, %rax
	movb $'\n',%al
	push %rax	# push a 64-bit version of '\n'
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
	push double1		#Identifier
	subq $8,%rsp			# allouer 8 octets sur le sommet de la pile pour DOUBLE
	movl	$0, (%rsp)	# Conversion de 10 (partie haute de 32 bits)
	movl	$1076101120, 4(%rsp)	# Conversion de 10 (partie basse de 32 bits)
	fldl	(%rsp)	# charger le premier operande dans le registre %st(0)
	fldl	8(%rsp)	# charger le deuxieme operande dans le registre %st(1)
	 addq $16, %rsp	# depiler les deux operandes
	fcomip %st(1)		# comparer op1 et op2 DOUBLE
	faddp %st(1)
	jbe Vrai162		# If below or equal
	push $0		# False
	jmp Suite162
Vrai162:	push $0xFFFFFFFFFFFFFFFF		# True
Suite162:
	pop b
	movq $0, %rax
	movb $'b',%al
	push %rax	# push a 64-bit version of 'b'
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
	movq $0, %rax
	movb $'=',%al
	push %rax	# push a 64-bit version of '='
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
	push b		#Identifier
	pop %rdx		# Zero : False, non-zero : true
	cmpq $0, %rdx
	je False164
	movq $TrueString, %rdi		# "TRUE\n"
	jmp Next164
False164:
	movq $FalseString, %rdi		# "FALSE\n"
Next164:
	call	printf@PLT
	movq $0, %rax
	movb $'\n',%al
	push %rax	# push a 64-bit version of '\n'
	pop %rsi		# Le char a afficher
	movq $FormatString3, %rdi	# "%c\n"
	movl	$0, %eax
	call printf@PLT
FinBegin113:
	popq %rbp		# Restore the position of the stack's top
	ret			# Return from main function
	.cfi_endproc
