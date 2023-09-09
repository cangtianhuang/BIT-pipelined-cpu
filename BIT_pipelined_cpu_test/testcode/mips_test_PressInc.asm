
    addi $t0, $zero, 0            # $t0 = 0
    addi $t1, $zero, 0            # $t1 = 0
    sw $t1, 4       # �洢 $t1 ��ֵ�� result

loop:
    lw $t2, 0      # �� signal1 �������ݵ� $t2
    beq $t2, $zero, reset_t0   # ��� $t2 == 0������ת�� reset_t0 ��ǩ

    # ��� $t0 != 0���������´����
    bne $t0, $zero, skip

    # $t0 == 0 ʱִ�����´���
    addi $t0, $zero, 1            # $t0 = 1
    addi $t1, $t1, 1    # $t1++
    sw $t1, 4       # �洢 $t1 ��ֵ�� result

skip:
    j loop

reset_t0:
    addi $t0, $zero, 0            # $t0 = 0
    j loop
    nop
