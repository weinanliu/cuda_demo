

tmp_file_prefix=tmp
SRC=halo.cu
CUDA_PATH=/usr/local/cuda/

.PHONY: clean all

all: a.out

clean:
	rm ${tmp_file_prefix}* a.out



${tmp_file_prefix}-6_halo.cpp4.ii: ${SRC}
	gcc \
	-D__CUDA_ARCH_LIST__=860 \
	-D__CUDACC__ \
	-D__NVCC__  \
	"-I${CUDA_PATH}/bin/../targets/x86_64-linux/include"    \
	-D__CUDACC_VER_MAJOR__=12 \
	-D__CUDACC_VER_MINOR__=1 \
	-D__CUDACC_VER_BUILD__=66 \
	-D__CUDA_API_VER_MAJOR__=12 \
	-D__CUDA_API_VER_MINOR__=1 \
	-D__NVCC_DIAG_PRAGMA_SUPPORT__=1 \
	-I/usr/local/cuda/targets/x86_64-linux/include \
	-include "cuda_runtime.h" \
	-m64 \
	-E \
	-x c++ \
	"./halo.cu" \
	-o "./${tmp_file_prefix}-6_halo.cpp4.ii"

${tmp_file_prefix}-10_halo.cpp1.ii: ${SRC}
	gcc \
	-D__CUDA_ARCH__=860 \
	-D__CUDA_ARCH_LIST__=860 \
	-DCUDA_DOUBLE_MATH_FUNCTIONS \
	-D__CUDACC__ \
	-D__NVCC__  \
	-I${CUDA_PATH}/bin/../targets/x86_64-linux/include    \
	-D__CUDACC_VER_MAJOR__=12 \
	-D__CUDACC_VER_MINOR__=1 \
	-D__CUDACC_VER_BUILD__=66 \
	-D__CUDA_API_VER_MAJOR__=12 \
	-D__CUDA_API_VER_MINOR__=1 \
	-D__NVCC_DIAG_PRAGMA_SUPPORT__=1 \
	-I/usr/local/cuda/targets/x86_64-linux/include \
	-include cuda_runtime.h \
	-m64 \
	-E \
	-x c++  \
	${SRC} \
	-o ${tmp_file_prefix}-10_halo.cpp1.ii

${tmp_file_prefix}-5_halo.module_id ${tmp_file_prefix}-7_halo.cudafe1.cpp: ${tmp_file_prefix}-6_halo.cpp4.ii
	${CUDA_PATH}/bin/cudafe++ \
	--c++17 \
	--gnu_version=110300 \
	--display_error_number \
	--allow_managed  \
	--m64 \
	--parse_templates \
	--gen_c_file_name "./${tmp_file_prefix}-7_halo.cudafe1.cpp" \
	--stub_file_name "${tmp_file_prefix}-7_halo.cudafe1.stub.c" \
	--gen_module_id_file \
	--module_id_file_name "./${tmp_file_prefix}-5_halo.module_id" \
	"./${tmp_file_prefix}-6_halo.cpp4.ii"

#	--orig_src_file_name "./halo.cu" \
#	--orig_src_path_name "/home/liuweinan/20230303_TVM/cuda_demo/halo.cu" \

${tmp_file_prefix}-7_halo.ptx ${tmp_file_prefix}-7_halo.cudafe1.stub.c: ${tmp_file_prefix}-10_halo.cpp1.ii ${tmp_file_prefix}-5_halo.module_id
	${CUDA_PATH}/nvvm/bin/cicc \
	--c++17 \
	--gnu_version=110300 \
	--display_error_number \
	--allow_managed   \
	-arch compute_86 \
	-m64 \
	--no-version-ident \
	-ftz=0 -prec_div=1 -prec_sqrt=1 -fmad=1 \
	--include_file_name ${tmp_file_prefix}-4_halo.fatbin.c \
	-tused \
	--module_id_file_name ${tmp_file_prefix}-5_halo.module_id \
	--gen_device_file_name ${tmp_file_prefix}-7_halo.cudafe1.gpu  \
	--gen_c_file_name ${tmp_file_prefix}-7_halo.cudafe1.c \
	--stub_file_name ${tmp_file_prefix}-7_halo.cudafe1.stub.c \
	${tmp_file_prefix}-10_halo.cpp1.ii \
	-o ${tmp_file_prefix}-7_halo.ptx

#    	--orig_src_file_name "./halo.cu" \
#    	--orig_src_path_name "/home/liuweinan/20230303_TVM/cuda_demo/halo.cu" \

${tmp_file_prefix}-11_halo.cubin: ${tmp_file_prefix}-7_halo.ptx
	${CUDA_PATH}/bin/ptxas -arch=sm_86 -m64  "./${tmp_file_prefix}-7_halo.ptx"  -o "./${tmp_file_prefix}-11_halo.cubin"

