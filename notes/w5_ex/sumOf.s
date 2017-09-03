# int array[10] = {5,4,7,6,8,9,1,2,3,0};

   .data
array:
   .word 5, 4, 7, 6, 8, 9, 1, 2, 3, 0

# int main(void)
# {
#    printf("%d\n", sumOf(array,0,9));
#    return 0;
# }
   .text
   .globl main
main:
   # build stack frame for main()
   sw   $fp, -4($sp)
   sw   $ra, -8($sp)
   la   $fp, -4($sp)
   addi $sp, $sp, -8
   # set args and invoke sumOf()
   la   $a0, array
   li   $a1, 0
   li   $a2, 9
   jal  sumOf
   # collect return value + print
   move $a0, $v0
   li   $v0, 1
   syscall
   li   $a0, '\n'
   li   $v0, 11
   syscall
   # pop main()'s stack frame
   lw   $ra, -4($fp)
   addi $sp, $sp, 8
   lw   $fp, ($fp)
   j    $ra 

# int sumOf(int a[], int lo, int hi)
# {
#    if (lo > hi)
#       return 0;
#    else
#       return a[lo] + sum(a,lo+1,hi);
# }
sumOf:
   # build stack frame for sumOf()
   sw   $fp, -4($sp)
   sw   $ra, -8($sp)
   sw   $s0, -12($sp)
   la   $fp, -4($sp)
   addi $sp, $sp, -12
   # compute sumOf(), recursively
if:
   ble  $a1, $a2, else
   li   $v0  0
   j    return
else:
   move $t0, $a0         # get &array[0]
   move $t1, $a1         # get lo
   mul  $t1, $t1, 4      # convert lo to byte offset
   add  $t0, $t0, $t1    # get &array[lo]
   lw   $s0, ($t0)       # get *(&array[lo])
   addi $a1, $a1, 1
   jal  sumOf
   add  $v0, $v0, $s0
   # pop sumOf()'s stack frame
return:
   lw   $s0, -8($fp)
   lw   $ra, -4($fp)
   addi $sp, $sp, 12
   lw   $fp, ($fp)
   j    $ra 
