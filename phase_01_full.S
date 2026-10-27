
0000000000402090 <phase_01>:
  402090:	endbr64
  402094:	push   %rbp
  402095:	mov    %rsp,%rbp
  402098:	push   %r12
  40209a:	mov    %rsi,%r12
  40209d:	mov    $0x1,%esi
  4020a2:	push   %rbx
  4020a3:	mov    %rdi,%rbx
  4020a6:	sub    $0x10,%rsp

  //栈帧 -16-8-8(%rdp)
  // call 1
  4020aa:	call   402c80 <valid_u32_fields>
  4020af:	test   %al,%al
  4020b1:	jne    4020c0 <phase_01+0x30>
  //如果合法则跳转进入call 2 如果不合法直接返回错误值
  4020b3:	add    $0x10,%rsp
  4020b7:	xor    %eax,%eax
  4020b9:	pop    %rbx
  4020ba:	pop    %r12
  4020bc:	pop    %rbp
  4020bd:	ret
  4020be:	xchg   %ax,%ax
  //dest from valid_u32_fields
  4020c0:	xor    %eax,%eax
  4020c2:	lea    -0x14(%rbp),%rdx
  //第三个传入参数 rdx
  4020c6:	mov    $0x403189,%esi
  //第二个参数 rsi的小部取一个常量
  4020cb:	mov    %rbx,%rdi
  //第一个参数 原始的rdi重新传入rdi
  //call 2
  4020ce:	call   4011e0 <__isoc99_sscanf@plt>
  4020d3:	cmp    $0x1,%eax
  4020d6:	jne    4020b3 <phase_01+0x23>
  //eax和1相等就进行下一步 不相等跳转返回返回错误值
  4020d8:	mov    %r12,%rdi
  //原初的第二个参数重置
  //call 3
  4020db:	call   402050 <p1_compute>
  4020e0:	cmp    %eax,-0x14(%rbp)
  //rbp为口令 一个int四个字节 
  //为1则返回LSB为1 不为1则设为0 
  4020e3:	sete   %al
  //清除栈帧
  4020e6:	add    $0x10,%rsp
  4020ea:	pop    %rbx
  4020eb:	pop    %r12
  4020ed:	pop    %rbp
  4020ee:	ret

Disassembly of section .fini:

./bomb:     file format elf64-x86-64


Disassembly of section .init:

Disassembly of section .plt:

Disassembly of section .plt.sec:

Disassembly of section .text:

0000000000402050 <p1_compute>:
  402050:	endbr64
  402054:	push   %rbp
  //start
  402055:	mov    %rdi,%rdx
  402058:	mov    %rdi,%rax
  40205b:	shr    $0x20,%rax
  40205f:	mov    %rdx,%rsi
  402062:	mov    %eax,%edi
  402064:	shr    $0x10,%rsi
  402068:	mov    %rsp,%rbp
  //call 1  rdi =  cha>>32 rsi = cha>>16; rax(re1) = (cha>>16+0xaaa4)^(cha>>32)(32);
  40206b:	call   402030 <p1_step1>
  402070:	mov    %edi,%esi
  402072:	mov    %edx,%edi
  402074:	mov    %eax,%ecx
  /call 2 rdi =  cha(32);rsi = cha>>32; rax(re2) = (3(cha(32)-cha>>32)+0x1ee5)(32);
  402076:	call   402020 <p1_step0>
  40207b:	mov    %ecx,%esi
  40207d:	mov    %eax,%edi
  /call 3 rdi  =   re2(32)  rsi =   re1(32)  rax = (re1(32)^0x19a+8re2(32))32
  40207f:	call   402040 <p1_step2>
  //end
  402084:	pop    %rbp
  402085:	ret


0000000000402030 <p1_step1>:
  402030:	endbr64
  402034:	lea    0xaaa4(%rsi),%eax
  40203a:	xor    %edi,%eax
  40203c:	ret

0000000000402020 <p1_step0>:
  402020:	endbr64
  402024:	sub    %esi,%edi
  //edi = edi - esi = cha(32) - cha>>32;
  402026:	lea    0x1ee5(%rdi,%rdi,2),%eax
  //rax = (3(cha(32)-cha>>32)+0x1ee5)(32)
  40202d:	ret

0000000000402040 <p1_step2>:
  402040:	endbr64
  402044:	xor    $0x19a,%esi
  //rsi = rsi^0x19a(32) = re1(32)^0x19a
  40204a:	lea    (%rsi,%rdi,8),%eax
  //rax = (re1(32)^0x19a+8re2(32))32
  40204d:	ret

