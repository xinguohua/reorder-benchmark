// /usr/local/clang-4.0/bin/clang -emit-llvm -g -c  4-MySQL.c -o 4-MySQL.bc  57:104  59:103
//https://bugs.mysql.com/file.php?id=28180&bug_id=94699&text=1
// Created by nsas2020 on 24-3-15.
//  clang -emit-llvm -S -o 4-MySQL.ll 4-MySQL.c
//  time nidhugg -arm 4-MySQL.ll
#include <stdbool.h>
#include <pthread.h>
#include <stdio.h>
#include <assert.h>
#include <unistd.h>
#include <sys/types.h>
#include <syscall.h>

#define X_LOCK_DECR		0x20000000
#define X_LOCK_HALF_DECR	0x10000000
//# define os_rmb	__atomic_thread_fence(__ATOMIC_ACQUIRE)
#define os_thread_eq(lhs, rhs)  ((lhs) == (rhs))


//void additional_logic() {
//    int data = 0;
//    // 这里增加大量的分支来扩充行数
//    if (data == 0) { data = 1; }
//    if (data == 1) { data = 2; }
//    if (data == 2) { data = 3; }
//    if (data == 3) { data = 4; }
//    if (data == 4) { data = 5; }
//    if (data == 5) { data = 6; }
//    if (data == 6) { data = 7; }
//    if (data == 7) { data = 8; }
//    if (data == 8) { data = 9; }
//    if (data == 9) { data = 10; }
//    if (data == 10) { data = 11; }
//    if (data == 11) { data = 12; }
//    if (data == 12) { data = 13; }
//    if (data == 13) { data = 14; }
//    if (data == 14) { data = 15; }
//    if (data == 15) { data = 16; }
//    if (data == 16) { data = 17; }
//    if (data == 17) { data = 18; }
//    if (data == 18) { data = 19; }
//    if (data == 19) { data = 20; }
//    if (data == 20) { data = 21; }
//    if (data == 21) { data = 22; }
//    if (data == 22) { data = 23; }
//    if (data == 23) { data = 24; }
//    if (data == 24) { data = 25; }
//    if (data == 25) { data = 26; }
//    if (data == 26) { data = 27; }
//    if (data == 27) { data = 28; }
//    if (data == 28) { data = 29; }
//    if (data == 29) { data = 30; }
//    if (data == 30) { data = 31; }
//    if (data == 31) { data = 32; }
//    if (data == 32) { data = 33; }
//    if (data == 33) { data = 34; }
//    if (data == 34) { data = 35; }
//    if (data == 35) { data = 36; }
//    if (data == 36) { data = 37; }
//    if (data == 37) { data = 38; }
//    if (data == 38) { data = 39; }
//    if (data == 39) { data = 40; }
//    if (data == 40) { data = 41; }
//    if (data == 41) { data = 42; }
//    if (data == 42) { data = 43; }
//    if (data == 43) { data = 44; }
//    if (data == 44) { data = 45; }
//    if (data == 45) { data = 46; }
//    if (data == 46) { data = 47; }
//    if (data == 47) { data = 48; }
//    if (data == 48) { data = 49; }
//    if (data == 49) { data = 50; }
//    if (data == 50) { data = 51; }
//    if (data == 51) { data = 52; }
//    if (data == 52) { data = 53; }
//    if (data == 53) { data = 54; }
//    if (data == 54) { data = 55; }
//    if (data == 55) { data = 56; }
//    if (data == 56) { data = 57; }
//    if (data == 57) { data = 58; }
//    if (data == 58) { data = 59; }
//    if (data == 59) { data = 60; }
//    if (data == 60) { data = 61; }
//    if (data == 61) { data = 62; }
//    if (data == 62) { data = 63; }
//    if (data == 63) { data = 64; }
//    if (data == 64) { data = 65; }
//    if (data == 65) { data = 66; }
//    if (data == 66) { data = 67; }
//    if (data == 67) { data = 68; }
//    if (data == 68) { data = 69; }
//    if (data == 69) { data = 70; }
//    if (data == 70) { data = 71; }
//    if (data == 71) { data = 72; }
//    if (data == 72) { data = 73; }
//    if (data == 73) { data = 74; }
//    if (data == 74) { data = 75; }
//    if (data == 75) { data = 76; }
//    if (data == 76) { data = 77; }
//    if (data == 77) { data = 78; }
//    if (data == 78) { data = 79; }
//    if (data == 79) { data = 80; }
//    if (data == 80) { data = 81; }
//    if (data == 81) { data = 82; }
//    if (data == 82) { data = 83; }
//    if (data == 83) { data = 84; }
//    if (data == 84) { data = 85; }
//    if (data == 85) { data = 86; }
//    if (data == 86) { data = 87; }
//    if (data == 87) { data = 88; }
//    if (data == 88) { data = 89; }
//    if (data == 89) { data = 90; }
//    if (data == 90) { data = 91; }
//    if (data == 91) { data = 92; }
//    if (data == 92) { data = 93; }
//    if (data == 93) { data = 94; }
//    if (data == 94) { data = 95; }
//    if (data == 95) { data = 96; }
//    if (data == 96) { data = 97; }
//    if (data == 97) { data = 98; }
//    if (data == 98) { data = 99; }
//    if (data == 99) { data = 100; }
//    if (data == 100) { data = 101; }
//    if (data == 101) { data = 102; }
//    if (data == 102) { data = 103; }
//    if (data == 103) { data = 104; }
//    if (data == 104) { data = 105; }
//    if (data == 105) { data = 106; }
//    if (data == 106) { data = 107; }
//    if (data == 107) { data = 108; }
//    if (data == 108) { data = 109; }
//    if (data == 109) { data = 110; }
//    if (data == 110) { data = 111; }
//    if (data == 111) { data = 112; }
//    if (data == 112) { data = 113; }
//    if (data == 113) { data = 114; }
//    if (data == 114) { data = 115; }
//    if (data == 115) { data = 116; }
//    if (data == 116) { data = 117; }
//    if (data == 117) { data = 118; }
//    if (data == 118) { data = 119; }
//    if (data == 119) { data = 120; }
//    if (data == 120) { data = 121; }
//    if (data == 121) { data = 122; }
//    if (data == 122) { data = 123; }
//    if (data == 123) { data = 124; }
//    if (data == 124) { data = 125; }
//    if (data == 125) { data = 126; }
//    if (data == 126) { data = 127; }
//    if (data == 127) { data = 128; }
//    if (data == 128) { data = 129; }
//    if (data == 129) { data = 130; }
//    if (data == 130) { data = 131; }
//    if (data == 131) { data = 132; }
//    if (data == 132) { data = 133; }
//    if (data == 133) { data = 134; }
//    if (data == 134) { data = 135; }
//    if (data == 135) { data = 136; }
//    if (data == 136) { data = 137; }
//    if (data == 137) { data = 138; }
//    if (data == 138) { data = 139; }
//    if (data == 139) { data = 140; }
//    if (data == 140) { data = 141; }
//    if (data == 141) { data = 142; }
//    if (data == 142) { data = 143; }
//    if (data == 143) { data = 144; }
//    if (data == 144) { data = 145; }
//    if (data == 145) { data = 146; }
//    if (data == 146) { data = 147; }
//    if (data == 147) { data = 148; }
//    if (data == 148) { data = 149; }
//    if (data == 149) { data = 150; }
//    if (data == 150) { data = 151; }
//    if (data == 151) { data = 152; }
//    if (data == 152) { data = 153; }
//    if (data == 153) { data = 154; }
//    if (data == 154) { data = 155; }
//    if (data == 155) { data = 156; }
//    if (data == 156) { data = 157; }
//    if (data == 157) { data = 158; }
//    if (data == 158) { data = 159; }
//    if (data == 159) { data = 160; }
//    if (data == 160) { data = 161; }
//    if (data == 161) { data = 162; }
//    if (data == 162) { data = 163; }
//    if (data == 163) { data = 164; }
//    if (data == 164) { data = 165; }
//    if (data == 165) { data = 166; }
//    if (data == 166) { data = 167; }
//    if (data == 167) { data = 168; }
//    if (data == 168) { data = 169; }
//    if (data == 169) { data = 170; }
//    if (data == 170) { data = 171; }
//    if (data == 171) { data = 172; }
//    if (data == 172) { data = 173; }
//    if (data == 173) { data = 174; }
//    if (data == 174) { data = 175; }
//    if (data == 175) { data = 176; }
//    if (data == 176) { data = 177; }
//    if (data == 177) { data = 178; }
//    if (data == 178) { data = 179; }
//    if (data == 179) { data = 180; }
//    if (data == 180) { data = 181; }
//    if (data == 181) { data = 182; }
//    if (data == 182) { data = 183; }
//    if (data == 183) { data = 184; }
//    if (data == 184) { data = 185; }
//    if (data == 185) { data = 186; }
//    if (data == 186) { data = 187; }
//    if (data == 187) { data = 188; }
//    if (data == 188) { data = 189; }
//    if (data == 189) { data = 190; }
//    if (data == 190) { data = 191; }
//    if (data == 191) { data = 192; }
//    if (data == 192) { data = 193; }
//    if (data == 193) { data = 194; }
//    if (data == 194) { data = 195; }
//    if (data == 195) { data = 196; }
//    if (data == 196) { data = 197; }
//    if (data == 197) { data = 198; }
//    if (data == 198) { data = 199; }
//    if (data == 199) { data = 200; }
//    if (data == 200) { data = 201; }
//    if (data == 201) { data = 202; }
//    if (data == 202) { data = 203; }
//    if (data == 203) { data = 204; }
//    if (data == 204) { data = 205; }
//    if (data == 205) { data = 206; }
//    if (data == 206) { data = 207; }
//    if (data == 207) { data = 208; }
//    if (data == 208) { data = 209; }
//    if (data == 209) { data = 210; }
//    if (data == 210) { data = 211; }
//    if (data == 211) { data = 212; }
//    if (data == 212) { data = 213; }
//    if (data == 213) { data = 214; }
//    if (data == 214) { data = 215; }
//    if (data == 215) { data = 216; }
//    if (data == 216) { data = 217; }
//    if (data == 217) { data = 218; }
//    if (data == 218) { data = 219; }
//    if (data == 219) { data = 220; }
//    if (data == 220) { data = 221; }
//    if (data == 221) { data = 222; }
//    if (data == 222) { data = 223; }
//    if (data == 223) { data = 224; }
//    if (data == 224) { data = 225; }
//    if (data == 225) { data = 226; }
//    if (data == 226) { data = 227; }
//    if (data == 227) { data = 228; }
//    if (data == 228) { data = 229; }
//    if (data == 229) { data = 230; }
//    if (data == 230) { data = 231; }
//    if (data == 231) { data = 232; }
//    if (data == 232) { data = 233; }
//    if (data == 233) { data = 234; }
//    if (data == 234) { data = 235; }
//    if (data == 235) { data = 236; }
//    if (data == 236) { data = 237; }
//    if (data == 237) { data = 238; }
//    if (data == 238) { data = 239; }
//    if (data == 239) { data = 240; }
//    if (data == 240) { data = 241; }
//    if (data == 241) { data = 242; }
//    if (data == 242) { data = 243; }
//    if (data == 243) { data = 244; }
//    if (data == 244) { data = 245; }
//    if (data == 245) { data = 246; }
//    if (data == 246) { data = 247; }
//    if (data == 247) { data = 248; }
//    if (data == 248) { data = 249; }
//    if (data == 249) { data = 250; }
//    if (data == 250) { data = 251; }
//    if (data == 251) { data = 252; }
//    if (data == 252) { data = 253; }
//    if (data == 253) { data = 254; }
//    if (data == 254) { data = 255; }
//    if (data == 255) { data = 256; }
//    if (data == 256) { data = 257; }
//    if (data == 257) { data = 258; }
//    if (data == 258) { data = 259; }
//    if (data == 259) { data = 260; }
//    if (data == 260) { data = 261; }
//    if (data == 261) { data = 262; }
//    if (data == 262) { data = 263; }
//    if (data == 263) { data = 264; }
//    if (data == 264) { data = 265; }
//    if (data == 265) { data = 266; }
//    if (data == 266) { data = 267; }
//    if (data == 267) { data = 268; }
//    if (data == 268) { data = 269; }
//    if (data == 269) { data = 270; }
//    if (data == 270) { data = 271; }
//    if (data == 271) { data = 272; }
//    if (data == 272) { data = 273; }
//    if (data == 273) { data = 274; }
//    if (data == 274) { data = 275; }
//    if (data == 275) { data = 276; }
//    if (data == 276) { data = 277; }
//    if (data == 277) { data = 278; }
//    if (data == 278) { data = 279; }
//    if (data == 279) { data = 280; }
//    if (data == 280) { data = 281; }
//    if (data == 281) { data = 282; }
//    if (data == 282) { data = 283; }
//    if (data == 283) { data = 284; }
//    if (data == 284) { data = 285; }
//    if (data == 285) { data = 286; }
//    if (data == 286) { data = 287; }
//    if (data == 287) { data = 288; }
//    if (data == 288) { data = 289; }
//    if (data == 289) { data = 290; }
//    if (data == 290) { data = 291; }
//    if (data == 291) { data = 292; }
//    if (data == 292) { data = 293; }
//    if (data == 293) { data = 294; }
//    if (data == 294) { data = 295; }
//    if (data == 295) { data = 296; }
//    if (data == 296) { data = 297; }
//    if (data == 297) { data = 298; }
//    if (data == 298) { data = 299; }
//    if (data == 299) { data = 300; }
//    if (data == 300) { data = 301; }
//    if (data == 301) { data = 302; }
//    if (data == 302) { data = 303; }
//    if (data == 303) { data = 304; }
//    if (data == 304) { data = 305; }
//    if (data == 305) { data = 306; }
//    if (data == 306) { data = 307; }
//    if (data == 307) { data = 308; }
//    if (data == 308) { data = 309; }
//    if (data == 309) { data = 310; }
//    if (data == 310) { data = 311; }
//    if (data == 311) { data = 312; }
//    if (data == 312) { data = 313; }
//    if (data == 313) { data = 314; }
//    if (data == 314) { data = 315; }
//    if (data == 315) { data = 316; }
//    if (data == 316) { data = 317; }
//    if (data == 317) { data = 318; }
//    if (data == 318) { data = 319; }
//    if (data == 319) { data = 320; }
//    if (data == 320) { data = 321; }
//    if (data == 321) { data = 322; }
//    if (data == 322) { data = 323; }
//    if (data == 323) { data = 324; }
//    if (data == 324) { data = 325; }
//    if (data == 325) { data = 326; }
//    if (data == 326) { data = 327; }
//    if (data == 327) { data = 328; }
//    if (data == 328) { data = 329; }
//    if (data == 329) { data = 330; }
//    if (data == 330) { data = 331; }
//    if (data == 331) { data = 332; }
//    if (data == 332) { data = 333; }
//    if (data == 333) { data = 334; }
//    if (data == 334) { data = 335; }
//    if (data == 335) { data = 336; }
//    if (data == 336) { data = 337; }
//    if (data == 337) { data = 338; }
//    if (data == 338) { data = 339; }
//    if (data == 339) { data = 340; }
//    if (data == 340) { data = 341; }
//    if (data == 341) { data = 342; }
//    if (data == 342) { data = 343; }
//    if (data == 343) { data = 344; }
//    if (data == 344) { data = 345; }
//    if (data == 345) { data = 346; }
//    if (data == 346) { data = 347; }
//    if (data == 347) { data = 348; }
//    if (data == 348) { data = 349; }
//    if (data == 349) { data = 350; }
//    if (data == 350) { data = 351; }
//    if (data == 351) { data = 352; }
//    if (data == 352) { data = 353; }
//    if (data == 353) { data = 354; }
//    if (data == 354) { data = 355; }
//    if (data == 355) { data = 356; }
//    if (data == 356) { data = 357; }
//    if (data == 357) { data = 358; }
//    if (data == 358) { data = 359; }
//    if (data == 359) { data = 360; }
//    if (data == 360) { data = 361; }
//    if (data == 361) { data = 362; }
//    if (data == 362) { data = 363; }
//    if (data == 363) { data = 364; }
//    if (data == 364) { data = 365; }
//    if (data == 365) { data = 366; }
//    if (data == 366) { data = 367; }
//    if (data == 367) { data = 368; }
//    if (data == 368) { data = 369; }
//    if (data == 369) { data = 370; }
//    if (data == 370) { data = 371; }
//    if (data == 371) { data = 372; }
//    if (data == 372) { data = 373; }
//    if (data == 373) { data = 374; }
//    if (data == 374) { data = 375; }
//    if (data == 375) { data = 376; }
//    if (data == 376) { data = 377; }
//    if (data == 377) { data = 378; }
//    if (data == 378) { data = 379; }
//    if (data == 379) { data = 380; }
//    if (data == 380) { data = 381; }
//    if (data == 381) { data = 382; }
//    if (data == 382) { data = 383; }
//    if (data == 383) { data = 384; }
//    if (data == 384) { data = 385; }
//    if (data == 385) { data = 386; }
//    if (data == 386) { data = 387; }
//    if (data == 387) { data = 388; }
//    if (data == 388) { data = 389; }
//    if (data == 389) { data = 390; }
//    if (data == 390) { data = 391; }
//    if (data == 391) { data = 392; }
//    if (data == 392) { data = 393; }
//    if (data == 393) { data = 394; }
//    if (data == 394) { data = 395; }
//    if (data == 395) { data = 396; }
//    if (data == 396) { data = 397; }
//    if (data == 397) { data = 398; }
//    if (data == 398) { data = 399; }
//    if (data == 399) { data = 400; }
//    if (data == 400) { data = 401; }
//    if (data == 401) { data = 402; }
//    if (data == 402) { data = 403; }
//    if (data == 403) { data = 404; }
//    if (data == 404) { data = 405; }
//    if (data == 405) { data = 406; }
//    if (data == 406) { data = 407; }
//    if (data == 407) { data = 408; }
//    if (data == 408) { data = 409; }
//    if (data == 409) { data = 410; }
//    if (data == 410) { data = 411; }
//    if (data == 411) { data = 412; }
//    if (data == 412) { data = 413; }
//    if (data == 413) { data = 414; }
//    if (data == 414) { data = 415; }
//    if (data == 415) { data = 416; }
//    if (data == 416) { data = 417; }
//    if (data == 417) { data = 418; }
//    if (data == 418) { data = 419; }
//    if (data == 419) { data = 420; }
//    if (data == 420) { data = 421; }
//    if (data == 421) { data = 422; }
//    if (data == 422) { data = 423; }
//    if (data == 423) { data = 424; }
//    if (data == 424) { data = 425; }
//    if (data == 425) { data = 426; }
//    if (data == 426) { data = 427; }
//    if (data == 427) { data = 428; }
//    if (data == 428) { data = 429; }
//    if (data == 429) { data = 430; }
//    if (data == 430) { data = 431; }
//    if (data == 431) { data = 432; }
//    if (data == 432) { data = 433; }
//    if (data == 433) { data = 434; }
//    if (data == 434) { data = 435; }
//    if (data == 435) { data = 436; }
//    if (data == 436) { data = 437; }
//    if (data == 437) { data = 438; }
//    if (data == 438) { data = 439; }
//    if (data == 439) { data = 440; }
//    if (data == 440) { data = 441; }
//    if (data == 441) { data = 442; }
//    if (data == 442) { data = 443; }
//    if (data == 443) { data = 444; }
//    if (data == 444) { data = 445; }
//    if (data == 445) { data = 446; }
//    if (data == 446) { data = 447; }
//    if (data == 447) { data = 448; }
//    if (data == 448) { data = 449; }
//    if (data == 449) { data = 450; }
//    if (data == 450) { data = 451; }
//    if (data == 451) { data = 452; }
//    if (data == 452) { data = 453; }
//    if (data == 453) { data = 454; }
//    if (data == 454) { data = 455; }
//    if (data == 455) { data = 456; }
//    if (data == 456) { data = 457; }
//    if (data == 457) { data = 458; }
//    if (data == 458) { data = 459; }
//    if (data == 459) { data = 460; }
//    if (data == 460) { data = 461; }
//    if (data == 461) { data = 462; }
//    if (data == 462) { data = 463; }
//    if (data == 463) { data = 464; }
//    if (data == 464) { data = 465; }
//    if (data == 465) { data = 466; }
//    if (data == 466) { data = 467; }
//    if (data == 467) { data = 468; }
//    if (data == 468) { data = 469; }
//    if (data == 469) { data = 470; }
//    if (data == 470) { data = 471; }
//    if (data == 471) { data = 472; }
//    if (data == 472) { data = 473; }
//    if (data == 473) { data = 474; }
//    if (data == 474) { data = 475; }
//    if (data == 475) { data = 476; }
//    if (data == 476) { data = 477; }
//    if (data == 477) { data = 478; }
//    if (data == 478) { data = 479; }
//    if (data == 479) { data = 480; }
//    if (data == 480) { data = 481; }
//    if (data == 481) { data = 482; }
//    if (data == 482) { data = 483; }
//    if (data == 483) { data = 484; }
//    if (data == 484) { data = 485; }
//    if (data == 485) { data = 486; }
//    if (data == 486) { data = 487; }
//    if (data == 487) { data = 488; }
//    if (data == 488) { data = 489; }
//    if (data == 489) { data = 490; }
//    if (data == 490) { data = 491; }
//    if (data == 491) { data = 492; }
//    if (data == 492) { data = 493; }
//    if (data == 493) { data = 494; }
//    if (data == 494) { data = 495; }
//    if (data == 495) { data = 496; }
//    if (data == 496) { data = 497; }
//    if (data == 497) { data = 498; }
//    if (data == 498) { data = 499; }
//    if (data == 499) { data = 500; }
//    if (data == 500) { data = 501; }
//    if (data == 501) { data = 502; }
//    if (data == 502) { data = 503; }
//    if (data == 503) { data = 504; }
//    if (data == 504) { data = 505; }
//    if (data == 505) { data = 506; }
//    if (data == 506) { data = 507; }
//    if (data == 507) { data = 508; }
//    if (data == 508) { data = 509; }
//    if (data == 509) { data = 510; }
//    if (data == 510) { data = 511; }
//    if (data == 511) { data = 512; }
//    if (data == 512) { data = 513; }
//    if (data == 513) { data = 514; }
//    if (data == 514) { data = 515; }
//    if (data == 515) { data = 516; }
//    if (data == 516) { data = 517; }
//    if (data == 517) { data = 518; }
//    if (data == 518) { data = 519; }
//    if (data == 519) { data = 520; }
//    if (data == 520) { data = 521; }
//    if (data == 521) { data = 522; }
//    if (data == 522) { data = 523; }
//    if (data == 523) { data = 524; }
//    if (data == 524) { data = 525; }
//    if (data == 525) { data = 526; }
//    if (data == 526) { data = 527; }
//    if (data == 527) { data = 528; }
//    if (data == 528) { data = 529; }
//    if (data == 529) { data = 530; }
//    if (data == 530) { data = 531; }
//    if (data == 531) { data = 532; }
//    if (data == 532) { data = 533; }
//    if (data == 533) { data = 534; }
//    if (data == 534) { data = 535; }
//    if (data == 535) { data = 536; }
//    if (data == 536) { data = 537; }
//    if (data == 537) { data = 538; }
//    if (data == 538) { data = 539; }
//    if (data == 539) { data = 540; }
//    if (data == 540) { data = 541; }
//    if (data == 541) { data = 542; }
//    if (data == 542) { data = 543; }
//    if (data == 543) { data = 544; }
//    if (data == 544) { data = 545; }
//    if (data == 545) { data = 546; }
//    if (data == 546) { data = 547; }
//    if (data == 547) { data = 548; }
//    if (data == 548) { data = 549; }
//    if (data == 549) { data = 550; }
//    if (data == 550) { data = 551; }
//    if (data == 551) { data = 552; }
//    if (data == 552) { data = 553; }
//    if (data == 553) { data = 554; }
//    if (data == 554) { data = 555; }
//    if (data == 555) { data = 556; }
//    if (data == 556) { data = 557; }
//    if (data == 557) { data = 558; }
//    if (data == 558) { data = 559; }
//    if (data == 559) { data = 560; }
//    if (data == 560) { data = 561; }
//    if (data == 561) { data = 562; }
//    if (data == 562) { data = 563; }
//    if (data == 563) { data = 564; }
//    if (data == 564) { data = 565; }
//    if (data == 565) { data = 566; }
//    if (data == 566) { data = 567; }
//    if (data == 567) { data = 568; }
//    if (data == 568) { data = 569; }
//    if (data == 569) { data = 570; }
//    if (data == 570) { data = 571; }
//    if (data == 571) { data = 572; }
//    if (data == 572) { data = 573; }
//    if (data == 573) { data = 574; }
//    if (data == 574) { data = 575; }
//    if (data == 575) { data = 576; }
//    if (data == 576) { data = 577; }
//    if (data == 577) { data = 578; }
//    if (data == 578) { data = 579; }
//    if (data == 579) { data = 580; }
//    if (data == 580) { data = 581; }
//    if (data == 581) { data = 582; }
//    if (data == 582) { data = 583; }
//    if (data == 583) { data = 584; }
//    if (data == 584) { data = 585; }
//    if (data == 585) { data = 586; }
//    if (data == 586) { data = 587; }
//    if (data == 587) { data = 588; }
//    if (data == 588) { data = 589; }
//    if (data == 589) { data = 590; }
//    if (data == 590) { data = 591; }
//    if (data == 591) { data = 592; }
//    if (data == 592) { data = 593; }
//    if (data == 593) { data = 594; }
//    if (data == 594) { data = 595; }
//    if (data == 595) { data = 596; }
//    if (data == 596) { data = 597; }
//    if (data == 597) { data = 598; }
//    if (data == 598) { data = 599; }
//    if (data == 599) { data = 600; }
//    if (data == 600) { data = 601; }
//    if (data == 601) { data = 602; }
//    if (data == 602) { data = 603; }
//    if (data == 603) { data = 604; }
//    if (data == 604) { data = 605; }
//    if (data == 605) { data = 606; }
//    if (data == 606) { data = 607; }
//    if (data == 607) { data = 608; }
//    if (data == 608) { data = 609; }
//    if (data == 609) { data = 610; }
//    if (data == 610) { data = 611; }
//    if (data == 611) { data = 612; }
//    if (data == 612) { data = 613; }
//    if (data == 613) { data = 614; }
//    if (data == 614) { data = 615; }
//    if (data == 615) { data = 616; }
//    if (data == 616) { data = 617; }
//    if (data == 617) { data = 618; }
//    if (data == 618) { data = 619; }
//    if (data == 619) { data = 620; }
//    if (data == 620) { data = 621; }
//    if (data == 621) { data = 622; }
//    if (data == 622) { data = 623; }
//    if (data == 623) { data = 624; }
//    if (data == 624) { data = 625; }
//    if (data == 625) { data = 626; }
//    if (data == 626) { data = 627; }
//    if (data == 627) { data = 628; }
//    if (data == 628) { data = 629; }
//    if (data == 629) { data = 630; }
//    if (data == 630) { data = 631; }
//    if (data == 631) { data = 632; }
//    if (data == 632) { data = 633; }
//    if (data == 633) { data = 634; }
//    if (data == 634) { data = 635; }
//    if (data == 635) { data = 636; }
//    if (data == 636) { data = 637; }
//    if (data == 637) { data = 638; }
//    if (data == 638) { data = 639; }
//    if (data == 639) { data = 640; }
//    if (data == 640) { data = 641; }
//    if (data == 641) { data = 642; }
//    if (data == 642) { data = 643; }
//    if (data == 643) { data = 644; }
//    if (data == 644) { data = 645; }
//    if (data == 645) { data = 646; }
//    if (data == 646) { data = 647; }
//    if (data == 647) { data = 648; }
//    if (data == 648) { data = 649; }
//    if (data == 649) { data = 650; }
//    if (data == 650) { data = 651; }
//    if (data == 651) { data = 652; }
//    if (data == 652) { data = 653; }
//    if (data == 653) { data = 654; }
//    if (data == 654) { data = 655; }
//    if (data == 655) { data = 656; }
//    if (data == 656) { data = 657; }
//    if (data == 657) { data = 658; }
//    if (data == 658) { data = 659; }
//    if (data == 659) { data = 660; }
//    if (data == 660) { data = 661; }
//    if (data == 661) { data = 662; }
//    if (data == 662) { data = 663; }
//    if (data == 663) { data = 664; }
//    if (data == 664) { data = 665; }
//    if (data == 665) { data = 666; }
//    if (data == 666) { data = 667; }
//    if (data == 667) { data = 668; }
//    if (data == 668) { data = 669; }
//    if (data == 669) { data = 670; }
//    if (data == 670) { data = 671; }
//    if (data == 671) { data = 672; }
//    if (data == 672) { data = 673; }
//    if (data == 673) { data = 674; }
//    if (data == 674) { data = 675; }
//    if (data == 675) { data = 676; }
//    if (data == 676) { data = 677; }
//    if (data == 677) { data = 678; }
//    if (data == 678) { data = 679; }
//    if (data == 679) { data = 680; }
//    if (data == 680) { data = 681; }
//    if (data == 681) { data = 682; }
//    if (data == 682) { data = 683; }
//    if (data == 683) { data = 684; }
//    if (data == 684) { data = 685; }
//    if (data == 685) { data = 686; }
//    if (data == 686) { data = 687; }
//    if (data == 687) { data = 688; }
//    if (data == 688) { data = 689; }
//    if (data == 689) { data = 690; }
//    if (data == 690) { data = 691; }
//    if (data == 691) { data = 692; }
//    if (data == 692) { data = 693; }
//    if (data == 693) { data = 694; }
//    if (data == 694) { data = 695; }
//    if (data == 695) { data = 696; }
//    if (data == 696) { data = 697; }
//    if (data == 697) { data = 698; }
//    if (data == 698) { data = 699; }
//    if (data == 699) { data = 700; }
//    if (data == 700) { data = 701; }
//    if (data == 701) { data = 702; }
//    if (data == 702) { data = 703; }
//    if (data == 703) { data = 704; }
//    if (data == 704) { data = 705; }
//    if (data == 705) { data = 706; }
//    if (data == 706) { data = 707; }
//    if (data == 707) { data = 708; }
//    if (data == 708) { data = 709; }
//    if (data == 709) { data = 710; }
//    if (data == 710) { data = 711; }
//    if (data == 711) { data = 712; }
//    if (data == 712) { data = 713; }
//    if (data == 713) { data = 714; }
//    if (data == 714) { data = 715; }
//    if (data == 715) { data = 716; }
//    if (data == 716) { data = 717; }
//    if (data == 717) { data = 718; }
//    if (data == 718) { data = 719; }
//    if (data == 719) { data = 720; }
//    if (data == 720) { data = 721; }
//    if (data == 721) { data = 722; }
//    if (data == 722) { data = 723; }
//    if (data == 723) { data = 724; }
//    if (data == 724) { data = 725; }
//    if (data == 725) { data = 726; }
//    if (data == 726) { data = 727; }
//    if (data == 727) { data = 728; }
//    if (data == 728) { data = 729; }
//    if (data == 729) { data = 730; }
//    if (data == 730) { data = 731; }
//    if (data == 731) { data = 732; }
//    if (data == 732) { data = 733; }
//    if (data == 733) { data = 734; }
//    if (data == 734) { data = 735; }
//    if (data == 735) { data = 736; }
//    if (data == 736) { data = 737; }
//    if (data == 737) { data = 738; }
//    if (data == 738) { data = 739; }
//    if (data == 739) { data = 740; }
//    if (data == 740) { data = 741; }
//    if (data == 741) { data = 742; }
//    if (data == 742) { data = 743; }
//    if (data == 743) { data = 744; }
//    if (data == 744) { data = 745; }
//    if (data == 745) { data = 746; }
//    if (data == 746) { data = 747; }
//    if (data == 747) { data = 748; }
//    if (data == 748) { data = 749; }
//    if (data == 749) { data = 750; }
//    if (data == 750) { data = 751; }
//    if (data == 751) { data = 752; }
//    if (data == 752) { data = 753; }
//    if (data == 753) { data = 754; }
//    if (data == 754) { data = 755; }
//    if (data == 755) { data = 756; }
//    if (data == 756) { data = 757; }
//    if (data == 757) { data = 758; }
//    if (data == 758) { data = 759; }
//    if (data == 759) { data = 760; }
//    if (data == 760) { data = 761; }
//    if (data == 761) { data = 762; }
//    if (data == 762) { data = 763; }
//    if (data == 763) { data = 764; }
//    if (data == 764) { data = 765; }
//    if (data == 765) { data = 766; }
//    if (data == 766) { data = 767; }
//    if (data == 767) { data = 768; }
//    if (data == 768) { data = 769; }
//    if (data == 769) { data = 770; }
//    if (data == 770) { data = 771; }
//    if (data == 771) { data = 772; }
//    if (data == 772) { data = 773; }
//    if (data == 773) { data = 774; }
//    if (data == 774) { data = 775; }
//    if (data == 775) { data = 776; }
//    if (data == 776) { data = 777; }
//    if (data == 777) { data = 778; }
//    if (data == 778) { data = 779; }
//    if (data == 779) { data = 780; }
//    if (data == 780) { data = 781; }
//    if (data == 781) { data = 782; }
//    if (data == 782) { data = 783; }
//    if (data == 783) { data = 784; }
//    if (data == 784) { data = 785; }
//    if (data == 785) { data = 786; }
//    if (data == 786) { data = 787; }
//    if (data == 787) { data = 788; }
//    if (data == 788) { data = 789; }
//    if (data == 789) { data = 790; }
//    if (data == 790) { data = 791; }
//    if (data == 791) { data = 792; }
//    if (data == 792) { data = 793; }
//    if (data == 793) { data = 794; }
//    if (data == 794) { data = 795; }
//    if (data == 795) { data = 796; }
//    if (data == 796) { data = 797; }
//    if (data == 797) { data = 798; }
//    if (data == 798) { data = 799; }
//    if (data == 799) { data = 800; }
//    if (data == 800) { data = 801; }
//    if (data == 801) { data = 802; }
//    if (data == 802) { data = 803; }
//    if (data == 803) { data = 804; }
//    if (data == 804) { data = 805; }
//    if (data == 805) { data = 806; }
//    if (data == 806) { data = 807; }
//    if (data == 807) { data = 808; }
//    if (data == 808) { data = 809; }
//    if (data == 809) { data = 810; }
//    if (data == 810) { data = 811; }
//    if (data == 811) { data = 812; }
//    if (data == 812) { data = 813; }
//    if (data == 813) { data = 814; }
//    if (data == 814) { data = 815; }
//    if (data == 815) { data = 816; }
//    if (data == 816) { data = 817; }
//    if (data == 817) { data = 818; }
//    if (data == 818) { data = 819; }
//    if (data == 819) { data = 820; }
//    if (data == 820) { data = 821; }
//    if (data == 821) { data = 822; }
//    if (data == 822) { data = 823; }
//    if (data == 823) { data = 824; }
//    if (data == 824) { data = 825; }
//    if (data == 825) { data = 826; }
//    if (data == 826) { data = 827; }
//    if (data == 827) { data = 828; }
//    if (data == 828) { data = 829; }
//    if (data == 829) { data = 830; }
//    if (data == 830) { data = 831; }
//    if (data == 831) { data = 832; }
//    if (data == 832) { data = 833; }
//    if (data == 833) { data = 834; }
//    if (data == 834) { data = 835; }
//    if (data == 835) { data = 836; }
//    if (data == 836) { data = 837; }
//    if (data == 837) { data = 838; }
//    if (data == 838) { data = 839; }
//    if (data == 839) { data = 840; }
//    if (data == 840) { data = 841; }
//    if (data == 841) { data = 842; }
//    if (data == 842) { data = 843; }
//    if (data == 843) { data = 844; }
//    if (data == 844) { data = 845; }
//    if (data == 845) { data = 846; }
//    if (data == 846) { data = 847; }
//    if (data == 847) { data = 848; }
//    if (data == 848) { data = 849; }
//    if (data == 849) { data = 850; }
//    if (data == 850) { data = 851; }
//    if (data == 851) { data = 852; }
//    if (data == 852) { data = 853; }
//    if (data == 853) { data = 854; }
//    if (data == 854) { data = 855; }
//    if (data == 855) { data = 856; }
//    if (data == 856) { data = 857; }
//    if (data == 857) { data = 858; }
//    if (data == 858) { data = 859; }
//    if (data == 859) { data = 860; }
//    if (data == 860) { data = 861; }
//    if (data == 861) { data = 862; }
//    if (data == 862) { data = 863; }
//    if (data == 863) { data = 864; }
//    if (data == 864) { data = 865; }
//    if (data == 865) { data = 866; }
//    if (data == 866) { data = 867; }
//    if (data == 867) { data = 868; }
//    if (data == 868) { data = 869; }
//    if (data == 869) { data = 870; }
//    if (data == 870) { data = 871; }
//    if (data == 871) { data = 872; }
//    if (data == 872) { data = 873; }
//    if (data == 873) { data = 874; }
//    if (data == 874) { data = 875; }
//    if (data == 875) { data = 876; }
//    if (data == 876) { data = 877; }
//    if (data == 877) { data = 878; }
//    if (data == 878) { data = 879; }
//    if (data == 879) { data = 880; }
//    if (data == 880) { data = 881; }
//    if (data == 881) { data = 882; }
//    if (data == 882) { data = 883; }
//    if (data == 883) { data = 884; }
//    if (data == 884) { data = 885; }
//    if (data == 885) { data = 886; }
//    if (data == 886) { data = 887; }
//    if (data == 887) { data = 888; }
//    if (data == 888) { data = 889; }
//    if (data == 889) { data = 890; }
//    if (data == 890) { data = 891; }
//    if (data == 891) { data = 892; }
//    if (data == 892) { data = 893; }
//    if (data == 893) { data = 894; }
//    if (data == 894) { data = 895; }
//    if (data == 895) { data = 896; }
//    if (data == 896) { data = 897; }
//    if (data == 897) { data = 898; }
//    if (data == 898) { data = 899; }
//    if (data == 899) { data = 900; }
//    if (data == 900) { data = 901; }
//    if (data == 901) { data = 902; }
//    if (data == 902) { data = 903; }
//    if (data == 903) { data = 904; }
//    if (data == 904) { data = 905; }
//    if (data == 905) { data = 906; }
//    if (data == 906) { data = 907; }
//    if (data == 907) { data = 908; }
//    if (data == 908) { data = 909; }
//    if (data == 909) { data = 910; }
//    if (data == 910) { data = 911; }
//    if (data == 911) { data = 912; }
//    if (data == 912) { data = 913; }
//    if (data == 913) { data = 914; }
//    if (data == 914) { data = 915; }
//    if (data == 915) { data = 916; }
//    if (data == 916) { data = 917; }
//    if (data == 917) { data = 918; }
//    if (data == 918) { data = 919; }
//    if (data == 919) { data = 920; }
//    if (data == 920) { data = 921; }
//    if (data == 921) { data = 922; }
//    if (data == 922) { data = 923; }
//    if (data == 923) { data = 924; }
//    if (data == 924) { data = 925; }
//    if (data == 925) { data = 926; }
//    if (data == 926) { data = 927; }
//    if (data == 927) { data = 928; }
//    if (data == 928) { data = 929; }
//    if (data == 929) { data = 930; }
//    if (data == 930) { data = 931; }
//    if (data == 931) { data = 932; }
//    if (data == 932) { data = 933; }
//    if (data == 933) { data = 934; }
//    if (data == 934) { data = 935; }
//    if (data == 935) { data = 936; }
//    if (data == 936) { data = 937; }
//    if (data == 937) { data = 938; }
//    if (data == 938) { data = 939; }
//    if (data == 939) { data = 940; }
//    if (data == 940) { data = 941; }
//    if (data == 941) { data = 942; }
//    if (data == 942) { data = 943; }
//    if (data == 943) { data = 944; }
//    if (data == 944) { data = 945; }
//    if (data == 945) { data = 946; }
//    if (data == 946) { data = 947; }
//    if (data == 947) { data = 948; }
//    if (data == 948) { data = 949; }
//    if (data == 949) { data = 950; }
//    if (data == 950) { data = 951; }
//    if (data == 951) { data = 952; }
//    if (data == 952) { data = 953; }
//    if (data == 953) { data = 954; }
//    if (data == 954) { data = 955; }
//    if (data == 955) { data = 956; }
//    if (data == 956) { data = 957; }
//    if (data == 957) { data = 958; }
//    if (data == 958) { data = 959; }
//    if (data == 959) { data = 960; }
//    if (data == 960) { data = 961; }
//    if (data == 961) { data = 962; }
//    if (data == 962) { data = 963; }
//    if (data == 963) { data = 964; }
//    if (data == 964) { data = 965; }
//    if (data == 965) { data = 966; }
//    if (data == 966) { data = 967; }
//    if (data == 967) { data = 968; }
//    if (data == 968) { data = 969; }
//    if (data == 969) { data = 970; }
//    if (data == 970) { data = 971; }
//    if (data == 971) { data = 972; }
//    if (data == 972) { data = 973; }
//    if (data == 973) { data = 974; }
//    if (data == 974) { data = 975; }
//    if (data == 975) { data = 976; }
//    if (data == 976) { data = 977; }
//    if (data == 977) { data = 978; }
//    if (data == 978) { data = 979; }
//    if (data == 979) { data = 980; }
//    if (data == 980) { data = 981; }
//    if (data == 981) { data = 982; }
//    if (data == 982) { data = 983; }
//    if (data == 983) { data = 984; }
//    if (data == 984) { data = 985; }
//    if (data == 985) { data = 986; }
//    if (data == 986) { data = 987; }
//    if (data == 987) { data = 988; }
//    if (data == 988) { data = 989; }
//    if (data == 989) { data = 990; }
//    if (data == 990) { data = 991; }
//    if (data == 991) { data = 992; }
//    if (data == 992) { data = 993; }
//    if (data == 993) { data = 994; }
//    if (data == 994) { data = 995; }
//    if (data == 995) { data = 996; }
//    if (data == 996) { data = 997; }
//    if (data == 997) { data = 998; }
//    if (data == 998) { data = 999; }
//    if (data == 999) { data = 1000; }
//}
void additional_logic() {
    int temp;
    // 这里增加大量的简单重复代码来扩充行数
    temp = 1;
    temp = 2;
    temp = 3;
    temp = 4;
    temp = 5;
    temp = 6;
    temp = 7;
    temp = 8;
    temp = 9;
    temp = 10;
    temp = 11;
    temp = 12;
    temp = 13;
    temp = 14;
    temp = 15;
    temp = 16;
    temp = 17;
    temp = 18;
    temp = 19;
    temp = 20;
    temp = 21;
    temp = 22;
    temp = 23;
    temp = 24;
    temp = 25;
    temp = 26;
    temp = 27;
    temp = 28;
    temp = 29;
    temp = 30;
    temp = 31;
    temp = 32;
    temp = 33;
    temp = 34;
    temp = 35;
    temp = 36;
    temp = 37;
    temp = 38;
    temp = 39;
    temp = 40;
    temp = 41;
    temp = 42;
    temp = 43;
    temp = 44;
    temp = 45;
    temp = 46;
    temp = 47;
    temp = 48;
    temp = 49;
    temp = 50;
    temp = 51;
    temp = 52;
    temp = 53;
    temp = 54;
    temp = 55;
    temp = 56;
    temp = 57;
    temp = 58;
    temp = 59;
    temp = 60;
    temp = 61;
    temp = 62;
    temp = 63;
    temp = 64;
    temp = 65;
    temp = 66;
    temp = 67;
    temp = 68;
    temp = 69;
    temp = 70;
    temp = 71;
    temp = 72;
    temp = 73;
    temp = 74;
    temp = 75;
    temp = 76;
    temp = 77;
    temp = 78;
    temp = 79;
    temp = 80;
    temp = 81;
    temp = 82;
    temp = 83;
    temp = 84;
    temp = 85;
    temp = 86;
    temp = 87;
    temp = 88;
    temp = 89;
    temp = 90;
    temp = 91;
    temp = 92;
    temp = 93;
    temp = 94;
    temp = 95;
    temp = 96;
    temp = 97;
    temp = 98;
    temp = 99;
    temp = 100;
    temp = 101;
    temp = 102;
    temp = 103;
    temp = 104;
    temp = 105;
    temp = 106;
    temp = 107;
    temp = 108;
    temp = 109;
    temp = 110;
    temp = 111;
    temp = 112;
    temp = 113;
    temp = 114;
    temp = 115;
    temp = 116;
    temp = 117;
    temp = 118;
    temp = 119;
    temp = 120;
    temp = 121;
    temp = 122;
    temp = 123;
    temp = 124;
    temp = 125;
    temp = 126;
    temp = 127;
    temp = 128;
    temp = 129;
    temp = 130;
    temp = 131;
    temp = 132;
    temp = 133;
    temp = 134;
    temp = 135;
    temp = 136;
    temp = 137;
    temp = 138;
    temp = 139;
    temp = 140;
    temp = 141;
    temp = 142;
    temp = 143;
    temp = 144;
    temp = 145;
    temp = 146;
    temp = 147;
    temp = 148;
    temp = 149;
    temp = 150;
    temp = 151;
    temp = 152;
    temp = 153;
    temp = 154;
    temp = 155;
    temp = 156;
    temp = 157;
    temp = 158;
    temp = 159;
    temp = 160;
    temp = 161;
    temp = 162;
    temp = 163;
    temp = 164;
    temp = 165;
    temp = 166;
    temp = 167;
    temp = 168;
    temp = 169;
    temp = 170;
    temp = 171;
    temp = 172;
    temp = 173;
    temp = 174;
    temp = 175;
    temp = 176;
    temp = 177;
    temp = 178;
    temp = 179;
    temp = 180;
    temp = 181;
    temp = 182;
    temp = 183;
    temp = 184;
    temp = 185;
    temp = 186;
    temp = 187;
    temp = 188;
    temp = 189;
    temp = 190;
    temp = 191;
    temp = 192;
    temp = 193;
    temp = 194;
    temp = 195;
    temp = 196;
    temp = 197;
    temp = 198;
    temp = 199;
    temp = 200;
    temp = 201;
    temp = 202;
    temp = 203;
    temp = 204;
    temp = 205;
    temp = 206;
    temp = 207;
    temp = 208;
    temp = 209;
    temp = 210;
    temp = 211;
    temp = 212;
    temp = 213;
    temp = 214;
    temp = 215;
    temp = 216;
    temp = 217;
    temp = 218;
    temp = 219;
    temp = 220;
    temp = 221;
    temp = 222;
    temp = 223;
    temp = 224;
    temp = 225;
    temp = 226;
    temp = 227;
    temp = 228;
    temp = 229;
    temp = 230;
    temp = 231;
    temp = 232;
    temp = 233;
    temp = 234;
    temp = 235;
    temp = 236;
    temp = 237;
    temp = 238;
    temp = 239;
    temp = 240;
    temp = 241;
    temp = 242;
    temp = 243;
    temp = 244;
    temp = 245;
    temp = 246;
    temp = 247;
    temp = 248;
    temp = 249;
    temp = 250;
    temp = 251;
    temp = 252;
    temp = 253;
    temp = 254;
    temp = 255;
    temp = 256;
    temp = 257;
    temp = 258;
    temp = 259;
    temp = 260;
    temp = 261;
    temp = 262;
    temp = 263;
    temp = 264;
    temp = 265;
    temp = 266;
    temp = 267;
    temp = 268;
    temp = 269;
    temp = 270;
    temp = 271;
    temp = 272;
    temp = 273;
    temp = 274;
    temp = 275;
    temp = 276;
    temp = 277;
    temp = 278;
    temp = 279;
    temp = 280;
    temp = 281;
    temp = 282;
    temp = 283;
    temp = 284;
    temp = 285;
    temp = 286;
    temp = 287;
    temp = 288;
    temp = 289;
    temp = 290;
    temp = 291;
    temp = 292;
    temp = 293;
    temp = 294;
    temp = 295;
    temp = 296;
    temp = 297;
    temp = 298;
    temp = 299;
    temp = 300;
    temp = 301;
    temp = 302;
    temp = 303;
    temp = 304;
    temp = 305;
    temp = 306;
    temp = 307;
    temp = 308;
    temp = 309;
    temp = 310;
    temp = 311;
    temp = 312;
    temp = 313;
    temp = 314;
    temp = 315;
    temp = 316;
    temp = 317;
    temp = 318;
    temp = 319;
    temp = 320;
    temp = 321;
    temp = 322;
    temp = 323;
    temp = 324;
    temp = 325;
    temp = 326;
    temp = 327;
    temp = 328;
    temp = 329;
    temp = 330;
    temp = 331;
    temp = 332;
    temp = 333;
    temp = 334;
    temp = 335;
    temp = 336;
    temp = 337;
    temp = 338;
    temp = 339;
    temp = 340;
    temp = 341;
    temp = 342;
    temp = 343;
    temp = 344;
    temp = 345;
    temp = 346;
    temp = 347;
    temp = 348;
    temp = 349;
    temp = 350;
    temp = 351;
    temp = 352;
    temp = 353;
    temp = 354;
    temp = 355;
    temp = 356;
    temp = 357;
    temp = 358;
    temp = 359;
    temp = 360;
    temp = 361;
    temp = 362;
    temp = 363;
    temp = 364;
    temp = 365;
    temp = 366;
    temp = 367;
    temp = 368;
    temp = 369;
    temp = 370;
    temp = 371;
    temp = 372;
    temp = 373;
    temp = 374;
    temp = 375;
    temp = 376;
    temp = 377;
    temp = 378;
    temp = 379;
    temp = 380;
    temp = 381;
    temp = 382;
    temp = 383;
    temp = 384;
    temp = 385;
    temp = 386;
    temp = 387;
    temp = 388;
    temp = 389;
    temp = 390;
    temp = 391;
    temp = 392;
    temp = 393;
    temp = 394;
    temp = 395;
    temp = 396;
    temp = 397;
    temp = 398;
    temp = 399;
    temp = 400;
    temp = 401;
    temp = 402;
    temp = 403;
    temp = 404;
    temp = 405;
    temp = 406;
    temp = 407;
    temp = 408;
    temp = 409;
    temp = 410;
    temp = 411;
    temp = 412;
    temp = 413;
    temp = 414;
    temp = 415;
    temp = 416;
    temp = 417;
    temp = 418;
    temp = 419;
    temp = 420;
    temp = 421;
    temp = 422;
    temp = 423;
    temp = 424;
    temp = 425;
    temp = 426;
    temp = 427;
    temp = 428;
    temp = 429;
    temp = 430;
    temp = 431;
    temp = 432;
    temp = 433;
    temp = 434;
    temp = 435;
    temp = 436;
    temp = 437;
    temp = 438;
    temp = 439;
    temp = 440;
    temp = 441;
    temp = 442;
    temp = 443;
    temp = 444;
    temp = 445;
    temp = 446;
    temp = 447;
    temp = 448;
    temp = 449;
    temp = 450;
    temp = 451;
    temp = 452;
    temp = 453;
    temp = 454;
    temp = 455;
    temp = 456;
    temp = 457;
    temp = 458;
    temp = 459;
    temp = 460;
    temp = 461;
    temp = 462;
    temp = 463;
    temp = 464;
    temp = 465;
    temp = 466;
    temp = 467;
    temp = 468;
    temp = 469;
    temp = 470;
    temp = 471;
    temp = 472;
    temp = 473;
    temp = 474;
    temp = 475;
    temp = 476;
    temp = 477;
    temp = 478;
    temp = 479;
    temp = 480;
    temp = 481;
    temp = 482;
    temp = 483;
    temp = 484;
    temp = 485;
    temp = 486;
    temp = 487;
    temp = 488;
    temp = 489;
    temp = 490;
    temp = 491;
    temp = 492;
    temp = 493;
    temp = 494;
    temp = 495;
    temp = 496;
    temp = 497;
    temp = 498;
    temp = 499;
    temp = 500;
    temp = 501;
    temp = 502;
    temp = 503;
    temp = 504;
    temp = 505;
    temp = 506;
    temp = 507;
    temp = 508;
    temp = 509;
    temp = 510;
    temp = 511;
    temp = 512;
    temp = 513;
    temp = 514;
    temp = 515;
    temp = 516;
    temp = 517;
    temp = 518;
    temp = 519;
    temp = 520;
    temp = 521;
    temp = 522;
    temp = 523;
    temp = 524;
    temp = 525;
    temp = 526;
    temp = 527;
    temp = 528;
    temp = 529;
    temp = 530;
    temp = 531;
    temp = 532;
    temp = 533;
    temp = 534;
    temp = 535;
    temp = 536;
    temp = 537;
    temp = 538;
    temp = 539;
    temp = 540;
    temp = 541;
    temp = 542;
    temp = 543;
    temp = 544;
    temp = 545;
    temp = 546;
    temp = 547;
    temp = 548;
    temp = 549;
    temp = 550;
    temp = 551;
    temp = 552;
    temp = 553;
    temp = 554;
    temp = 555;
    temp = 556;
    temp = 557;
    temp = 558;
    temp = 559;
    temp = 560;
    temp = 561;
    temp = 562;
    temp = 563;
    temp = 564;
    temp = 565;
    temp = 566;
    temp = 567;
    temp = 568;
    temp = 569;
    temp = 570;
    temp = 571;
    temp = 572;
    temp = 573;
    temp = 574;
    temp = 575;
    temp = 576;
    temp = 577;
    temp = 578;
    temp = 579;
    temp = 580;
    temp = 581;
    temp = 582;
    temp = 583;
    temp = 584;
    temp = 585;
    temp = 586;
    temp = 587;
    temp = 588;
    temp = 589;
    temp = 590;
    temp = 591;
    temp = 592;
    temp = 593;
    temp = 594;
    temp = 595;
    temp = 596;
    temp = 597;
    temp = 598;
    temp = 599;
    temp = 600;
    temp = 601;
    temp = 602;
    temp = 603;
    temp = 604;
    temp = 605;
    temp = 606;
    temp = 607;
    temp = 608;
    temp = 609;
    temp = 610;
    temp = 611;
    temp = 612;
    temp = 613;
    temp = 614;
    temp = 615;
    temp = 616;
    temp = 617;
    temp = 618;
    temp = 619;
    temp = 620;
    temp = 621;
    temp = 622;
    temp = 623;
    temp = 624;
    temp = 625;
    temp = 626;
    temp = 627;
    temp = 628;
    temp = 629;
    temp = 630;
    temp = 631;
    temp = 632;
    temp = 633;
    temp = 634;
    temp = 635;
    temp = 636;
    temp = 637;
    temp = 638;
    temp = 639;
    temp = 640;
    temp = 641;
    temp = 642;
    temp = 643;
    temp = 644;
    temp = 645;
    temp = 646;
    temp = 647;
    temp = 648;
    temp = 649;
    temp = 650;
    temp = 651;
    temp = 652;
    temp = 653;
    temp = 654;
    temp = 655;
    temp = 656;
    temp = 657;
    temp = 658;
    temp = 659;
    temp = 660;
    temp = 661;
    temp = 662;
    temp = 663;
    temp = 664;
    temp = 665;
    temp = 666;
    temp = 667;
    temp = 668;
    temp = 669;
    temp = 670;
    temp = 671;
    temp = 672;
    temp = 673;
    temp = 674;
    temp = 675;
    temp = 676;
    temp = 677;
    temp = 678;
    temp = 679;
    temp = 680;
    temp = 681;
    temp = 682;
    temp = 683;
    temp = 684;
    temp = 685;
    temp = 686;
    temp = 687;
    temp = 688;
    temp = 689;
    temp = 690;
    temp = 691;
    temp = 692;
    temp = 693;
    temp = 694;
    temp = 695;
    temp = 696;
    temp = 697;
    temp = 698;
    temp = 699;
    temp = 700;
    temp = 701;
    temp = 702;
    temp = 703;
    temp = 704;
    temp = 705;
    temp = 706;
    temp = 707;
    temp = 708;
    temp = 709;
    temp = 710;
    temp = 711;
    temp = 712;
    temp = 713;
    temp = 714;
    temp = 715;
    temp = 716;
    temp = 717;
    temp = 718;
    temp = 719;
    temp = 720;
    temp = 721;
    temp = 722;
    temp = 723;
    temp = 724;
    temp = 725;
    temp = 726;
    temp = 727;
    temp = 728;
    temp = 729;
    temp = 730;
    temp = 731;
    temp = 732;
    temp = 733;
    temp = 734;
    temp = 735;
    temp = 736;
    temp = 737;
    temp = 738;
    temp = 739;
    temp = 740;
    temp = 741;
    temp = 742;
    temp = 743;
    temp = 744;
    temp = 745;
    temp = 746;
    temp = 747;
    temp = 748;
    temp = 749;
    temp = 750;
    temp = 751;
    temp = 752;
    temp = 753;
    temp = 754;
    temp = 755;
    temp = 756;
    temp = 757;
    temp = 758;
    temp = 759;
    temp = 760;
    temp = 761;
    temp = 762;
    temp = 763;
    temp = 764;
    temp = 765;
    temp = 766;
    temp = 767;
    temp = 768;
    temp = 769;
    temp = 770;
    temp = 771;
    temp = 772;
    temp = 773;
    temp = 774;
    temp = 775;
    temp = 776;
    temp = 777;
    temp = 778;
    temp = 779;
    temp = 780;
    temp = 781;
    temp = 782;
    temp = 783;
    temp = 784;
    temp = 785;
    temp = 786;
    temp = 787;
    temp = 788;
    temp = 789;
    temp = 790;
    temp = 791;
    temp = 792;
    temp = 793;
    temp = 794;
    temp = 795;
    temp = 796;
    temp = 797;
    temp = 798;
    temp = 799;
    temp = 800;
    temp = 801;
    temp = 802;
    temp = 803;
    temp = 804;
    temp = 805;
    temp = 806;
    temp = 807;
    temp = 808;
    temp = 809;
    temp = 810;
    temp = 811;
    temp = 812;
    temp = 813;
    temp = 814;
    temp = 815;
    temp = 816;
    temp = 817;
    temp = 818;
    temp = 819;
    temp = 820;
    temp = 821;
    temp = 822;
    temp = 823;
    temp = 824;
    temp = 825;
    temp = 826;
    temp = 827;
    temp = 828;
    temp = 829;
    temp = 830;
    temp = 831;
    temp = 832;
    temp = 833;
    temp = 834;
    temp = 835;
    temp = 836;
    temp = 837;
    temp = 838;
    temp = 839;
    temp = 840;
    temp = 841;
    temp = 842;
    temp = 843;
    temp = 844;
    temp = 845;
    temp = 846;
    temp = 847;
    temp = 848;
    temp = 849;
    temp = 850;
    temp = 851;
    temp = 852;
    temp = 853;
    temp = 854;
    temp = 855;
    temp = 856;
    temp = 857;
    temp = 858;
    temp = 859;
    temp = 860;
    temp = 861;
    temp = 862;
    temp = 863;
    temp = 864;
    temp = 865;
    temp = 866;
    temp = 867;
    temp = 868;
    temp = 869;
    temp = 870;
    temp = 871;
    temp = 872;
    temp = 873;
    temp = 874;
    temp = 875;
    temp = 876;
    temp = 877;
    temp = 878;
    temp = 879;
    temp = 880;
    temp = 881;
    temp = 882;
    temp = 883;
    temp = 884;
    temp = 885;
    temp = 886;
    temp = 887;
    temp = 888;
    temp = 889;
    temp = 890;
    temp = 891;
    temp = 892;
    temp = 893;
    temp = 894;
    temp = 895;
    temp = 896;
    temp = 897;
    temp = 898;
    temp = 899;
    temp = 900;
    temp = 901;
    temp = 902;
    temp = 903;
    temp = 904;
    temp = 905;
    temp = 906;
    temp = 907;
    temp = 908;
    temp = 909;
    temp = 910;
    temp = 911;
    temp = 912;
    temp = 913;
    temp = 914;
    temp = 915;
    temp = 916;
    temp = 917;
    temp = 918;
    temp = 919;
    temp = 920;
    temp = 921;
    temp = 922;
    temp = 923;
    temp = 924;
    temp = 925;
    temp = 926;
    temp = 927;
    temp = 928;
    temp = 929;
    temp = 930;
    temp = 931;
    temp = 932;
    temp = 933;
    temp = 934;
    temp = 935;
    temp = 936;
    temp = 937;
    temp = 938;
    temp = 939;
    temp = 940;
    temp = 941;
    temp = 942;
    temp = 943;
    temp = 944;
    temp = 945;
    temp = 946;
    temp = 947;
    temp = 948;
    temp = 949;
    temp = 950;
    temp = 951;
    temp = 952;
    temp = 953;
    temp = 954;
    temp = 955;
    temp = 956;
    temp = 957;
    temp = 958;
    temp = 959;
    temp = 960;
    temp = 961;
    temp = 962;
    temp = 963;
    temp = 964;
    temp = 965;
    temp = 966;
    temp = 967;
    temp = 968;
    temp = 969;
    temp = 970;
    temp = 971;
    temp = 972;
    temp = 973;
    temp = 974;
    temp = 975;
    temp = 976;
    temp = 977;
    temp = 978;
    temp = 979;
    temp = 980;
    temp = 981;
    temp = 982;
    temp = 983;
    temp = 984;
    temp = 985;
    temp = 986;
    temp = 987;
    temp = 988;
    temp = 989;
    temp = 990;
    temp = 991;
    temp = 992;
    temp = 993;
    temp = 994;
    temp = 995;
    temp = 996;
    temp = 997;
    temp = 998;
    temp = 999;
    temp = 1000;
}

