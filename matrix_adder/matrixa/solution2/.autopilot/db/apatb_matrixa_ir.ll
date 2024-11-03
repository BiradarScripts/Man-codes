; ModuleID = 'D:/FPGA-24/matrix_adder/matrixa/solution2/.autopilot/db/a.g.ld.5.gdce.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-i64:64-i128:128-i256:256-i512:512-i1024:1024-i2048:2048-i4096:4096-n8:16:32:64-S128-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024"
target triple = "fpga64-xilinx-none"

; Function Attrs: inaccessiblememonly nounwind
declare void @llvm.sideeffect() #0

; Function Attrs: inaccessiblemem_or_argmemonly noinline
define void @apatb_matrixa_ir([3 x i8]* noalias nocapture nonnull readonly "fpga.decayed.dim.hint"="3" %a, [3 x i8]* noalias nocapture nonnull readonly "fpga.decayed.dim.hint"="3" %b, [3 x i32]* noalias nocapture nonnull "fpga.decayed.dim.hint"="3" %result) local_unnamed_addr #1 {
entry:
  %a_copy_0 = alloca [3 x [2 x i8]], align 512
  %a_copy_1 = alloca [3 x [2 x i8]], align 512
  %b_copy_0 = alloca [3 x [2 x i8]], align 512
  %b_copy_1 = alloca [3 x [2 x i8]], align 512
  %result_copy = alloca [3 x [3 x i32]], align 512
  %0 = bitcast [3 x i8]* %a to [3 x [3 x i8]]*
  %1 = bitcast [3 x i8]* %b to [3 x [3 x i8]]*
  %2 = bitcast [3 x i32]* %result to [3 x [3 x i32]]*
  call void @copy_in([3 x [3 x i8]]* nonnull %0, [3 x [2 x i8]]* nonnull align 512 %a_copy_0, [3 x [2 x i8]]* nonnull align 512 %a_copy_1, [3 x [3 x i8]]* nonnull %1, [3 x [2 x i8]]* nonnull align 512 %b_copy_0, [3 x [2 x i8]]* nonnull align 512 %b_copy_1, [3 x [3 x i32]]* nonnull %2, [3 x [3 x i32]]* nonnull align 512 %result_copy)
  %a_copy.gep_0 = getelementptr [3 x [2 x i8]], [3 x [2 x i8]]* %a_copy_0, i64 0, i32 0
  %a_copy.gep_1 = getelementptr [3 x [2 x i8]], [3 x [2 x i8]]* %a_copy_1, i64 0, i32 0
  %b_copy.gep_0 = getelementptr [3 x [2 x i8]], [3 x [2 x i8]]* %b_copy_0, i64 0, i32 0
  %b_copy.gep_1 = getelementptr [3 x [2 x i8]], [3 x [2 x i8]]* %b_copy_1, i64 0, i32 0
  %3 = getelementptr inbounds [3 x [3 x i32]], [3 x [3 x i32]]* %result_copy, i32 0, i32 0
  call void @llvm.sideeffect() #7 [ "xlx_array_partition"([2 x i8]* %a_copy.gep_0, i32 998, i32 1, i32 0, i1 false) ], !dbg !19
  call void @llvm.sideeffect() #7 [ "xlx_array_partition"([2 x i8]* %a_copy.gep_1, i32 998, i32 1, i32 0, i1 false) ], !dbg !19
  call void @llvm.sideeffect() #7 [ "xlx_array_partition"([2 x i8]* %b_copy.gep_0, i32 998, i32 1, i32 0, i1 false) ], !dbg !42
  call void @llvm.sideeffect() #7 [ "xlx_array_partition"([2 x i8]* %b_copy.gep_1, i32 998, i32 1, i32 0, i1 false) ], !dbg !42
  call void @apatb_matrixa_hw([3 x [2 x i8]]* %a_copy_0, [3 x [2 x i8]]* %a_copy_1, [3 x [2 x i8]]* %b_copy_0, [3 x [2 x i8]]* %b_copy_1, [3 x i32]* %3)
  call void @copy_back([3 x [3 x i8]]* %0, [3 x [2 x i8]]* %a_copy_0, [3 x [2 x i8]]* %a_copy_1, [3 x [3 x i8]]* %1, [3 x [2 x i8]]* %b_copy_0, [3 x [2 x i8]]* %b_copy_1, [3 x [3 x i32]]* %2, [3 x [3 x i32]]* %result_copy)
  ret void
}

