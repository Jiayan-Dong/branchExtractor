#!/bin/bash
BRANCH_EXT_ROOT=$(dirname $(realpath -s $0))

make -C ${BRANCH_EXT_ROOT}

${BRANCH_EXT_ROOT}/pin_tool/pin -t ${BRANCH_EXT_ROOT}/obj-intel64/branchExt.so -- $1

mv branches_0.out "$2_n"
mv generalInfo_0.out "$2.txt"

head -20000000 "$2_n" > $2

echo "bzip2 in progress - it may take a while"

bzip2 -f $2