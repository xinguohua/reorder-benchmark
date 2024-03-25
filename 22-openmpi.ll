; ModuleID = '22-openmpi.c'
source_filename = "22-openmpi.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.opal_lifo_t = type { %struct.opal_atomic_lifo_head_t, %struct.opal_list_item_t }
%struct.opal_atomic_lifo_head_t = type { %struct.opal_list_item_t* }
%struct.opal_list_item_t = type { %struct.opal_list_item_t*, i32 }
%union.pthread_attr_t = type { i64, [48 x i8] }

@.str = private unnamed_addr constant [2 x i8] c"1\00", align 1
@.str.1 = private unnamed_addr constant [2 x i8] c"3\00", align 1
@lifo = common global %struct.opal_lifo_t zeroinitializer, align 8, !dbg !0
@.str.2 = private unnamed_addr constant [29 x i8] c"Failed to create push thread\00", align 1
@.str.3 = private unnamed_addr constant [28 x i8] c"Failed to create pop thread\00", align 1

; Function Attrs: noinline nounwind uwtable
define i32 @opal_atomic_cmpset_ptr(%struct.opal_list_item_t**, %struct.opal_list_item_t*, %struct.opal_list_item_t*) #0 !dbg !32 {
  %4 = alloca i32, align 4
  %5 = alloca %struct.opal_list_item_t**, align 8
  %6 = alloca %struct.opal_list_item_t*, align 8
  %7 = alloca %struct.opal_list_item_t*, align 8
  store %struct.opal_list_item_t** %0, %struct.opal_list_item_t*** %5, align 8
  call void @llvm.dbg.declare(metadata %struct.opal_list_item_t*** %5, metadata !38, metadata !39), !dbg !40
  store %struct.opal_list_item_t* %1, %struct.opal_list_item_t** %6, align 8
  call void @llvm.dbg.declare(metadata %struct.opal_list_item_t** %6, metadata !41, metadata !39), !dbg !42
  store %struct.opal_list_item_t* %2, %struct.opal_list_item_t** %7, align 8
  call void @llvm.dbg.declare(metadata %struct.opal_list_item_t** %7, metadata !43, metadata !39), !dbg !44
  %8 = load %struct.opal_list_item_t**, %struct.opal_list_item_t*** %5, align 8, !dbg !45
  %9 = load %struct.opal_list_item_t*, %struct.opal_list_item_t** %8, align 8, !dbg !47
  %10 = load %struct.opal_list_item_t*, %struct.opal_list_item_t** %6, align 8, !dbg !48
  %11 = icmp eq %struct.opal_list_item_t* %9, %10, !dbg !49
  br i1 %11, label %12, label %15, !dbg !50

; <label>:12:                                     ; preds = %3
  %13 = load %struct.opal_list_item_t*, %struct.opal_list_item_t** %7, align 8, !dbg !51
  %14 = load %struct.opal_list_item_t**, %struct.opal_list_item_t*** %5, align 8, !dbg !53
  store %struct.opal_list_item_t* %13, %struct.opal_list_item_t** %14, align 8, !dbg !54
  store i32 1, i32* %4, align 4, !dbg !55
  br label %16, !dbg !55

; <label>:15:                                     ; preds = %3
  store i32 0, i32* %4, align 4, !dbg !56
  br label %16, !dbg !56

; <label>:16:                                     ; preds = %15, %12
  %17 = load i32, i32* %4, align 4, !dbg !57
  ret i32 %17, !dbg !57
}

; Function Attrs: nounwind readnone
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: noinline nounwind uwtable
define void @opal_atomic_wmb() #0 !dbg !58 {
  ret void, !dbg !61
}

; Function Attrs: noinline nounwind uwtable
define %struct.opal_list_item_t* @opal_lifo_push_atomic(%struct.opal_lifo_t*, %struct.opal_list_item_t*) #0 !dbg !62 {
  %3 = alloca %struct.opal_list_item_t*, align 8
  %4 = alloca %struct.opal_lifo_t*, align 8
  %5 = alloca %struct.opal_list_item_t*, align 8
  %6 = alloca %struct.opal_list_item_t*, align 8
  %7 = alloca %struct.opal_list_item_t*, align 8
  %8 = alloca i8, align 1
  store %struct.opal_lifo_t* %0, %struct.opal_lifo_t** %4, align 8
  call void @llvm.dbg.declare(metadata %struct.opal_lifo_t** %4, metadata !66, metadata !39), !dbg !67
  store %struct.opal_list_item_t* %1, %struct.opal_list_item_t** %5, align 8
  call void @llvm.dbg.declare(metadata %struct.opal_list_item_t** %5, metadata !68, metadata !39), !dbg !69
  %9 = load %struct.opal_list_item_t*, %struct.opal_list_item_t** %5, align 8, !dbg !70
  %10 = getelementptr inbounds %struct.opal_list_item_t, %struct.opal_list_item_t* %9, i32 0, i32 1, !dbg !71
  store atomic i32 1, i32* %10 seq_cst, align 4, !dbg !72
  br label %11, !dbg !73, !llvm.loop !74

