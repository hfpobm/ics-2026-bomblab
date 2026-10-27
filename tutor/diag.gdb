set pagination off
set confirm off
break *phase_00
run --seed 42 --phase 0 < phase0-answer.txt

echo \n=== 精确跟踪 valid_u32_fields 的返回 ===\n
break *valid_u32_fields
break *0x4014ac
continue

echo \n--- 进入 valid_u32_fields ---\n
p/x $rdi
p/d $rsi
finish

echo \n--- finish 之后停在哪? ---\n
x/i $pc
p/d $eax
echo --- 再看 al 和标志位判断 ---
p/d $al
x/i $pc
