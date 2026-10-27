
./bomb:     file format elf64-x86-64


Disassembly of section .init:

Disassembly of section .plt:

Disassembly of section .plt.sec:

Disassembly of section .text:

00000000004020f0 <phase_02>:
  4020f0:	endbr64
  4020f4:	push   %rbp
  4020f5:	mov    %rsp,%rbp
  4020f8:	push   %r13
  4020fa:	mov    %rsi,%r13
  4020fd:	mov    $0x6,%esi
  402102:	push   %r12
  402104:	mov    %rdi,%r12
  402107:	push   %rbx
  402108:	sub    $0x28,%rsp
  //生成栈帧   -(0x28)-(0x18)(%rbp)
  40210c:	call   402c80 <valid_u32_fields>
  402111:	test   %al,%al
  402113:	jne    402128 <phase_02+0x38>
  //函数失败退出
  402115:	xor    %ebx,%ebx
  //boom
  402117:	lea    -0x18(%rbp),%rsp
  //安全出口
  40211b:	mov    %ebx,%eax
  40211d:	pop    %rbx
  40211e:	pop    %r12
  402120:	pop    %r13
  402122:	pop    %rbp
  402123:	ret
  402124:	nopl   0x0(%rax)
  //合法性检验
  402128:	mov    %eax,%ebx
  40212a:	lea    -0x2c(%rbp),%rax
  40212e:	lea    -0x3c(%rbp),%rcx
  402132:	mov    $0x40317a,%esi
  402137:	push   %rax
  402138:	lea    -0x30(%rbp),%rax
  40213c:	lea    -0x40(%rbp),%rdx
  402140:	mov    %r12,%rdi
  402143:	push   %rax
  402144:	lea    -0x34(%rbp),%r9
  402148:	lea    -0x38(%rbp),%r8
  40214c:	xor    %eax,%eax
  40214e:	call   4011e0 <__isoc99_sscanf@plt>
  402153:	pop    %rdx
  402154:	pop    %rcx
  402155:	cmp    $0x6,%eax
  402158:	jne    402115 <phase_02+0x25>
  //是否有合法的6个口令 没有就直接跳转退出 有的话接着进行计算

  算法开始 初始化


  40215a:	mov    %r13,%rax
  //rax = cha
  40215d:	mov    -0x40(%rbp),%esi
  //rsi = M[rbp - 0x40](32)
  402160:	shr    $0x18,%rax
  //rax = cha>>24
  402164:	and    $0x7f,%eax
  //rax = (0x7f&(cha>>24)) (32)
  402167:	lea    (%rax,%rax,2),%eax
  //rax = 3*(0x7f&(cha>>24)) (32)
  40216a:	cmp    %eax,%esi
  40216c:	jne    402115 <phase_02+0x25>
  //if rax != rsi return as  3*(0x7f&(cha>>24)) (32) != M[rbp - 0x40](32)
  40216e:	xor    %edx,%edx
  //rdx = 0 (32)
  402170:	mov    $0x3,%edi
  //rdi = 0x3 (32)

  while()
  402175:	lea    0xf(%rdx),%ecx
  //rcx = 0xf + 4(n-1)(32)
  402178:	mov    %r13,%rax
  //rax = cha
  40217b:	shr    %cl,%rax
  //rax = cha >> 15
  40217e:	lea    (%rsi,%rsi,4),%ecx
  //rcx = 5*M[rbp+rdx-0x3c] (32)
  402181:	mov    -0x3c(%rbp,%rdx,1),%esi
  //rsi = M[rbp+rdx-0x3c] (32)
  402185:	and    $0xf,%eax
  //rax = (cha >> 15)&0xf  (32)
  402188:	xor    %edi,%eax
  //rax =  0x3^((cha >> 15)&0xf)  (32)
  40218a:	add    %ecx,%eax
  //rax = 0x3^((cha >> 15)&0xf) (32) + 5*M[rbp+rdx-0x3c] (32)
  40218c:	cmp    %eax,%esi
  40218e:	jne    402115 <phase_02+0x25>
  //if rsi != rax return as M[rbp+rdx-0x3c] ！= 0x3^((cha >> 15)&0xf) (32) + 5*(rbp - 0x40) (32)
  402190:	add    $0x4,%rdx
  //rdx = rdx + 0x4
  402194:	add    $0x1,%edi
  //rdi = rdi+0x1(32)
  402197:	cmp    $0x14,%rdx
  40219b:	jne    402175 <phase_02+0x85>
  //if rdx != 0x14 开始循环

  
  40219d:	jmp    402117 <phase_02+0x27>
  //循环结束

Disassembly of section .fini:
 405820 78224000 00000000 80224000 00000000  x"@......"@.....
 405830 88224000 00000000 90224000 00000000  ."@......"@.....
 405840 98224000 00000000 a0224000 00000000  ."@......"@.....
 405850 68224000 00000000 70224000 00000000  h"@.....p"@.....
 405860 55524745 4e542041 49204e4f 54494345  URGENT AI NOTICE