; <label>:11:                                     ; preds = %44, %2
  call void @llvm.dbg.declare(metadata %struct.opal_list_item_t** %6, metadata !76, metadata !39), !dbg !78
  %12 = load %struct.opal_lifo_t*, %struct.opal_lifo_t** %4, align 8, !dbg !79
  %13 = getelementptr inbounds %struct.opal_lifo_t, %struct.opal_lifo_t* %12, i32 0, i32 0, !dbg !80
  %14 = getelementptr inbounds %struct.opal_atomic_lifo_head_t, %struct.opal_atomic_lifo_head_t* %13, i32 0, i32 0, !dbg !81
  %15 = bitcast %struct.opal_list_item_t** %14 to i64*, !dbg !81
  %16 = load atomic i64, i64* %15 seq_cst, align 8, !dbg !81
  %17 = inttoptr i64 %16 to %struct.opal_list_item_t*, !dbg !81
  store %struct.opal_list_item_t* %17, %struct.opal_list_item_t** %6, align 8, !dbg !78
  %18 = load %struct.opal_list_item_t*, %struct.opal_list_item_t** %6, align 8, !dbg !82
  %19 = load %struct.opal_list_item_t*, %struct.opal_list_item_t** %5, align 8, !dbg !83
  %20 = getelementptr inbounds %struct.opal_list_item_t, %struct.opal_list_item_t* %19, i32 0, i32 0, !dbg !84
  store %struct.opal_list_item_t* %18, %struct.opal_list_item_t** %20, align 8, !dbg !85
  call void @opal_atomic_wmb(), !dbg !86
  %21 = load %struct.opal_lifo_t*, %struct.opal_lifo_t** %4, align 8, !dbg !87
  %22 = getelementptr inbounds %struct.opal_lifo_t, %struct.opal_lifo_t* %21, i32 0, i32 0, !dbg !87
  %23 = getelementptr inbounds %struct.opal_atomic_lifo_head_t, %struct.opal_atomic_lifo_head_t* %22, i32 0, i32 0, !dbg !87
  %24 = load %struct.opal_list_item_t*, %struct.opal_list_item_t** %5, align 8, !dbg !87
  store %struct.opal_list_item_t* %24, %struct.opal_list_item_t** %7, align 8, !dbg !87
  %25 = bitcast %struct.opal_list_item_t** %23 to i64*, !dbg !87
  %26 = bitcast %struct.opal_list_item_t** %6 to i64*, !dbg !87
  %27 = bitcast %struct.opal_list_item_t** %7 to i64*, !dbg !87
  %28 = load i64, i64* %26, align 8, !dbg !87
  %29 = load i64, i64* %27, align 8, !dbg !87
  %30 = cmpxchg i64* %25, i64 %28, i64 %29 seq_cst seq_cst, !dbg !87
  %31 = extractvalue { i64, i1 } %30, 0, !dbg !87
  %32 = extractvalue { i64, i1 } %30, 1, !dbg !87
  br i1 %32, label %34, label %33, !dbg !87

; <label>:33:                                     ; preds = %11
  store i64 %31, i64* %26, align 8, !dbg !89
  br label %34, !dbg !89

; <label>:34:                                     ; preds = %33, %11
  %35 = zext i1 %32 to i8, !dbg !91
  store i8 %35, i8* %8, align 1, !dbg !91
  %36 = load i8, i8* %8, align 1, !dbg !91
  %37 = trunc i8 %36 to i1, !dbg !91
  br i1 %37, label %38, label %43, !dbg !93

; <label>:38:                                     ; preds = %34
  call void @opal_atomic_wmb(), !dbg !95
  %39 = load %struct.opal_list_item_t*, %struct.opal_list_item_t** %5, align 8, !dbg !97
  %40 = getelementptr inbounds %struct.opal_list_item_t, %struct.opal_list_item_t* %39, i32 0, i32 1, !dbg !98
  store atomic i32 0, i32* %40 seq_cst, align 4, !dbg !99
  %41 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str, i32 0, i32 0)), !dbg !100
  %42 = load %struct.opal_list_item_t*, %struct.opal_list_item_t** %6, align 8, !dbg !101
  store %struct.opal_list_item_t* %42, %struct.opal_list_item_t** %3, align 8, !dbg !102
  br label %45, !dbg !102

; <label>:43:                                     ; preds = %34
  br label %44, !dbg !103

; <label>:44:                                     ; preds = %43
  br i1 true, label %11, label %45, !dbg !104, !llvm.loop !74

; <label>:45:                                     ; preds = %38, %44
  %46 = load %struct.opal_list_item_t*, %struct.opal_list_item_t** %3, align 8, !dbg !106
  ret %struct.opal_list_item_t* %46, !dbg !106
}

declare i32 @printf(i8*, ...) #2

; Function Attrs: noinline nounwind uwtable
define %struct.opal_list_item_t* @opal_lifo_pop_atomic(%struct.opal_lifo_t*) #0 !dbg !107 {
  %2 = alloca %struct.opal_lifo_t*, align 8
  %3 = alloca %struct.opal_list_item_t*, align 8
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca %struct.opal_list_item_t*, align 8
  %7 = alloca i8, align 1
  store %struct.opal_lifo_t* %0, %struct.opal_lifo_t** %2, align 8
  call void @llvm.dbg.declare(metadata %struct.opal_lifo_t** %2, metadata !110, metadata !39), !dbg !111
  call void @llvm.dbg.declare(metadata %struct.opal_list_item_t** %3, metadata !112, metadata !39), !dbg !113
  br label %8, !dbg !114

; <label>:8:                                      ; preds = %48, %25, %1
  %9 = load %struct.opal_lifo_t*, %struct.opal_lifo_t** %2, align 8, !dbg !115
  %10 = getelementptr inbounds %struct.opal_lifo_t, %struct.opal_lifo_t* %9, i32 0, i32 0, !dbg !117
  %11 = getelementptr inbounds %struct.opal_atomic_lifo_head_t, %struct.opal_atomic_lifo_head_t* %10, i32 0, i32 0, !dbg !118
  %12 = bitcast %struct.opal_list_item_t** %11 to i64*, !dbg !118
  %13 = load atomic i64, i64* %12 seq_cst, align 8, !dbg !118
  %14 = inttoptr i64 %13 to %struct.opal_list_item_t*, !dbg !118
  store %struct.opal_list_item_t* %14, %struct.opal_list_item_t** %3, align 8, !dbg !119
  %15 = load %struct.opal_lifo_t*, %struct.opal_lifo_t** %2, align 8, !dbg !120
  %16 = getelementptr inbounds %struct.opal_lifo_t, %struct.opal_lifo_t* %15, i32 0, i32 1, !dbg !121
  %17 = icmp ne %struct.opal_list_item_t* %14, %16, !dbg !122
  br i1 %17, label %18, label %51, !dbg !123

