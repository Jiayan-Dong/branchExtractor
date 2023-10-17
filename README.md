![alt text](https://raw.githubusercontent.com/mbaharan/branchExtractor/master/img/TeCSARIcon-1.png)
# Branch Extractor

This software logs the trace of branche executed during a specific benchmark. This software uses Intel PIN tools for instrumenting the retired instructions.

## Installation
```sh
$ make
```
If the compilation finished succefully, a file named `obj-intel64/branchExt.so` should be created inside the working folder.
## How to use
This is how the tool should be called
```sh
$ ./pin-3.28-98749-g6643ecee5-gcc-linux/pin -t ./obj-intel64/branchExt.so -- <executable>
```
After execution, two log files named `branches_0.out`(default) and `generalInfo_0.out` will be created. The first one containing all the information about branched executed by `ls` application. Following is the sample of output:
```
// T = 1,              C = 1                     ,  Call = 0      ,  Ret = 0     ,  Direct = 1
// (Taken-Not taken), (Conditional-Unconditional), (Call-Not Call), (Ret-Not Ret), (Direct-NotDirect), (first_inst_count_after_offset)
```
```
0x7f5c1bacd128	0	1	0	0	1	23	              0x7f5c1bacd089 #BASE 0F8499000000             jz 0x7f5c1bacd128
0x7f5c1bacd0da	1	0	0	0	1	32	              0x7f5c1bacd0be #BASE EB1A                     jmp 0x7f5c1bacd0da
0x7f5c1bacd0c9	1	1	0	0	1	34	              0x7f5c1bacd0de #BASE 76E9                     jbe 0x7f5c1bacd0c9
0x7f5c1bacd128	0	1	0	0	1	39	              0x7f5c1bacd0d8 #BASE 744E                     jz 0x7f5c1bacd128
0x7f5c1bacd0c9	1	1	0	0	1	41	              0x7f5c1bacd0de #BASE 76E9                     jbe 0x7f5c1bacd0c9
0x7f5c1bacd128	0	1	0	0	1	46	              0x7f5c1bacd0d8 #BASE 744E                     jz 0x7f5c1bacd128
0x7f5c1bacd0c9	0	1	0	0	1	48	              0x7f5c1bacd0de #BASE 76E9                     jbe 0x7f5c1bacd0c9
0x7f5c1bacd0c0	0	1	0	0	1	52	              0x7f5c1bacd0ea #BASE 76D4                     jbe 0x7f5c1bacd0c0
0x7f5c1bacd108	1	1	0	0	1	57	              0x7f5c1bacd0f8 #BASE 760E                     jbe 0x7f5c1bacd108
```

while the latter one contains static information about the executed branches:
```
!!! Number of Instructions = 569883
!!! Number of Unconditional branches = 23315
!!! Number of Conditional branches = 91351
!!! Number of Call branches = 6811
!!! Number of Ret branches = 6807
------------------------------------
```

About `branches_0.out`, the first column is the branch target IP, the second column is `1` if it is taken, the third one is `1` if the branch is conditional, the fourth one is `1` if it is a call instruction, the fifth one is `1` if it is a RET instruction, the sixth one is `1` if it is direct branch, and the seventh one is the total number of instructions seen until the current branch after the defined offset, the eighth on is the address of PC, and after the `#` sign is instruction opcode and disassembled version.

Please have look at following lines in branchExt.cpp to understand the tools options:

```c++
KNOB<string> KnobOutputFile(KNOB_MODE_WRITEONCE, "pintool", "o", "branches", "specifies the output file name prefix.");

KNOB<string> KnobHowManySet(KNOB_MODE_WRITEONCE, "pintool", "b", "1", "Specifies how many set should be created.");

KNOB<string> KnobHowManyBranch(KNOB_MODE_WRITEONCE, "pintool", "m", "-1", "Specifies how many instructions should be probed.");

KNOB<string> KnobOffset(KNOB_MODE_WRITEONCE, "pintool", "f", "0", "Starts saving instructions after seeing the first `f` instruction.");
```