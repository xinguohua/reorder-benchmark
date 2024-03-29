; ModuleID = '20-JDK.c'
source_filename = "20-JDK.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.ObjectWaiter = type { i32, %struct.ObjectWaiter* }
%union.sem_t = type { i64, [24 x i8] }
%union.pthread_attr_t = type { i64, [48 x i8] }

@entryList = global %struct.ObjectWaiter* null, align 8, !dbg !0
@.str = private unnamed_addr constant [5 x i8] c"2222\00", align 1
@semaphore = common global %union.sem_t zeroinitializer, align 8, !dbg !20
@.str.1 = private unnamed_addr constant [4 x i8] c"111\00", align 1

; Function Attrs: noinline nounwind uwtable
define void @SimpleEnter(%struct.ObjectWaiter*) #0 !dbg !36 {
  %2 = alloca %struct.ObjectWaiter*, align 8
  store %struct.ObjectWaiter* %0, %struct.ObjectWaiter** %2, align 8
  call void @llvm.dbg.declare(metadata %struct.ObjectWaiter** %2, metadata !40, metadata !41), !dbg !42
  %3 = load %struct.ObjectWaiter*, %struct.ObjectWaiter** %2, align 8, !dbg !43
  %4 = getelementptr inbounds %struct.ObjectWaiter, %struct.ObjectWaiter* %3, i32 0, i32 0, !dbg !44
  store i32 0, i32* %4, align 8, !dbg !45
  %5 = load %struct.ObjectWaiter*, %struct.ObjectWaiter** @entryList, align 8, !dbg !46
  %6 = load %struct.ObjectWaiter*, %struct.ObjectWaiter** %2, align 8, !dbg !47
  %7 = getelementptr inbounds %struct.ObjectWaiter, %struct.ObjectWaiter* %6, i32 0, i32 1, !dbg !48
  store %struct.ObjectWaiter* %5, %struct.ObjectWaiter** %7, align 8, !dbg !49
  %8 = load %struct.ObjectWaiter*, %struct.ObjectWaiter** %2, align 8, !dbg !50
  store %struct.ObjectWaiter* %8, %struct.ObjectWaiter** @entryList, align 8, !dbg !51
  br label %9, !dbg !52

; <label>:9:                                      ; preds = %14, %1
  %10 = load %struct.ObjectWaiter*, %struct.ObjectWaiter** %2, align 8, !dbg !53
  %11 = getelementptr inbounds %struct.ObjectWaiter, %struct.ObjectWaiter* %10, i32 0, i32 0, !dbg !55
  %12 = load i32, i32* %11, align 8, !dbg !55
  %13 = icmp eq i32 %12, 0, !dbg !56
  br i1 %13, label %14, label %17, !dbg !57

; <label>:14:                                     ; preds = %9
  %15 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str, i32 0, i32 0)), !dbg !58
  %16 = call i32 @sem_wait(%union.sem_t* @semaphore), !dbg !60
  br label %9, !dbg !61, !llvm.loop !63

; <label>:17:                                     ; preds = %9
  ret void, !dbg !65
}

; Function Attrs: nounwind readnone
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

declare i32 @printf(i8*, ...) #2

declare i32 @sem_wait(%union.sem_t*) #2

; Function Attrs: noinline nounwind uwtable
define void @SimpleExit() #0 !dbg !66 {
  %1 = alloca %struct.ObjectWaiter*, align 8
  %2 = load %struct.ObjectWaiter*, %struct.ObjectWaiter** @entryList, align 8, !dbg !69
  %3 = icmp eq %struct.ObjectWaiter* %2, null, !dbg !71
  br i1 %3, label %4, label %5, !dbg !72

; <label>:4:                                      ; preds = %0
  br label %21, !dbg !73

; <label>:5:                                      ; preds = %0
  call void @llvm.dbg.declare(metadata %struct.ObjectWaiter** %1, metadata !75, metadata !41), !dbg !76
  %6 = load %struct.ObjectWaiter*, %struct.ObjectWaiter** @entryList, align 8, !dbg !77
  store %struct.ObjectWaiter* %6, %struct.ObjectWaiter** %1, align 8, !dbg !76
  %7 = load %struct.ObjectWaiter*, %struct.ObjectWaiter** %1, align 8, !dbg !78
  %8 = icmp ne %struct.ObjectWaiter* %7, null, !dbg !80
  br i1 %8, label %9, label %13, !dbg !81