; <label>:18:                                     ; preds = %8
  %19 = load %struct.opal_list_item_t*, %struct.opal_list_item_t** %3, align 8, !dbg !124
  %20 = getelementptr inbounds %struct.opal_list_item_t, %struct.opal_list_item_t* %19, i32 0, i32 1, !dbg !124
  store i32 1, i32* %4, align 4, !dbg !124
  %21 = load i32, i32* %4, align 4, !dbg !124
  %22 = atomicrmw xchg i32* %20, i32 %21 seq_cst, !dbg !124
  store i32 %22, i32* %5, align 4, !dbg !124
  %23 = load i32, i32* %5, align 4, !dbg !124
  %24 = icmp ne i32 %23, 0, !dbg !124
  br i1 %24, label %25, label %26, !dbg !127

; <label>:25:                                     ; preds = %18
  br label %8, !dbg !128, !llvm.loop !130

; <label>:26:                                     ; preds = %18
  %27 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.1, i32 0, i32 0)), !dbg !132
  %28 = load %struct.opal_lifo_t*, %struct.opal_lifo_t** %2, align 8, !dbg !133
  %29 = getelementptr inbounds %struct.opal_lifo_t, %struct.opal_lifo_t* %28, i32 0, i32 0, !dbg !133
  %30 = getelementptr inbounds %struct.opal_atomic_lifo_head_t, %struct.opal_atomic_lifo_head_t* %29, i32 0, i32 0, !dbg !133
  %31 = load %struct.opal_list_item_t*, %struct.opal_list_item_t** %3, align 8, !dbg !133
  %32 = getelementptr inbounds %struct.opal_list_item_t, %struct.opal_list_item_t* %31, i32 0, i32 0, !dbg !133
  %33 = load %struct.opal_list_item_t*, %struct.opal_list_item_t** %32, align 8, !dbg !133
  store %struct.opal_list_item_t* %33, %struct.opal_list_item_t** %6, align 8, !dbg !133
  %34 = bitcast %struct.opal_list_item_t** %30 to i64*, !dbg !133
  %35 = bitcast %struct.opal_list_item_t** %3 to i64*, !dbg !133
  %36 = bitcast %struct.opal_list_item_t** %6 to i64*, !dbg !133
  %37 = load i64, i64* %35, align 8, !dbg !133
  %38 = load i64, i64* %36, align 8, !dbg !133
  %39 = cmpxchg weak i64* %34, i64 %37, i64 %38 seq_cst seq_cst, !dbg !133
  %40 = extractvalue { i64, i1 } %39, 0, !dbg !133
  %41 = extractvalue { i64, i1 } %39, 1, !dbg !133
  br i1 %41, label %43, label %42, !dbg !133

; <label>:42:                                     ; preds = %26
  store i64 %40, i64* %35, align 8, !dbg !135
  br label %43, !dbg !135

; <label>:43:                                     ; preds = %42, %26
  %44 = zext i1 %41 to i8, !dbg !137
  store i8 %44, i8* %7, align 1, !dbg !137
  %45 = load i8, i8* %7, align 1, !dbg !137
  %46 = trunc i8 %45 to i1, !dbg !137
  br i1 %46, label %47, label %48, !dbg !139

; <label>:47:                                     ; preds = %43
  br label %51, !dbg !141

; <label>:48:                                     ; preds = %43
  %49 = load %struct.opal_list_item_t*, %struct.opal_list_item_t** %3, align 8, !dbg !143
  %50 = getelementptr inbounds %struct.opal_list_item_t, %struct.opal_list_item_t* %49, i32 0, i32 1, !dbg !144
  store atomic i32 0, i32* %50 seq_cst, align 4, !dbg !145
  br label %8, !dbg !146, !llvm.loop !130

; <label>:51:                                     ; preds = %47, %8
  ret %struct.opal_list_item_t* null, !dbg !148
}

; Function Attrs: noinline nounwind uwtable
define i8* @push_thread_func(i8*) #0 !dbg !149 {
  %2 = alloca i8*, align 8
  %3 = alloca i32, align 4
  %4 = alloca %struct.opal_list_item_t*, align 8
  store i8* %0, i8** %2, align 8
  call void @llvm.dbg.declare(metadata i8** %2, metadata !152, metadata !39), !dbg !153
  call void @llvm.dbg.declare(metadata i32* %3, metadata !154, metadata !39), !dbg !156
  store i32 0, i32* %3, align 4, !dbg !156
  br label %5, !dbg !157

; <label>:5:                                      ; preds = %14, %1
  %6 = load i32, i32* %3, align 4, !dbg !158
  %7 = icmp slt i32 %6, 1000, !dbg !161
  br i1 %7, label %8, label %17, !dbg !162

; <label>:8:                                      ; preds = %5
  call void @llvm.dbg.declare(metadata %struct.opal_list_item_t** %4, metadata !164, metadata !39), !dbg !166
  %9 = call noalias i8* @malloc(i64 16) #4, !dbg !167
  %10 = bitcast i8* %9 to %struct.opal_list_item_t*, !dbg !167
  store %struct.opal_list_item_t* %10, %struct.opal_list_item_t** %4, align 8, !dbg !166
  %11 = load %struct.opal_list_item_t*, %struct.opal_list_item_t** %4, align 8, !dbg !168
  %12 = call %struct.opal_list_item_t* @opal_lifo_push_atomic(%struct.opal_lifo_t* @lifo, %struct.opal_list_item_t* %11), !dbg !169
  %13 = call i32 (i32, ...) bitcast (i32 (...)* @usleep to i32 (i32, ...)*)(i32 100), !dbg !170
  br label %14, !dbg !171

; <label>:14:                                     ; preds = %8
  %15 = load i32, i32* %3, align 4, !dbg !172
  %16 = add nsw i32 %15, 1, !dbg !172
  store i32 %16, i32* %3, align 4, !dbg !172
  br label %5, !dbg !174, !llvm.loop !175

