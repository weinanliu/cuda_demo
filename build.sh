#!/bin/bash

#set -x

#nvcc ./halo.cu -arch=native -v

tmp_file_prefix=tmp
PATH=/usr/local/cuda-12.1/bin/../nvvm/bin:$PATH

#PATH=/usr/local/cuda-12.1/bin:/home/liuweinan/.local/bin:/usr/local/cuda-12.1/bin:/home/liuweinan/6.824/go1.9/bin:/home/liuweinan/ysyx/qemu-7.0.0/build:/home/liuweinan/ysyx/host_root/usr/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/usr/lib/wsl/lib:/mnt/c/Windows/system32:/mnt/c/Windows:/mnt/c/Windows/System32/Wbem:/mnt/c/Windows/System32/WindowsPowerShell/v1.0/:/mnt/c/Windows/System32/OpenSSH/:/mnt/c/Program Files/Microsoft VS Code/bin:/mnt/c/Program Files/dotnet/:/mnt/c/Users/lwn/AppData/Local/Microsoft/WindowsApps:/mnt/c/adb:/mnt/c/WINDOWS/system32:/mnt/c/WINDOWS:/mnt/c/WINDOWS/System32/Wbem:/mnt/c/WINDOWS/System32/WindowsPowerShell/v1.0/:/mnt/c/WINDOWS/System32/OpenSSH/:/mnt/c/Program Files (x86)/NVIDIA Corporation/PhysX/Common:/mnt/c/Program Files/NVIDIA Corporation/NVIDIA NvDLISR:/snap/bin
#_NVVM_BRANCH_=nvvm
#_SPACE_=
#_CUDART_=cudart
#_HERE_=/usr/local/cuda-12.1/bin
#_THERE_=/usr/local/cuda-12.1/bin
#_TARGET_SIZE_=
#_TARGET_DIR_=
#_TARGET_DIR_=targets/x86_64-linux
#TOP=/usr/local/cuda-12.1/bin/..
#NVVMIR_LIBRARY_DIR=/usr/local/cuda-12.1/bin/../nvvm/libdevice
#LD_LIBRARY_PATH=/usr/local/cuda-12.1/bin/../lib:/usr/local/cuda-12.1/lib64
#PATH=/usr/local/cuda-12.1/bin/../nvvm/bin:/usr/local/cuda-12.1/bin:/usr/local/cuda-12.1/bin:/home/liuweinan/.local/bin:/usr/local/cuda-12.1/bin:/home/liuweinan/6.824/go1.9/bin:/home/liuweinan/ysyx/qemu-7.0.0/build:/home/liuweinan/ysyx/host_root/usr/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/usr/lib/wsl/lib:/mnt/c/Windows/system32:/mnt/c/Windows:/mnt/c/Windows/System32/Wbem:/mnt/c/Windows/System32/WindowsPowerShell/v1.0/:/mnt/c/Windows/System32/OpenSSH/:/mnt/c/Program Files/Microsoft VS Code/bin:/mnt/c/Program Files/dotnet/:/mnt/c/Users/lwn/AppData/Local/Microsoft/WindowsApps:/mnt/c/adb:/mnt/c/WINDOWS/system32:/mnt/c/WINDOWS:/mnt/c/WINDOWS/System32/Wbem:/mnt/c/WINDOWS/System32/WindowsPowerShell/v1.0/:/mnt/c/WINDOWS/System32/OpenSSH/:/mnt/c/Program Files (x86)/NVIDIA Corporation/PhysX/Common:/mnt/c/Program Files/NVIDIA Corporation/NVIDIA NvDLISR:/snap/bin
#INCLUDES="-I/usr/local/cuda-12.1/bin/../targets/x86_64-linux/include"
#LIBRARIES=  "-L/usr/local/cuda-12.1/bin/../targets/x86_64-linux/lib/stubs" "-L/usr/local/cuda-12.1/bin/../targets/x86_64-linux/lib"
#CUDAFE_FLAGS=
#PTXAS_FLAGS=
gcc -D__CUDA_ARCH_LIST__=860 -E -x c++ -D__CUDACC__ -D__NVCC__  "-I/usr/local/cuda-12.1/bin/../targets/x86_64-linux/include"    -D__CUDACC_VER_MAJOR__=12 -D__CUDACC_VER_MINOR__=1 -D__CUDACC_VER_BUILD__=66 -D__CUDA_API_VER_MAJOR__=12 -D__CUDA_API_VER_MINOR__=1 -D__NVCC_DIAG_PRAGMA_SUPPORT__=1 -include "cuda_runtime.h" -m64 "./halo.cu" -o "./${tmp_file_prefix}-6_halo.cpp4.ii"
cudafe++ --c++17 --gnu_version=110300 --display_error_number --orig_src_file_name "./halo.cu" --orig_src_path_name "/home/liuweinan/20230303_TVM/cuda_demo/halo.cu" --allow_managed  --m64 --parse_templates --gen_c_file_name "./${tmp_file_prefix}-7_halo.cudafe1.cpp" --stub_file_name "${tmp_file_prefix}-7_halo.cudafe1.stub.c" --gen_module_id_file --module_id_file_name "./${tmp_file_prefix}-5_halo.module_id" "./${tmp_file_prefix}-6_halo.cpp4.ii"
gcc -D__CUDA_ARCH__=860 -D__CUDA_ARCH_LIST__=860 -E -x c++  -DCUDA_DOUBLE_MATH_FUNCTIONS -D__CUDACC__ -D__NVCC__  "-I/usr/local/cuda-12.1/bin/../targets/x86_64-linux/include"    -D__CUDACC_VER_MAJOR__=12 -D__CUDACC_VER_MINOR__=1 -D__CUDACC_VER_BUILD__=66 -D__CUDA_API_VER_MAJOR__=12 -D__CUDA_API_VER_MINOR__=1 -D__NVCC_DIAG_PRAGMA_SUPPORT__=1 -include "cuda_runtime.h" -m64 "./halo.cu" -o "./${tmp_file_prefix}-10_halo.cpp1.ii"
cicc --c++17 --gnu_version=110300 --display_error_number --orig_src_file_name "./halo.cu" --orig_src_path_name "/home/liuweinan/20230303_TVM/cuda_demo/halo.cu" --allow_managed   -arch compute_86 -m64 --no-version-ident -ftz=0 -prec_div=1 -prec_sqrt=1 -fmad=1 --include_file_name "${tmp_file_prefix}-4_halo.fatbin.c" -tused --module_id_file_name "./${tmp_file_prefix}-5_halo.module_id" --gen_c_file_name "./${tmp_file_prefix}-7_halo.cudafe1.c" --stub_file_name "./${tmp_file_prefix}-7_halo.cudafe1.stub.c" --gen_device_file_name "./${tmp_file_prefix}-7_halo.cudafe1.gpu"  "./${tmp_file_prefix}-10_halo.cpp1.ii" -o "./${tmp_file_prefix}-7_halo.ptx"
ptxas -arch=sm_86 -m64  "./${tmp_file_prefix}-7_halo.ptx"  -o "./${tmp_file_prefix}-11_halo.cubin"
fatbinary -64 --cicc-cmdline="-ftz=0 -prec_div=1 -prec_sqrt=1 -fmad=1 " "--image3=kind=elf,sm=86,file=./${tmp_file_prefix}-11_halo.cubin" --embedded-fatbin="./${tmp_file_prefix}-4_halo.fatbin.c"
#rm ./${tmp_file_prefix}-4_halo.fatbin
gcc -D__CUDA_ARCH__=860 -D__CUDA_ARCH_LIST__=860 -c -x c++  -DCUDA_DOUBLE_MATH_FUNCTIONS "-I/usr/local/cuda-12.1/bin/../targets/x86_64-linux/include"   -m64 "./${tmp_file_prefix}-7_halo.cudafe1.cpp" -o "./${tmp_file_prefix}-12_halo.o"
nvlink -m64 --arch=sm_86 --register-link-binaries="./${tmp_file_prefix}-8_a_dlink.reg.c"    "-L/usr/local/cuda-12.1/bin/../targets/x86_64-linux/lib/stubs" "-L/usr/local/cuda-12.1/bin/../targets/x86_64-linux/lib" -cpu-arch=X86_64 "./${tmp_file_prefix}-12_halo.o"  -lcudadevrt  -o "./${tmp_file_prefix}-13_a_dlink.cubin" --host-ccbin "gcc"
fatbinary -64 --cicc-cmdline="-ftz=0 -prec_div=1 -prec_sqrt=1 -fmad=1 " -link "--image3=kind=elf,sm=86,file=./${tmp_file_prefix}-13_a_dlink.cubin" --embedded-fatbin="./${tmp_file_prefix}-9_a_dlink.fatbin.c"
#rm ./${tmp_file_prefix}-9_a_dlink.fatbin
gcc -D__CUDA_ARCH_LIST__=860 -c -x c++ -DFATBINFILE="\"./${tmp_file_prefix}-9_a_dlink.fatbin.c\"" -DREGISTERLINKBINARYFILE="\"./${tmp_file_prefix}-8_a_dlink.reg.c\"" -I. -D__NV_EXTRA_INITIALIZATION= -D__NV_EXTRA_FINALIZATION= -D__CUDA_INCLUDE_COMPILER_INTERNAL_HEADERS__  "-I/usr/local/cuda-12.1/bin/../targets/x86_64-linux/include"    -D__CUDACC_VER_MAJOR__=12 -D__CUDACC_VER_MINOR__=1 -D__CUDACC_VER_BUILD__=66 -D__CUDA_API_VER_MAJOR__=12 -D__CUDA_API_VER_MINOR__=1 -D__NVCC_DIAG_PRAGMA_SUPPORT__=1 -m64 "/usr/local/cuda-12.1/bin/crt/link.stub" -o "./${tmp_file_prefix}-14_a_dlink.o"
g++ -D__CUDA_ARCH_LIST__=860 -m64 -Wl,--start-group "./${tmp_file_prefix}-14_a_dlink.o" "./${tmp_file_prefix}-12_halo.o"   "-L/usr/local/cuda-12.1/bin/../targets/x86_64-linux/lib/stubs" "-L/usr/local/cuda-12.1/bin/../targets/x86_64-linux/lib"  -lcudadevrt  -lcudart_static  -lrt -lpthread  -ldl  -Wl,--end-group -o "a.out"
