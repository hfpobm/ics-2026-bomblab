set pagination off
set confirm off
break *phase_00
run --seed 42 --phase 0 < phase0-answer.txt

echo \n########## 停点0: 函数入口 ##########\n
x/i $pc
echo --- 参数1 rdi (输入字符串) ---
x/s $rdi
echo --- 参数2 rsi (challenge) ---
p/x $rsi
set $challenge = $rsi

echo \n########## 停点1: call valid_u32_fields 之前 ##########\n
break *0x4014a7
continue
x/i $pc
echo --- rdi ---
x/s $rdi
echo --- esi: 要求几个字段 ---
p/d $esi

echo \n########## 停点2: call sscanf 之前 ##########\n
break *0x4014e2
continue
x/i $pc
echo --- rdi (str) ---
x/s $rdi
echo --- rsi (format) ---
x/s $rsi
echo --- rdx (第1个输出地址) ---
p/x $rdx
echo --- rcx (第2个输出地址) ---
p/x $rcx
set $slot1 = $rdx
set $slot2 = $rcx

echo \n########## 停点3: cmp (第1个数检查) 之前 ##########\n
break *0x4014fa
continue
x/i $pc
echo --- 程序算出的第1个数 (edi) ---
p/u $edi
echo --- 我的公式独立算一遍 ---
p/u (($challenge >> 5) & 255) ^ 42
echo --- 输入的第1个数 (内存) ---
x/1uw $slot1
echo --- 栈偏移核对: slot1 - rbp 应为 -0x20 (= -32) ---
p/d (long)$slot1 - (long)$rbp
echo --- 栈上的整数: 每个占 4 字节 ---
x/2uw $slot1
echo --- 金丝雀在 -0x18(%rbp) ---
p/x *(unsigned long *)((long)$rbp - 0x18)

echo \n########## 停点4: call tutorial_mix 之前 ##########\n
break *0x4014ff
continue
x/i $pc
echo --- tutorial_mix 的参数 (edi) ---
p/u $edi
set $first = $edi

echo \n########## 停点5: 第二个 cmp 之前 ##########\n
break *0x401504
continue
x/i $pc
echo --- tutorial_mix 返回值 (eax) ---
p/u $eax
echo --- 我的公式 3*first+7 ---
p/u 3 * $first + 7
echo --- 输入的第2个数 (内存) ---
x/1uw $slot2

echo \n########## 跑完 ##########\n
continue
