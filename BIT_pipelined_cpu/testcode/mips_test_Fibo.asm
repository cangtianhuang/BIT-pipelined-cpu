# ��ʼ���Ĵ��� t0 Ϊ N
    addi $t0, $zero, 32
    lw  $t0, 4($t0)
    
    # ��ʼ��ǰ����쳲�������ֵ
    addi $t1, $zero, 0    # F(0) = 0
    addi $t2, $zero, 1    # F(1) = 1
    
    # ѭ������쳲��������е� N ��ֵ
loop:
    beq $t0, $zero, done   # �� N == 0�������ѭ��
    add $t3, $t1, $t2      # $t3 = F(N-1) + F(N-2)
    addi $t1, $t2, 0       # $t1 = F(N-2)
    addi $t2, $t3, 0       # $t2 = F(N-1)
    addi $t0, $t0, -1      # N = N - 1
    j loop

# ������
done:
    nop
    # ��ʱ $t2 �б�����쳲��������е� N ��ֵ