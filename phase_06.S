
00000000004025d0 <phase_06>:
  4025d0:	endbr64
  4025d4:	push   %rbp
  4025d5:	mov    %rsp,%rbp
  4025d8:	push   %r12
  4025da:	mov    %rsi,%r12
  4025dd:	mov    $0x1,%esi
  4025e2:	push   %rbx
  4025e3:	mov    %rdi,%rbx
  4025e6:	sub    $0x10,%rsp


  4025ea:	call   402c80 <valid_u32_fields>
  4025ef:	test   %al,%al
  4025f1:	jne    402600 <phase_06+0x30>
  4025f3:	add    $0x10,%rsp
  4025f7:	xor    %eax,%eax
  4025f9:	pop    %rbx
  4025fa:	pop    %r12
  4025fc:	pop    %rbp
  4025fd:	ret


  4025fe:	xchg   %ax,%ax
  402600:	xor    %eax,%eax
  402602:	lea    -0x14(%rbp),%rdx
  402606:	mov    $0x403189,%esi
  40260b:	mov    %rbx,%rdi
  40260e:	call   4011e0 <__isoc99_sscanf@plt>
  402613:	cmp    $0x1,%eax
  402616:	jne    4025f3 <phase_06+0x23>


  402618:	mov    %r12,%rdi
  40261b:	call   402580 <p6_dispatch>
  402620:	cmp    %eax,-0x14(%rbp)
  402623:	sete   %al
  402626:	add    $0x10,%rsp
  40262a:	pop    %rbx
  40262b:	pop    %r12
  40262d:	pop    %rbp
  40262e:	ret



0000000000402580 <p6_dispatch>:
  402580:	endbr64
  402584:	push   %rbp
  402585:	mov    %rsp,%rbp
  402588:	push   %rbx
  402589:	mov    %rdi,%rbx
  bx = a
  40258c:	shr    $0x6,%rdi
  di = cha>>6;
  402590:	mov    %rbx,%rax
  ax = cha;
  402593:	shr    $0x20,%rax
  ax = cha >> 32;
  402597:	xor    %eax,%edi
  di = (cha>>6) ^ (cha >> 32);
  402599:	mov    %rbx,%rax
  ax = cha;
  40259c:	sub    $0x8,%rsp
  4025a0:	and    $0x38,%ebx
  bx = a&0x38
  4025a3:	and    $0x7,%eax
  ax = (uint32_t) (cha & 7);
  /*

  */di = (uint32_t)((cha>>6) ^ (cha >> 32));
  4025a6:	call   *0x405e00(,%rax,8)
  //下标最大为7 猜测有八个函数
  4025ad:	xor    $0x3ab,%eax
  ax = ax ^ 0x3ab;
  4025b2:	mov    %eax,%edi
  di = ax ^ 0x3ab;
  4025b4:	call   *0x405e00(%rbx)
  4025ba:	mov    -0x8(%rbp),%rbx
  4025be:	leave
  4025bf:	add    $0xf400,%eax
  ax = ax + 0xf400
  4025c4:	ret



0x405e00 <p6_ops>:      0x402510 <p6_op_1>      0x402550 <p6_op_4>
0x405e10 <p6_ops+16>:   0x402560 <p6_op_5>      0x4024f0 <p6_op_0>
0x405e20 <p6_ops+32>:   0x402520 <p6_op_2>      0x402550 <p6_op_4>
0x405e30 <p6_ops+48>:   0x402540 <p6_op_3>      0x402520 <p6_op_2>


0000000000402510 <p6_op_1>:
  402510:	endbr64
  402514:	mov    %edi,%eax
  402516:	ror    $0x3,%eax
  402519:	ret


0000000000402550 <p6_op_4>:
  402550:	endbr64
  402554:	mov    %edi,%eax
  402556:	rol    $1,%eax
  402558:	xor    $0x9e38,%eax
  40255d:	ret



0000000000402560 <p6_op_5>:
  402560:	endbr64
  402564:	mov    %edi,%eax
  402566:	shl    $0x7,%edi
  402569:	xor    $0x6236,%eax
  40256e:	add    %edi,%eax
  402570:	ret


00000000004024f0 <p6_op_0>:
  4024f0:	endbr64
  4024f4:	mov    %edi,%eax
  4024f6:	lea    (%rdi,%rdi,4),%edx
  dx = 5a
  4024f9:	shl    $0x5,%eax
  ax = a<<5
  4024fc:	add    $0xa0e1,%eax
  ax = (a<<5) + 0xa0e1
  402501:	xor    %edx,%eax
  ax = ((a<<5) + 0xa0e1) ^ 5a
  402503:	ret


0000000000402520 <p6_op_2>:
  402520:	endbr64
  402524:	mov    %edi,%eax
  402526:	shr    $0x5,%eax
  ax = a >> 5
  402529:	xor    %edi,%eax
  ax = (a >> 5) ^ a
  40252b:	add    $0x32aa,%eax
  ax = (a >> 5) ^ a + 0x32aa;
  402530:	ret


0000000000402550 <p6_op_4>:
  402550:	endbr64
  402554:	mov    %edi,%eax
  402556:	rol    $1,%eax
  402558:	xor    $0x9e38,%eax
  40255d:	ret



0000000000402540 <p6_op_3>:
  402540:	endbr64
  402544:	lea    0x5b00(%rdi),%eax
  ax = a + 0x5b00
  40254a:	shr    $0x7,%edi
  di = a >>7
  40254d:	xor    %edi,%eax
  a = (a+0x5b00) ^ (a>>7)
  40254f:	ret


0000000000402520 <p6_op_2>:
  402520:	endbr64
  402524:	mov    %edi,%eax
  402526:	shr    $0x5,%eax
  402529:	xor    %edi,%eax
  40252b:	add    $0x32aa,%eax
  402530:	ret
