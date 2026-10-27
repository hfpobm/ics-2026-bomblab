#include "defuser.h"

#include <inttypes.h>
#include <stdio.h>

#define MAX_FIELDS 8

/*
 * 把 values 中的 count 个整数写成一行“空格分隔的无符号十进制整数”，存入 out。
 * 成功返回 0；count 为 0（还没有实现）、snprintf 出错或结果被截断时返回非零。
 */
static int write_answer(char *out, size_t cap, const uint32_t *values, size_t count) {
    size_t used = 0;
    for (size_t i = 0; i < count; ++i) {
        int size = snprintf(out + used, cap - used, "%s%" PRIu32, i ? " " : "", values[i]);
        if (size < 0 || (size_t)size >= cap - used) return 1;
        used += (size_t)size;
    }
    return count == 0;
}

int p4_walker(uint32_t a,uint32_t b ,uint32_t c,uint32_t d){
    uint32_t mid = ((c-b)>>1) + b;
    uint32_t res;
    if ( mid  == a){
    return  (mid + 163)^d;
    }
    else if(a < mid){
    res = p4_walker(a,b,mid-1,d);
    return (5*res)^(mid+d)^(0x1d);
    }
    else{
    res = p4_walker(a,mid+1,c,d);
    return (5*res)^(mid+d)^0x5;
    }
}



uint32_t rotr32(uint32_t x, unsigned int n)
{
    n %= 32;
    return (x >> n) | (x << ((32 - n) % 32));
}

uint32_t rol32(uint32_t x, unsigned int n)
{
    n %= 32;
    return (x << n) | (x >> ((32 - n) % 32));
}


uint32_t p6_switch(uint32_t a,uint32_t choice){
    int way[8] = {1,4,5,0,2,4,3,2};
    int tmp = way[choice];

    switch(tmp){
        case 1:
            a = rotr32(a,3);
            break;

        case 4:
            a = rol32(a,1);
            a = a^0x9e38;
            break;

        case 5:
            a = (a<<7) + (a^0x6236);
            break;

        case 0:
            a = ((a<<5) + 0xa0e1) ^ (5*a);
            break;

        case 2:
            a = ((a >> 5) ^ a) + 0x32aa;
            break;

        case 3:
            a = (a+0x5b00) ^ (a>>7);
            break;

    }
    return a;
}

int solve_phase_1(uint64_t challenge, char *out, size_t cap) {
    uint32_t values[MAX_FIELDS] = {0};
    size_t count = 1;
    uint32_t step_1 = ((challenge >> 16) + 0xaaa4)^(challenge>>32);
    uint32_t step_2 = (3*((uint32_t)challenge - (challenge>>32))) + 0x1ee5;
    int value_0 = ((step_1^0x19a)+8*step_2);
    values[0] = value_0;
    // TODO: 根据 phase_01 的汇编，用 challenge 算出口令中的各个整数，依次存入 values，并把 count 改为整数个数。
    return write_answer(out, cap, values, count);
}

int solve_phase_2(uint64_t challenge, char *out, size_t cap) {
    uint32_t values[MAX_FIELDS] = {0};
    size_t count = 6;
    values[0] = (3*(0x7f&(uint32_t)(challenge>>24)));
    
    for(uint32_t i = 0;i < 5;i = i+1){
        values[i+1] = 5*values[i] + ((0x3+i)^(((uint32_t)((uint64_t)challenge >> (0xf + 4*i))&0xf)));
    }
    // TODO: 根据 phase_02 的汇编，用 challenge 算出口令中的各个整数，依次存入 values，并把 count 改为整数个数。
    return write_answer(out, cap, values, count);
}

int solve_phase_3(uint64_t challenge, char *out, size_t cap) {
    uint32_t values[MAX_FIELDS] = {0};
    size_t count = 2;
    values[0] = (uint32_t)challenge & 0x7;
    uint32_t rdi = (uint32_t)challenge & 0x7;
    uint32_t rsi = (uint32_t)((challenge >> 0x20) ^ (challenge>>0x3));
    switch (rdi)
    {
    case 0: 
        values[1] = 5*rsi + 0xbe95;
        break;
    case 1:
        values[1] = 5*rsi + 0x365ce;
        break;
    case 2:
        values[1] = (2*rsi)^0x6621;
        break;
    case 3:
        values[1] = 3*rsi+0x1d1;
        break;
    case 4:
        values[1] = (rsi ^ 0xb3c ) + (rsi >> 1);
        break;
    case 5:
        values[1] = (rsi >> 0x2) + (rsi ^ 0x8eca);
        break;
    case 6:
        values[1] = (4*rsi)^0xdf2b;
        break;
    case 7:
        values[1] = (5*rsi+0x33d0b);
        break;

    }
    // TODO: 根据 phase_03 的汇编，用 challenge 算出口令中的各个整数，依次存入 values，并把 count 改为整数个数。
    return write_answer(out, cap, values, count);
}

