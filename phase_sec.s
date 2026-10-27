

0000000000402650 <secret_phase>:
  402650:	endbr64
  402654:	push   %rbp
  402655:	mov    %rsp,%rbp
  402658:	push   %r13
  40265a:	mov    %rdx,%r13
  40265d:	push   %r12
  40265f:	mov    %rsi,%r12
  402662:	mov    $0x3,%esi
  402667:	push   %rbx
  402668:	mov    %rdi,%rbx
  40266b:	sub    $0x18,%rsp


  40266f:	call   402c80 <valid_u32_fields>
  402674:	test   %al,%al
  402676:	jne    402690 <secret_phase+0x40>
  402678:	xor    %edx,%edx
  40267a:	add    $0x18,%rsp
  40267e:	mov    %edx,%eax
  402680:	pop    %rbx
  402681:	pop    %r12
  402683:	pop    %r13
  402685:	pop    %rbp
  402686:	ret
  402687:	nopw   0x0(%rax,%rax,1)


  402690:	xor    %eax,%eax
  402692:	lea    -0x24(%rbp),%r8
  402696:	lea    -0x28(%rbp),%rcx
  40269a:	mov    $0x403183,%esi
  40269f:	lea    -0x2c(%rbp),%rdx
  4026a3:	mov    %rbx,%rdi
  4026a6:	call   4011e0 <__isoc99_sscanf@plt>
  4026ab:	cmp    $0x3,%eax
  4026ae:	jne    402678 <secret_phase+0x28>

0x403183:       "%u %u %u"
0x403183:       0x25    0x75    0x20    0x25    0x75    0x20    0x25    0x75

  
  4026b0:	mov    %r13d,%ecx
  //rcx = c
  4026b3:	xor    %edx,%edx
  4026b5:	and    $0x3,%ecx
  //rcx = c & 0x3
  4026b8:	cmp    %ecx,-0x2c(%rbp)
  4026bb:	jne    40267a <secret_phase+0x2a>
  // fisrt == c & 0x3;
  4026bd:	mov    %r12,%rsi
  //rsi = b
  4026c0:	imul   $0xf0e1,%ecx,%r9d
  //r9d = (c & 0x3) * (0xf0e1)
  4026c7:	mov    %r13,%r8
  //r8 = c
  4026ca:	shr    $0x20,%rsi
  //rsi = b >> 0x20
  4026ce:	shr    $0x20,%r8
  //r8 = c >>0x20
  4026d2:	xor    %r12d,%esi
  //rsi = (b >> 0x20) ^  b
  4026d5:	xor    %r13d,%r8d
  //r8 = (c >>0x20) ^  c
  4026d8:	shr    $0x10,%r13
  //r13 = c >>0x10
  4026dc:	mov    %esi,%edi
  //rdi = (b >> 0x20) ^  b;
  4026de:	xor    %r13d,%r9d
  //r9d = ((c & 0x3) * (0xf0e1)) ^ (c >>0x10)
  4026e1:	xor    %r8d,%edi
  //rdi = ((b >> 0x20) ^  b) ^  ((c >>0x20) ^  c) = mid
  4026e4:	call   402630 <secret_mix>
  //secret_copy()  rax = (3mid+0xf0e1)^0x1a65
  4026e9:	xor    %r9d,%eax
  //rax = ((3mid+0xf0e1)^0x1a65) ^  (((c & 0x3) * (0xf0e1))^(c >>0x10))==mid2;
  4026ec:	cmp    %eax,-0x28(%rbp)
  4026ef:	jne    40267a <secret_phase+0x2a>
  //second == mid2;
  4026f1:	shr    $1,%esi
  //rsi = ((b >> 0x20) ^  b) >> 1;
  4026f3:	lea    0x1a65(%r8,%rcx,1),%edx
  //rdx =  ((c >>0x20) ^  c) + (c & 0x3) + (0x1a65);
  4026fb:	add    %esi,%edx
  //rdx = ((c >>0x20) ^  c) + (c & 0x3) + (0x1a65) + (((b >> 0x20) ^  b) >> 1) = mid3
  4026fd:	xor    %edx,%eax
  // rax = mid2 ^ mid3
  4026ff:	cmp    -0x24(%rbp),%eax
  //third == mid2 ^ mid3
  402702:	sete   %dl
  402705:	jmp    40267a <secret_phase+0x2a>



0000000000402630 <secret_mix>:
  402630:	endbr64
  402634:	lea    0xf0e1(%rdi,%rdi,2),%eax
  40263b:	xor    $0x1a65,%eax
  // rax = (3rdi+0xf0e1)^0x1a65
  402640:	ret




0000000000402710 <secret_copy>:
  402710:	endbr64
  402714:	xor    %eax,%eax
  402716:	cs nopw 0x0(%rax,%rax,1)
/*

void secret_copy(rdi,rsi){
    //把rsi上的内容复制到rdi
}
uint32_t n = 0;
while( dl != 0 ){
    dx = M_1byte[rsi+n];
    M_1byte[rdi+n] = dl;
    n++;
}
return n;
*/

  402720:	movzbl (%rsi,%rax,1),%edx
  402724:	mov    %dl,(%rdi,%rax,1)
  402727:	add    $0x1,%rax
  40272b:	test   %dl,%dl
  40272d:	jne    402720 <secret_copy+0x10>


  40272f:	ret



0000000000402730 <secret_gate>:
  402730:	endbr64
  402734:	push   %rbp
  402735:	xor    %eax,%eax
  402737:	mov    $0x14,%ecx
  40273c:	mov    %rsp,%rbp
  40273f:	push   %r14
  402741:	mov    %rdx,%r14
  402744:	push   %r13
  402746:	mov    %rsi,%r13
  402749:	push   %r12
  40274b:	lea    -0xd0(%rbp),%r12
  402752:	push   %rbx
  402753:	mov    %rdi,%rbx
  402756:	mov    %r12,%rdi
  402759:	sub    $0xb0,%rsp



  402760:	rep stos %rax,(%rdi)
  402763:	movl   $0x0,(%rdi)
  402769:	mov    %rbx,%rdi
  40276c:	call   401190 <strlen@plt>
  402771:	sub    $0x24,%rax
  402775:	cmp    $0x7f,%rax
  402779:	jbe    402790 <secret_gate+0x60>
  40277b:	add    $0xb0,%rsp
  402782:	xor    %eax,%eax
  402784:	pop    %rbx
  402785:	pop    %r12
  402787:	pop    %r13
  402789:	pop    %r14
  40278b:	pop    %rbp
  40278c:	ret
  40278d:	nopl   (%rax)


  402790:	mov    %rbx,%rsi
  402793:	mov    %r12,%rdi
  //rdi = %rbp-0xd0  rsi = b
  402796:	call   402710 <secret_copy>
  //copy from rsi to rdi
  //rdi = rsi；
  40279b:	cmpl   $0x4e45504f,-0xb0(%rbp)
  4027a5:	jne    40277b <secret_gate+0x4b>
  //前32个字节要为4e45504f   32个任意bit+0x4e45504f+a+b+c
  4027a7:	mov    %r14,%rdx
  4027aa:	mov    %r13,%rsi
  4027ad:	lea    -0xac(%rbp),%rdi
  //rsi =  b   rdx=  c
  4027b4:	call   402650 <secret_phase>
  4027b9:	add    $0xb0,%rsp
  4027c0:	pop    %rbx
  4027c1:	pop    %r12
  4027c3:	pop    %r13
  4027c5:	pop    %r14
  4027c7:	pop    %rbp
  4027c8:	ret