_Thread_local int my_thread_id;
int global_thread_id_counter = 1;

int os_thread_get_curr_id() {
    return my_thread_id;
}

void initialize_thread_id() {
    my_thread_id = global_thread_id_counter++;
}

typedef pthread_mutex_t mutex_t;

// 初始化互斥锁
void mutex_init(mutex_t* mutex) {
    pthread_mutex_init(mutex, NULL);
}

// 进入互斥锁
void mutex_enter(mutex_t* mutex) {
    pthread_mutex_lock(mutex);
}

// 退出互斥锁
void mutex_exit(mutex_t* mutex) {
    pthread_mutex_unlock(mutex);
}


struct rw_lock_t {
    mutex_t mutex; // 互斥锁
    volatile int lock_word;; // 锁的状态，使用原子变量进行原子操作
    int writer_thread; // 当前写入者线程ID
    bool recursive; // 是否允许递归锁定
    const char* last_x_file_name; // 最后一次尝试获取写锁的文件名
    unsigned int last_x_line; // 最后一次尝试获取写锁的行号
};

void rw_lock_set_writer_id_and_recursion_flag(
/*=====================================*/
        struct rw_lock_t*	lock,		/*!< in/out: lock to work on */
        bool		recursive)	/*!< in: true if recursion
					allowed */
{
    pid_t	curr_thread	= os_thread_get_curr_id();
    additional_logic();
    additional_logic();
    additional_logic();
    additional_logic();
    additional_logic();
    additional_logic();
    additional_logic();
    additional_logic();
    additional_logic();
    additional_logic();
    additional_logic();
    additional_logic();
    additional_logic();
    additional_logic();
    additional_logic();
    additional_logic();
    additional_logic();
    additional_logic();
    additional_logic();
    additional_logic();
    mutex_enter(&lock->mutex);
//    printf("1: W writer_thread\n");
    lock->writer_thread = curr_thread;
//    printf("2: W writer_recursive\n");
    lock->recursive = recursive;
    mutex_exit(&lock->mutex);
}