; <label>:9:                                      ; preds = %5
  %10 = load %struct.ObjectWaiter*, %struct.ObjectWaiter** %1, align 8, !dbg !82
  %11 = getelementptr inbounds %struct.ObjectWaiter, %struct.ObjectWaiter* %10, i32 0, i32 1, !dbg !84
  %12 = load %struct.ObjectWaiter*, %struct.ObjectWaiter** %11, align 8, !dbg !84
  store %struct.ObjectWaiter* %12, %struct.ObjectWaiter** @entryList, align 8, !dbg !85
  br label %13, !dbg !86

; <label>:13:                                     ; preds = %9, %5
  %14 = load %struct.ObjectWaiter*, %struct.ObjectWaiter** %1, align 8, !dbg !87
  %15 = icmp ne %struct.ObjectWaiter* %14, null, !dbg !89
  br i1 %15, label %16, label %21, !dbg !90

; <label>:16:                                     ; preds = %13
  %17 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.1, i32 0, i32 0)), !dbg !91
  %18 = call i32 @sem_post(%union.sem_t* @semaphore) #4, !dbg !93
  %19 = load %struct.ObjectWaiter*, %struct.ObjectWaiter** %1, align 8, !dbg !94
  %20 = getelementptr inbounds %struct.ObjectWaiter, %struct.ObjectWaiter* %19, i32 0, i32 0, !dbg !95
  store i32 1, i32* %20, align 8, !dbg !96
  br label %21, !dbg !97

; <label>:21:                                     ; preds = %4, %16, %13
  ret void, !dbg !98
}

; Function Attrs: nounwind
declare i32 @sem_post(%union.sem_t*) #3

; Function Attrs: noinline nounwind uwtable
define i8* @threadFuncEnter(i8*) #0 !dbg !99 {
  %2 = alloca i8*, align 8
  %3 = alloca %struct.ObjectWaiter*, align 8
  store i8* %0, i8** %2, align 8
  call void @llvm.dbg.declare(metadata i8** %2, metadata !102, metadata !41), !dbg !103
  call void @llvm.dbg.declare(metadata %struct.ObjectWaiter** %3, metadata !104, metadata !41), !dbg !105
  %4 = load i8*, i8** %2, align 8, !dbg !106
  %5 = bitcast i8* %4 to %struct.ObjectWaiter*, !dbg !107
  store %struct.ObjectWaiter* %5, %struct.ObjectWaiter** %3, align 8, !dbg !105
  %6 = load %struct.ObjectWaiter*, %struct.ObjectWaiter** %3, align 8, !dbg !108
  call void @SimpleEnter(%struct.ObjectWaiter* %6), !dbg !109
  ret i8* null, !dbg !110
}

; Function Attrs: noinline nounwind uwtable
define i8* @threadFuncExit(i8*) #0 !dbg !111 {
  %2 = alloca i8*, align 8
  store i8* %0, i8** %2, align 8
  call void @llvm.dbg.declare(metadata i8** %2, metadata !112, metadata !41), !dbg !113
  %3 = load i8*, i8** %2, align 8, !dbg !114
  call void @SimpleExit(), !dbg !115
  ret i8* null, !dbg !116
}

; Function Attrs: noinline nounwind uwtable
define void @InitObjectWaiter() #0 !dbg !117 {
  %1 = call i32 @sem_init(%union.sem_t* @semaphore, i32 0, i32 0) #4, !dbg !118
  ret void, !dbg !119
}

; Function Attrs: nounwind
declare i32 @sem_init(%union.sem_t*, i32, i32) #3

