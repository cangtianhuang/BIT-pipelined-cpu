# 初始化寄存器 t0 为 N
    addi $t0, $zero, 32
    lw  $t0, 4($t0)
    
    # 初始化前两项斐波那契数值
    addi $t1, $zero, 0    # F(0) = 0
    addi $t2, $zero, 1    # F(1) = 1
    
    # 循环计算斐波那契数列第 N 项值
loop:
    beq $t0, $zero, done   # 若 N == 0，则结束循环
    add $t3, $t1, $t2      # $t3 = F(N-1) + F(N-2)
    addi $t1, $t2, 0       # $t1 = F(N-2)
    addi $t2, $t3, 0       # $t2 = F(N-1)
    addi $t0, $t0, -1      # N = N - 1
    j loop

# 输出结果
done:
    nop
    # 此时 $t2 中保存了斐波那契数列第 N 项值