bool rw_lock_lock_word_decr(struct rw_lock_t* lock, int amount, int threshold) {
    bool success = false; // 默认设置为失败

    pthread_mutex_lock(&lock->mutex); // 加锁
    if (lock->lock_word > threshold) {
        lock->lock_word -= amount;
        success = true; // 设置成功状态
    }
    pthread_mutex_unlock(&lock->mutex); // 无论如何都解锁

    return success;
}

bool rw_lock_x_lock_low(
/*===============*/
        struct rw_lock_t*	lock,	/*!< in: pointer to rw-lock */
        int		pass,	/*!< in: pass value; != 0, if the lock will
				be passed to another thread to unlock */
        const char*	file_name,/*!< in: file name where lock requested */
        int		line)	/*!< in: line where requested */
{
    if (rw_lock_lock_word_decr(lock, X_LOCK_DECR, X_LOCK_HALF_DECR)) {

        /* Decrement occurred: we are writer or next-writer. */
        rw_lock_set_writer_id_and_recursion_flag(
                lock, !pass);
    } else {
        int	thread_id = os_thread_get_curr_id();

        if (!pass) {
//            os_rmb;
        }

        /* Decrement failed: An X or SX lock is held by either
        this thread or another. Try to relock. */
        if (lock->recursive == 1) {
            assert(os_thread_eq(lock->writer_thread, thread_id));
        }
        if (!pass
            && lock->recursive
            && os_thread_eq(lock->writer_thread, thread_id)) {
            /* Other s-locks can be allowed. If it is request x
            recursively while holding sx lock, this x lock should
            be along with the latching-order. */

            /* The existing X or SX lock is from this thread */
            if (rw_lock_lock_word_decr(lock, X_LOCK_DECR, 0)) {
                /* There is at least one SX-lock from this
                thread, but no X-lock. */

                /* Wait for any the other S-locks to be
                released. */


            } else {
                /* At least one X lock by this thread already
                exists. Add another. */
                if (lock->lock_word == 0
                    || lock->lock_word == -X_LOCK_HALF_DECR) {
                    lock->lock_word -= X_LOCK_DECR;
                } else {
                    --lock->lock_word;
                }
            }

        } else {
            /* Another thread locked before us */
            return 0;
        }
    }


    lock->last_x_file_name = file_name;
    lock->last_x_line = (unsigned int) line;

    return 1;
}


