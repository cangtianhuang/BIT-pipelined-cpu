
    addi $t0, $zero, 0            # $t0 = 0
    addi $t1, $zero, 0            # $t1 = 0
    sw $t1, 4       # 存储 $t1 的值到 result

loop:
    lw $t2, 0      # 从 signal1 加载数据到 $t2
    beq $t2, $zero, reset_t0   # 如果 $t2 == 0，则跳转到 reset_t0 标签

    # 如果 $t0 != 0，跳过以下代码块
    bne $t0, $zero, skip

    # $t0 == 0 时执行以下代码
    addi $t0, $zero, 1            # $t0 = 1
    addi $t1, $t1, 1    # $t1++
    sw $t1, 4       # 存储 $t1 的值回 result

skip:
    j loop

reset_t0:
    addi $t0, $zero, 0            # $t0 = 0
    j loop
    nop