; Function Attrs: argmemonly noinline norecurse
define internal fastcc void @onebyonecpy_hls.p0a3a3i32([3 x [3 x i32]]* noalias align 512, [3 x [3 x i32]]* noalias readonly) unnamed_addr #2 {
entry:
  %2 = icmp eq [3 x [3 x i32]]* %0, null
  %3 = icmp eq [3 x [3 x i32]]* %1, null
  %4 = or i1 %2, %3
  br i1 %4, label %ret, label %copy

copy:                                             ; preds = %entry
  br label %for.loop

for.loop:                                         ; preds = %for.loop.split, %copy
  %for.loop.idx10 = phi i64 [ 0, %copy ], [ %for.loop.idx.next, %for.loop.split ]
  br label %for.loop2

for.loop2:                                        ; preds = %for.loop2, %for.loop
  %for.loop.idx39 = phi i64 [ 0, %for.loop ], [ %for.loop.idx3.next, %for.loop2 ]
  %dst.addr57 = getelementptr [3 x [3 x i32]], [3 x [3 x i32]]* %0, i64 0, i64 %for.loop.idx10, i64 %for.loop.idx39
  %src.addr68 = getelementptr [3 x [3 x i32]], [3 x [3 x i32]]* %1, i64 0, i64 %for.loop.idx10, i64 %for.loop.idx39
  %5 = load i32, i32* %src.addr68, align 4
  store i32 %5, i32* %dst.addr57, align 4
  %for.loop.idx3.next = add nuw nsw i64 %for.loop.idx39, 1
  %exitcond = icmp ne i64 %for.loop.idx3.next, 3
  br i1 %exitcond, label %for.loop2, label %for.loop.split

for.loop.split:                                   ; preds = %for.loop2
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx10, 1
  %exitcond11 = icmp ne i64 %for.loop.idx.next, 3
  br i1 %exitcond11, label %for.loop, label %ret

ret:                                              ; preds = %for.loop.split, %entry
  ret void
}

; Function Attrs: nounwind
declare void @llvm.assume(i1) #3

; Function Attrs: argmemonly noinline norecurse
define internal void @onebyonecpy_hls.p0a3a3i8.3.4([3 x [2 x i8]]* noalias align 512 "fpga.caller.interfaces"="layout_transformed" "orig.arg.no"="0" "unpacked"="0.0" %_0, [3 x [2 x i8]]* noalias align 512 "fpga.caller.interfaces"="layout_transformed" "orig.arg.no"="0" "unpacked"="0.1" %_1, [3 x [3 x i8]]* noalias readonly "fpga.caller.interfaces"="layout_transformed" "orig.arg.no"="1") #2 {
entry:
  %1 = icmp eq [3 x [2 x i8]]* %_0, null
  %2 = icmp eq [3 x [3 x i8]]* %0, null
  %3 = or i1 %1, %2
  br i1 %3, label %ret, label %copy

copy:                                             ; preds = %entry
  br label %for.loop

for.loop:                                         ; preds = %for.loop.split, %copy
  %for.loop.idx10 = phi i64 [ 0, %copy ], [ %for.loop.idx.next, %for.loop.split ]
  br label %for.loop2

