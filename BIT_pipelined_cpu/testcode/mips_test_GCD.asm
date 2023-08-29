    # ��ʼ���Ĵ���
    ADDIU    $t0, $zero, 35   # �������� 6 �洢���Ĵ��� $t0
    ADDIU    $t1, $zero, 14  # �������� 15 �洢���Ĵ��� $t1

loop:
    BEQ     $t0, $t1, done  # ��� A == B����ת�� done
    
    # ��� A != B��ִ�������ָ��
    SLTU     $t2, $t0, $t1   # $t2 = (A < B) ? 1 : 0
    BEQ     $t2, $zero, greater # ��� $t2 == 0��A > B����ת�� greater
    
    # ��� A < B��ִ�������ָ��
    # ���� A �� B ��ֵ
    ADDU    $t3, $zero, $t0  # $t3 = A
    ADDU    $t0, $zero, $t1  # $t0 = B
    ADDU    $t1, $zero, $t3  # $t1 = A
    
greater:
    SUBU    $t0, $t0, $t1    # $t0 = $t0 - $t1
    J       loop
    
done:
    # ���Լ����������� $t0 ��
