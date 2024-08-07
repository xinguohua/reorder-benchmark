; ModuleID = '26-ompi.cpp'
source_filename = "26-ompi.cpp"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%"class.std::ios_base::Init" = type { i8 }
%class.mca_btl_vader_fbox_hdr_t = type { i32, i16, i16 }
%"class.std::basic_ostream" = type { i32 (...)**, %"class.std::basic_ios" }
%"class.std::basic_ios" = type { %"class.std::ios_base", %"class.std::basic_ostream"*, i8, i8, %"class.std::basic_streambuf"*, %"class.std::ctype"*, %"class.std::num_put"*, %"class.std::num_get"* }
%"class.std::ios_base" = type { i32 (...)**, i64, i64, i32, i32, i32, %"struct.std::ios_base::_Callback_list"*, %"struct.std::ios_base::_Words", [8 x %"struct.std::ios_base::_Words"], i32, %"struct.std::ios_base::_Words"*, %"class.std::locale" }
%"struct.std::ios_base::_Callback_list" = type { %"struct.std::ios_base::_Callback_list"*, void (i32, %"class.std::ios_base"*, i32)*, i32, i32 }
%"struct.std::ios_base::_Words" = type { i8*, i64 }
%"class.std::locale" = type { %"class.std::locale::_Impl"* }
%"class.std::locale::_Impl" = type { i32, %"class.std::locale::facet"**, i64, %"class.std::locale::facet"**, i8** }
%"class.std::locale::facet" = type <{ i32 (...)**, i32, [4 x i8] }>
%"class.std::basic_streambuf" = type { i32 (...)**, i8*, i8*, i8*, i8*, i8*, i8*, %"class.std::locale" }
%"class.std::ctype" = type <{ %"class.std::locale::facet.base", [4 x i8], %struct.__locale_struct*, i8, [7 x i8], i32*, i32*, i16*, i8, [256 x i8], [256 x i8], i8, [6 x i8] }>
%"class.std::locale::facet.base" = type <{ i32 (...)**, i32 }>
%struct.__locale_struct = type { [13 x %struct.__locale_data*], i16*, i32*, i32*, [13 x i8*] }
%struct.__locale_data = type opaque
%"class.std::num_put" = type { %"class.std::locale::facet.base", [4 x i8] }
%"class.std::num_get" = type { %"class.std::locale::facet.base", [4 x i8] }
%union.pthread_attr_t = type { i64, [48 x i8] }

$_ZN24mca_btl_vader_fbox_hdr_tC2Ettj = comdat any

@_ZStL8__ioinit = internal global %"class.std::ios_base::Init" zeroinitializer, align 1, !dbg !0
@__dso_handle = external global i8
@global_hdr = global %class.mca_btl_vader_fbox_hdr_t* null, align 8, !dbg !29
@_ZSt4cout = external global %"class.std::basic_ostream", align 8
@llvm.global_ctors = appending global [1 x { i32, void ()*, i8* }] [{ i32, void ()*, i8* } { i32 65535, void ()* @_GLOBAL__sub_I_26_ompi.cpp, i8* null }]

; Function Attrs: noinline uwtable
define internal void @__cxx_global_var_init() #0 section ".text.startup" !dbg !949 {
  call void @_ZNSt8ios_base4InitC1Ev(%"class.std::ios_base::Init"* @_ZStL8__ioinit), !dbg !951
  %1 = call i32 @__cxa_atexit(void (i8*)* bitcast (void (%"class.std::ios_base::Init"*)* @_ZNSt8ios_base4InitD1Ev to void (i8*)*), i8* getelementptr inbounds (%"class.std::ios_base::Init", %"class.std::ios_base::Init"* @_ZStL8__ioinit, i32 0, i32 0), i8* @__dso_handle) #3, !dbg !952
  ret void, !dbg !951
}

declare void @_ZNSt8ios_base4InitC1Ev(%"class.std::ios_base::Init"*) unnamed_addr #1

; Function Attrs: nounwind
declare void @_ZNSt8ios_base4InitD1Ev(%"class.std::ios_base::Init"*) unnamed_addr #2

; Function Attrs: nounwind
declare i32 @__cxa_atexit(void (i8*)*, i8*, i8*) #3

; Function Attrs: noinline uwtable
define i8* @_Z13writer_threadPv(i8*) #0 !dbg !954 {
  %2 = alloca i8*, align 8
  %3 = alloca i32, align 4
  store i8* %0, i8** %2, align 8
  call void @llvm.dbg.declare(metadata i8** %2, metadata !957, metadata !958), !dbg !959
  call void @llvm.dbg.declare(metadata i32* %3, metadata !960, metadata !958), !dbg !962
  store i32 0, i32* %3, align 4, !dbg !962
  br label %4, !dbg !963

; <label>:4:                                      ; preds = %11, %1
  %5 = load i32, i32* %3, align 4, !dbg !964
  %6 = icmp slt i32 %5, 5, !dbg !967
  br i1 %6, label %7, label %14, !dbg !968

; <label>:7:                                      ; preds = %4
  %8 = load i32, i32* %3, align 4, !dbg !970
  %9 = trunc i32 %8 to i16, !dbg !970
  call void @_ZL29mca_btl_vader_fbox_set_headerttj(i16 zeroext 1, i16 zeroext %9, i32 1024), !dbg !972
  %10 = call i32 @sleep(i32 1), !dbg !973
  br label %11, !dbg !974

; <label>:11:                                     ; preds = %7
  %12 = load i32, i32* %3, align 4, !dbg !975
  %13 = add nsw i32 %12, 1, !dbg !975
  store i32 %13, i32* %3, align 4, !dbg !975
  br label %4, !dbg !977, !llvm.loop !978

; <label>:14:                                     ; preds = %4
  ret i8* null, !dbg !981
}

; Function Attrs: nounwind readnone
declare void @llvm.dbg.declare(metadata, metadata, metadata) #4

; Function Attrs: noinline uwtable
define internal void @_ZL29mca_btl_vader_fbox_set_headerttj(i16 zeroext, i16 zeroext, i32) #0 !dbg !982 {
  %4 = alloca i16, align 2
  %5 = alloca i16, align 2
  %6 = alloca i32, align 4
  %7 = alloca %class.mca_btl_vader_fbox_hdr_t, align 4
  store i16 %0, i16* %4, align 2
  call void @llvm.dbg.declare(metadata i16* %4, metadata !985, metadata !958), !dbg !986
  store i16 %1, i16* %5, align 2
  call void @llvm.dbg.declare(metadata i16* %5, metadata !987, metadata !958), !dbg !988
  store i32 %2, i32* %6, align 4
  call void @llvm.dbg.declare(metadata i32* %6, metadata !989, metadata !958), !dbg !990
  call void @llvm.dbg.declare(metadata %class.mca_btl_vader_fbox_hdr_t* %7, metadata !991, metadata !958), !dbg !992
  %8 = load i16, i16* %4, align 2, !dbg !993
  %9 = load i16, i16* %5, align 2, !dbg !994
  %10 = load i32, i32* %6, align 4, !dbg !995
  call void @_ZN24mca_btl_vader_fbox_hdr_tC2Ettj(%class.mca_btl_vader_fbox_hdr_t* %7, i16 zeroext %8, i16 zeroext %9, i32 %10), !dbg !992
  store %class.mca_btl_vader_fbox_hdr_t* %7, %class.mca_btl_vader_fbox_hdr_t** @global_hdr, align 8, !dbg !996
  call void @_ZL15opal_atomic_wmbv(), !dbg !997
  ret void, !dbg !998
}

declare i32 @sleep(i32) #1

; Function Attrs: noinline uwtable
define i8* @_Z13reader_threadPv(i8*) #0 !dbg !999 {
  %2 = alloca i8*, align 8
  %3 = alloca i32, align 4
  store i8* %0, i8** %2, align 8
  call void @llvm.dbg.declare(metadata i8** %2, metadata !1000, metadata !958), !dbg !1001
  call void @llvm.dbg.declare(metadata i32* %3, metadata !1002, metadata !958), !dbg !1004
  store i32 0, i32* %3, align 4, !dbg !1004
  br label %4, !dbg !1005

; <label>:4:                                      ; preds = %9, %1
  %5 = load i32, i32* %3, align 4, !dbg !1006
  %6 = icmp slt i32 %5, 5, !dbg !1009
  br i1 %6, label %7, label %12, !dbg !1010

; <label>:7:                                      ; preds = %4
  call void @_ZL30mca_btl_vader_fbox_read_headerv(), !dbg !1012
  %8 = call i32 @sleep(i32 1), !dbg !1014
  br label %9, !dbg !1015

; <label>:9:                                      ; preds = %7
  %10 = load i32, i32* %3, align 4, !dbg !1016
  %11 = add nsw i32 %10, 1, !dbg !1016
  store i32 %11, i32* %3, align 4, !dbg !1016
  br label %4, !dbg !1018, !llvm.loop !1019

; <label>:12:                                     ; preds = %4
  ret i8* null, !dbg !1022
}

; Function Attrs: noinline uwtable
define internal void @_ZL30mca_btl_vader_fbox_read_headerv() #0 !dbg !1023 {
  %1 = load %class.mca_btl_vader_fbox_hdr_t*, %class.mca_btl_vader_fbox_hdr_t** @global_hdr, align 8, !dbg !1024
  %2 = bitcast %class.mca_btl_vader_fbox_hdr_t* %1 to i8*, !dbg !1024
  %3 = call dereferenceable(272) %"class.std::basic_ostream"* @_ZNSolsEPKv(%"class.std::basic_ostream"* @_ZSt4cout, i8* %2), !dbg !1025
  ret void, !dbg !1026
}

; Function Attrs: noinline norecurse uwtable
define i32 @main() #5 !dbg !1027 {
  %1 = alloca i32, align 4
  %2 = alloca i64, align 8
  %3 = alloca i64, align 8
  store i32 0, i32* %1, align 4
  call void @llvm.dbg.declare(metadata i64* %2, metadata !1028, metadata !958), !dbg !1031
  call void @llvm.dbg.declare(metadata i64* %3, metadata !1032, metadata !958), !dbg !1033
  %4 = call i32 @pthread_create(i64* %2, %union.pthread_attr_t* null, i8* (i8*)* @_Z13writer_threadPv, i8* null) #3, !dbg !1034
  %5 = call i32 @pthread_create(i64* %3, %union.pthread_attr_t* null, i8* (i8*)* @_Z13reader_threadPv, i8* null) #3, !dbg !1035
  %6 = load i64, i64* %2, align 8, !dbg !1036
  %7 = call i32 @pthread_join(i64 %6, i8** null), !dbg !1037
  %8 = load i64, i64* %3, align 8, !dbg !1038
  %9 = call i32 @pthread_join(i64 %8, i8** null), !dbg !1039
  ret i32 0, !dbg !1040
}

; Function Attrs: nounwind
declare i32 @pthread_create(i64*, %union.pthread_attr_t*, i8* (i8*)*, i8*) #2

declare i32 @pthread_join(i64, i8**) #1

; Function Attrs: noinline nounwind uwtable
define linkonce_odr void @_ZN24mca_btl_vader_fbox_hdr_tC2Ettj(%class.mca_btl_vader_fbox_hdr_t*, i16 zeroext, i16 zeroext, i32) unnamed_addr #6 comdat align 2 !dbg !1041 {
  %5 = alloca %class.mca_btl_vader_fbox_hdr_t*, align 8
  %6 = alloca i16, align 2
  %7 = alloca i16, align 2
  %8 = alloca i32, align 4
  store %class.mca_btl_vader_fbox_hdr_t* %0, %class.mca_btl_vader_fbox_hdr_t** %5, align 8
  call void @llvm.dbg.declare(metadata %class.mca_btl_vader_fbox_hdr_t** %5, metadata !1042, metadata !958), !dbg !1043
  store i16 %1, i16* %6, align 2
  call void @llvm.dbg.declare(metadata i16* %6, metadata !1044, metadata !958), !dbg !1045
  store i16 %2, i16* %7, align 2
  call void @llvm.dbg.declare(metadata i16* %7, metadata !1046, metadata !958), !dbg !1047
  store i32 %3, i32* %8, align 4
  call void @llvm.dbg.declare(metadata i32* %8, metadata !1048, metadata !958), !dbg !1049
  %9 = load %class.mca_btl_vader_fbox_hdr_t*, %class.mca_btl_vader_fbox_hdr_t** %5, align 8
  %10 = getelementptr inbounds %class.mca_btl_vader_fbox_hdr_t, %class.mca_btl_vader_fbox_hdr_t* %9, i32 0, i32 0, !dbg !1050
  %11 = load i32, i32* %8, align 4, !dbg !1051
  store i32 %11, i32* %10, align 4, !dbg !1050
  %12 = getelementptr inbounds %class.mca_btl_vader_fbox_hdr_t, %class.mca_btl_vader_fbox_hdr_t* %9, i32 0, i32 1, !dbg !1052
  %13 = load i16, i16* %6, align 2, !dbg !1053
  store i16 %13, i16* %12, align 4, !dbg !1052
  %14 = getelementptr inbounds %class.mca_btl_vader_fbox_hdr_t, %class.mca_btl_vader_fbox_hdr_t* %9, i32 0, i32 2, !dbg !1054
  %15 = load i16, i16* %7, align 2, !dbg !1055
  store i16 %15, i16* %14, align 2, !dbg !1054
  ret void, !dbg !1056
}

; Function Attrs: noinline nounwind uwtable
define internal void @_ZL15opal_atomic_wmbv() #6 !dbg !1057 {
  %1 = alloca i32, align 4
  call void @llvm.dbg.declare(metadata i32* %1, metadata !1058, metadata !958), !dbg !1063
  store i32 3, i32* %1, align 4
  %2 = load i32, i32* %1, align 4, !dbg !1065
  switch i32 %2, label %7 [
    i32 1, label %3
    i32 2, label %3
    i32 3, label %4
    i32 4, label %5
    i32 5, label %6
  ], !dbg !1066

; <label>:3:                                      ; preds = %0, %0
  fence acquire, !dbg !1067
  br label %7, !dbg !1067

; <label>:4:                                      ; preds = %0
  fence release, !dbg !1069
  br label %7, !dbg !1069

; <label>:5:                                      ; preds = %0
  fence acq_rel, !dbg !1071
  br label %7, !dbg !1071

; <label>:6:                                      ; preds = %0
  fence seq_cst, !dbg !1073
  br label %7, !dbg !1073

; <label>:7:                                      ; preds = %0, %3, %4, %5, %6
  ret void, !dbg !1075
}

declare dereferenceable(272) %"class.std::basic_ostream"* @_ZNSolsEPKv(%"class.std::basic_ostream"*, i8*) #1

; Function Attrs: noinline uwtable
define internal void @_GLOBAL__sub_I_26_ompi.cpp() #0 section ".text.startup" !dbg !1076 {
  call void @__cxx_global_var_init(), !dbg !1078
  ret void
}

attributes #0 = { noinline uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind }
attributes #4 = { nounwind readnone }
attributes #5 = { noinline norecurse uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #6 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!31}
!llvm.module.flags = !{!946, !947}
!llvm.ident = !{!948}

!0 = !DIGlobalVariableExpression(var: !1)
!1 = distinct !DIGlobalVariable(name: "__ioinit", linkageName: "_ZStL8__ioinit", scope: !2, file: !4, line: 74, type: !5, isLocal: true, isDefinition: true)
!2 = !DINamespace(name: "std", scope: null, file: !3, line: 256)
!3 = !DIFile(filename: "/usr/lib/gcc/x86_64-linux-gnu/9/../../../../include/x86_64-linux-gnu/c++/9/bits/c++config.h", directory: "/home/nsas2020/fuzz/targetProcess/reorder")
!4 = !DIFile(filename: "/usr/lib/gcc/x86_64-linux-gnu/9/../../../../include/c++/9/iostream", directory: "/home/nsas2020/fuzz/targetProcess/reorder")
!5 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "Init", scope: !7, file: !6, line: 608, size: 8, elements: !8, identifier: "_ZTSNSt8ios_base4InitE")
!6 = !DIFile(filename: "/usr/lib/gcc/x86_64-linux-gnu/9/../../../../include/c++/9/bits/ios_base.h", directory: "/home/nsas2020/fuzz/targetProcess/reorder")
!7 = !DICompositeType(tag: DW_TAG_class_type, name: "ios_base", scope: !2, file: !6, line: 228, flags: DIFlagFwdDecl, identifier: "_ZTSSt8ios_base")
!8 = !{!9, !13, !15, !19, !20, !25}
!9 = !DIDerivedType(tag: DW_TAG_member, name: "_S_refcount", scope: !5, file: !6, line: 621, baseType: !10, flags: DIFlagStaticMember)
!10 = !DIDerivedType(tag: DW_TAG_typedef, name: "_Atomic_word", file: !11, line: 32, baseType: !12)
!11 = !DIFile(filename: "/usr/lib/gcc/x86_64-linux-gnu/9/../../../../include/x86_64-linux-gnu/c++/9/bits/atomic_word.h", directory: "/home/nsas2020/fuzz/targetProcess/reorder")
!12 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!13 = !DIDerivedType(tag: DW_TAG_member, name: "_S_synced_with_stdio", scope: !5, file: !6, line: 622, baseType: !14, flags: DIFlagStaticMember)
!14 = !DIBasicType(name: "bool", size: 8, encoding: DW_ATE_boolean)
!15 = !DISubprogram(name: "Init", scope: !5, file: !6, line: 612, type: !16, isLocal: false, isDefinition: false, scopeLine: 612, flags: DIFlagPublic | DIFlagPrototyped, isOptimized: false)
!16 = !DISubroutineType(types: !17)
!17 = !{null, !18}
!18 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !5, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!19 = !DISubprogram(name: "~Init", scope: !5, file: !6, line: 613, type: !16, isLocal: false, isDefinition: false, scopeLine: 613, flags: DIFlagPublic | DIFlagPrototyped, isOptimized: false)
!20 = !DISubprogram(name: "Init", scope: !5, file: !6, line: 616, type: !21, isLocal: false, isDefinition: false, scopeLine: 616, flags: DIFlagPublic | DIFlagPrototyped, isOptimized: false)
!21 = !DISubroutineType(types: !22)
!22 = !{null, !18, !23}
!23 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !24, size: 64)
!24 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !5)
!25 = !DISubprogram(name: "operator=", linkageName: "_ZNSt8ios_base4InitaSERKS0_", scope: !5, file: !6, line: 617, type: !26, isLocal: false, isDefinition: false, scopeLine: 617, flags: DIFlagPublic | DIFlagPrototyped, isOptimized: false)
!26 = !DISubroutineType(types: !27)
!27 = !{!28, !18, !23}
!28 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !5, size: 64)
!29 = !DIGlobalVariableExpression(var: !30)
!30 = distinct !DIGlobalVariable(name: "global_hdr", scope: !31, file: !32, line: 30, type: !933, isLocal: false, isDefinition: true)
!31 = distinct !DICompileUnit(language: DW_LANG_C_plus_plus, file: !32, producer: "clang version 4.0.0 (tags/RELEASE_400/final)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !33, retainedTypes: !43, globals: !44, imports: !45)
!32 = !DIFile(filename: "26-ompi.cpp", directory: "/home/nsas2020/fuzz/targetProcess/reorder")
!33 = !{!34}
!34 = !DICompositeType(tag: DW_TAG_enumeration_type, name: "memory_order", scope: !2, file: !35, line: 73, size: 32, elements: !36, identifier: "_ZTSSt12memory_order")
!35 = !DIFile(filename: "/usr/lib/gcc/x86_64-linux-gnu/9/../../../../include/c++/9/bits/atomic_base.h", directory: "/home/nsas2020/fuzz/targetProcess/reorder")
!36 = !{!37, !38, !39, !40, !41, !42}
!37 = !DIEnumerator(name: "memory_order_relaxed", value: 0)
!38 = !DIEnumerator(name: "memory_order_consume", value: 1)
!39 = !DIEnumerator(name: "memory_order_acquire", value: 2)
!40 = !DIEnumerator(name: "memory_order_release", value: 3)
!41 = !DIEnumerator(name: "memory_order_acq_rel", value: 4)
!42 = !DIEnumerator(name: "memory_order_seq_cst", value: 5)
!43 = !{!12}
!44 = !{!0, !29}
!45 = !{!46, !64, !67, !72, !80, !88, !92, !99, !103, !107, !109, !111, !115, !127, !131, !137, !143, !145, !149, !153, !157, !161, !173, !175, !179, !183, !187, !189, !195, !199, !203, !205, !207, !211, !220, !224, !228, !232, !234, !240, !242, !249, !254, !258, !263, !267, !271, !275, !277, !279, !283, !287, !291, !293, !297, !301, !303, !305, !309, !315, !320, !325, !326, !327, !328, !329, !330, !331, !332, !333, !334, !335, !389, !393, !397, !403, !407, !410, !413, !416, !418, !420, !422, !425, !428, !431, !434, !437, !441, !446, !450, !453, !456, !458, !460, !462, !464, !467, !470, !473, !476, !479, !481, !484, !488, !493, !498, !500, !502, !504, !506, !508, !510, !512, !514, !516, !518, !520, !522, !524, !526, !528, !531, !534, !540, !544, !549, !551, !555, !559, !563, !573, !577, !581, !585, !589, !593, !597, !601, !605, !609, !613, !617, !621, !623, !626, !630, !634, !640, !644, !648, !650, !654, !658, !664, !666, !670, !674, !678, !682, !686, !690, !694, !695, !696, !697, !700, !701, !702, !703, !704, !705, !706, !709, !715, !720, !724, !726, !728, !730, !732, !739, !743, !747, !751, !755, !759, !764, !768, !770, !774, !780, !784, !789, !791, !793, !797, !801, !805, !807, !809, !811, !813, !817, !819, !821, !825, !829, !833, !837, !841, !843, !845, !849, !853, !857, !861, !863, !865, !869, !873, !874, !875, !876, !877, !878, !883, !886, !887, !889, !891, !893, !895, !899, !901, !903, !905, !907, !909, !911, !913, !915, !919, !923, !925, !929}
!46 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !47, line: 64)
!47 = !DIDerivedType(tag: DW_TAG_typedef, name: "mbstate_t", file: !48, line: 6, baseType: !49)
!48 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/bits/types/mbstate_t.h", directory: "/home/nsas2020/fuzz/targetProcess/reorder")
!49 = !DIDerivedType(tag: DW_TAG_typedef, name: "__mbstate_t", file: !50, line: 21, baseType: !51)
!50 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/bits/types/__mbstate_t.h", directory: "/home/nsas2020/fuzz/targetProcess/reorder")
!51 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !50, line: 13, size: 64, elements: !52, identifier: "_ZTS11__mbstate_t")
!52 = !{!53, !54}
!53 = !DIDerivedType(tag: DW_TAG_member, name: "__count", scope: !51, file: !50, line: 15, baseType: !12, size: 32)
!54 = !DIDerivedType(tag: DW_TAG_member, name: "__value", scope: !51, file: !50, line: 20, baseType: !55, size: 32, offset: 32)
!55 = distinct !DICompositeType(tag: DW_TAG_union_type, scope: !51, file: !50, line: 16, size: 32, elements: !56, identifier: "_ZTSN11__mbstate_tUt_E")
!56 = !{!57, !59}
!57 = !DIDerivedType(tag: DW_TAG_member, name: "__wch", scope: !55, file: !50, line: 18, baseType: !58, size: 32)
!58 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!59 = !DIDerivedType(tag: DW_TAG_member, name: "__wchb", scope: !55, file: !50, line: 19, baseType: !60, size: 32)
!60 = !DICompositeType(tag: DW_TAG_array_type, baseType: !61, size: 32, elements: !62)
!61 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!62 = !{!63}
!63 = !DISubrange(count: 4)
!64 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !65, line: 141)
!65 = !DIDerivedType(tag: DW_TAG_typedef, name: "wint_t", file: !66, line: 20, baseType: !58)
!66 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/bits/types/wint_t.h", directory: "/home/nsas2020/fuzz/targetProcess/reorder")
!67 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !68, line: 143)
!68 = !DISubprogram(name: "btowc", scope: !69, file: !69, line: 284, type: !70, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!69 = !DIFile(filename: "/usr/include/wchar.h", directory: "/home/nsas2020/fuzz/targetProcess/reorder")
!70 = !DISubroutineType(types: !71)
!71 = !{!65, !12}
!72 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !73, line: 144)
!73 = !DISubprogram(name: "fgetwc", scope: !69, file: !69, line: 726, type: !74, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!74 = !DISubroutineType(types: !75)
!75 = !{!65, !76}
!76 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !77, size: 64)
!77 = !DIDerivedType(tag: DW_TAG_typedef, name: "__FILE", file: !78, line: 5, baseType: !79)
!78 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/bits/types/__FILE.h", directory: "/home/nsas2020/fuzz/targetProcess/reorder")
!79 = !DICompositeType(tag: DW_TAG_structure_type, name: "_IO_FILE", file: !78, line: 4, flags: DIFlagFwdDecl, identifier: "_ZTS8_IO_FILE")
!80 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !81, line: 145)
!81 = !DISubprogram(name: "fgetws", scope: !69, file: !69, line: 755, type: !82, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!82 = !DISubroutineType(types: !83)
!83 = !{!84, !86, !12, !87}
!84 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !85, size: 64)
!85 = !DIBasicType(name: "wchar_t", size: 32, encoding: DW_ATE_signed)
!86 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !84)
!87 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !76)
!88 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !89, line: 146)
!89 = !DISubprogram(name: "fputwc", scope: !69, file: !69, line: 740, type: !90, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!90 = !DISubroutineType(types: !91)
!91 = !{!65, !85, !76}
!92 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !93, line: 147)
!93 = !DISubprogram(name: "fputws", scope: !69, file: !69, line: 762, type: !94, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!94 = !DISubroutineType(types: !95)
!95 = !{!12, !96, !87}
!96 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !97)
!97 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !98, size: 64)
!98 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !85)
!99 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !100, line: 148)
!100 = !DISubprogram(name: "fwide", scope: !69, file: !69, line: 573, type: !101, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!101 = !DISubroutineType(types: !102)
!102 = !{!12, !76, !12}
!103 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !104, line: 149)
!104 = !DISubprogram(name: "fwprintf", scope: !69, file: !69, line: 580, type: !105, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!105 = !DISubroutineType(types: !106)
!106 = !{!12, !87, !96, null}
!107 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !108, line: 150)
!108 = !DISubprogram(name: "fwscanf", linkageName: "__isoc99_fwscanf", scope: !69, file: !69, line: 640, type: !105, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!109 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !110, line: 151)
!110 = !DISubprogram(name: "getwc", scope: !69, file: !69, line: 727, type: !74, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!111 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !112, line: 152)
!112 = !DISubprogram(name: "getwchar", scope: !69, file: !69, line: 733, type: !113, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!113 = !DISubroutineType(types: !114)
!114 = !{!65}
!115 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !116, line: 153)
!116 = !DISubprogram(name: "mbrlen", scope: !69, file: !69, line: 307, type: !117, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!117 = !DISubroutineType(types: !118)
!118 = !{!119, !122, !119, !125}
!119 = !DIDerivedType(tag: DW_TAG_typedef, name: "size_t", file: !120, line: 62, baseType: !121)
!120 = !DIFile(filename: "/usr/local/clang-4.0/bin/../lib/clang/4.0.0/include/stddef.h", directory: "/home/nsas2020/fuzz/targetProcess/reorder")
!121 = !DIBasicType(name: "long unsigned int", size: 64, encoding: DW_ATE_unsigned)
!122 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !123)
!123 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !124, size: 64)
!124 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !61)
!125 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !126)
!126 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !47, size: 64)
!127 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !128, line: 154)
!128 = !DISubprogram(name: "mbrtowc", scope: !69, file: !69, line: 296, type: !129, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!129 = !DISubroutineType(types: !130)
!130 = !{!119, !86, !122, !119, !125}
!131 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !132, line: 155)
!132 = !DISubprogram(name: "mbsinit", scope: !69, file: !69, line: 292, type: !133, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!133 = !DISubroutineType(types: !134)
!134 = !{!12, !135}
!135 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !136, size: 64)
!136 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !47)
!137 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !138, line: 156)
!138 = !DISubprogram(name: "mbsrtowcs", scope: !69, file: !69, line: 337, type: !139, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!139 = !DISubroutineType(types: !140)
!140 = !{!119, !86, !141, !119, !125}
!141 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !142)
!142 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !123, size: 64)
!143 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !144, line: 157)
!144 = !DISubprogram(name: "putwc", scope: !69, file: !69, line: 741, type: !90, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!145 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !146, line: 158)
!146 = !DISubprogram(name: "putwchar", scope: !69, file: !69, line: 747, type: !147, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!147 = !DISubroutineType(types: !148)
!148 = !{!65, !85}
!149 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !150, line: 160)
!150 = !DISubprogram(name: "swprintf", scope: !69, file: !69, line: 590, type: !151, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!151 = !DISubroutineType(types: !152)
!152 = !{!12, !86, !119, !96, null}
!153 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !154, line: 162)
!154 = !DISubprogram(name: "swscanf", linkageName: "__isoc99_swscanf", scope: !69, file: !69, line: 647, type: !155, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!155 = !DISubroutineType(types: !156)
!156 = !{!12, !96, !96, null}
!157 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !158, line: 163)
!158 = !DISubprogram(name: "ungetwc", scope: !69, file: !69, line: 770, type: !159, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!159 = !DISubroutineType(types: !160)
!160 = !{!65, !65, !76}
!161 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !162, line: 164)
!162 = !DISubprogram(name: "vfwprintf", scope: !69, file: !69, line: 598, type: !163, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!163 = !DISubroutineType(types: !164)
!164 = !{!12, !87, !96, !165}
!165 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !166, size: 64)
!166 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "__va_list_tag", file: !32, size: 192, elements: !167, identifier: "_ZTS13__va_list_tag")
!167 = !{!168, !169, !170, !172}
!168 = !DIDerivedType(tag: DW_TAG_member, name: "gp_offset", scope: !166, file: !32, baseType: !58, size: 32)
!169 = !DIDerivedType(tag: DW_TAG_member, name: "fp_offset", scope: !166, file: !32, baseType: !58, size: 32, offset: 32)
!170 = !DIDerivedType(tag: DW_TAG_member, name: "overflow_arg_area", scope: !166, file: !32, baseType: !171, size: 64, offset: 64)
!171 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!172 = !DIDerivedType(tag: DW_TAG_member, name: "reg_save_area", scope: !166, file: !32, baseType: !171, size: 64, offset: 128)
!173 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !174, line: 166)
!174 = !DISubprogram(name: "vfwscanf", linkageName: "__isoc99_vfwscanf", scope: !69, file: !69, line: 693, type: !163, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!175 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !176, line: 169)
!176 = !DISubprogram(name: "vswprintf", scope: !69, file: !69, line: 611, type: !177, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!177 = !DISubroutineType(types: !178)
!178 = !{!12, !86, !119, !96, !165}
!179 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !180, line: 172)
!180 = !DISubprogram(name: "vswscanf", linkageName: "__isoc99_vswscanf", scope: !69, file: !69, line: 700, type: !181, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!181 = !DISubroutineType(types: !182)
!182 = !{!12, !96, !96, !165}
!183 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !184, line: 174)
!184 = !DISubprogram(name: "vwprintf", scope: !69, file: !69, line: 606, type: !185, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!185 = !DISubroutineType(types: !186)
!186 = !{!12, !96, !165}
!187 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !188, line: 176)
!188 = !DISubprogram(name: "vwscanf", linkageName: "__isoc99_vwscanf", scope: !69, file: !69, line: 697, type: !185, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!189 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !190, line: 178)
!190 = !DISubprogram(name: "wcrtomb", scope: !69, file: !69, line: 301, type: !191, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!191 = !DISubroutineType(types: !192)
!192 = !{!119, !193, !85, !125}
!193 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !194)
!194 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !61, size: 64)
!195 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !196, line: 179)
!196 = !DISubprogram(name: "wcscat", scope: !69, file: !69, line: 97, type: !197, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!197 = !DISubroutineType(types: !198)
!198 = !{!84, !86, !96}
!199 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !200, line: 180)
!200 = !DISubprogram(name: "wcscmp", scope: !69, file: !69, line: 106, type: !201, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!201 = !DISubroutineType(types: !202)
!202 = !{!12, !97, !97}
!203 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !204, line: 181)
!204 = !DISubprogram(name: "wcscoll", scope: !69, file: !69, line: 131, type: !201, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!205 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !206, line: 182)
!206 = !DISubprogram(name: "wcscpy", scope: !69, file: !69, line: 87, type: !197, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!207 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !208, line: 183)
!208 = !DISubprogram(name: "wcscspn", scope: !69, file: !69, line: 187, type: !209, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!209 = !DISubroutineType(types: !210)
!210 = !{!119, !97, !97}
!211 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !212, line: 184)
!212 = !DISubprogram(name: "wcsftime", scope: !69, file: !69, line: 834, type: !213, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!213 = !DISubroutineType(types: !214)
!214 = !{!119, !86, !119, !96, !215}
!215 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !216)
!216 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !217, size: 64)
!217 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !218)
!218 = !DICompositeType(tag: DW_TAG_structure_type, name: "tm", file: !219, line: 7, flags: DIFlagFwdDecl, identifier: "_ZTS2tm")
!219 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/bits/types/struct_tm.h", directory: "/home/nsas2020/fuzz/targetProcess/reorder")
!220 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !221, line: 185)
!221 = !DISubprogram(name: "wcslen", scope: !69, file: !69, line: 222, type: !222, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!222 = !DISubroutineType(types: !223)
!223 = !{!119, !97}
!224 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !225, line: 186)
!225 = !DISubprogram(name: "wcsncat", scope: !69, file: !69, line: 101, type: !226, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!226 = !DISubroutineType(types: !227)
!227 = !{!84, !86, !96, !119}
!228 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !229, line: 187)
!229 = !DISubprogram(name: "wcsncmp", scope: !69, file: !69, line: 109, type: !230, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!230 = !DISubroutineType(types: !231)
!231 = !{!12, !97, !97, !119}
!232 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !233, line: 188)
!233 = !DISubprogram(name: "wcsncpy", scope: !69, file: !69, line: 92, type: !226, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!234 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !235, line: 189)
!235 = !DISubprogram(name: "wcsrtombs", scope: !69, file: !69, line: 343, type: !236, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!236 = !DISubroutineType(types: !237)
!237 = !{!119, !193, !238, !119, !125}
!238 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !239)
!239 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !97, size: 64)
!240 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !241, line: 190)
!241 = !DISubprogram(name: "wcsspn", scope: !69, file: !69, line: 191, type: !209, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!242 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !243, line: 191)
!243 = !DISubprogram(name: "wcstod", scope: !69, file: !69, line: 377, type: !244, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!244 = !DISubroutineType(types: !245)
!245 = !{!246, !96, !247}
!246 = !DIBasicType(name: "double", size: 64, encoding: DW_ATE_float)
!247 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !248)
!248 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !84, size: 64)
!249 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !250, line: 193)
!250 = !DISubprogram(name: "wcstof", scope: !69, file: !69, line: 382, type: !251, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!251 = !DISubroutineType(types: !252)
!252 = !{!253, !96, !247}
!253 = !DIBasicType(name: "float", size: 32, encoding: DW_ATE_float)
!254 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !255, line: 195)
!255 = !DISubprogram(name: "wcstok", scope: !69, file: !69, line: 217, type: !256, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!256 = !DISubroutineType(types: !257)
!257 = !{!84, !86, !96, !247}
!258 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !259, line: 196)
!259 = !DISubprogram(name: "wcstol", scope: !69, file: !69, line: 428, type: !260, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!260 = !DISubroutineType(types: !261)
!261 = !{!262, !96, !247, !12}
!262 = !DIBasicType(name: "long int", size: 64, encoding: DW_ATE_signed)
!263 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !264, line: 197)
!264 = !DISubprogram(name: "wcstoul", scope: !69, file: !69, line: 433, type: !265, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!265 = !DISubroutineType(types: !266)
!266 = !{!121, !96, !247, !12}
!267 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !268, line: 198)
!268 = !DISubprogram(name: "wcsxfrm", scope: !69, file: !69, line: 135, type: !269, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!269 = !DISubroutineType(types: !270)
!270 = !{!119, !86, !96, !119}
!271 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !272, line: 199)
!272 = !DISubprogram(name: "wctob", scope: !69, file: !69, line: 288, type: !273, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!273 = !DISubroutineType(types: !274)
!274 = !{!12, !65}
!275 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !276, line: 200)
!276 = !DISubprogram(name: "wmemcmp", scope: !69, file: !69, line: 258, type: !230, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!277 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !278, line: 201)
!278 = !DISubprogram(name: "wmemcpy", scope: !69, file: !69, line: 262, type: !226, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!279 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !280, line: 202)
!280 = !DISubprogram(name: "wmemmove", scope: !69, file: !69, line: 267, type: !281, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!281 = !DISubroutineType(types: !282)
!282 = !{!84, !84, !97, !119}
!283 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !284, line: 203)
!284 = !DISubprogram(name: "wmemset", scope: !69, file: !69, line: 271, type: !285, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!285 = !DISubroutineType(types: !286)
!286 = !{!84, !84, !85, !119}
!287 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !288, line: 204)
!288 = !DISubprogram(name: "wprintf", scope: !69, file: !69, line: 587, type: !289, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!289 = !DISubroutineType(types: !290)
!290 = !{!12, !96, null}
!291 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !292, line: 205)
!292 = !DISubprogram(name: "wscanf", linkageName: "__isoc99_wscanf", scope: !69, file: !69, line: 644, type: !289, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!293 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !294, line: 206)
!294 = !DISubprogram(name: "wcschr", scope: !69, file: !69, line: 164, type: !295, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!295 = !DISubroutineType(types: !296)
!296 = !{!84, !97, !85}
!297 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !298, line: 207)
!298 = !DISubprogram(name: "wcspbrk", scope: !69, file: !69, line: 201, type: !299, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!299 = !DISubroutineType(types: !300)
!300 = !{!84, !97, !97}
!301 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !302, line: 208)
!302 = !DISubprogram(name: "wcsrchr", scope: !69, file: !69, line: 174, type: !295, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!303 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !304, line: 209)
!304 = !DISubprogram(name: "wcsstr", scope: !69, file: !69, line: 212, type: !299, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!305 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !306, line: 210)
!306 = !DISubprogram(name: "wmemchr", scope: !69, file: !69, line: 253, type: !307, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!307 = !DISubroutineType(types: !308)
!308 = !{!84, !97, !85, !119}
!309 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !310, entity: !311, line: 251)
!310 = !DINamespace(name: "__gnu_cxx", scope: null, file: !3, line: 282)
!311 = !DISubprogram(name: "wcstold", scope: !69, file: !69, line: 384, type: !312, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!312 = !DISubroutineType(types: !313)
!313 = !{!314, !96, !247}
!314 = !DIBasicType(name: "long double", size: 128, encoding: DW_ATE_float)
!315 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !310, entity: !316, line: 260)
!316 = !DISubprogram(name: "wcstoll", scope: !69, file: !69, line: 441, type: !317, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!317 = !DISubroutineType(types: !318)
!318 = !{!319, !96, !247, !12}
!319 = !DIBasicType(name: "long long int", size: 64, encoding: DW_ATE_signed)
!320 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !310, entity: !321, line: 261)
!321 = !DISubprogram(name: "wcstoull", scope: !69, file: !69, line: 448, type: !322, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!322 = !DISubroutineType(types: !323)
!323 = !{!324, !96, !247, !12}
!324 = !DIBasicType(name: "long long unsigned int", size: 64, encoding: DW_ATE_unsigned)
!325 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !311, line: 267)
!326 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !316, line: 268)
!327 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !321, line: 269)
!328 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !250, line: 283)
!329 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !174, line: 286)
!330 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !180, line: 289)
!331 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !188, line: 292)
!332 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !311, line: 296)
!333 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !316, line: 297)
!334 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !321, line: 298)
!335 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !336, line: 57)
!336 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "exception_ptr", scope: !338, file: !337, line: 79, size: 64, elements: !339, identifier: "_ZTSNSt15__exception_ptr13exception_ptrE")
!337 = !DIFile(filename: "/usr/lib/gcc/x86_64-linux-gnu/9/../../../../include/c++/9/bits/exception_ptr.h", directory: "/home/nsas2020/fuzz/targetProcess/reorder")
!338 = !DINamespace(name: "__exception_ptr", scope: !2, file: !337, line: 52)
!339 = !{!340, !341, !345, !348, !349, !354, !355, !359, !364, !368, !372, !375, !376, !379, !382}
!340 = !DIDerivedType(tag: DW_TAG_member, name: "_M_exception_object", scope: !336, file: !337, line: 81, baseType: !171, size: 64)
!341 = !DISubprogram(name: "exception_ptr", scope: !336, file: !337, line: 83, type: !342, isLocal: false, isDefinition: false, scopeLine: 83, flags: DIFlagExplicit | DIFlagPrototyped, isOptimized: false)
!342 = !DISubroutineType(types: !343)
!343 = !{null, !344, !171}
!344 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !336, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!345 = !DISubprogram(name: "_M_addref", linkageName: "_ZNSt15__exception_ptr13exception_ptr9_M_addrefEv", scope: !336, file: !337, line: 85, type: !346, isLocal: false, isDefinition: false, scopeLine: 85, flags: DIFlagPrototyped, isOptimized: false)
!346 = !DISubroutineType(types: !347)
!347 = !{null, !344}
!348 = !DISubprogram(name: "_M_release", linkageName: "_ZNSt15__exception_ptr13exception_ptr10_M_releaseEv", scope: !336, file: !337, line: 86, type: !346, isLocal: false, isDefinition: false, scopeLine: 86, flags: DIFlagPrototyped, isOptimized: false)
!349 = !DISubprogram(name: "_M_get", linkageName: "_ZNKSt15__exception_ptr13exception_ptr6_M_getEv", scope: !336, file: !337, line: 88, type: !350, isLocal: false, isDefinition: false, scopeLine: 88, flags: DIFlagPrototyped, isOptimized: false)
!350 = !DISubroutineType(types: !351)
!351 = !{!171, !352}
!352 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !353, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!353 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !336)
!354 = !DISubprogram(name: "exception_ptr", scope: !336, file: !337, line: 96, type: !346, isLocal: false, isDefinition: false, scopeLine: 96, flags: DIFlagPublic | DIFlagPrototyped, isOptimized: false)
!355 = !DISubprogram(name: "exception_ptr", scope: !336, file: !337, line: 98, type: !356, isLocal: false, isDefinition: false, scopeLine: 98, flags: DIFlagPublic | DIFlagPrototyped, isOptimized: false)
!356 = !DISubroutineType(types: !357)
!357 = !{null, !344, !358}
!358 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !353, size: 64)
!359 = !DISubprogram(name: "exception_ptr", scope: !336, file: !337, line: 101, type: !360, isLocal: false, isDefinition: false, scopeLine: 101, flags: DIFlagPublic | DIFlagPrototyped, isOptimized: false)
!360 = !DISubroutineType(types: !361)
!361 = !{null, !344, !362}
!362 = !DIDerivedType(tag: DW_TAG_typedef, name: "nullptr_t", scope: !2, file: !3, line: 262, baseType: !363)
!363 = !DIBasicType(tag: DW_TAG_unspecified_type, name: "decltype(nullptr)")
!364 = !DISubprogram(name: "exception_ptr", scope: !336, file: !337, line: 105, type: !365, isLocal: false, isDefinition: false, scopeLine: 105, flags: DIFlagPublic | DIFlagPrototyped, isOptimized: false)
!365 = !DISubroutineType(types: !366)
!366 = !{null, !344, !367}
!367 = !DIDerivedType(tag: DW_TAG_rvalue_reference_type, baseType: !336, size: 64)
!368 = !DISubprogram(name: "operator=", linkageName: "_ZNSt15__exception_ptr13exception_ptraSERKS0_", scope: !336, file: !337, line: 118, type: !369, isLocal: false, isDefinition: false, scopeLine: 118, flags: DIFlagPublic | DIFlagPrototyped, isOptimized: false)
!369 = !DISubroutineType(types: !370)
!370 = !{!371, !344, !358}
!371 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !336, size: 64)
!372 = !DISubprogram(name: "operator=", linkageName: "_ZNSt15__exception_ptr13exception_ptraSEOS0_", scope: !336, file: !337, line: 122, type: !373, isLocal: false, isDefinition: false, scopeLine: 122, flags: DIFlagPublic | DIFlagPrototyped, isOptimized: false)
!373 = !DISubroutineType(types: !374)
!374 = !{!371, !344, !367}
!375 = !DISubprogram(name: "~exception_ptr", scope: !336, file: !337, line: 129, type: !346, isLocal: false, isDefinition: false, scopeLine: 129, flags: DIFlagPublic | DIFlagPrototyped, isOptimized: false)
!376 = !DISubprogram(name: "swap", linkageName: "_ZNSt15__exception_ptr13exception_ptr4swapERS0_", scope: !336, file: !337, line: 132, type: !377, isLocal: false, isDefinition: false, scopeLine: 132, flags: DIFlagPublic | DIFlagPrototyped, isOptimized: false)
!377 = !DISubroutineType(types: !378)
!378 = !{null, !344, !371}
!379 = !DISubprogram(name: "operator bool", linkageName: "_ZNKSt15__exception_ptr13exception_ptrcvbEv", scope: !336, file: !337, line: 144, type: !380, isLocal: false, isDefinition: false, scopeLine: 144, flags: DIFlagPublic | DIFlagExplicit | DIFlagPrototyped, isOptimized: false)
!380 = !DISubroutineType(types: !381)
!381 = !{!14, !352}
!382 = !DISubprogram(name: "__cxa_exception_type", linkageName: "_ZNKSt15__exception_ptr13exception_ptr20__cxa_exception_typeEv", scope: !336, file: !337, line: 153, type: !383, isLocal: false, isDefinition: false, scopeLine: 153, flags: DIFlagPublic | DIFlagPrototyped, isOptimized: false)
!383 = !DISubroutineType(types: !384)
!384 = !{!385, !352}
!385 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !386, size: 64)
!386 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !387)
!387 = !DICompositeType(tag: DW_TAG_class_type, name: "type_info", scope: !2, file: !388, line: 88, flags: DIFlagFwdDecl, identifier: "_ZTSSt9type_info")
!388 = !DIFile(filename: "/usr/lib/gcc/x86_64-linux-gnu/9/../../../../include/c++/9/typeinfo", directory: "/home/nsas2020/fuzz/targetProcess/reorder")
!389 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !338, entity: !390, line: 73)
!390 = !DISubprogram(name: "rethrow_exception", linkageName: "_ZSt17rethrow_exceptionNSt15__exception_ptr13exception_ptrE", scope: !2, file: !337, line: 69, type: !391, isLocal: false, isDefinition: false, flags: DIFlagPrototyped | DIFlagNoReturn, isOptimized: false)
!391 = !DISubroutineType(types: !392)
!392 = !{null, !336}
!393 = !DIImportedEntity(tag: DW_TAG_imported_module, scope: !394, entity: !396, line: 58)
!394 = !DINamespace(name: "__gnu_debug", scope: null, file: !395, line: 56)
!395 = !DIFile(filename: "/usr/lib/gcc/x86_64-linux-gnu/9/../../../../include/c++/9/debug/debug.h", directory: "/home/nsas2020/fuzz/targetProcess/reorder")
!396 = !DINamespace(name: "__debug", scope: !2, file: !395, line: 50)
!397 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !398, line: 47)
!398 = !DIDerivedType(tag: DW_TAG_typedef, name: "int8_t", file: !399, line: 24, baseType: !400)
!399 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/bits/stdint-intn.h", directory: "/home/nsas2020/fuzz/targetProcess/reorder")
!400 = !DIDerivedType(tag: DW_TAG_typedef, name: "__int8_t", file: !401, line: 37, baseType: !402)
!401 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/bits/types.h", directory: "/home/nsas2020/fuzz/targetProcess/reorder")
!402 = !DIBasicType(name: "signed char", size: 8, encoding: DW_ATE_signed_char)
!403 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !404, line: 48)
!404 = !DIDerivedType(tag: DW_TAG_typedef, name: "int16_t", file: !399, line: 25, baseType: !405)
!405 = !DIDerivedType(tag: DW_TAG_typedef, name: "__int16_t", file: !401, line: 39, baseType: !406)
!406 = !DIBasicType(name: "short", size: 16, encoding: DW_ATE_signed)
!407 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !408, line: 49)
!408 = !DIDerivedType(tag: DW_TAG_typedef, name: "int32_t", file: !399, line: 26, baseType: !409)
!409 = !DIDerivedType(tag: DW_TAG_typedef, name: "__int32_t", file: !401, line: 41, baseType: !12)
!410 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !411, line: 50)
!411 = !DIDerivedType(tag: DW_TAG_typedef, name: "int64_t", file: !399, line: 27, baseType: !412)
!412 = !DIDerivedType(tag: DW_TAG_typedef, name: "__int64_t", file: !401, line: 44, baseType: !262)
!413 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !414, line: 52)
!414 = !DIDerivedType(tag: DW_TAG_typedef, name: "int_fast8_t", file: !415, line: 58, baseType: !402)
!415 = !DIFile(filename: "/usr/include/stdint.h", directory: "/home/nsas2020/fuzz/targetProcess/reorder")
!416 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !417, line: 53)
!417 = !DIDerivedType(tag: DW_TAG_typedef, name: "int_fast16_t", file: !415, line: 60, baseType: !262)
!418 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !419, line: 54)
!419 = !DIDerivedType(tag: DW_TAG_typedef, name: "int_fast32_t", file: !415, line: 61, baseType: !262)
!420 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !421, line: 55)
!421 = !DIDerivedType(tag: DW_TAG_typedef, name: "int_fast64_t", file: !415, line: 62, baseType: !262)
!422 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !423, line: 57)
!423 = !DIDerivedType(tag: DW_TAG_typedef, name: "int_least8_t", file: !415, line: 43, baseType: !424)
!424 = !DIDerivedType(tag: DW_TAG_typedef, name: "__int_least8_t", file: !401, line: 52, baseType: !400)
!425 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !426, line: 58)
!426 = !DIDerivedType(tag: DW_TAG_typedef, name: "int_least16_t", file: !415, line: 44, baseType: !427)
!427 = !DIDerivedType(tag: DW_TAG_typedef, name: "__int_least16_t", file: !401, line: 54, baseType: !405)
!428 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !429, line: 59)
!429 = !DIDerivedType(tag: DW_TAG_typedef, name: "int_least32_t", file: !415, line: 45, baseType: !430)
!430 = !DIDerivedType(tag: DW_TAG_typedef, name: "__int_least32_t", file: !401, line: 56, baseType: !409)
!431 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !432, line: 60)
!432 = !DIDerivedType(tag: DW_TAG_typedef, name: "int_least64_t", file: !415, line: 46, baseType: !433)
!433 = !DIDerivedType(tag: DW_TAG_typedef, name: "__int_least64_t", file: !401, line: 58, baseType: !412)
!434 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !435, line: 62)
!435 = !DIDerivedType(tag: DW_TAG_typedef, name: "intmax_t", file: !415, line: 101, baseType: !436)
!436 = !DIDerivedType(tag: DW_TAG_typedef, name: "__intmax_t", file: !401, line: 72, baseType: !262)
!437 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !438, line: 63)
!438 = !DIDerivedType(tag: DW_TAG_typedef, name: "intptr_t", file: !439, line: 267, baseType: !440)
!439 = !DIFile(filename: "/usr/include/unistd.h", directory: "/home/nsas2020/fuzz/targetProcess/reorder")
!440 = !DIDerivedType(tag: DW_TAG_typedef, name: "__intptr_t", file: !401, line: 206, baseType: !262)
!441 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !442, line: 65)
!442 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint8_t", file: !443, line: 24, baseType: !444)
!443 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/bits/stdint-uintn.h", directory: "/home/nsas2020/fuzz/targetProcess/reorder")
!444 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uint8_t", file: !401, line: 38, baseType: !445)
!445 = !DIBasicType(name: "unsigned char", size: 8, encoding: DW_ATE_unsigned_char)
!446 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !447, line: 66)
!447 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint16_t", file: !443, line: 25, baseType: !448)
!448 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uint16_t", file: !401, line: 40, baseType: !449)
!449 = !DIBasicType(name: "unsigned short", size: 16, encoding: DW_ATE_unsigned)
!450 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !451, line: 67)
!451 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint32_t", file: !443, line: 26, baseType: !452)
!452 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uint32_t", file: !401, line: 42, baseType: !58)
!453 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !454, line: 68)
!454 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint64_t", file: !443, line: 27, baseType: !455)
!455 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uint64_t", file: !401, line: 45, baseType: !121)
!456 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !457, line: 70)
!457 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint_fast8_t", file: !415, line: 71, baseType: !445)
!458 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !459, line: 71)
!459 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint_fast16_t", file: !415, line: 73, baseType: !121)
!460 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !461, line: 72)
!461 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint_fast32_t", file: !415, line: 74, baseType: !121)
!462 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !463, line: 73)
!463 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint_fast64_t", file: !415, line: 75, baseType: !121)
!464 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !465, line: 75)
!465 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint_least8_t", file: !415, line: 49, baseType: !466)
!466 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uint_least8_t", file: !401, line: 53, baseType: !444)
!467 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !468, line: 76)
!468 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint_least16_t", file: !415, line: 50, baseType: !469)
!469 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uint_least16_t", file: !401, line: 55, baseType: !448)
!470 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !471, line: 77)
!471 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint_least32_t", file: !415, line: 51, baseType: !472)
!472 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uint_least32_t", file: !401, line: 57, baseType: !452)
!473 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !474, line: 78)
!474 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint_least64_t", file: !415, line: 52, baseType: !475)
!475 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uint_least64_t", file: !401, line: 59, baseType: !455)
!476 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !477, line: 80)
!477 = !DIDerivedType(tag: DW_TAG_typedef, name: "uintmax_t", file: !415, line: 102, baseType: !478)
!478 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uintmax_t", file: !401, line: 73, baseType: !121)
!479 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !480, line: 81)
!480 = !DIDerivedType(tag: DW_TAG_typedef, name: "uintptr_t", file: !415, line: 90, baseType: !121)
!481 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !482, line: 53)
!482 = !DICompositeType(tag: DW_TAG_structure_type, name: "lconv", file: !483, line: 51, flags: DIFlagFwdDecl, identifier: "_ZTS5lconv")
!483 = !DIFile(filename: "/usr/include/locale.h", directory: "/home/nsas2020/fuzz/targetProcess/reorder")
!484 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !485, line: 54)
!485 = !DISubprogram(name: "setlocale", scope: !483, file: !483, line: 122, type: !486, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!486 = !DISubroutineType(types: !487)
!487 = !{!194, !12, !123}
!488 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !489, line: 55)
!489 = !DISubprogram(name: "localeconv", scope: !483, file: !483, line: 125, type: !490, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!490 = !DISubroutineType(types: !491)
!491 = !{!492}
!492 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !482, size: 64)
!493 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !494, line: 64)
!494 = !DISubprogram(name: "isalnum", scope: !495, file: !495, line: 108, type: !496, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!495 = !DIFile(filename: "/usr/include/ctype.h", directory: "/home/nsas2020/fuzz/targetProcess/reorder")
!496 = !DISubroutineType(types: !497)
!497 = !{!12, !12}
!498 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !499, line: 65)
!499 = !DISubprogram(name: "isalpha", scope: !495, file: !495, line: 109, type: !496, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!500 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !501, line: 66)
!501 = !DISubprogram(name: "iscntrl", scope: !495, file: !495, line: 110, type: !496, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!502 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !503, line: 67)
!503 = !DISubprogram(name: "isdigit", scope: !495, file: !495, line: 111, type: !496, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!504 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !505, line: 68)
!505 = !DISubprogram(name: "isgraph", scope: !495, file: !495, line: 113, type: !496, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!506 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !507, line: 69)
!507 = !DISubprogram(name: "islower", scope: !495, file: !495, line: 112, type: !496, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!508 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !509, line: 70)
!509 = !DISubprogram(name: "isprint", scope: !495, file: !495, line: 114, type: !496, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!510 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !511, line: 71)
!511 = !DISubprogram(name: "ispunct", scope: !495, file: !495, line: 115, type: !496, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!512 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !513, line: 72)
!513 = !DISubprogram(name: "isspace", scope: !495, file: !495, line: 116, type: !496, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!514 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !515, line: 73)
!515 = !DISubprogram(name: "isupper", scope: !495, file: !495, line: 117, type: !496, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!516 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !517, line: 74)
!517 = !DISubprogram(name: "isxdigit", scope: !495, file: !495, line: 118, type: !496, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!518 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !519, line: 75)
!519 = !DISubprogram(name: "tolower", scope: !495, file: !495, line: 122, type: !496, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!520 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !521, line: 76)
!521 = !DISubprogram(name: "toupper", scope: !495, file: !495, line: 125, type: !496, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!522 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !523, line: 87)
!523 = !DISubprogram(name: "isblank", scope: !495, file: !495, line: 130, type: !496, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!524 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !310, entity: !525, line: 44)
!525 = !DIDerivedType(tag: DW_TAG_typedef, name: "size_t", scope: !2, file: !3, line: 258, baseType: !121)
!526 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !310, entity: !527, line: 45)
!527 = !DIDerivedType(tag: DW_TAG_typedef, name: "ptrdiff_t", scope: !2, file: !3, line: 259, baseType: !262)
!528 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !529, line: 52)
!529 = !DISubprogram(name: "abs", scope: !530, file: !530, line: 840, type: !496, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!530 = !DIFile(filename: "/usr/include/stdlib.h", directory: "/home/nsas2020/fuzz/targetProcess/reorder")
!531 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !532, line: 127)
!532 = !DIDerivedType(tag: DW_TAG_typedef, name: "div_t", file: !530, line: 62, baseType: !533)
!533 = !DICompositeType(tag: DW_TAG_structure_type, file: !530, line: 58, flags: DIFlagFwdDecl, identifier: "_ZTS5div_t")
!534 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !535, line: 128)
!535 = !DIDerivedType(tag: DW_TAG_typedef, name: "ldiv_t", file: !530, line: 70, baseType: !536)
!536 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !530, line: 66, size: 128, elements: !537, identifier: "_ZTS6ldiv_t")
!537 = !{!538, !539}
!538 = !DIDerivedType(tag: DW_TAG_member, name: "quot", scope: !536, file: !530, line: 68, baseType: !262, size: 64)
!539 = !DIDerivedType(tag: DW_TAG_member, name: "rem", scope: !536, file: !530, line: 69, baseType: !262, size: 64, offset: 64)
!540 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !541, line: 130)
!541 = !DISubprogram(name: "abort", scope: !530, file: !530, line: 591, type: !542, isLocal: false, isDefinition: false, flags: DIFlagPrototyped | DIFlagNoReturn, isOptimized: false)
!542 = !DISubroutineType(types: !543)
!543 = !{null}
!544 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !545, line: 134)
!545 = !DISubprogram(name: "atexit", scope: !530, file: !530, line: 595, type: !546, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!546 = !DISubroutineType(types: !547)
!547 = !{!12, !548}
!548 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !542, size: 64)
!549 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !550, line: 137)
!550 = !DISubprogram(name: "at_quick_exit", scope: !530, file: !530, line: 600, type: !546, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!551 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !552, line: 140)
!552 = !DISubprogram(name: "atof", scope: !530, file: !530, line: 101, type: !553, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!553 = !DISubroutineType(types: !554)
!554 = !{!246, !123}
!555 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !556, line: 141)
!556 = !DISubprogram(name: "atoi", scope: !530, file: !530, line: 104, type: !557, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!557 = !DISubroutineType(types: !558)
!558 = !{!12, !123}
!559 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !560, line: 142)
!560 = !DISubprogram(name: "atol", scope: !530, file: !530, line: 107, type: !561, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!561 = !DISubroutineType(types: !562)
!562 = !{!262, !123}
!563 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !564, line: 143)
!564 = !DISubprogram(name: "bsearch", scope: !530, file: !530, line: 820, type: !565, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!565 = !DISubroutineType(types: !566)
!566 = !{!171, !567, !567, !119, !119, !569}
!567 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !568, size: 64)
!568 = !DIDerivedType(tag: DW_TAG_const_type, baseType: null)
!569 = !DIDerivedType(tag: DW_TAG_typedef, name: "__compar_fn_t", file: !530, line: 808, baseType: !570)
!570 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !571, size: 64)
!571 = !DISubroutineType(types: !572)
!572 = !{!12, !567, !567}
!573 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !574, line: 144)
!574 = !DISubprogram(name: "calloc", scope: !530, file: !530, line: 542, type: !575, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!575 = !DISubroutineType(types: !576)
!576 = !{!171, !119, !119}
!577 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !578, line: 145)
!578 = !DISubprogram(name: "div", scope: !530, file: !530, line: 852, type: !579, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!579 = !DISubroutineType(types: !580)
!580 = !{!532, !12, !12}
!581 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !582, line: 146)
!582 = !DISubprogram(name: "exit", scope: !530, file: !530, line: 617, type: !583, isLocal: false, isDefinition: false, flags: DIFlagPrototyped | DIFlagNoReturn, isOptimized: false)
!583 = !DISubroutineType(types: !584)
!584 = !{null, !12}
!585 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !586, line: 147)
!586 = !DISubprogram(name: "free", scope: !530, file: !530, line: 565, type: !587, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!587 = !DISubroutineType(types: !588)
!588 = !{null, !171}
!589 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !590, line: 148)
!590 = !DISubprogram(name: "getenv", scope: !530, file: !530, line: 634, type: !591, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!591 = !DISubroutineType(types: !592)
!592 = !{!194, !123}
!593 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !594, line: 149)
!594 = !DISubprogram(name: "labs", scope: !530, file: !530, line: 841, type: !595, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!595 = !DISubroutineType(types: !596)
!596 = !{!262, !262}
!597 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !598, line: 150)
!598 = !DISubprogram(name: "ldiv", scope: !530, file: !530, line: 854, type: !599, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!599 = !DISubroutineType(types: !600)
!600 = !{!535, !262, !262}
!601 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !602, line: 151)
!602 = !DISubprogram(name: "malloc", scope: !530, file: !530, line: 539, type: !603, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!603 = !DISubroutineType(types: !604)
!604 = !{!171, !119}
!605 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !606, line: 153)
!606 = !DISubprogram(name: "mblen", scope: !530, file: !530, line: 922, type: !607, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!607 = !DISubroutineType(types: !608)
!608 = !{!12, !123, !119}
!609 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !610, line: 154)
!610 = !DISubprogram(name: "mbstowcs", scope: !530, file: !530, line: 933, type: !611, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!611 = !DISubroutineType(types: !612)
!612 = !{!119, !86, !122, !119}
!613 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !614, line: 155)
!614 = !DISubprogram(name: "mbtowc", scope: !530, file: !530, line: 925, type: !615, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!615 = !DISubroutineType(types: !616)
!616 = !{!12, !86, !122, !119}
!617 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !618, line: 157)
!618 = !DISubprogram(name: "qsort", scope: !530, file: !530, line: 830, type: !619, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!619 = !DISubroutineType(types: !620)
!620 = !{null, !171, !119, !119, !569}
!621 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !622, line: 160)
!622 = !DISubprogram(name: "quick_exit", scope: !530, file: !530, line: 623, type: !583, isLocal: false, isDefinition: false, flags: DIFlagPrototyped | DIFlagNoReturn, isOptimized: false)
!623 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !624, line: 163)
!624 = !DISubprogram(name: "rand", scope: !530, file: !530, line: 453, type: !625, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!625 = !DISubroutineType(types: !43)
!626 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !627, line: 164)
!627 = !DISubprogram(name: "realloc", scope: !530, file: !530, line: 550, type: !628, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!628 = !DISubroutineType(types: !629)
!629 = !{!171, !171, !119}
!630 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !631, line: 165)
!631 = !DISubprogram(name: "srand", scope: !530, file: !530, line: 455, type: !632, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!632 = !DISubroutineType(types: !633)
!633 = !{null, !58}
!634 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !635, line: 166)
!635 = !DISubprogram(name: "strtod", scope: !530, file: !530, line: 117, type: !636, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!636 = !DISubroutineType(types: !637)
!637 = !{!246, !122, !638}
!638 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !639)
!639 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !194, size: 64)
!640 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !641, line: 167)
!641 = !DISubprogram(name: "strtol", scope: !530, file: !530, line: 176, type: !642, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!642 = !DISubroutineType(types: !643)
!643 = !{!262, !122, !638, !12}
!644 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !645, line: 168)
!645 = !DISubprogram(name: "strtoul", scope: !530, file: !530, line: 180, type: !646, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!646 = !DISubroutineType(types: !647)
!647 = !{!121, !122, !638, !12}
!648 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !649, line: 169)
!649 = !DISubprogram(name: "system", scope: !530, file: !530, line: 784, type: !557, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!650 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !651, line: 171)
!651 = !DISubprogram(name: "wcstombs", scope: !530, file: !530, line: 936, type: !652, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!652 = !DISubroutineType(types: !653)
!653 = !{!119, !193, !96, !119}
!654 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !655, line: 172)
!655 = !DISubprogram(name: "wctomb", scope: !530, file: !530, line: 929, type: !656, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!656 = !DISubroutineType(types: !657)
!657 = !{!12, !194, !85}
!658 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !310, entity: !659, line: 200)
!659 = !DIDerivedType(tag: DW_TAG_typedef, name: "lldiv_t", file: !530, line: 80, baseType: !660)
!660 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !530, line: 76, size: 128, elements: !661, identifier: "_ZTS7lldiv_t")
!661 = !{!662, !663}
!662 = !DIDerivedType(tag: DW_TAG_member, name: "quot", scope: !660, file: !530, line: 78, baseType: !319, size: 64)
!663 = !DIDerivedType(tag: DW_TAG_member, name: "rem", scope: !660, file: !530, line: 79, baseType: !319, size: 64, offset: 64)
!664 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !310, entity: !665, line: 206)
!665 = !DISubprogram(name: "_Exit", scope: !530, file: !530, line: 629, type: !583, isLocal: false, isDefinition: false, flags: DIFlagPrototyped | DIFlagNoReturn, isOptimized: false)
!666 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !310, entity: !667, line: 210)
!667 = !DISubprogram(name: "llabs", scope: !530, file: !530, line: 844, type: !668, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!668 = !DISubroutineType(types: !669)
!669 = !{!319, !319}
!670 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !310, entity: !671, line: 216)
!671 = !DISubprogram(name: "lldiv", scope: !530, file: !530, line: 858, type: !672, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!672 = !DISubroutineType(types: !673)
!673 = !{!659, !319, !319}
!674 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !310, entity: !675, line: 227)
!675 = !DISubprogram(name: "atoll", scope: !530, file: !530, line: 112, type: !676, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!676 = !DISubroutineType(types: !677)
!677 = !{!319, !123}
!678 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !310, entity: !679, line: 228)
!679 = !DISubprogram(name: "strtoll", scope: !530, file: !530, line: 200, type: !680, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!680 = !DISubroutineType(types: !681)
!681 = !{!319, !122, !638, !12}
!682 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !310, entity: !683, line: 229)
!683 = !DISubprogram(name: "strtoull", scope: !530, file: !530, line: 205, type: !684, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!684 = !DISubroutineType(types: !685)
!685 = !{!324, !122, !638, !12}
!686 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !310, entity: !687, line: 231)
!687 = !DISubprogram(name: "strtof", scope: !530, file: !530, line: 123, type: !688, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!688 = !DISubroutineType(types: !689)
!689 = !{!253, !122, !638}
!690 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !310, entity: !691, line: 232)
!691 = !DISubprogram(name: "strtold", scope: !530, file: !530, line: 126, type: !692, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!692 = !DISubroutineType(types: !693)
!693 = !{!314, !122, !638}
!694 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !659, line: 240)
!695 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !665, line: 242)
!696 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !667, line: 244)
!697 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !698, line: 245)
!698 = !DISubprogram(name: "div", linkageName: "_ZN9__gnu_cxx3divExx", scope: !310, file: !699, line: 213, type: !672, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!699 = !DIFile(filename: "/usr/lib/gcc/x86_64-linux-gnu/9/../../../../include/c++/9/cstdlib", directory: "/home/nsas2020/fuzz/targetProcess/reorder")
!700 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !671, line: 246)
!701 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !675, line: 248)
!702 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !687, line: 249)
!703 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !679, line: 250)
!704 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !683, line: 251)
!705 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !691, line: 252)
!706 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !707, line: 98)
!707 = !DIDerivedType(tag: DW_TAG_typedef, name: "FILE", file: !708, line: 7, baseType: !79)
!708 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/bits/types/FILE.h", directory: "/home/nsas2020/fuzz/targetProcess/reorder")
!709 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !710, line: 99)
!710 = !DIDerivedType(tag: DW_TAG_typedef, name: "fpos_t", file: !711, line: 84, baseType: !712)
!711 = !DIFile(filename: "/usr/include/stdio.h", directory: "/home/nsas2020/fuzz/targetProcess/reorder")
!712 = !DIDerivedType(tag: DW_TAG_typedef, name: "__fpos_t", file: !713, line: 14, baseType: !714)
!713 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/bits/types/__fpos_t.h", directory: "/home/nsas2020/fuzz/targetProcess/reorder")
!714 = !DICompositeType(tag: DW_TAG_structure_type, name: "_G_fpos_t", file: !713, line: 10, flags: DIFlagFwdDecl, identifier: "_ZTS9_G_fpos_t")
!715 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !716, line: 101)
!716 = !DISubprogram(name: "clearerr", scope: !711, file: !711, line: 757, type: !717, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!717 = !DISubroutineType(types: !718)
!718 = !{null, !719}
!719 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !707, size: 64)
!720 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !721, line: 102)
!721 = !DISubprogram(name: "fclose", scope: !711, file: !711, line: 213, type: !722, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!722 = !DISubroutineType(types: !723)
!723 = !{!12, !719}
!724 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !725, line: 103)
!725 = !DISubprogram(name: "feof", scope: !711, file: !711, line: 759, type: !722, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!726 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !727, line: 104)
!727 = !DISubprogram(name: "ferror", scope: !711, file: !711, line: 761, type: !722, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!728 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !729, line: 105)
!729 = !DISubprogram(name: "fflush", scope: !711, file: !711, line: 218, type: !722, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!730 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !731, line: 106)
!731 = !DISubprogram(name: "fgetc", scope: !711, file: !711, line: 485, type: !722, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!732 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !733, line: 107)
!733 = !DISubprogram(name: "fgetpos", scope: !711, file: !711, line: 731, type: !734, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!734 = !DISubroutineType(types: !735)
!735 = !{!12, !736, !737}
!736 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !719)
!737 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !738)
!738 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !710, size: 64)
!739 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !740, line: 108)
!740 = !DISubprogram(name: "fgets", scope: !711, file: !711, line: 564, type: !741, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!741 = !DISubroutineType(types: !742)
!742 = !{!194, !193, !12, !736}
!743 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !744, line: 109)
!744 = !DISubprogram(name: "fopen", scope: !711, file: !711, line: 246, type: !745, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!745 = !DISubroutineType(types: !746)
!746 = !{!719, !122, !122}
!747 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !748, line: 110)
!748 = !DISubprogram(name: "fprintf", scope: !711, file: !711, line: 326, type: !749, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!749 = !DISubroutineType(types: !750)
!750 = !{!12, !736, !122, null}
!751 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !752, line: 111)
!752 = !DISubprogram(name: "fputc", scope: !711, file: !711, line: 521, type: !753, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!753 = !DISubroutineType(types: !754)
!754 = !{!12, !12, !719}
!755 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !756, line: 112)
!756 = !DISubprogram(name: "fputs", scope: !711, file: !711, line: 626, type: !757, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!757 = !DISubroutineType(types: !758)
!758 = !{!12, !122, !736}
!759 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !760, line: 113)
!760 = !DISubprogram(name: "fread", scope: !711, file: !711, line: 646, type: !761, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!761 = !DISubroutineType(types: !762)
!762 = !{!119, !763, !119, !119, !736}
!763 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !171)
!764 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !765, line: 114)
!765 = !DISubprogram(name: "freopen", scope: !711, file: !711, line: 252, type: !766, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!766 = !DISubroutineType(types: !767)
!767 = !{!719, !122, !122, !736}
!768 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !769, line: 115)
!769 = !DISubprogram(name: "fscanf", linkageName: "__isoc99_fscanf", scope: !711, file: !711, line: 407, type: !749, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!770 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !771, line: 116)
!771 = !DISubprogram(name: "fseek", scope: !711, file: !711, line: 684, type: !772, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!772 = !DISubroutineType(types: !773)
!773 = !{!12, !719, !262, !12}
!774 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !775, line: 117)
!775 = !DISubprogram(name: "fsetpos", scope: !711, file: !711, line: 736, type: !776, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!776 = !DISubroutineType(types: !777)
!777 = !{!12, !719, !778}
!778 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !779, size: 64)
!779 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !710)
!780 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !781, line: 118)
!781 = !DISubprogram(name: "ftell", scope: !711, file: !711, line: 689, type: !782, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!782 = !DISubroutineType(types: !783)
!783 = !{!262, !719}
!784 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !785, line: 119)
!785 = !DISubprogram(name: "fwrite", scope: !711, file: !711, line: 652, type: !786, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!786 = !DISubroutineType(types: !787)
!787 = !{!119, !788, !119, !119, !736}
!788 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !567)
!789 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !790, line: 120)
!790 = !DISubprogram(name: "getc", scope: !711, file: !711, line: 486, type: !722, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!791 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !792, line: 121)
!792 = !DISubprogram(name: "getchar", scope: !711, file: !711, line: 492, type: !625, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!793 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !794, line: 124)
!794 = !DISubprogram(name: "gets", scope: !711, file: !711, line: 577, type: !795, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!795 = !DISubroutineType(types: !796)
!796 = !{!194, !194}
!797 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !798, line: 126)
!798 = !DISubprogram(name: "perror", scope: !711, file: !711, line: 775, type: !799, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!799 = !DISubroutineType(types: !800)
!800 = !{null, !123}
!801 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !802, line: 127)
!802 = !DISubprogram(name: "printf", scope: !711, file: !711, line: 332, type: !803, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!803 = !DISubroutineType(types: !804)
!804 = !{!12, !122, null}
!805 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !806, line: 128)
!806 = !DISubprogram(name: "putc", scope: !711, file: !711, line: 522, type: !753, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!807 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !808, line: 129)
!808 = !DISubprogram(name: "putchar", scope: !711, file: !711, line: 528, type: !496, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!809 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !810, line: 130)
!810 = !DISubprogram(name: "puts", scope: !711, file: !711, line: 632, type: !557, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!811 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !812, line: 131)
!812 = !DISubprogram(name: "remove", scope: !711, file: !711, line: 146, type: !557, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!813 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !814, line: 132)
!814 = !DISubprogram(name: "rename", scope: !711, file: !711, line: 148, type: !815, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!815 = !DISubroutineType(types: !816)
!816 = !{!12, !123, !123}
!817 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !818, line: 133)
!818 = !DISubprogram(name: "rewind", scope: !711, file: !711, line: 694, type: !717, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!819 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !820, line: 134)
!820 = !DISubprogram(name: "scanf", linkageName: "__isoc99_scanf", scope: !711, file: !711, line: 410, type: !803, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!821 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !822, line: 135)
!822 = !DISubprogram(name: "setbuf", scope: !711, file: !711, line: 304, type: !823, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!823 = !DISubroutineType(types: !824)
!824 = !{null, !736, !193}
!825 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !826, line: 136)
!826 = !DISubprogram(name: "setvbuf", scope: !711, file: !711, line: 308, type: !827, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!827 = !DISubroutineType(types: !828)
!828 = !{!12, !736, !193, !12, !119}
!829 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !830, line: 137)
!830 = !DISubprogram(name: "sprintf", scope: !711, file: !711, line: 334, type: !831, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!831 = !DISubroutineType(types: !832)
!832 = !{!12, !193, !122, null}
!833 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !834, line: 138)
!834 = !DISubprogram(name: "sscanf", linkageName: "__isoc99_sscanf", scope: !711, file: !711, line: 412, type: !835, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!835 = !DISubroutineType(types: !836)
!836 = !{!12, !122, !122, null}
!837 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !838, line: 139)
!838 = !DISubprogram(name: "tmpfile", scope: !711, file: !711, line: 173, type: !839, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!839 = !DISubroutineType(types: !840)
!840 = !{!719}
!841 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !842, line: 141)
!842 = !DISubprogram(name: "tmpnam", scope: !711, file: !711, line: 187, type: !795, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!843 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !844, line: 143)
!844 = !DISubprogram(name: "ungetc", scope: !711, file: !711, line: 639, type: !753, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!845 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !846, line: 144)
!846 = !DISubprogram(name: "vfprintf", scope: !711, file: !711, line: 341, type: !847, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!847 = !DISubroutineType(types: !848)
!848 = !{!12, !736, !122, !165}
!849 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !850, line: 145)
!850 = !DISubprogram(name: "vprintf", scope: !711, file: !711, line: 347, type: !851, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!851 = !DISubroutineType(types: !852)
!852 = !{!12, !122, !165}
!853 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !854, line: 146)
!854 = !DISubprogram(name: "vsprintf", scope: !711, file: !711, line: 349, type: !855, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!855 = !DISubroutineType(types: !856)
!856 = !{!12, !193, !122, !165}
!857 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !310, entity: !858, line: 175)
!858 = !DISubprogram(name: "snprintf", scope: !711, file: !711, line: 354, type: !859, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!859 = !DISubroutineType(types: !860)
!860 = !{!12, !193, !119, !122, null}
!861 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !310, entity: !862, line: 176)
!862 = !DISubprogram(name: "vfscanf", linkageName: "__isoc99_vfscanf", scope: !711, file: !711, line: 451, type: !847, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!863 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !310, entity: !864, line: 177)
!864 = !DISubprogram(name: "vscanf", linkageName: "__isoc99_vscanf", scope: !711, file: !711, line: 456, type: !851, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!865 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !310, entity: !866, line: 178)
!866 = !DISubprogram(name: "vsnprintf", scope: !711, file: !711, line: 358, type: !867, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!867 = !DISubroutineType(types: !868)
!868 = !{!12, !193, !119, !122, !165}
!869 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !310, entity: !870, line: 179)
!870 = !DISubprogram(name: "vsscanf", linkageName: "__isoc99_vsscanf", scope: !711, file: !711, line: 459, type: !871, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!871 = !DISubroutineType(types: !872)
!872 = !{!12, !122, !122, !165}
!873 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !858, line: 185)
!874 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !862, line: 186)
!875 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !864, line: 187)
!876 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !866, line: 188)
!877 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !870, line: 189)
!878 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !879, line: 82)
!879 = !DIDerivedType(tag: DW_TAG_typedef, name: "wctrans_t", file: !880, line: 48, baseType: !881)
!880 = !DIFile(filename: "/usr/include/wctype.h", directory: "/home/nsas2020/fuzz/targetProcess/reorder")
!881 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !882, size: 64)
!882 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !409)
!883 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !884, line: 83)
!884 = !DIDerivedType(tag: DW_TAG_typedef, name: "wctype_t", file: !885, line: 38, baseType: !121)
!885 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/bits/wctype-wchar.h", directory: "/home/nsas2020/fuzz/targetProcess/reorder")
!886 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !65, line: 84)
!887 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !888, line: 86)
!888 = !DISubprogram(name: "iswalnum", scope: !885, file: !885, line: 95, type: !273, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!889 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !890, line: 87)
!890 = !DISubprogram(name: "iswalpha", scope: !885, file: !885, line: 101, type: !273, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!891 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !892, line: 89)
!892 = !DISubprogram(name: "iswblank", scope: !885, file: !885, line: 146, type: !273, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!893 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !894, line: 91)
!894 = !DISubprogram(name: "iswcntrl", scope: !885, file: !885, line: 104, type: !273, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!895 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !896, line: 92)
!896 = !DISubprogram(name: "iswctype", scope: !885, file: !885, line: 159, type: !897, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!897 = !DISubroutineType(types: !898)
!898 = !{!12, !65, !884}
!899 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !900, line: 93)
!900 = !DISubprogram(name: "iswdigit", scope: !885, file: !885, line: 108, type: !273, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!901 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !902, line: 94)
!902 = !DISubprogram(name: "iswgraph", scope: !885, file: !885, line: 112, type: !273, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!903 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !904, line: 95)
!904 = !DISubprogram(name: "iswlower", scope: !885, file: !885, line: 117, type: !273, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!905 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !906, line: 96)
!906 = !DISubprogram(name: "iswprint", scope: !885, file: !885, line: 120, type: !273, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!907 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !908, line: 97)
!908 = !DISubprogram(name: "iswpunct", scope: !885, file: !885, line: 125, type: !273, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!909 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !910, line: 98)
!910 = !DISubprogram(name: "iswspace", scope: !885, file: !885, line: 130, type: !273, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!911 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !912, line: 99)
!912 = !DISubprogram(name: "iswupper", scope: !885, file: !885, line: 135, type: !273, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!913 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !914, line: 100)
!914 = !DISubprogram(name: "iswxdigit", scope: !885, file: !885, line: 140, type: !273, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!915 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !916, line: 101)
!916 = !DISubprogram(name: "towctrans", scope: !880, file: !880, line: 55, type: !917, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!917 = !DISubroutineType(types: !918)
!918 = !{!65, !65, !879}
!919 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !920, line: 102)
!920 = !DISubprogram(name: "towlower", scope: !885, file: !885, line: 166, type: !921, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!921 = !DISubroutineType(types: !922)
!922 = !{!65, !65}
!923 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !924, line: 103)
!924 = !DISubprogram(name: "towupper", scope: !885, file: !885, line: 169, type: !921, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!925 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !926, line: 104)
!926 = !DISubprogram(name: "wctrans", scope: !880, file: !880, line: 52, type: !927, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!927 = !DISubroutineType(types: !928)
!928 = !{!879, !123}
!929 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !930, line: 105)
!930 = !DISubprogram(name: "wctype", scope: !885, file: !885, line: 155, type: !931, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!931 = !DISubroutineType(types: !932)
!932 = !{!884, !123}
!933 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !934, size: 64)
!934 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "mca_btl_vader_fbox_hdr_t", file: !32, line: 10, size: 64, elements: !935, identifier: "_ZTS24mca_btl_vader_fbox_hdr_t")
!935 = !{!936, !937, !938, !939, !943}
!936 = !DIDerivedType(tag: DW_TAG_member, name: "size", scope: !934, file: !32, line: 12, baseType: !451, size: 32, flags: DIFlagPublic)
!937 = !DIDerivedType(tag: DW_TAG_member, name: "tag", scope: !934, file: !32, line: 13, baseType: !447, size: 16, offset: 32, flags: DIFlagPublic)
!938 = !DIDerivedType(tag: DW_TAG_member, name: "seq", scope: !934, file: !32, line: 14, baseType: !447, size: 16, offset: 48, flags: DIFlagPublic)
!939 = !DISubprogram(name: "mca_btl_vader_fbox_hdr_t", scope: !934, file: !32, line: 15, type: !940, isLocal: false, isDefinition: false, scopeLine: 15, flags: DIFlagPublic | DIFlagPrototyped, isOptimized: false)
!940 = !DISubroutineType(types: !941)
!941 = !{null, !942, !447, !447, !451}
!942 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !934, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!943 = !DISubprogram(name: "mca_btl_vader_fbox_hdr_t", scope: !934, file: !32, line: 16, type: !944, isLocal: false, isDefinition: false, scopeLine: 16, flags: DIFlagPublic | DIFlagPrototyped, isOptimized: false)
!944 = !DISubroutineType(types: !945)
!945 = !{null, !942}
!946 = !{i32 2, !"Dwarf Version", i32 4}
!947 = !{i32 2, !"Debug Info Version", i32 3}
!948 = !{!"clang version 4.0.0 (tags/RELEASE_400/final)"}
!949 = distinct !DISubprogram(name: "__cxx_global_var_init", scope: !4, file: !4, line: 74, type: !542, isLocal: true, isDefinition: true, scopeLine: 74, flags: DIFlagPrototyped, isOptimized: false, unit: !31, variables: !950)
!950 = !{}
!951 = !DILocation(line: 74, column: 25, scope: !949)
!952 = !DILocation(line: 74, column: 25, scope: !953)
!953 = !DILexicalBlockFile(scope: !949, file: !4, discriminator: 1)
!954 = distinct !DISubprogram(name: "writer_thread", linkageName: "_Z13writer_threadPv", scope: !32, file: !32, line: 50, type: !955, isLocal: false, isDefinition: true, scopeLine: 50, flags: DIFlagPrototyped, isOptimized: false, unit: !31, variables: !950)
!955 = !DISubroutineType(types: !956)
!956 = !{!171, !171}
!957 = !DILocalVariable(name: "arg", arg: 1, scope: !954, file: !32, line: 50, type: !171)
!958 = !DIExpression()
!959 = !DILocation(line: 50, column: 27, scope: !954)
!960 = !DILocalVariable(name: "i", scope: !961, file: !32, line: 51, type: !12)
!961 = distinct !DILexicalBlock(scope: !954, file: !32, line: 51, column: 5)
!962 = !DILocation(line: 51, column: 14, scope: !961)
!963 = !DILocation(line: 51, column: 10, scope: !961)
!964 = !DILocation(line: 51, column: 21, scope: !965)
!965 = !DILexicalBlockFile(scope: !966, file: !32, discriminator: 1)
!966 = distinct !DILexicalBlock(scope: !961, file: !32, line: 51, column: 5)
!967 = !DILocation(line: 51, column: 23, scope: !965)
!968 = !DILocation(line: 51, column: 5, scope: !969)
!969 = !DILexicalBlockFile(scope: !961, file: !32, discriminator: 1)
!970 = !DILocation(line: 52, column: 42, scope: !971)
!971 = distinct !DILexicalBlock(scope: !966, file: !32, line: 51, column: 33)
!972 = !DILocation(line: 52, column: 9, scope: !971)
!973 = !DILocation(line: 53, column: 9, scope: !971)
!974 = !DILocation(line: 54, column: 5, scope: !971)
!975 = !DILocation(line: 51, column: 28, scope: !976)
!976 = !DILexicalBlockFile(scope: !966, file: !32, discriminator: 2)
!977 = !DILocation(line: 51, column: 5, scope: !976)
!978 = distinct !{!978, !979, !980}
!979 = !DILocation(line: 51, column: 5, scope: !961)
!980 = !DILocation(line: 54, column: 5, scope: !961)
!981 = !DILocation(line: 55, column: 5, scope: !954)
!982 = distinct !DISubprogram(name: "mca_btl_vader_fbox_set_header", linkageName: "_ZL29mca_btl_vader_fbox_set_headerttj", scope: !32, file: !32, line: 33, type: !983, isLocal: true, isDefinition: true, scopeLine: 35, flags: DIFlagPrototyped, isOptimized: false, unit: !31, variables: !950)
!983 = !DISubroutineType(types: !984)
!984 = !{null, !447, !447, !451}
!985 = !DILocalVariable(name: "tag", arg: 1, scope: !982, file: !32, line: 33, type: !447)
!986 = !DILocation(line: 33, column: 59, scope: !982)
!987 = !DILocalVariable(name: "seq", arg: 2, scope: !982, file: !32, line: 34, type: !447)
!988 = !DILocation(line: 34, column: 59, scope: !982)
!989 = !DILocalVariable(name: "size", arg: 3, scope: !982, file: !32, line: 34, type: !451)
!990 = !DILocation(line: 34, column: 73, scope: !982)
!991 = !DILocalVariable(name: "tmp", scope: !982, file: !32, line: 36, type: !934)
!992 = !DILocation(line: 36, column: 30, scope: !982)
!993 = !DILocation(line: 36, column: 34, scope: !982)
!994 = !DILocation(line: 36, column: 39, scope: !982)
!995 = !DILocation(line: 36, column: 44, scope: !982)
!996 = !DILocation(line: 37, column: 16, scope: !982)
!997 = !DILocation(line: 38, column: 5, scope: !982)
!998 = !DILocation(line: 39, column: 1, scope: !982)
!999 = distinct !DISubprogram(name: "reader_thread", linkageName: "_Z13reader_threadPv", scope: !32, file: !32, line: 59, type: !955, isLocal: false, isDefinition: true, scopeLine: 59, flags: DIFlagPrototyped, isOptimized: false, unit: !31, variables: !950)
!1000 = !DILocalVariable(name: "arg", arg: 1, scope: !999, file: !32, line: 59, type: !171)
!1001 = !DILocation(line: 59, column: 27, scope: !999)
!1002 = !DILocalVariable(name: "i", scope: !1003, file: !32, line: 60, type: !12)
!1003 = distinct !DILexicalBlock(scope: !999, file: !32, line: 60, column: 5)
!1004 = !DILocation(line: 60, column: 14, scope: !1003)
!1005 = !DILocation(line: 60, column: 10, scope: !1003)
!1006 = !DILocation(line: 60, column: 21, scope: !1007)
!1007 = !DILexicalBlockFile(scope: !1008, file: !32, discriminator: 1)
!1008 = distinct !DILexicalBlock(scope: !1003, file: !32, line: 60, column: 5)
!1009 = !DILocation(line: 60, column: 23, scope: !1007)
!1010 = !DILocation(line: 60, column: 5, scope: !1011)
!1011 = !DILexicalBlockFile(scope: !1003, file: !32, discriminator: 1)
!1012 = !DILocation(line: 61, column: 9, scope: !1013)
!1013 = distinct !DILexicalBlock(scope: !1008, file: !32, line: 60, column: 33)
!1014 = !DILocation(line: 62, column: 9, scope: !1013)
!1015 = !DILocation(line: 63, column: 5, scope: !1013)
!1016 = !DILocation(line: 60, column: 28, scope: !1017)
!1017 = !DILexicalBlockFile(scope: !1008, file: !32, discriminator: 2)
!1018 = !DILocation(line: 60, column: 5, scope: !1017)
!1019 = distinct !{!1019, !1020, !1021}
!1020 = !DILocation(line: 60, column: 5, scope: !1003)
!1021 = !DILocation(line: 63, column: 5, scope: !1003)
!1022 = !DILocation(line: 64, column: 5, scope: !999)
!1023 = distinct !DISubprogram(name: "mca_btl_vader_fbox_read_header", linkageName: "_ZL30mca_btl_vader_fbox_read_headerv", scope: !32, file: !32, line: 42, type: !542, isLocal: true, isDefinition: true, scopeLine: 43, flags: DIFlagPrototyped, isOptimized: false, unit: !31, variables: !950)
!1024 = !DILocation(line: 44, column: 16, scope: !1023)
!1025 = !DILocation(line: 44, column: 14, scope: !1023)
!1026 = !DILocation(line: 45, column: 1, scope: !1023)
!1027 = distinct !DISubprogram(name: "main", scope: !32, file: !32, line: 68, type: !625, isLocal: false, isDefinition: true, scopeLine: 68, flags: DIFlagPrototyped, isOptimized: false, unit: !31, variables: !950)
!1028 = !DILocalVariable(name: "writer", scope: !1027, file: !32, line: 69, type: !1029)
!1029 = !DIDerivedType(tag: DW_TAG_typedef, name: "pthread_t", file: !1030, line: 27, baseType: !121)
!1030 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/bits/pthreadtypes.h", directory: "/home/nsas2020/fuzz/targetProcess/reorder")
!1031 = !DILocation(line: 69, column: 15, scope: !1027)
!1032 = !DILocalVariable(name: "reader", scope: !1027, file: !32, line: 69, type: !1029)
!1033 = !DILocation(line: 69, column: 23, scope: !1027)
!1034 = !DILocation(line: 70, column: 5, scope: !1027)
!1035 = !DILocation(line: 71, column: 5, scope: !1027)
!1036 = !DILocation(line: 72, column: 18, scope: !1027)
!1037 = !DILocation(line: 72, column: 5, scope: !1027)
!1038 = !DILocation(line: 73, column: 18, scope: !1027)
!1039 = !DILocation(line: 73, column: 5, scope: !1027)
!1040 = !DILocation(line: 74, column: 5, scope: !1027)
!1041 = distinct !DISubprogram(name: "mca_btl_vader_fbox_hdr_t", linkageName: "_ZN24mca_btl_vader_fbox_hdr_tC2Ettj", scope: !934, file: !32, line: 15, type: !940, isLocal: false, isDefinition: true, scopeLine: 15, flags: DIFlagPrototyped, isOptimized: false, unit: !31, declaration: !939, variables: !950)
!1042 = !DILocalVariable(name: "this", arg: 1, scope: !1041, type: !933, flags: DIFlagArtificial | DIFlagObjectPointer)
!1043 = !DILocation(line: 0, scope: !1041)
!1044 = !DILocalVariable(name: "t", arg: 2, scope: !1041, file: !32, line: 15, type: !447)
!1045 = !DILocation(line: 15, column: 39, scope: !1041)
!1046 = !DILocalVariable(name: "s", arg: 3, scope: !1041, file: !32, line: 15, type: !447)
!1047 = !DILocation(line: 15, column: 51, scope: !1041)
!1048 = !DILocalVariable(name: "sz", arg: 4, scope: !1041, file: !32, line: 15, type: !451)
!1049 = !DILocation(line: 15, column: 63, scope: !1041)
!1050 = !DILocation(line: 15, column: 85, scope: !1041)
!1051 = !DILocation(line: 15, column: 90, scope: !1041)
!1052 = !DILocation(line: 15, column: 69, scope: !1041)
!1053 = !DILocation(line: 15, column: 73, scope: !1041)
!1054 = !DILocation(line: 15, column: 77, scope: !1041)
!1055 = !DILocation(line: 15, column: 81, scope: !1041)
!1056 = !DILocation(line: 15, column: 95, scope: !1041)
!1057 = distinct !DISubprogram(name: "opal_atomic_wmb", linkageName: "_ZL15opal_atomic_wmbv", scope: !32, file: !32, line: 20, type: !542, isLocal: true, isDefinition: true, scopeLine: 20, flags: DIFlagPrototyped, isOptimized: false, unit: !31, variables: !950)
!1058 = !DILocalVariable(name: "__m", arg: 1, scope: !1059, file: !35, line: 120, type: !1062)
!1059 = distinct !DISubprogram(name: "atomic_thread_fence", linkageName: "_ZSt19atomic_thread_fenceSt12memory_order", scope: !2, file: !35, line: 120, type: !1060, isLocal: false, isDefinition: true, scopeLine: 121, flags: DIFlagPrototyped, isOptimized: false, unit: !31, variables: !950)
!1060 = !DISubroutineType(types: !1061)
!1061 = !{null, !1062}
!1062 = !DIDerivedType(tag: DW_TAG_typedef, name: "memory_order", scope: !2, file: !35, line: 81, baseType: !34)
!1063 = !DILocation(line: 120, column: 36, scope: !1059, inlinedAt: !1064)
!1064 = distinct !DILocation(line: 21, column: 5, scope: !1057)
!1065 = !DILocation(line: 121, column: 31, scope: !1059, inlinedAt: !1064)
!1066 = !DILocation(line: 121, column: 5, scope: !1059, inlinedAt: !1064)
!1067 = !DILocation(line: 121, column: 5, scope: !1068, inlinedAt: !1064)
!1068 = !DILexicalBlockFile(scope: !1059, file: !35, discriminator: 1)
!1069 = !DILocation(line: 121, column: 5, scope: !1070, inlinedAt: !1064)
!1070 = !DILexicalBlockFile(scope: !1059, file: !35, discriminator: 2)
!1071 = !DILocation(line: 121, column: 5, scope: !1072, inlinedAt: !1064)
!1072 = !DILexicalBlockFile(scope: !1059, file: !35, discriminator: 3)
!1073 = !DILocation(line: 121, column: 5, scope: !1074, inlinedAt: !1064)
!1074 = !DILexicalBlockFile(scope: !1059, file: !35, discriminator: 4)
!1075 = !DILocation(line: 22, column: 1, scope: !1057)
!1076 = distinct !DISubprogram(linkageName: "_GLOBAL__sub_I_26_ompi.cpp", scope: !32, file: !32, type: !1077, isLocal: true, isDefinition: true, flags: DIFlagArtificial, isOptimized: false, unit: !31, variables: !950)
!1077 = !DISubroutineType(types: !950)
!1078 = !DILocation(line: 0, scope: !1076)
