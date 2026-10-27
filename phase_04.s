
00000000004023a0 <phase_04>:
  4023a0:	endbr64
  4023a4:	push   %rbp
  4023a5:	mov    %rsp,%rbp
  4023a8:	push   %r12
  4023aa:	mov    %rsi,%r12
  4023ad:	mov    $0x1,%esi
  4023b2:	push   %rbx
  4023b3:	mov    %rdi,%rbx
  4023b6:	sub    $0x10,%rsp

  4023ba:	call   402c80 <valid_u32_fields>
  4023bf:	test   %al,%al
  4023c1:	jne    4023d0 <phase_04+0x30>
  4023c3:	add    $0x10,%rsp
  4023c7:	xor    %eax,%eax
  4023c9:	pop    %rbx
  4023ca:	pop    %r12
  4023cc:	pop    %rbp
  4023cd:	ret
  4023ce:	xchg   %ax,%ax
  4023d0:	xor    %eax,%eax
  4023d2:	lea    -0x14(%rbp),%rdx
  4023d6:	mov    $0x403189,%esi
  4023db:	mov    %rbx,%rdi

  4023de:	call   4011e0 <__isoc99_sscanf@plt>
  4023e3:	cmp    $0x1,%eax
  4023e6:	jne    4023c3 <phase_04+0x23>

  4023e8:	mov    %r12,%rcx
  4023eb:	mov    %r12,%rax
  4023ee:	mov    %r12d,%edi
  4023f1:	xor    %esi,%esi
  4023f3:	shr    $0x20,%rax
  4023f7:	shr    $0x7,%rcx
  4023fb:	and    $0x7f,%edi
  4023fe:	mov    $0x7f,%edx
  402403:	xor    %eax,%ecx
/*
res = p4_walk(b&0x7f,0,127,(b>>7)^(b>>0x20))
*
  402405:	call   402330 <p4_walk>
  40240a:	cmp    %eax,-0x14(%rbp)
//value[0] = res
  40240d:	sete   %al
  402410:	add    $0x10,%rsp
  402414:	pop    %rbx
  402415:	pop    %r12
  402417:	pop    %rbp
  402418:	ret
















0000000000402330 <p4_walk>:
  402330:	endbr64
  402334:	mov    %edi,%eax
  402336:	mov    %edx,%edi
  402338:	sub    %esi,%edi
  40233a:	shr    $1,%edi
  40233c:	add    %esi,%edi
  40233e:	cmp    %eax,%edi
  402340:	je     402390 <p4_walk+0x60>
/*
if ( mid  == a){
  int mid = (c-b)/2 + b;
  return  (mid + 163)^d;
}
else if(a < mid){
  res = p4_walk(a,b,mid-1,d);
  return (5*res)^(mid+d)^(0x1d);
}
else{
  res = p4_walk(a,mid+1,c,d);
  return (5*res)^(mid+d)^0x5
}
*/
  402342:	push   %rbp
  402343:	mov    %rsp,%rbp
  402346:	push   %rbx
  402347:	lea    (%rdi,%rcx,1),%ebx
  40234a:	sub    $0x8,%rsp
  40234e:	cmp    %edi,%eax
  402350:	jb     402370 <p4_walk+0x40>
/*
else if(a < mid){
  res = p4_walk(a,b,mid-1,d);
  return (5*res)^(mid+d)^(0x1d);
}
else{
  res = p4_walk(a,mid+1,c,d);
  return (5*res)^(mid+d)^0x5
}
*/
  402352:	lea    0x1(%rdi),%esi
  402355:	mov    %eax,%edi
  402357:	call   402330 <p4_walk>
  40235c:	lea    (%rax,%rax,4),%eax
  40235f:	xor    %ebx,%eax
  402361:	mov    -0x8(%rbp),%rbx
  402365:	leave
  402366:	xor    $0x5,%eax
  402369:	ret
  40236a:	nopw   0x0(%rax,%rax,1)

  402370:	lea    -0x1(%rdi),%edx
  402373:	mov    %eax,%edi
  402375:	call   402330 <p4_walk>
  40237a:	lea    (%rax,%rax,4),%eax
  40237d:	xor    %ebx,%eax
  40237f:	mov    -0x8(%rbp),%rbx
  402383:	leave
  402384:	xor    $0x1d,%eax
  402387:	ret
  402388:	nopl   0x0(%rax,%rax,1)


  402390:	lea    0xa3(%rdi),%eax
  402396:	xor    %ecx,%eax
  402398:	ret