; <label>:17:                                     ; preds = %5
  ret i8* null, !dbg !178
}

; Function Attrs: nounwind
declare noalias i8* @malloc(i64) #3

declare i32 @usleep(...) #2

; Function Attrs: noinline nounwind uwtable
define i8* @pop_thread_func(i8*) #0 !dbg !179 {
  %2 = alloca i8*, align 8
  %3 = alloca i32, align 4
  %4 = alloca %struct.opal_list_item_t*, align 8
  store i8* %0, i8** %2, align 8
  call void @llvm.dbg.declare(metadata i8** %2, metadata !180, metadata !39), !dbg !181
  call void @llvm.dbg.declare(metadata i32* %3, metadata !182, metadata !39), !dbg !184
  store i32 0, i32* %3, align 4, !dbg !184
  br label %5, !dbg !185

; <label>:5:                                      ; preds = %17, %1
  %6 = load i32, i32* %3, align 4, !dbg !186
  %7 = icmp slt i32 %6, 1000, !dbg !189
  br i1 %7, label %8, label %20, !dbg !190

; <label>:8:                                      ; preds = %5
  call void @llvm.dbg.declare(metadata %struct.opal_list_item_t** %4, metadata !192, metadata !39), !dbg !194
  %9 = call %struct.opal_list_item_t* @opal_lifo_pop_atomic(%struct.opal_lifo_t* @lifo), !dbg !195
  store %struct.opal_list_item_t* %9, %struct.opal_list_item_t** %4, align 8, !dbg !194
  %10 = load %struct.opal_list_item_t*, %struct.opal_list_item_t** %4, align 8, !dbg !196
  %11 = icmp ne %struct.opal_list_item_t* %10, null, !dbg !196
  br i1 %11, label %12, label %15, !dbg !198

; <label>:12:                                     ; preds = %8
  %13 = load %struct.opal_list_item_t*, %struct.opal_list_item_t** %4, align 8, !dbg !199
  %14 = bitcast %struct.opal_list_item_t* %13 to i8*, !dbg !199
  call void @free(i8* %14) #4, !dbg !201
  br label %15, !dbg !202

; <label>:15:                                     ; preds = %12, %8
  %16 = call i32 (i32, ...) bitcast (i32 (...)* @usleep to i32 (i32, ...)*)(i32 100), !dbg !203
  br label %17, !dbg !204

; <label>:17:                                     ; preds = %15
  %18 = load i32, i32* %3, align 4, !dbg !205
  %19 = add nsw i32 %18, 1, !dbg !205
  store i32 %19, i32* %3, align 4, !dbg !205
  br label %5, !dbg !207, !llvm.loop !208

; <label>:20:                                     ; preds = %5
  ret i8* null, !dbg !211
}

; Function Attrs: nounwind
declare void @free(i8*) #3

; Function Attrs: noinline nounwind uwtable
define void @opal_lifo_init(%struct.opal_lifo_t*) #0 !dbg !212 {
  %2 = alloca %struct.opal_lifo_t*, align 8
  store %struct.opal_lifo_t* %0, %struct.opal_lifo_t** %2, align 8
  call void @llvm.dbg.declare(metadata %struct.opal_lifo_t** %2, metadata !215, metadata !39), !dbg !216
  %3 = load %struct.opal_lifo_t*, %struct.opal_lifo_t** %2, align 8, !dbg !217
  %4 = getelementptr inbounds %struct.opal_lifo_t, %struct.opal_lifo_t* %3, i32 0, i32 1, !dbg !218
  %5 = getelementptr inbounds %struct.opal_list_item_t, %struct.opal_list_item_t* %4, i32 0, i32 1, !dbg !219
  store atomic i32 0, i32* %5 seq_cst, align 4, !dbg !220
  %6 = load %struct.opal_lifo_t*, %struct.opal_lifo_t** %2, align 8, !dbg !221
  %7 = getelementptr inbounds %struct.opal_lifo_t, %struct.opal_lifo_t* %6, i32 0, i32 1, !dbg !222
  %8 = getelementptr inbounds %struct.opal_list_item_t, %struct.opal_list_item_t* %7, i32 0, i32 0, !dbg !223
  store %struct.opal_list_item_t* null, %struct.opal_list_item_t** %8, align 8, !dbg !224
  %9 = load %struct.opal_lifo_t*, %struct.opal_lifo_t** %2, align 8, !dbg !225
  %10 = getelementptr inbounds %struct.opal_lifo_t, %struct.opal_lifo_t* %9, i32 0, i32 1, !dbg !226
  %11 = load %struct.opal_lifo_t*, %struct.opal_lifo_t** %2, align 8, !dbg !227
  %12 = getelementptr inbounds %struct.opal_lifo_t, %struct.opal_lifo_t* %11, i32 0, i32 0, !dbg !228
  %13 = getelementptr inbounds %struct.opal_atomic_lifo_head_t, %struct.opal_atomic_lifo_head_t* %12, i32 0, i32 0, !dbg !229
  %14 = ptrtoint %struct.opal_list_item_t* %10 to i64, !dbg !230
  %15 = bitcast %struct.opal_list_item_t** %13 to i64*, !dbg !230
  store atomic i64 %14, i64* %15 seq_cst, align 8, !dbg !230
  ret void, !dbg !231
}

; Function Attrs: noinline nounwind uwtable
define i32 @main() #0 !dbg !232 {
  %1 = alloca i32, align 4
  %2 = alloca i64, align 8
  %3 = alloca i64, align 8
  store i32 0, i32* %1, align 4
  call void @llvm.dbg.declare(metadata i64* %2, metadata !235, metadata !39), !dbg !239
  call void @llvm.dbg.declare(metadata i64* %3, metadata !240, metadata !39), !dbg !241
  call void @opal_lifo_init(%struct.opal_lifo_t* @lifo), !dbg !242
  %4 = call i32 @pthread_create(i64* %2, %union.pthread_attr_t* null, i8* (i8*)* @push_thread_func, i8* null) #4, !dbg !243
  %5 = icmp ne i32 %4, 0, !dbg !245
  br i1 %5, label %6, label %7, !dbg !246