for.loop2:                                        ; preds = %dst.addr57.exit, %for.loop
  %for.loop.idx39 = phi i64 [ 0, %for.loop ], [ %for.loop.idx3.next, %dst.addr57.exit ]
  %4 = udiv i64 %for.loop.idx39, 2
  %5 = urem i64 %for.loop.idx39, 2
  %dst.addr57_0 = getelementptr [3 x [2 x i8]], [3 x [2 x i8]]* %_0, i64 0, i64 %for.loop.idx10, i64 %5
  %dst.addr57_1 = getelementptr [3 x [2 x i8]], [3 x [2 x i8]]* %_1, i64 0, i64 %for.loop.idx10, i64 %5
  %src.addr68 = getelementptr [3 x [3 x i8]], [3 x [3 x i8]]* %0, i64 0, i64 %for.loop.idx10, i64 %for.loop.idx39
  %6 = load i8, i8* %src.addr68, align 1
  %7 = trunc i64 %4 to i1
  %cond = icmp eq i1 %7, false
  br i1 %cond, label %dst.addr57.case.0, label %dst.addr57.case.1

dst.addr57.case.0:                                ; preds = %for.loop2
  store i8 %6, i8* %dst.addr57_0, align 1
  br label %dst.addr57.exit

dst.addr57.case.1:                                ; preds = %for.loop2
  call void @llvm.assume(i1 %7)
  store i8 %6, i8* %dst.addr57_1, align 1
  br label %dst.addr57.exit

dst.addr57.exit:                                  ; preds = %dst.addr57.case.1, %dst.addr57.case.0
  %for.loop.idx3.next = add nuw nsw i64 %for.loop.idx39, 1
  %exitcond = icmp ne i64 %for.loop.idx3.next, 3
  br i1 %exitcond, label %for.loop2, label %for.loop.split

for.loop.split:                                   ; preds = %dst.addr57.exit
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx10, 1
  %exitcond11 = icmp ne i64 %for.loop.idx.next, 3
  br i1 %exitcond11, label %for.loop, label %ret

ret:                                              ; preds = %for.loop.split, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse
define internal void @copy_in([3 x [3 x i8]]* noalias readonly "orig.arg.no"="0", [3 x [2 x i8]]* noalias align 512 "fpga.caller.interfaces"="layout_transformed" "orig.arg.no"="1" "unpacked"="1.0" %_0, [3 x [2 x i8]]* noalias align 512 "fpga.caller.interfaces"="layout_transformed" "orig.arg.no"="1" "unpacked"="1.1" %_1, [3 x [3 x i8]]* noalias readonly "orig.arg.no"="2", [3 x [2 x i8]]* noalias align 512 "fpga.caller.interfaces"="layout_transformed" "orig.arg.no"="3" "unpacked"="3.0" %_01, [3 x [2 x i8]]* noalias align 512 "fpga.caller.interfaces"="layout_transformed" "orig.arg.no"="3" "unpacked"="3.1" %_12, [3 x [3 x i32]]* noalias readonly "orig.arg.no"="4", [3 x [3 x i32]]* noalias align 512 "orig.arg.no"="5") #4 {
entry:
  call void @onebyonecpy_hls.p0a3a3i8.3.4([3 x [2 x i8]]* align 512 %_0, [3 x [2 x i8]]* align 512 %_1, [3 x [3 x i8]]* %0)
  call void @onebyonecpy_hls.p0a3a3i8.3.4([3 x [2 x i8]]* align 512 %_01, [3 x [2 x i8]]* align 512 %_12, [3 x [3 x i8]]* %1)
  call fastcc void @onebyonecpy_hls.p0a3a3i32([3 x [3 x i32]]* align 512 %3, [3 x [3 x i32]]* %2)
  ret void
}

; Function Attrs: argmemonly noinline norecurse
define internal void @onebyonecpy_hls.p0a3a3i8.9.10([3 x [3 x i8]]* noalias "fpga.caller.interfaces"="layout_transformed" "orig.arg.no"="0", [3 x [2 x i8]]* noalias readonly align 512 "fpga.caller.interfaces"="layout_transformed" "orig.arg.no"="1" "unpacked"="1.0" %_0, [3 x [2 x i8]]* noalias readonly align 512 "fpga.caller.interfaces"="layout_transformed" "orig.arg.no"="1" "unpacked"="1.1" %_1) #2 {
entry:
  %1 = icmp eq [3 x [3 x i8]]* %0, null
  %2 = icmp eq [3 x [2 x i8]]* %_0, null
  %3 = or i1 %1, %2
  br i1 %3, label %ret, label %copy