${tmp_file_prefix}-4_halo.fatbin.c: ${tmp_file_prefix}-11_halo.cubin
	${CUDA_PATH}/bin/fatbinary -64 --cicc-cmdline="-ftz=0 -prec_div=1 -prec_sqrt=1 -fmad=1 " "--image3=kind=elf,sm=86,file=./${tmp_file_prefix}-11_halo.cubin" --embedded-fatbin="./${tmp_file_prefix}-4_halo.fatbin.c"


${tmp_file_prefix}-12_halo.o: ${tmp_file_prefix}-7_halo.cudafe1.stub.c ${tmp_file_prefix}-7_halo.cudafe1.cpp ${tmp_file_prefix}-4_halo.fatbin.c
	gcc \
	-D__CUDA_ARCH__=860 \
	-D__CUDA_ARCH_LIST__=860 \
	-DCUDA_DOUBLE_MATH_FUNCTIONS \
	"-I${CUDA_PATH}/bin/../targets/x86_64-linux/include"   \
	-m64 \
	-x c++  \
	-c \
	"./${tmp_file_prefix}-7_halo.cudafe1.cpp" \
	-o "./${tmp_file_prefix}-12_halo.o"


${tmp_file_prefix}-13_a_dlink.cubin ${tmp_file_prefix}-8_a_dlink.reg.c: ${tmp_file_prefix}-12_halo.o
	${CUDA_PATH}/bin/nvlink -m64 --arch=sm_86 --register-link-binaries="./${tmp_file_prefix}-8_a_dlink.reg.c"    "-L${CUDA_PATH}/bin/../targets/x86_64-linux/lib/stubs" "-L${CUDA_PATH}/bin/../targets/x86_64-linux/lib" -cpu-arch=X86_64 "./${tmp_file_prefix}-12_halo.o"  -lcudadevrt  -o "./${tmp_file_prefix}-13_a_dlink.cubin" --host-ccbin "gcc"


${tmp_file_prefix}-9_a_dlink.fatbin.c: ${tmp_file_prefix}-13_a_dlink.cubin
	${CUDA_PATH}/bin/fatbinary -64 --cicc-cmdline="-ftz=0 -prec_div=1 -prec_sqrt=1 -fmad=1 " -link "--image3=kind=elf,sm=86,file=./${tmp_file_prefix}-13_a_dlink.cubin" --embedded-fatbin="./${tmp_file_prefix}-9_a_dlink.fatbin.c"


${tmp_file_prefix}-14_a_dlink.o: ${tmp_file_prefix}-8_a_dlink.reg.c ${tmp_file_prefix}-9_a_dlink.fatbin.c
	gcc \
	-D__CUDA_ARCH_LIST__=860 \
	-DFATBINFILE="\"./${tmp_file_prefix}-9_a_dlink.fatbin.c\"" \
	-DREGISTERLINKBINARYFILE="\"./${tmp_file_prefix}-8_a_dlink.reg.c\"" \
	-I. \
	-D__NV_EXTRA_INITIALIZATION= \
	-D__NV_EXTRA_FINALIZATION= \
	-D__CUDA_INCLUDE_COMPILER_INTERNAL_HEADERS__  \
	"-I${CUDA_PATH}/bin/../targets/x86_64-linux/include"    \
	-D__CUDACC_VER_MAJOR__=12 \
	-D__CUDACC_VER_MINOR__=1 \
	-D__CUDACC_VER_BUILD__=66 \
	-D__CUDA_API_VER_MAJOR__=12 \
	-D__CUDA_API_VER_MINOR__=1 \
	-D__NVCC_DIAG_PRAGMA_SUPPORT__=1 \
	-m64 \
	-x c++ \
	-c \
	"${CUDA_PATH}/bin/crt/link.stub" \
	-o "./${tmp_file_prefix}-14_a_dlink.o"



a.out: ${tmp_file_prefix}-14_a_dlink.o ${tmp_file_prefix}-12_halo.o
	g++ \
	-D__CUDA_ARCH_LIST__=860 \
	-m64 \
	-Wl,--start-group "./${tmp_file_prefix}-14_a_dlink.o" \
	"./${tmp_file_prefix}-12_halo.o"   \
	"-L${CUDA_PATH}/bin/../targets/x86_64-linux/lib/stubs" \
	"-L${CUDA_PATH}/bin/../targets/x86_64-linux/lib"  \
	-lcudadevrt  \
	-lcudart_static  \
	-lrt \
	-lpthread  \
	-ldl  \
	-Wl,--end-group \
	-o "a.out"
