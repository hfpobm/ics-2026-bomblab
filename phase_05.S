
0000000000402480 <phase_05>:
  402480:	endbr64
  402484:	push   %rbp
  402485:	mov    %rsp,%rbp
  402488:	push   %r12
  40248a:	mov    %rsi,%r12
  40248d:	mov    $0x2,%esi
  402492:	push   %rbx
  402493:	mov    %rdi,%rbx
  402496:	sub    $0x10,%rsp


  40249a:	call   402c80 <valid_u32_fields>
  40249f:	test   %al,%al
  4024a1:	jne    4024b0 <phase_05+0x30>
  4024a3:	xor    %eax,%eax
  4024a5:	add    $0x10,%rsp
  4024a9:	pop    %rbx
  4024aa:	pop    %r12
  4024ac:	pop    %rbp
  4024ad:	ret


  4024ae:	xchg   %ax,%ax
  4024b0:	xor    %eax,%eax
  4024b2:	lea    -0x18(%rbp),%rcx
  4024b6:	lea    -0x1c(%rbp),%rdx
  4024ba:	mov    $0x403186,%esi
  4024bf:	mov    %rbx,%rdi
  4024c2:	call   4011e0 <__isoc99_sscanf@plt>
  4024c7:	cmp    $0x2,%eax
  4024ca:	jne    4024a3 <phase_05+0x23>


  4024cc:	lea    -0x14(%rbp),%rsi
  4024d0:	mov    %r12,%rdi
  4024d3:	call   402420 <p5_traverse>
  4024d8:	mov    %eax,%edx
  4024da:	xor    %eax,%eax
  4024dc:	cmp    %edx,-0x1c(%rbp)
  4024df:	jne    4024a5 <phase_05+0x25>
  4024e1:	mov    -0x14(%rbp),%eax
  4024e4:	cmp    %eax,-0x18(%rbp)
  4024e7:	sete   %al
  4024ea:	jmp    4024a5 <phase_05+0x25>





0000000000402420 <p5_traverse>:
  402420:	endbr64
  402424:	mov    %rdi,%rax
  402427:	mov    %rdi,%rcx
  40242a:	mov    %rsi,%r8
  40242d:	and    $0x7,%eax
  402430:	shr    $0x3,%rcx
  402434:	mov    0x405b60(,%rax,8),%rdx

//用绝对地址访问的情况下这个值绝对不能直接拿去使用，必须要使用gdb抓取实际值。
  40243c:	mov    %rdi,%rax
  40243f:	shr    $0x20,%rdi
  402443:	shr    $0x6,%rax
  402447:	xor    %edi,%eax
  402449:	mov    0x4(%rdx),%esi
  40244c:	mov    %ecx,%edi
  40244e:	xor    $0xe340,%eax
  402453:	lea    (%rax,%rax,2),%eax
  402456:	add    (%rdx),%eax
  402458:	mov    %esi,(%r8)
  40245b:	xor    %esi,%eax
  40245d:	and    $0x3,%edi
  402460:	je     40247f <p5_traverse+0x5f>
  402462:	mov    $0x1,%ecx
  402467:	mov    0x8(%rdx),%rdx
  40246b:	lea    (%rax,%rax,2),%eax
  40246e:	add    $0x1,%ecx
  402471:	mov    0x4(%rdx),%esi
  402474:	add    (%rdx),%eax
  402476:	xor    %esi,%eax
  402478:	mov    %esi,(%r8)
  40247b:	cmp    %ecx,%edi
  40247d:	jae    402467 <p5_traverse+0x47>
  40247f:	ret




set pagination off
set $p = 0x405ba0
set $i = 0
printf "顺着 next 一直走:\n"
while $p != 0
  printf "  [%2d] addr=%#lx  val0=%-6u val1=%-6u next=%#lx\n", \
         $i, $p, *(unsigned int *)$p, *(unsigned int *)($p+4), *(unsigned long *)($p+8)
  set $p = *(unsigned long *)($p+8)
  set $i = $i + 1
end
printf "共 %d 个节点\n", $i
EOF
gdb -batch -x /tmp/walk2.gdb ./bomb

This GDB supports auto-downloading debuginfo from the following URLs:
  <https://debuginfod.ubuntu.com>
Enable debuginfod for this session? (y or [n]) [answered N; input not from terminal]
Debuginfod has been disabled.
To make this setting permanent, add 'set debuginfod enabled off' to .gdbinit.
顺着 next 一直走:
  [ 0] addr=0x405ba0  val0=53352  val1=1033   next=0x405c10
  [ 1] addr=0x405c10  val0=43702  val1=21     next=0x405c00
  [ 2] addr=0x405c00  val0=25500  val1=1644   next=0x405c30
  [ 3] addr=0x405c30  val0=12916  val1=1895   next=0x405c20
  [ 4] addr=0x405c20  val0=146    val1=1293   next=0x405bb0
  [ 5] addr=0x405bb0  val0=64803  val1=622    next=0x405bd0
  [ 6] addr=0x405bd0  val0=1949   val1=2673   next=0x405bf0
  [ 7] addr=0x405bf0  val0=34225  val1=304    next=0x405bc0
  [ 8] addr=0x405bc0  val0=38201  val1=2100   next=0x405c40
  [ 9] addr=0x405c40  val0=21166  val1=2394   next=0x405be0
  [10] addr=0x405be0  val0=44104  val1=2917   next=0x405c50
  [11] addr=0x405c50  val0=9027   val1=882    next=0
共 12 个节点