copy:                                             ; preds = %entry
  br label %for.loop

for.loop:                                         ; preds = %for.loop.split, %copy
  %for.loop.idx10 = phi i64 [ 0, %copy ], [ %for.loop.idx.next, %for.loop.split ]
  br label %for.loop2

for.loop2:                                        ; preds = %src.addr68.exit, %for.loop
  %for.loop.idx39 = phi i64 [ 0, %for.loop ], [ %for.loop.idx3.next, %src.addr68.exit ]
  %dst.addr57 = getelementptr [3 x [3 x i8]], [3 x [3 x i8]]* %0, i64 0, i64 %for.loop.idx10, i64 %for.loop.idx39
  %4 = udiv i64 %for.loop.idx39, 2
  %5 = urem i64 %for.loop.idx39, 2
  %src.addr68_0 = getelementptr [3 x [2 x i8]], [3 x [2 x i8]]* %_0, i64 0, i64 %for.loop.idx10, i64 %5
  %src.addr68_1 = getelementptr [3 x [2 x i8]], [3 x [2 x i8]]* %_1, i64 0, i64 %for.loop.idx10, i64 %5
  %6 = trunc i64 %4 to i1
  %cond = icmp eq i1 %6, false
  br i1 %cond, label %src.addr68.case.0, label %src.addr68.case.1

src.addr68.case.0:                                ; preds = %for.loop2
  %_01 = load i8, i8* %src.addr68_0, align 1
  br label %src.addr68.exit

src.addr68.case.1:                                ; preds = %for.loop2
  call void @llvm.assume(i1 %6)
  %_12 = load i8, i8* %src.addr68_1, align 1
  br label %src.addr68.exit

src.addr68.exit:                                  ; preds = %src.addr68.case.1, %src.addr68.case.0
  %7 = phi i8 [ %_01, %src.addr68.case.0 ], [ %_12, %src.addr68.case.1 ]
  store i8 %7, i8* %dst.addr57, align 1
  %for.loop.idx3.next = add nuw nsw i64 %for.loop.idx39, 1
  %exitcond = icmp ne i64 %for.loop.idx3.next, 3
  br i1 %exitcond, label %for.loop2, label %for.loop.split

for.loop.split:                                   ; preds = %src.addr68.exit
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx10, 1
  %exitcond11 = icmp ne i64 %for.loop.idx.next, 3
  br i1 %exitcond11, label %for.loop, label %ret

ret:                                              ; preds = %for.loop.split, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse
define internal void @copy_out([3 x [3 x i8]]* noalias "orig.arg.no"="0", [3 x [2 x i8]]* noalias readonly align 512 "fpga.caller.interfaces"="layout_transformed" "orig.arg.no"="1" "unpacked"="1.0" %_0, [3 x [2 x i8]]* noalias readonly align 512 "fpga.caller.interfaces"="layout_transformed" "orig.arg.no"="1" "unpacked"="1.1" %_1, [3 x [3 x i8]]* noalias "orig.arg.no"="2", [3 x [2 x i8]]* noalias readonly align 512 "fpga.caller.interfaces"="layout_transformed" "orig.arg.no"="3" "unpacked"="3.0" %_01, [3 x [2 x i8]]* noalias readonly align 512 "fpga.caller.interfaces"="layout_transformed" "orig.arg.no"="3" "unpacked"="3.1" %_12, [3 x [3 x i32]]* noalias "orig.arg.no"="4", [3 x [3 x i32]]* noalias readonly align 512 "orig.arg.no"="5") #5 {
entry:
  call void @onebyonecpy_hls.p0a3a3i8.9.10([3 x [3 x i8]]* %0, [3 x [2 x i8]]* align 512 %_0, [3 x [2 x i8]]* align 512 %_1)
  call void @onebyonecpy_hls.p0a3a3i8.9.10([3 x [3 x i8]]* %1, [3 x [2 x i8]]* align 512 %_01, [3 x [2 x i8]]* align 512 %_12)
  call fastcc void @onebyonecpy_hls.p0a3a3i32([3 x [3 x i32]]* %2, [3 x [3 x i32]]* align 512 %3)
  ret void
}

