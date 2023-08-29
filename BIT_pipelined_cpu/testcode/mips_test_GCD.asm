    # 初始化寄存器
    ADDIU    $t0, $zero, 35   # 将立即数 6 存储到寄存器 $t0
    ADDIU    $t1, $zero, 14  # 将立即数 15 存储到寄存器 $t1

loop:
    BEQ     $t0, $t1, done  # 如果 A == B，跳转到 done
    
    # 如果 A != B，执行下面的指令
    SLTU     $t2, $t0, $t1   # $t2 = (A < B) ? 1 : 0
    BEQ     $t2, $zero, greater # 如果 $t2 == 0，A > B，跳转到 greater
    
    # 如果 A < B，执行下面的指令
    # 交换 A 和 B 的值
    ADDU    $t3, $zero, $t0  # $t3 = A
    ADDU    $t0, $zero, $t1  # $t0 = B
    ADDU    $t1, $zero, $t3  # $t1 = A
    
greater:
    SUBU    $t0, $t0, $t1    # $t0 = $t0 - $t1
    J       loop
    
done:
    # 最大公约数结果保存在 $t0 中
