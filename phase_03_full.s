
00000000004022b0 <phase_03>:
  4022b0:	endbr64
  4022b4:	push   %rbp
  4022b5:	mov    %rsp,%rbp
  4022b8:	push   %r12
  4022ba:	mov    %rsi,%r12
  4022bd:	mov    $0x2,%esi
  4022c2:	push   %rbx
  4022c3:	mov    %rdi,%rbx
  4022c6:	sub    $0x10,%rsp
  //栈帧 -0x10-0x10(%rbp)
  4022ca:	call   402c80 <valid_u32_fields>
  4022cf:	test   %al,%al
  4022d1:	jne    4022e0 <phase_03+0x30>
  4022d3:	xor    %eax,%eax
  4022d5:	add    $0x10,%rsp
  4022d9:	pop    %rbx
  4022da:	pop    %r12
  4022dc:	pop    %rbp
  4022dd:	ret
  4022de:	xchg   %ax,%ax
  //数据判断合格入口
  4022e0:	xor    %eax,%eax
  4022e2:	lea    -0x14(%rbp),%rcx
  4022e6:	lea    -0x18(%rbp),%rdx
  4022ea:	mov    $0x403186,%esi
  4022ef:	mov    %rbx,%rdi
  4022f2:	call   4011e0 <__isoc99_sscanf@plt>
  4022f7:	cmp    $0x2,%eax
  4022fa:	jne    4022d3 <phase_03+0x23>
  //没有2个输入值就 错误返回
  4022fc:	mov    %r12d,%edi
  //rdi = cha(32)
  4022ff:	xor    %eax,%eax
  //rax = 0
  402301:	and    $0x7,%edi
  //rdi = cha(32) & 0x7
  402304:	cmp    %edi,-0x18(%rbp)
  402307:	jne    4022d5 <phase_03+0x25>
  //if M[rbp-0x18] != rdi return with error as M[rbp-0x18] = (cha(32) & 0x7)
  402309:	mov    %r12,%rax
  //rax = cha
  40230c:	mov    %r12,%rsi
  //rsi = cha
  40230f:	shr    $0x3,%rax
  //rax = cha >> 0x3
  402313:	shr    $0x20,%rsi
  //rsi = cha >> 0x20
  402317:	xor    %eax,%esi
  //rsi = (cha >> 0x20) ^ (cha>>0x3)(32)
  //rdi =   cha(32) & 0x7 ;  rsi = (cha >> 0x20) ^ (cha>>0x3)(32)
  402319:	call   402250 <p3_dispatch>
  40231e:	cmp    %eax,-0x14(%rbp)
  402321:	sete   %al
  402324:	jmp    4022d5 <phase_03+0x25>
  //if M[rbp-0x14] == %rax return else return with error as values[1] = rax


0000000000402250 <p3_dispatch>:
  402250:	endbr64
  402254:	mov    %edi,%eax
  //rax = rdi(32)
  402256:	mov    %esi,%edi
  //rdi = rsi(32)
  402258:	cmp    $0x7,%eax
  40225b:	ja     4022a5 <p3_dispatch+0x55>
  //if rax > 0x7 return rax = 0 rdi(32) > 0x7
  40225d:	notrack jmp *0x405820(,%rax,8)
  //jmp to jt 查阅jump table 可得跳转位置
  402265:	nopl   (%rax)
    402268:	jmp    4021b0 <p3_case_0>
  //rax = (4*rdi)^0xdf2b (32)
  40226d:	nopl   (%rax)
    402270:	jmp    4021f0 <p3_case_2>
  //rax =(5rdi+0x33d0b) (32)
  402275:	nopl   (%rax)
    402278:	jmp    402230 <p3_case_6>
  //rax = (5rdi + 0xbe95) (32)
  40227a:	nopw   0x0(%rax,%rax,1)
    402280:	jmp    402210 <p3_case_4>
  //rax = (5rdi + 0x365ce) (32) 
  402282:	nopw   0x0(%rax,%rax,1)
    402288:	jmp    402240 <p3_case_7>
  //rax = (2rdi)^0x6621 (32)
  40228a:	nopw   0x0(%rax,%rax,1)
    402290:	jmp    402200 <p3_case_3>
  //rax = 3rdi+0x1d1 (32)
  402295:	nopl   (%rax)
    402298:	jmp    402220 <p3_case_5>
  40229a:	nopw   0x0(%rax,%rax,1)
  // rax = (rdi ^ 0xb3c (32)) + (rdi(32) >> 1)
    4022a0:	jmp    4021d0 <p3_case_1>
  //rax = (rdi(32) >> 0x2) + (rdi ^ 0x8eca) (32)
  4022a5:	xor    %eax,%eax
  4022a7:	ret

jl：
0x405820:       0x0000000000402278      0x0000000000402280
0x405830:       0x0000000000402288      0x0000000000402290
0x405840:       0x0000000000402298      0x00000000004022a0
0x405850:       0x0000000000402268      0x0000000000402270




00000000004021b0 <p3_case_0>:
  4021b0:	endbr64
  4021b4:	lea    0x0(,%rdi,4),%eax
  4021bb:	xor    $0xdf2b,%eax
  4021c0:	ret
  //rax = (4*rdi)^0xdf2b (32)


00000000004021f0 <p3_case_2>:
  4021f0:	endbr64
  4021f4:	lea    0x33d0b(%rdi,%rdi,4),%eax
  4021fb:	ret
  //rax =(5rdi+0x33d0b) (32)

0000000000402230 <p3_case_6>:
  402230:	endbr64
  402234:	lea    0xbe95(%rdi,%rdi,4),%eax
  40223b:	ret
  //rax = (5rdi + 0xbe95) (32)

0000000000402210 <p3_case_4>:
  402210:	endbr64
  402214:	lea    0x365ce(%rdi,%rdi,4),%eax
  40221b:	ret
//rax = (5rdi + 0x365ce) (32)

0000000000402240 <p3_case_7>:
  402240:	endbr64
  402244:	lea    (%rdi,%rdi,1),%eax
  402247:	xor    $0x6621,%eax
  40224c:	ret
  //rax = (2rdi)^0x6621 (32)


  0000000000402200 <p3_case_3>:
  402200:	endbr64
  402204:	lea    0x1d1(%rdi,%rdi,2),%eax
  40220b:	ret
  //rax = 3rdi+0x1d1 (32)

0000000000402220 <p3_case_5>:
  402220:	endbr64
  402224:	mov    %edi,%eax
  //rax = rdi (32)
  402226:	shr    $1,%edi
  //rdi = rdi(32) >> 1
  402228:	xor    $0xb3c,%eax
  //rax = rdi ^ 0xb3c (32)
  40222d:	add    %edi,%eax
  // rax = (rdi ^ 0xb3c (32)) + (rdi(32) >> 1)
  40222f:	ret

00000000004021d0 <p3_case_1>:
  4021d0:	endbr64
  4021d4:	mov    %edi,%eax
  //rax = rdi(32)
  4021d6:	shr    $0x2,%edi
  //rdi = rdi(32) >> 0x2
  4021d9:	xor    $0x8eca,%eax
  //rax = rdi ^ 0x8eca (32)
  4021de:	add    %edi,%eax
  //rax = (rdi(32) >> 0x2) + (rdi ^ 0x8eca) (32)
  4021e0:	ret
  //






