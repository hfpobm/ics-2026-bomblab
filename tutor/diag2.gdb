set pagination off
set confirm off
break *phase_00
break *0x4014e2
break *0x4014ac
run --seed 42 --phase 0 < phase0-answer.txt
echo \n=== 当前停点 ===\n
x/i $pc
echo \n=== continue 一次，看命中的是哪个断点 ===\n
continue
x/i $pc
echo \n=== 再 continue 一次 ===\n
continue
x/i $pc
