addi $s5,$zero,5
sw $s5,($zero)
addi $s5,$zero,3
sw $s5,4($zero)
addi $s5,$zero,4
sw $s5,8($zero)
addi $s5,$zero,1
sw $s5,0xc($zero)

addi $k0,$zero,0
addi $t5,$zero,10
loop:
addi $a0,$zero,0
addi  $a1,$a0,4
cmp_loop:
lw $t0,($a0)
lw $t1,($a1)
ble $t1,$t0,swap
addi $a0,$a0,4
addi  $a1,$a1,4
addi $k0,$k0,1
ble $k0,$t5,cmp_loop
j end

swap:
sw $t0,($a1)
sw $t1,($a0)
j loop

end:
lw $t0,($zero)
lw $t0,4($zero)
lw $t0,8($zero)
lw $t0,0xc($zero)

