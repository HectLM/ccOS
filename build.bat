@echo off
echo ==============================================
echo Building Custom OS via WSL (Ubuntu)
echo ==============================================

rem Convert Windows paths to WSL paths and run the compilation script
wsl bash -c "nasm -f bin boot.asm -o boot.bin && gcc -m32 -ffreestanding -c kernel.c -o kernel.o && ld -m elf_i386 -T linker.ld kernel.o -o kernel.bin --oformat binary && cat boot.bin kernel.bin > os_image.bin"

if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] Compilation failed! Ensure GCC, NASM, and GNU Linker are installed inside WSL.
    pause
    exit /b %ERRORLEVEL%
)

echo [SUCCESS] os_image.bin built successfully!
echo Launching in QEMU...

rem Launch QEMU from Windows (assumes QEMU is installed on Windows and added to PATH)
qemu-system-i386 -drive format=raw,file=os_image.bin

pause