declare void @apatb_matrixa_hw([3 x [2 x i8]]*, [3 x [2 x i8]]*, [3 x [2 x i8]]*, [3 x [2 x i8]]*, [3 x i32]*)

; Function Attrs: argmemonly noinline norecurse
define internal void @copy_back([3 x [3 x i8]]* noalias "orig.arg.no"="0", [3 x [2 x i8]]* noalias readonly align 512 "fpga.caller.interfaces"="layout_transformed" "orig.arg.no"="1" "unpacked"="1.0" %_0, [3 x [2 x i8]]* noalias readonly align 512 "fpga.caller.interfaces"="layout_transformed" "orig.arg.no"="1" "unpacked"="1.1" %_1, [3 x [3 x i8]]* noalias "orig.arg.no"="2", [3 x [2 x i8]]* noalias readonly align 512 "fpga.caller.interfaces"="layout_transformed" "orig.arg.no"="3" "unpacked"="3.0" %_01, [3 x [2 x i8]]* noalias readonly align 512 "fpga.caller.interfaces"="layout_transformed" "orig.arg.no"="3" "unpacked"="3.1" %_12, [3 x [3 x i32]]* noalias "orig.arg.no"="4", [3 x [3 x i32]]* noalias readonly align 512 "orig.arg.no"="5") #5 {
entry:
  call fastcc void @onebyonecpy_hls.p0a3a3i32([3 x [3 x i32]]* %2, [3 x [3 x i32]]* align 512 %3)
  ret void
}

define void @matrixa_hw_stub_wrapper([3 x [2 x i8]]*, [3 x [2 x i8]]*, [3 x [2 x i8]]*, [3 x [2 x i8]]*, [3 x i32]*) #6 {
entry:
  %5 = alloca [3 x [3 x i8]]
  %6 = alloca [3 x [3 x i8]]
  %7 = bitcast [3 x i32]* %4 to [3 x [3 x i32]]*
  call void @copy_out([3 x [3 x i8]]* %5, [3 x [2 x i8]]* %0, [3 x [2 x i8]]* %1, [3 x [3 x i8]]* %6, [3 x [2 x i8]]* %2, [3 x [2 x i8]]* %3, [3 x [3 x i32]]* null, [3 x [3 x i32]]* %7)
  %8 = bitcast [3 x [3 x i8]]* %5 to [3 x i8]*
  %9 = bitcast [3 x [3 x i8]]* %6 to [3 x i8]*
  %10 = bitcast [3 x [3 x i32]]* %7 to [3 x i32]*
  call void @matrixa_hw_stub([3 x i8]* %8, [3 x i8]* %9, [3 x i32]* %10)
  call void @copy_in([3 x [3 x i8]]* %5, [3 x [2 x i8]]* %0, [3 x [2 x i8]]* %1, [3 x [3 x i8]]* %6, [3 x [2 x i8]]* %2, [3 x [2 x i8]]* %3, [3 x [3 x i32]]* null, [3 x [3 x i32]]* %7)
  ret void
}

declare void @matrixa_hw_stub([3 x i8]*, [3 x i8]*, [3 x i32]*)

attributes #0 = { inaccessiblememonly nounwind }
attributes #1 = { inaccessiblemem_or_argmemonly noinline "fpga.wrapper.func"="wrapper" }
attributes #2 = { argmemonly noinline norecurse "fpga.wrapper.func"="onebyonecpy_hls" }
attributes #3 = { nounwind }
attributes #4 = { argmemonly noinline norecurse "fpga.wrapper.func"="copyin" }
attributes #5 = { argmemonly noinline norecurse "fpga.wrapper.func"="copyout" }
attributes #6 = { "fpga.wrapper.func"="stub" }
attributes #7 = { inaccessiblememonly nounwind "xlx.source"="user" }