; Function Attrs: noinline nounwind uwtable
define i32 @main() #0 !dbg !120 {
  %1 = alloca i32, align 4
  %2 = alloca i64, align 8
  %3 = alloca i64, align 8
  %4 = alloca %struct.ObjectWaiter, align 8
  store i32 0, i32* %1, align 4
  call void @llvm.dbg.declare(metadata i64* %2, metadata !124, metadata !41), !dbg !128
  call void @llvm.dbg.declare(metadata i64* %3, metadata !129, metadata !41), !dbg !130
  call void @llvm.dbg.declare(metadata %struct.ObjectWaiter* %4, metadata !131, metadata !41), !dbg !132
  call void @InitObjectWaiter(), !dbg !133
  %5 = bitcast %struct.ObjectWaiter* %4 to i8*, !dbg !134
  %6 = call i32 @pthread_create(i64* %2, %union.pthread_attr_t* null, i8* (i8*)* @threadFuncEnter, i8* %5) #4, !dbg !135
  %7 = call i32 @usleep(i32 100000), !dbg !136
  %8 = call i32 @pthread_create(i64* %3, %union.pthread_attr_t* null, i8* (i8*)* @threadFuncExit, i8* null) #4, !dbg !137
  %9 = load i64, i64* %2, align 8, !dbg !138
  %10 = call i32 @pthread_join(i64 %9, i8** null), !dbg !139
  %11 = load i64, i64* %3, align 8, !dbg !140
  %12 = call i32 @pthread_join(i64 %11, i8** null), !dbg !141
  %13 = call i32 @sem_destroy(%union.sem_t* @semaphore) #4, !dbg !142
  ret i32 0, !dbg !143
}

; Function Attrs: nounwind
declare i32 @pthread_create(i64*, %union.pthread_attr_t*, i8* (i8*)*, i8*) #3

declare i32 @usleep(i32) #2

declare i32 @pthread_join(i64, i8**) #2

; Function Attrs: nounwind
declare i32 @sem_destroy(%union.sem_t*) #3

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { nounwind }

!llvm.dbg.cu = !{!2}
!llvm.module.flags = !{!33, !34}
!llvm.ident = !{!35}