int solve_phase_4(uint64_t challenge, char *out, size_t cap) {
    uint32_t values[MAX_FIELDS] = {0};
    size_t count = 1;
    uint32_t b = (uint32_t)challenge;
    values[0] = p4_walker(b&0x7f,0,127,(uint32_t)((challenge>>7)^(challenge>>0x20)));
    // TODO: 根据 phase_04 的汇编，用 challenge 算出口令中的各个整数，依次存入 values，并把 count 改为整数个数。
    return write_answer(out, cap, values, count);
}

int solve_phase_5(uint64_t challenge, char *out, size_t cap) {
    typedef struct {
        uint32_t val0;
        uint32_t val1;
        int32_t  next;
    } p5_node;

    static const p5_node p5_nodes[12] = {
        { 53352, 1033,  1 },
        { 43702,   21,  2 },
        { 25500, 1644,  3 },
        { 12916, 1895,  4 },
        {   146, 1293,  5 },
        { 64803,  622,  6 },
        {  1949, 2673,  7 },
        { 34225,  304,  8 },
        { 38201, 2100,  9 },
        { 21166, 2394, 10 },
        { 44104, 2917, 11 },
        {  9027,  882, -1 },
    };

    static const int32_t p5_heads[8] = { 0, 1, 2, 3, 4, 5, 6, 7 };

    uint32_t values[MAX_FIELDS] = {0};
    size_t count = 2;
    int32_t cur = p5_heads[challenge & 0x7];              /* ← 原 base / rdx */

    uint32_t con1 = (((challenge>>0x6)^(challenge >>0x20))^0xe340);
    uint32_t rax = (3*con1 +  p5_nodes[cur].val0) ^ p5_nodes[cur].val1;
    uint32_t rsi = p5_nodes[cur].val1;

    if( ((challenge>>0x3)&(0x3)) % 4 == 0){
        values[0] = rax;
        values[1] = p5_nodes[cur].val1;
        return write_answer(out, cap, values, count);
    }

    int i = 1;

    while ( ((challenge>>0x3)&(0x3)) >= (uint64_t)i){
        cur = p5_nodes[cur].next;                 
        rax = 3*rax;
        i++;
        rsi = p5_nodes[cur].val1;
        rax = p5_nodes[cur].val0 + rax;
        rax = rax ^ (rsi);
    }
    values[0] = rax;
    values[1] = rsi;

    return write_answer(out, cap, values, count);


    // TODO: 根据 phase_05 的汇编，用 challenge 算出口令中的各个整数，依次存入 values，并把 count 改为整数个数。
    return write_answer(out, cap, values, count);
}

int solve_phase_6(uint64_t challenge, char *out, size_t cap) {
    uint32_t values[MAX_FIELDS] = {0};
    size_t count = 1;
    uint32_t tmp;
    tmp = p6_switch((uint32_t)((challenge>>6) ^ (challenge >> 32)),(uint32_t) (challenge & 7));
    tmp = p6_switch(tmp^0x3ab,(challenge >> 3) & 7);
    values[0] = tmp + 0xf400;
    // TODO: 根据 phase_06 的汇编，用 challenge 算出口令中的各个整数，依次存入 values，并把 count 改为整数个数。
    return write_answer(out, cap, values, count);
}

int solve_secret(uint64_t challenge, uint64_t context, char *out, size_t cap) {
    uint64_t b = challenge;
    uint64_t c = context;
    uint32_t mid = ((b >> 0x20) ^  b) ^  ((c >>0x20) ^  c);
    uint32_t mid2 =  ((3*mid+0xf0e1)^0x1a65) ^  (((c & 0x3) * (0xf0e1))^(c >>0x10));
    uint32_t mid3 = ((c >>0x20) ^  c) + (c & 0x3) + (0x1a65) + ((uint32_t)((b >> 0x20) ^  b) >> 1);
    uint32_t first,second,third;

    first = c & 0x3;
    second = mid2;
    third = mid2 ^ mid3;
    snprintf(out, cap, "%32sOPEN %u %u %u", "", first,second,third);
    // TODO（选做）: 根据 secret_gate、secret_copy 和 secret_phase 的汇编构造完整的第七行，写入 out 后返回 0。
    // 第七行不一定只有整数，可以直接用 snprintf 写入；还没完成时保持返回 1，测试会显示 not attempted。
    return 0;
}