!llvm.dbg.cu = !{}
!llvm.ident = !{!0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0}
!llvm.module.flags = !{!1, !2, !3}
!blackbox_cfg = !{!4}
!datalayout.transforms.on.top = !{!5, !13}

!0 = !{!"clang version 7.0.0 "}
!1 = !{i32 2, !"Dwarf Version", i32 4}
!2 = !{i32 2, !"Debug Info Version", i32 3}
!3 = !{i32 1, !"wchar_size", i32 4}
!4 = !{}
!5 = !{!6, !8, !10}
!6 = !{!7}
!7 = !{!"0", [3 x [3 x i8]]* null}
!8 = !{!9}
!9 = !{!"array_partition", !"type=Block", !"dim=2", !"factor=2"}
!10 = !{!11, !12}
!11 = !{!"0.0", [3 x [2 x i8]]* null}
!12 = !{!"0.1", [3 x [2 x i8]]* null}
!13 = !{!14, !8, !16}
!14 = !{!15}
!15 = !{!"1", [3 x [3 x i8]]* null}
!16 = !{!17, !18}
!17 = !{!"1.0", [3 x [2 x i8]]* null}
!18 = !{!"1.1", [3 x [2 x i8]]* null}
!19 = !DILocation(line: 6, column: 9, scope: !20)
!20 = !DILexicalBlockFile(scope: !22, file: !21, discriminator: 0)
!21 = !DIFile(filename: "D:/FPGA-24/matrix_adder/matrixa/solution2/directives.tcl", directory: "D:\5CFPGA-24\5Cmatrix_adder")
!22 = distinct !DISubprogram(name: "matrixa", linkageName: "_Z7matrixaPA3_cS0_PA3_i", scope: !23, file: !23, line: 3, type: !24, isLocal: false, isDefinition: true, scopeLine: 4, flags: DIFlagPrototyped, isOptimized: false, unit: !40, variables: !4)
!23 = !DIFile(filename: "matrixa.cpp", directory: "D:\5CFPGA-24\5Cmatrix_adder")
!24 = !DISubroutineType(types: !25)
!25 = !{null, !26, !33, !36}
!26 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !27, size: 64)
!27 = !DICompositeType(tag: DW_TAG_array_type, baseType: !28, size: 24, elements: !31)
!28 = !DIDerivedType(tag: DW_TAG_typedef, name: "matrix_a", file: !29, line: 8, baseType: !30)
!29 = !DIFile(filename: "./matrixa.h", directory: "D:\5CFPGA-24\5Cmatrix_adder")
!30 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!31 = !{!32}
!32 = !DISubrange(count: 3)
!33 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !34, size: 64)
!34 = !DICompositeType(tag: DW_TAG_array_type, baseType: !35, size: 24, elements: !31)
!35 = !DIDerivedType(tag: DW_TAG_typedef, name: "matrix_b", file: !29, line: 9, baseType: !30)
!36 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !37, size: 64)
!37 = !DICompositeType(tag: DW_TAG_array_type, baseType: !38, size: 96, elements: !31)
!38 = !DIDerivedType(tag: DW_TAG_typedef, name: "matrix_c", file: !29, line: 10, baseType: !39)
!39 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!40 = distinct !DICompileUnit(language: DW_LANG_C_plus_plus, file: !41, producer: "clang version 7.0.0 ", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, enums: !4)
!41 = !DIFile(filename: "D:/FPGA-24/matrix_adder/matrixa/solution2/.autopilot/db\5Cmatrixa.pp.0.cpp", directory: "D:\5CFPGA-24\5Cmatrix_adder")
!42 = !DILocation(line: 7, column: 9, scope: !20)