; <label>:6:                                      ; preds = %0
  call void @perror(i8* getelementptr inbounds ([29 x i8], [29 x i8]* @.str.2, i32 0, i32 0)), !dbg !247
  store i32 1, i32* %1, align 4, !dbg !249
  br label %16, !dbg !249

; <label>:7:                                      ; preds = %0
  %8 = call i32 @pthread_create(i64* %3, %union.pthread_attr_t* null, i8* (i8*)* @pop_thread_func, i8* null) #4, !dbg !250
  %9 = icmp ne i32 %8, 0, !dbg !252
  br i1 %9, label %10, label %11, !dbg !253

; <label>:10:                                     ; preds = %7
  call void @perror(i8* getelementptr inbounds ([28 x i8], [28 x i8]* @.str.3, i32 0, i32 0)), !dbg !254
  store i32 1, i32* %1, align 4, !dbg !256
  br label %16, !dbg !256

; <label>:11:                                     ; preds = %7
  %12 = load i64, i64* %2, align 8, !dbg !257
  %13 = call i32 @pthread_join(i64 %12, i8** null), !dbg !258
  %14 = load i64, i64* %3, align 8, !dbg !259
  %15 = call i32 @pthread_join(i64 %14, i8** null), !dbg !260
  store i32 0, i32* %1, align 4, !dbg !261
  br label %16, !dbg !261

; <label>:16:                                     ; preds = %11, %10, %6
  %17 = load i32, i32* %1, align 4, !dbg !262
  ret i32 %17, !dbg !262
}

; Function Attrs: nounwind
declare i32 @pthread_create(i64*, %union.pthread_attr_t*, i8* (i8*)*, i8*) #3

declare void @perror(i8*) #2

declare i32 @pthread_join(i64, i8**) #2

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { nounwind }

!llvm.dbg.cu = !{!2}
!llvm.module.flags = !{!29, !30}
!llvm.ident = !{!31}

