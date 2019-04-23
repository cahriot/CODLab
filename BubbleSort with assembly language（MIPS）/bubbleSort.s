.data
    sortarray:
        .space 40
    separate:
        .asciiz " "
    line:
        .asciiz "\n"

.text
.globl main

main:
    li $v0, 30
    syscall
    
    move $t9, $a0
    
    la $t0, sortarray          #������ʼ��ַ
    add $t1, $zero, $t0         #ָ��������ʼ��ַ
    addi $t8, $t0, 40            #������ֹ��ַ

    addi $t3, $zero, 0           #���������
    inputData:
        li $v0, 5              #������������/read_int
        syscall
        sw $v0, 0($t1)         #��������

        addi $t1, $t1, 4     #ָ��������һ����ַ
        addi $t3, $t3, 1     #�����������1
        slti $s0, $t3, 10        #������С��10����������
        bnez $s0, inputData

        addi $t3, $zero, 0       #���ѭ��������i = 0
    outLoop:
        add $t1, $zero, $t0		#ÿ�ν�������ѭ������$t1ָ��������ʼ��ַ
        slti $s0, $t3, 10       #i < 10�������ڲ�ѭ��
        beqz $s0, print            #i > 10, �˳�ѭ������ӡ����������

        addi $t4, $t3, -1       #j = i - 1
    inLoop:
        slti $s0, $t4, 0        #j < 0���˳��ڲ�ѭ��
        bnez $s0, exitInLoop

        sll $t5, $t4, 2         #$t5 = j * 4
        add $t5, $t1, $t5		#$t5 = ������ʼ��ַ + j * 4
        lw $t6, 0($t5)            #$t6 = a[j]
        lw $t7, 4($t5)            #$t7 = a[j + 1]
        slt $s0, $t6, $t7      #a[j] < a[j + 1]������
        bnez $s0, swap
        addi $t4, $t4, -1       #j--
        j inLoop                #�����ڲ�ѭ��

    swap:
        sw $t6, 4($t5)            #$t6 = a[j + 1]
        sw $t7, 0($t5)            #$t7 = a[j]
        addi $t4, $t4, -1       #j--
        j inLoop                #�����ڲ�ѭ��

    exitInLoop:
        addi $t3, $t3, 1        #i++
        j outLoop               #�������ѭ��

    print:
        lw $a0, 0($t0)            #Ҫ��ӡ�����ݴ浽$a0
        li $v0, 1              #ϵͳ����/print_int
        syscall

        la $a0, separate       #��ӡ�ո�
        li $v0, 4              #ϵͳ����/print_string
        syscall

        addi $t0, $t0, 4        #�������һ����ַ
        bne $t0, $t8, print     #��������ֹ��ַǰ������ӡ

        la $a0, line           #�����ӡ�����
        li $v0, 4              #ϵͳ����/print_string
        syscall

        j exit                  #�˳�����

    exit:
    	li $v0, 30
    	syscall
    	
    	move $t0, $a0
    	
    	sub $t1, $t0, $t9

    	#print time taken
    	li $v0, 1
   	move $a0, $t1
    	syscall
    	
        li $v0, 10             #ϵͳ����/�˳�����
        syscall
