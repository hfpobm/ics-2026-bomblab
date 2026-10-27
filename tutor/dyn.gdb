set pagination off
set confirm off

echo \n############ 准备：设好所有关键断点 ############\n
break *phase_00
break *0x4014a7
break *0x4014e2
break *0x4014ff
break *0x4014fa
break *0x401504

echo \n############ 入口：拿参数 ############\n
run --seed 42 --phase 0 < phase0-answer.txt
x/i $pc
echo --- rdi (第1个参数) ---
x/s $rdi
echo --- rsi (第2个参数 = challenge) ---
p/x $rsi
set $challenge = $rsi

echo \n############ 停点1: 0x4014a7 call valid_u32_fields 之前 ############\n
continue
x/i $pc
echo rdi = 输入字符串:
x/s $rdi
echo esi = 要求几个字段?  (rsi 的低32位)
p/d $esi

echo \n############ 跨过这次调用，看返回值 ############\n
finish
echo eax = valid_u32_fields 的返回值:
p/d $eax

echo \n############ 停点2: 0x4014e2 call sscanf 之前 ############\n
continue
x/i $pc
echo --- sscanf 的 4 个参数 ---
echo rdi (str)    :
x/s $rdi
echo rsi (format) :
x/s $rsi
echo rdx (slot1)  :
p/x $rdx
echo rcx (slot2)  :
p/x $rcx
set $slot1 = $rdx
set $slot2 = $rcx

echo \n############ 跨过 sscanf，看它写了什么 ############\n
finish
echo eax = sscanf 返回值(读了几个数):
p/d $eax
echo slot1 里的值:
x/1uw $slot1
echo slot2 里的值:
x/1uw $slot2

echo \n############ 停点3: 0x4014fa cmp 之前（算法已算完）############\n
continue
x/i $pc
echo --- 程序算出的第1个数 (edi) ---
p/u $edi
echo --- 我的公式独立算一遍 ---
p/u (($challenge >> 5) & 255) ^ 42
echo --- 输入的第1个数 (内存) ---
x/1uw $slot1

echo \n############ 停点4: 0x4014ff call tutorial_mix 之前 ############\n
continue
x/i $pc
echo --- tutorial_mix 的参数 ---
p/u $edi
set $first = $edi

echo \n############ 跨过 tutorial_mix，看返回值 ############\n
finish
echo eax = tutorial_mix 的返回值:
p/u $eax

echo \n############ 停点5: 0x401504 cmp 之前 ############\n
continue
x/i $pc
echo --- 期望的第2个数 (我从公式算) ---
p/u 3 * $first + 7
echo --- 输入的第2个数 (内存) ---
x/1uw $slot2

echo \n############ 跑完 ############\n
continue