!0 = !DIGlobalVariableExpression(var: !1)
!1 = distinct !DIGlobalVariable(name: "lifo", scope: !2, file: !3, line: 85, type: !19, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C99, file: !3, producer: "clang version 4.0.0 (tags/RELEASE_400/final)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !4, retainedTypes: !5, globals: !18)
!3 = !DIFile(filename: "22-openmpi.c", directory: "/home/nsas2020/fuzz/targetProcess/reorder")
!4 = !{}
!5 = !{!6, !17}
!6 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !7, size: 64)
!7 = !DIDerivedType(tag: DW_TAG_typedef, name: "opal_list_item_t", file: !3, line: 20, baseType: !8)
!8 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "opal_list_item_t", file: !3, line: 17, size: 128, elements: !9)
!9 = !{!10, !12}
!10 = !DIDerivedType(tag: DW_TAG_member, name: "opal_list_next", scope: !8, file: !3, line: 18, baseType: !11, size: 64)
!11 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !8, size: 64)
!12 = !DIDerivedType(tag: DW_TAG_member, name: "item_free", scope: !8, file: !3, line: 19, baseType: !13, size: 32, offset: 64)
!13 = !DIDerivedType(tag: DW_TAG_typedef, name: "atomic_int", file: !14, line: 97, baseType: !15)
!14 = !DIFile(filename: "/usr/local/clang-4.0/bin/../lib/clang/4.0.0/include/stdatomic.h", directory: "/home/nsas2020/fuzz/targetProcess/reorder")
!15 = !DIDerivedType(tag: DW_TAG_atomic_type, baseType: !16)
!16 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!17 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!18 = !{!0}
!19 = !DIDerivedType(tag: DW_TAG_typedef, name: "opal_lifo_t", file: !3, line: 29, baseType: !20)
!20 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !3, line: 26, size: 192, elements: !21)
!21 = !{!22, !28}
!22 = !DIDerivedType(tag: DW_TAG_member, name: "opal_lifo_head", scope: !20, file: !3, line: 27, baseType: !23, size: 64)
!23 = !DIDerivedType(tag: DW_TAG_typedef, name: "opal_atomic_lifo_head_t", file: !3, line: 24, baseType: !24)
!24 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !3, line: 22, size: 64, elements: !25)
!25 = !{!26}
!26 = !DIDerivedType(tag: DW_TAG_member, name: "item", scope: !24, file: !3, line: 23, baseType: !27, size: 64)
!27 = !DIDerivedType(tag: DW_TAG_atomic_type, baseType: !6)
!28 = !DIDerivedType(tag: DW_TAG_member, name: "opal_lifo_ghost", scope: !20, file: !3, line: 28, baseType: !7, size: 128, offset: 64)
!29 = !{i32 2, !"Dwarf Version", i32 4}
!30 = !{i32 2, !"Debug Info Version", i32 3}
!31 = !{!"clang version 4.0.0 (tags/RELEASE_400/final)"}
!32 = distinct !DISubprogram(name: "opal_atomic_cmpset_ptr", scope: !3, file: !3, line: 32, type: !33, isLocal: false, isDefinition: true, scopeLine: 32, flags: DIFlagPrototyped, isOptimized: false, unit: !2, variables: !4)
!33 = !DISubroutineType(types: !34)
!34 = !{!16, !35, !6, !6}
!35 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !36, size: 64)
!36 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !37, size: 64)
!37 = !DIDerivedType(tag: DW_TAG_volatile_type, baseType: !7)
!38 = !DILocalVariable(name: "addr", arg: 1, scope: !32, file: !3, line: 32, type: !35)
!39 = !DIExpression()
!40 = !DILocation(line: 32, column: 56, scope: !32)
!41 = !DILocalVariable(name: "oldval", arg: 2, scope: !32, file: !3, line: 32, type: !6)
!42 = !DILocation(line: 32, column: 80, scope: !32)
!43 = !DILocalVariable(name: "newval", arg: 3, scope: !32, file: !3, line: 32, type: !6)
!44 = !DILocation(line: 32, column: 106, scope: !32)
!45 = !DILocation(line: 33, column: 10, scope: !46)
!46 = distinct !DILexicalBlock(scope: !32, file: !3, line: 33, column: 9)
!47 = !DILocation(line: 33, column: 9, scope: !46)
!48 = !DILocation(line: 33, column: 18, scope: !46)
!49 = !DILocation(line: 33, column: 15, scope: !46)
!50 = !DILocation(line: 33, column: 9, scope: !32)
!51 = !DILocation(line: 34, column: 17, scope: !52)
!52 = distinct !DILexicalBlock(scope: !46, file: !3, line: 33, column: 26)
!53 = !DILocation(line: 34, column: 10, scope: !52)
!54 = !DILocation(line: 34, column: 15, scope: !52)
!55 = !DILocation(line: 35, column: 9, scope: !52)
!56 = !DILocation(line: 37, column: 5, scope: !32)
!57 = !DILocation(line: 38, column: 1, scope: !32)
!58 = distinct !DISubprogram(name: "opal_atomic_wmb", scope: !3, file: !3, line: 41, type: !59, isLocal: false, isDefinition: true, scopeLine: 41, isOptimized: false, unit: !2, variables: !4)
!59 = !DISubroutineType(types: !60)
!60 = !{null}
!61 = !DILocation(line: 43, column: 1, scope: !58)
!62 = distinct !DISubprogram(name: "opal_lifo_push_atomic", scope: !3, file: !3, line: 46, type: !63, isLocal: false, isDefinition: true, scopeLine: 46, flags: DIFlagPrototyped, isOptimized: false, unit: !2, variables: !4)
!63 = !DISubroutineType(types: !64)
!64 = !{!6, !65, !6}
!65 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !19, size: 64)
!66 = !DILocalVariable(name: "lifo", arg: 1, scope: !62, file: !3, line: 46, type: !65)
!67 = !DILocation(line: 46, column: 54, scope: !62)
!68 = !DILocalVariable(name: "item", arg: 2, scope: !62, file: !3, line: 46, type: !6)
!69 = !DILocation(line: 46, column: 78, scope: !62)
!70 = !DILocation(line: 47, column: 5, scope: !62)
!71 = !DILocation(line: 47, column: 11, scope: !62)
!72 = !DILocation(line: 47, column: 21, scope: !62)
!73 = !DILocation(line: 48, column: 5, scope: !62)
!74 = distinct !{!74, !73, !75}
!75 = !DILocation(line: 60, column: 15, scope: !62)
!76 = !DILocalVariable(name: "next", scope: !77, file: !3, line: 49, type: !6)
!77 = distinct !DILexicalBlock(scope: !62, file: !3, line: 48, column: 8)
!78 = !DILocation(line: 49, column: 27, scope: !77)
!79 = !DILocation(line: 49, column: 53, scope: !77)
!80 = !DILocation(line: 49, column: 59, scope: !77)
!81 = !DILocation(line: 49, column: 74, scope: !77)
!82 = !DILocation(line: 50, column: 32, scope: !77)
!83 = !DILocation(line: 50, column: 9, scope: !77)
!84 = !DILocation(line: 50, column: 15, scope: !77)
!85 = !DILocation(line: 50, column: 30, scope: !77)
!86 = !DILocation(line: 51, column: 9, scope: !77)
!87 = !DILocation(line: 52, column: 13, scope: !88)
!88 = distinct !DILexicalBlock(scope: !77, file: !3, line: 52, column: 13)
!89 = !DILocation(line: 52, column: 13, scope: !90)
!90 = !DILexicalBlockFile(scope: !88, file: !3, discriminator: 1)
!91 = !DILocation(line: 52, column: 13, scope: !92)
!92 = !DILexicalBlockFile(scope: !88, file: !3, discriminator: 2)
!93 = !DILocation(line: 52, column: 13, scope: !94)
!94 = !DILexicalBlockFile(scope: !77, file: !3, discriminator: 2)
!95 = !DILocation(line: 53, column: 13, scope: !96)
!96 = distinct !DILexicalBlock(scope: !88, file: !3, line: 52, column: 86)
!97 = !DILocation(line: 55, column: 13, scope: !96)
!98 = !DILocation(line: 55, column: 19, scope: !96)
!99 = !DILocation(line: 55, column: 29, scope: !96)
!100 = !DILocation(line: 56, column: 13, scope: !96)
!101 = !DILocation(line: 57, column: 20, scope: !96)
!102 = !DILocation(line: 57, column: 13, scope: !96)
!103 = !DILocation(line: 60, column: 5, scope: !77)
!104 = !DILocation(line: 60, column: 5, scope: !105)
!105 = !DILexicalBlockFile(scope: !77, file: !3, discriminator: 1)
!106 = !DILocation(line: 61, column: 1, scope: !62)
!107 = distinct !DISubprogram(name: "opal_lifo_pop_atomic", scope: !3, file: !3, line: 64, type: !108, isLocal: false, isDefinition: true, scopeLine: 64, flags: DIFlagPrototyped, isOptimized: false, unit: !2, variables: !4)
!108 = !DISubroutineType(types: !109)
!109 = !{!6, !65}
!110 = !DILocalVariable(name: "lifo", arg: 1, scope: !107, file: !3, line: 64, type: !65)
!111 = !DILocation(line: 64, column: 53, scope: !107)
!112 = !DILocalVariable(name: "item", scope: !107, file: !3, line: 65, type: !6)
!113 = !DILocation(line: 65, column: 23, scope: !107)
!114 = !DILocation(line: 66, column: 5, scope: !107)
!115 = !DILocation(line: 66, column: 39, scope: !116)
!116 = !DILexicalBlockFile(scope: !107, file: !3, discriminator: 1)
!117 = !DILocation(line: 66, column: 45, scope: !116)
!118 = !DILocation(line: 66, column: 60, scope: !116)
!119 = !DILocation(line: 66, column: 18, scope: !116)
!120 = !DILocation(line: 66, column: 70, scope: !116)
!121 = !DILocation(line: 66, column: 76, scope: !116)
!122 = !DILocation(line: 66, column: 66, scope: !116)
!123 = !DILocation(line: 66, column: 5, scope: !116)
!124 = !DILocation(line: 68, column: 13, scope: !125)
!125 = distinct !DILexicalBlock(scope: !126, file: !3, line: 68, column: 13)
!126 = distinct !DILexicalBlock(scope: !107, file: !3, line: 66, column: 93)
!127 = !DILocation(line: 68, column: 13, scope: !126)
!128 = !DILocation(line: 69, column: 13, scope: !129)
!129 = distinct !DILexicalBlock(scope: !125, file: !3, line: 68, column: 51)
!130 = distinct !{!130, !114, !131}
!131 = !DILocation(line: 79, column: 5, scope: !107)
!132 = !DILocation(line: 71, column: 9, scope: !126)
!133 = !DILocation(line: 75, column: 13, scope: !134)
!134 = distinct !DILexicalBlock(scope: !126, file: !3, line: 75, column: 13)
!135 = !DILocation(line: 75, column: 13, scope: !136)
!136 = !DILexicalBlockFile(scope: !134, file: !3, discriminator: 1)
!137 = !DILocation(line: 75, column: 13, scope: !138)
!138 = !DILexicalBlockFile(scope: !134, file: !3, discriminator: 2)
!139 = !DILocation(line: 75, column: 13, scope: !140)
!140 = !DILexicalBlockFile(scope: !126, file: !3, discriminator: 2)
!141 = !DILocation(line: 76, column: 13, scope: !142)
!142 = distinct !DILexicalBlock(scope: !134, file: !3, line: 75, column: 100)
!143 = !DILocation(line: 78, column: 9, scope: !126)
!144 = !DILocation(line: 78, column: 16, scope: !126)
!145 = !DILocation(line: 78, column: 26, scope: !126)
!146 = !DILocation(line: 66, column: 5, scope: !147)
!147 = !DILexicalBlockFile(scope: !107, file: !3, discriminator: 2)
!148 = !DILocation(line: 80, column: 5, scope: !107)
!149 = distinct !DISubprogram(name: "push_thread_func", scope: !3, file: !3, line: 88, type: !150, isLocal: false, isDefinition: true, scopeLine: 88, flags: DIFlagPrototyped, isOptimized: false, unit: !2, variables: !4)
!150 = !DISubroutineType(types: !151)
!151 = !{!17, !17}
!152 = !DILocalVariable(name: "arg", arg: 1, scope: !149, file: !3, line: 88, type: !17)
!153 = !DILocation(line: 88, column: 30, scope: !149)
!154 = !DILocalVariable(name: "i", scope: !155, file: !3, line: 89, type: !16)
!155 = distinct !DILexicalBlock(scope: !149, file: !3, line: 89, column: 5)
!156 = !DILocation(line: 89, column: 14, scope: !155)
!157 = !DILocation(line: 89, column: 10, scope: !155)
!158 = !DILocation(line: 89, column: 21, scope: !159)
!159 = !DILexicalBlockFile(scope: !160, file: !3, discriminator: 1)
!160 = distinct !DILexicalBlock(scope: !155, file: !3, line: 89, column: 5)
!161 = !DILocation(line: 89, column: 23, scope: !159)
!162 = !DILocation(line: 89, column: 5, scope: !163)
!163 = !DILexicalBlockFile(scope: !155, file: !3, discriminator: 1)
!164 = !DILocalVariable(name: "item", scope: !165, file: !3, line: 90, type: !6)
!165 = distinct !DILexicalBlock(scope: !160, file: !3, line: 89, column: 47)
!166 = !DILocation(line: 90, column: 27, scope: !165)
!167 = !DILocation(line: 90, column: 34, scope: !165)
!168 = !DILocation(line: 91, column: 38, scope: !165)
!169 = !DILocation(line: 91, column: 9, scope: !165)
!170 = !DILocation(line: 93, column: 9, scope: !165)
!171 = !DILocation(line: 94, column: 5, scope: !165)
!172 = !DILocation(line: 89, column: 42, scope: !173)
!173 = !DILexicalBlockFile(scope: !160, file: !3, discriminator: 2)
!174 = !DILocation(line: 89, column: 5, scope: !173)
!175 = distinct !{!175, !176, !177}
!176 = !DILocation(line: 89, column: 5, scope: !155)
!177 = !DILocation(line: 94, column: 5, scope: !155)
!178 = !DILocation(line: 95, column: 5, scope: !149)
!179 = distinct !DISubprogram(name: "pop_thread_func", scope: !3, file: !3, line: 99, type: !150, isLocal: false, isDefinition: true, scopeLine: 99, flags: DIFlagPrototyped, isOptimized: false, unit: !2, variables: !4)
!180 = !DILocalVariable(name: "arg", arg: 1, scope: !179, file: !3, line: 99, type: !17)
!181 = !DILocation(line: 99, column: 29, scope: !179)
!182 = !DILocalVariable(name: "i", scope: !183, file: !3, line: 100, type: !16)
!183 = distinct !DILexicalBlock(scope: !179, file: !3, line: 100, column: 5)
!184 = !DILocation(line: 100, column: 14, scope: !183)
!185 = !DILocation(line: 100, column: 10, scope: !183)
!186 = !DILocation(line: 100, column: 21, scope: !187)
!187 = !DILexicalBlockFile(scope: !188, file: !3, discriminator: 1)
!188 = distinct !DILexicalBlock(scope: !183, file: !3, line: 100, column: 5)
!189 = !DILocation(line: 100, column: 23, scope: !187)
!190 = !DILocation(line: 100, column: 5, scope: !191)
!191 = !DILexicalBlockFile(scope: !183, file: !3, discriminator: 1)
!192 = !DILocalVariable(name: "item", scope: !193, file: !3, line: 101, type: !6)
!193 = distinct !DILexicalBlock(scope: !188, file: !3, line: 100, column: 46)
!194 = !DILocation(line: 101, column: 27, scope: !193)
!195 = !DILocation(line: 101, column: 34, scope: !193)
!196 = !DILocation(line: 102, column: 13, scope: !197)
!197 = distinct !DILexicalBlock(scope: !193, file: !3, line: 102, column: 13)
!198 = !DILocation(line: 102, column: 13, scope: !193)
!199 = !DILocation(line: 104, column: 18, scope: !200)
!200 = distinct !DILexicalBlock(scope: !197, file: !3, line: 102, column: 19)
!201 = !DILocation(line: 104, column: 13, scope: !200)
!202 = !DILocation(line: 105, column: 9, scope: !200)
!203 = !DILocation(line: 107, column: 9, scope: !193)
!204 = !DILocation(line: 108, column: 5, scope: !193)
!205 = !DILocation(line: 100, column: 41, scope: !206)
!206 = !DILexicalBlockFile(scope: !188, file: !3, discriminator: 2)
!207 = !DILocation(line: 100, column: 5, scope: !206)
!208 = distinct !{!208, !209, !210}
!209 = !DILocation(line: 100, column: 5, scope: !183)
!210 = !DILocation(line: 108, column: 5, scope: !183)
!211 = !DILocation(line: 109, column: 5, scope: !179)
!212 = distinct !DISubprogram(name: "opal_lifo_init", scope: !3, file: !3, line: 112, type: !213, isLocal: false, isDefinition: true, scopeLine: 112, flags: DIFlagPrototyped, isOptimized: false, unit: !2, variables: !4)
!213 = !DISubroutineType(types: !214)
!214 = !{null, !65}
!215 = !DILocalVariable(name: "lifo", arg: 1, scope: !212, file: !3, line: 112, type: !65)
!216 = !DILocation(line: 112, column: 34, scope: !212)
!217 = !DILocation(line: 114, column: 5, scope: !212)
!218 = !DILocation(line: 114, column: 11, scope: !212)
!219 = !DILocation(line: 114, column: 27, scope: !212)
!220 = !DILocation(line: 114, column: 37, scope: !212)
!221 = !DILocation(line: 115, column: 5, scope: !212)
!222 = !DILocation(line: 115, column: 11, scope: !212)
!223 = !DILocation(line: 115, column: 27, scope: !212)
!224 = !DILocation(line: 115, column: 42, scope: !212)
!225 = !DILocation(line: 118, column: 34, scope: !212)
!226 = !DILocation(line: 118, column: 40, scope: !212)
!227 = !DILocation(line: 118, column: 5, scope: !212)
!228 = !DILocation(line: 118, column: 11, scope: !212)
!229 = !DILocation(line: 118, column: 26, scope: !212)
!230 = !DILocation(line: 118, column: 31, scope: !212)
!231 = !DILocation(line: 119, column: 1, scope: !212)
!232 = distinct !DISubprogram(name: "main", scope: !3, file: !3, line: 122, type: !233, isLocal: false, isDefinition: true, scopeLine: 122, isOptimized: false, unit: !2, variables: !4)
!233 = !DISubroutineType(types: !234)
!234 = !{!16}
!235 = !DILocalVariable(name: "push_thread", scope: !232, file: !3, line: 123, type: !236)
!236 = !DIDerivedType(tag: DW_TAG_typedef, name: "pthread_t", file: !237, line: 27, baseType: !238)
!237 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/bits/pthreadtypes.h", directory: "/home/nsas2020/fuzz/targetProcess/reorder")
!238 = !DIBasicType(name: "long unsigned int", size: 64, encoding: DW_ATE_unsigned)
!239 = !DILocation(line: 123, column: 15, scope: !232)
!240 = !DILocalVariable(name: "pop_thread", scope: !232, file: !3, line: 123, type: !236)
!241 = !DILocation(line: 123, column: 28, scope: !232)
!242 = !DILocation(line: 126, column: 5, scope: !232)
!243 = !DILocation(line: 129, column: 9, scope: !244)
!244 = distinct !DILexicalBlock(scope: !232, file: !3, line: 129, column: 9)
!245 = !DILocation(line: 129, column: 68, scope: !244)
!246 = !DILocation(line: 129, column: 9, scope: !232)
!247 = !DILocation(line: 130, column: 9, scope: !248)
!248 = distinct !DILexicalBlock(scope: !244, file: !3, line: 129, column: 74)
!249 = !DILocation(line: 131, column: 9, scope: !248)
!250 = !DILocation(line: 133, column: 9, scope: !251)
!251 = distinct !DILexicalBlock(scope: !232, file: !3, line: 133, column: 9)
!252 = !DILocation(line: 133, column: 66, scope: !251)
!253 = !DILocation(line: 133, column: 9, scope: !232)
!254 = !DILocation(line: 134, column: 9, scope: !255)
!255 = distinct !DILexicalBlock(scope: !251, file: !3, line: 133, column: 72)
!256 = !DILocation(line: 135, column: 9, scope: !255)
!257 = !DILocation(line: 139, column: 18, scope: !232)
!258 = !DILocation(line: 139, column: 5, scope: !232)
!259 = !DILocation(line: 140, column: 18, scope: !232)
!260 = !DILocation(line: 140, column: 5, scope: !232)
!261 = !DILocation(line: 144, column: 5, scope: !232)
!262 = !DILocation(line: 145, column: 1, scope: !232)
