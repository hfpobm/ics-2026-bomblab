set pagination off
set confirm off
break *phase_00
run --seed 42 --phase 0 < phase0-answer.txt

echo \n===== [1] phase_00 入口 =====\n
x/s $rdi
p/x $rsi
set $challenge = $rsi

echo \n===== [2] 从 challenge 推出两个数 =====\n
set $first  = (($challenge >> 5) & 255) ^ 42
set $second = 3 * $first + 7
echo first  = 
p/u $first
echo second = 
p/u $second

echo \n===== [3] 官方示例答案文件 =====\n
shell cat phase0-answer.txt

echo \n===== [4] 断在 call tutorial_mix 之前 =====\n
delete breakpoints
break *0x4014ff
run --seed 42 --phase 0 < phase0-answer.txt
x/i $pc
echo edi(tutorial_mix 参数) = 
p/u $edi
echo 我们算的 first         = 
p/u $first

echo \n===== [5] si 进入 tutorial_mix：逐条看 eax =====\n
si
x/i $pc
echo eax 此刻 = 
p/u $eax
ni
x/i $pc
echo eax 此刻 = 
p/u $eax
ni
x/i $pc
echo eax 此刻 = 
p/u $eax

echo \n===== [6] 对照 =====\n
echo 我们算的 second = 
p/u $second

echo \n===== [7] 跑完 =====\n
continue