!0 = !DIGlobalVariableExpression(var: !1)
!1 = distinct !DIGlobalVariable(name: "entryList", scope: !2, file: !3, line: 25, type: !11, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C99, file: !3, producer: "clang version 4.0.0 (tags/RELEASE_400/final)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !4, retainedTypes: !9, globals: !19)
!3 = !DIFile(filename: "20-JDK.c", directory: "/home/nsas2020/fuzz/targetProcess/reorder")
!4 = !{!5}
!5 = !DICompositeType(tag: DW_TAG_enumeration_type, file: !3, line: 13, size: 32, elements: !6)
!6 = !{!7, !8}
!7 = !DIEnumerator(name: "TS_ENTER", value: 0)
!8 = !DIEnumerator(name: "TS_RUN", value: 1)
!9 = !{!10, !11}
!10 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!11 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !12, size: 64)
!12 = !DIDerivedType(tag: DW_TAG_typedef, name: "ObjectWaiter", file: !3, line: 23, baseType: !13)
!13 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "ObjectWaiter", file: !3, line: 20, size: 128, elements: !14)
!14 = !{!15, !17}
!15 = !DIDerivedType(tag: DW_TAG_member, name: "state", scope: !13, file: !3, line: 21, baseType: !16, size: 32)
!16 = !DIDerivedType(tag: DW_TAG_typedef, name: "ObjectWaiterState", file: !3, line: 15, baseType: !5)
!17 = !DIDerivedType(tag: DW_TAG_member, name: "next", scope: !13, file: !3, line: 22, baseType: !18, size: 64, offset: 64)
!18 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !13, size: 64)
!19 = !{!0, !20}
!20 = !DIGlobalVariableExpression(var: !21)
!21 = distinct !DIGlobalVariable(name: "semaphore", scope: !2, file: !3, line: 18, type: !22, isLocal: false, isDefinition: true)
!22 = !DIDerivedType(tag: DW_TAG_typedef, name: "sem_t", file: !23, line: 40, baseType: !24)
!23 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/bits/semaphore.h", directory: "/home/nsas2020/fuzz/targetProcess/reorder")
!24 = distinct !DICompositeType(tag: DW_TAG_union_type, file: !23, line: 36, size: 256, elements: !25)
!25 = !{!26, !31}
!26 = !DIDerivedType(tag: DW_TAG_member, name: "__size", scope: !24, file: !23, line: 38, baseType: !27, size: 256)
!27 = !DICompositeType(tag: DW_TAG_array_type, baseType: !28, size: 256, elements: !29)
!28 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!29 = !{!30}
!30 = !DISubrange(count: 32)
!31 = !DIDerivedType(tag: DW_TAG_member, name: "__align", scope: !24, file: !23, line: 39, baseType: !32, size: 64)
!32 = !DIBasicType(name: "long int", size: 64, encoding: DW_ATE_signed)
!33 = !{i32 2, !"Dwarf Version", i32 4}
!34 = !{i32 2, !"Debug Info Version", i32 3}
!35 = !{!"clang version 4.0.0 (tags/RELEASE_400/final)"}
!36 = distinct !DISubprogram(name: "SimpleEnter", scope: !3, file: !3, line: 27, type: !37, isLocal: false, isDefinition: true, scopeLine: 27, flags: DIFlagPrototyped, isOptimized: false, unit: !2, variables: !39)
!37 = !DISubroutineType(types: !38)
!38 = !{null, !11}
!39 = !{}
!40 = !DILocalVariable(name: "node", arg: 1, scope: !36, file: !3, line: 27, type: !11)
!41 = !DIExpression()
!42 = !DILocation(line: 27, column: 32, scope: !36)
!43 = !DILocation(line: 28, column: 5, scope: !36)
!44 = !DILocation(line: 28, column: 11, scope: !36)
!45 = !DILocation(line: 28, column: 17, scope: !36)
!46 = !DILocation(line: 29, column: 18, scope: !36)
!47 = !DILocation(line: 29, column: 5, scope: !36)
!48 = !DILocation(line: 29, column: 11, scope: !36)
!49 = !DILocation(line: 29, column: 16, scope: !36)
!50 = !DILocation(line: 30, column: 17, scope: !36)
!51 = !DILocation(line: 30, column: 15, scope: !36)
!52 = !DILocation(line: 31, column: 5, scope: !36)
!53 = !DILocation(line: 31, column: 12, scope: !54)
!54 = !DILexicalBlockFile(scope: !36, file: !3, discriminator: 1)
!55 = !DILocation(line: 31, column: 18, scope: !54)
!56 = !DILocation(line: 31, column: 24, scope: !54)
!57 = !DILocation(line: 31, column: 5, scope: !54)
!58 = !DILocation(line: 32, column: 9, scope: !59)
!59 = distinct !DILexicalBlock(scope: !36, file: !3, line: 31, column: 37)
!60 = !DILocation(line: 33, column: 9, scope: !59)
!61 = !DILocation(line: 31, column: 5, scope: !62)
!62 = !DILexicalBlockFile(scope: !36, file: !3, discriminator: 2)
!63 = distinct !{!63, !52, !64}
!64 = !DILocation(line: 34, column: 5, scope: !36)
!65 = !DILocation(line: 35, column: 1, scope: !36)
!66 = distinct !DISubprogram(name: "SimpleExit", scope: !3, file: !3, line: 37, type: !67, isLocal: false, isDefinition: true, scopeLine: 37, isOptimized: false, unit: !2, variables: !39)
!67 = !DISubroutineType(types: !68)
!68 = !{null}
!69 = !DILocation(line: 38, column: 9, scope: !70)
!70 = distinct !DILexicalBlock(scope: !66, file: !3, line: 38, column: 9)
!71 = !DILocation(line: 38, column: 19, scope: !70)
!72 = !DILocation(line: 38, column: 9, scope: !66)
!73 = !DILocation(line: 38, column: 28, scope: !74)
!74 = !DILexicalBlockFile(scope: !70, file: !3, discriminator: 1)
!75 = !DILocalVariable(name: "w", scope: !66, file: !3, line: 40, type: !11)
!76 = !DILocation(line: 40, column: 19, scope: !66)
!77 = !DILocation(line: 40, column: 23, scope: !66)
!78 = !DILocation(line: 42, column: 9, scope: !79)
!79 = distinct !DILexicalBlock(scope: !66, file: !3, line: 42, column: 9)
!80 = !DILocation(line: 42, column: 11, scope: !79)
!81 = !DILocation(line: 42, column: 9, scope: !66)
!82 = !DILocation(line: 43, column: 21, scope: !83)
!83 = distinct !DILexicalBlock(scope: !79, file: !3, line: 42, column: 20)
!84 = !DILocation(line: 43, column: 24, scope: !83)
!85 = !DILocation(line: 43, column: 19, scope: !83)
!86 = !DILocation(line: 44, column: 5, scope: !83)
!87 = !DILocation(line: 47, column: 9, scope: !88)
!88 = distinct !DILexicalBlock(scope: !66, file: !3, line: 47, column: 9)
!89 = !DILocation(line: 47, column: 11, scope: !88)
!90 = !DILocation(line: 47, column: 9, scope: !66)
!91 = !DILocation(line: 48, column: 9, scope: !92)
!92 = distinct !DILexicalBlock(scope: !88, file: !3, line: 47, column: 20)
!93 = !DILocation(line: 49, column: 9, scope: !92)
!94 = !DILocation(line: 51, column: 9, scope: !92)
!95 = !DILocation(line: 51, column: 12, scope: !92)
!96 = !DILocation(line: 51, column: 18, scope: !92)
!97 = !DILocation(line: 52, column: 5, scope: !92)
!98 = !DILocation(line: 53, column: 1, scope: !66)
!99 = distinct !DISubprogram(name: "threadFuncEnter", scope: !3, file: !3, line: 56, type: !100, isLocal: false, isDefinition: true, scopeLine: 56, flags: DIFlagPrototyped, isOptimized: false, unit: !2, variables: !39)
!100 = !DISubroutineType(types: !101)
!101 = !{!10, !10}
!102 = !DILocalVariable(name: "arg", arg: 1, scope: !99, file: !3, line: 56, type: !10)
!103 = !DILocation(line: 56, column: 29, scope: !99)
!104 = !DILocalVariable(name: "node", scope: !99, file: !3, line: 57, type: !11)
!105 = !DILocation(line: 57, column: 19, scope: !99)
!106 = !DILocation(line: 57, column: 41, scope: !99)
!107 = !DILocation(line: 57, column: 26, scope: !99)
!108 = !DILocation(line: 58, column: 17, scope: !99)
!109 = !DILocation(line: 58, column: 5, scope: !99)
!110 = !DILocation(line: 59, column: 5, scope: !99)
!111 = distinct !DISubprogram(name: "threadFuncExit", scope: !3, file: !3, line: 62, type: !100, isLocal: false, isDefinition: true, scopeLine: 62, flags: DIFlagPrototyped, isOptimized: false, unit: !2, variables: !39)
!112 = !DILocalVariable(name: "arg", arg: 1, scope: !111, file: !3, line: 62, type: !10)
!113 = !DILocation(line: 62, column: 28, scope: !111)
!114 = !DILocation(line: 63, column: 11, scope: !111)
!115 = !DILocation(line: 64, column: 5, scope: !111)
!116 = !DILocation(line: 65, column: 5, scope: !111)
!117 = distinct !DISubprogram(name: "InitObjectWaiter", scope: !3, file: !3, line: 68, type: !67, isLocal: false, isDefinition: true, scopeLine: 68, isOptimized: false, unit: !2, variables: !39)
!118 = !DILocation(line: 69, column: 5, scope: !117)
!119 = !DILocation(line: 70, column: 1, scope: !117)
!120 = distinct !DISubprogram(name: "main", scope: !3, file: !3, line: 72, type: !121, isLocal: false, isDefinition: true, scopeLine: 72, isOptimized: false, unit: !2, variables: !39)
!121 = !DISubroutineType(types: !122)
!122 = !{!123}
!123 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!124 = !DILocalVariable(name: "t1", scope: !120, file: !3, line: 73, type: !125)
!125 = !DIDerivedType(tag: DW_TAG_typedef, name: "pthread_t", file: !126, line: 27, baseType: !127)
!126 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/bits/pthreadtypes.h", directory: "/home/nsas2020/fuzz/targetProcess/reorder")
!127 = !DIBasicType(name: "long unsigned int", size: 64, encoding: DW_ATE_unsigned)
!128 = !DILocation(line: 73, column: 15, scope: !120)
!129 = !DILocalVariable(name: "t2", scope: !120, file: !3, line: 73, type: !125)
!130 = !DILocation(line: 73, column: 19, scope: !120)
!131 = !DILocalVariable(name: "node", scope: !120, file: !3, line: 74, type: !12)
!132 = !DILocation(line: 74, column: 18, scope: !120)
!133 = !DILocation(line: 75, column: 5, scope: !120)
!134 = !DILocation(line: 77, column: 48, scope: !120)
!135 = !DILocation(line: 77, column: 5, scope: !120)
!136 = !DILocation(line: 78, column: 5, scope: !120)
!137 = !DILocation(line: 79, column: 5, scope: !120)
!138 = !DILocation(line: 81, column: 18, scope: !120)
!139 = !DILocation(line: 81, column: 5, scope: !120)
!140 = !DILocation(line: 82, column: 18, scope: !120)
!141 = !DILocation(line: 82, column: 5, scope: !120)
!142 = !DILocation(line: 84, column: 5, scope: !120)
!143 = !DILocation(line: 86, column: 5, scope: !120)
