

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
  4022ff:	xor    %eax,%eax
  402301:	and    $0x7,%edi
  402304:	cmp    %edi,-0x18(%rbp)
  402307:	jne    4022d5 <phase_03+0x25>
  402309:	mov    %r12,%rax
  40230c:	mov    %r12,%rsi
  40230f:	shr    $0x3,%rax
  402313:	shr    $0x20,%rsi
  402317:	xor    %eax,%esi
  402319:	call   402250 <p3_dispatch>
  40231e:	cmp    %eax,-0x14(%rbp)
  402321:	sete   %al
  402324:	jmp    4022d5 <phase_03+0x25>