struct rw_lock_t my_lock;

// 线程A的运行函数
void* thread_a_func(void* arg) {
    initialize_thread_id();
//    printf("Thread A is trying to lock...\n");
    if (rw_lock_x_lock_low(&my_lock, 0, __FILE__, __LINE__)) {
//        printf("Thread A successfully locked.\n");
    } else {
//        printf("Thread A failed to lock.\n");
    }
    // 模拟工作
    //sleep(1);

    // 解锁逻辑（根据需要实现）
    return NULL;
}

// 线程B的运行函数
void* thread_b_func(void* arg) {
    initialize_thread_id();
//    printf("Thread B is trying to lock...\n");
    if (rw_lock_x_lock_low(&my_lock, 0, __FILE__, __LINE__)) {
//        printf("Thread B successfully locked.\n");
    } else {
//        printf("Thread B failed to lock.\n");
    }
    // 解锁逻辑（根据需要实现）
    return NULL;
}

int main() {
    // 初始化锁
    pthread_mutex_init(&my_lock.mutex, NULL);
    my_lock.lock_word = 0x30000000; // 初始化为一个允许A线程锁定的值

    pthread_t thread_a, thread_b;

    // 创建线程A
    if (pthread_create(&thread_a, NULL, thread_a_func, NULL)) {
//        perror("Failed to create thread A");
        return 1;
    }

    // 稍作延时以确保线程A先运行
    //sleep(1);

    // 创建线程B
    if (pthread_create(&thread_b, NULL, thread_b_func, NULL)) {
//        perror("Failed to create thread B");
        return 1;
    }

    // 等待线程结束
    pthread_join(thread_a, NULL);
    pthread_join(thread_b, NULL);

    return 0;
}






