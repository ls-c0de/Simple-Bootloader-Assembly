#!/bin/zsh

nasm -f bin boot.asm -o boot.bin
qemu-system-x86_64 -nographic -drive format=raw,file=boot.bin
