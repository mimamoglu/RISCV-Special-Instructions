//===----------------------------------------------------------------------===//
// Instruction class templates
//===----------------------------------------------------------------------===//

// KAREAL_TOPLA
let hasSideEffects = 0, mayLoad = 0, mayStore = 0 in
def KAREAL_TOPLA : RVInst<(outs GPR:$rd), (ins GPR:$rs1, GPR:$rs2),
	"kareal.topla", "$rd, $rs1, $rs2", [], InstFormatOther>, Sched<[]>
{
	bits<5> rs2;
	bits<5> rs1;
	bits<5> rd;

	let Inst{31-25} = 0b0000000;
	let Inst{24-20} = rs2;
	let Inst{19-15} = rs1;
	let Inst{14-12} = 0b000;
	let Inst{11-7} = rd;

	let Opcode = RISCVOpcode<0b1110111>.Value;
}

// CARP_CIKAR
let hasSideEffects = 0, mayLoad = 0, mayStore = 0 in
def CARP_CIKAR : RVInst<(outs GPR:$rd), (ins GPR:$rs1, GPR:$rs2),
	"carp.cikar", "$rd, $rs1, $rs2", [], InstFormatOther>, Sched<[]>
{
	bits<5> rs2;
	bits<5> rs1;
	bits<5> rd;

	let Inst{31-25} = 0b1000010;
	let Inst{24-20} = rs2;
	let Inst{19-15} = rs1;
	let Inst{14-12} = 0b001;
	let Inst{11-7} = rd;

	let Opcode = RISCVOpcode<0b1110111>.Value;
}

// SIFRELE
let hasSideEffects = 0, mayLoad = 0, mayStore = 0 in
def SIFRELE : RVInst<(outs GPR:$rd), (ins GPR:$rs1, simm12:$imm12),
	"sifrele", "$rd, $rs1, $imm12", [], InstFormatOther>, Sched<[]>
{
	bits<12> imm12;
	bits<5> rs1;
	bits<5> rd;

	let Inst{31-20} = imm12;
	let Inst{19-15} = rs1;
	let Inst{14-12} = 0b100;
	let Inst{11-7} = rd;

	let Opcode = RISCVOpcode<0b1110111>.Value;
}

// TASI
let hasSideEffects = 0, mayLoad = 0, mayStore = 0 in
def TASI : RVInst<(outs GPR:$rd), (ins GPR:$rs1, simm12:$imm12),
	"tasi", "$rd, $rs1, $imm12", [], InstFormatOther>, Sched<[]>
{
	bits<12> imm12;
	bits<5> rs1;
	bits<5> rd;

	let Inst{31-20} = imm12;
	let Inst{19-15} = rs1;
	let Inst{14-12} = 0b101;
	let Inst{11-7} = rd;

	let Opcode = RISCVOpcode<0b1110111>.Value;
}

// IKIKAT_ATLA
let hasSideEffects = 0, mayLoad = 0, mayStore = 0 in
def IKIKAT_ATLA : RVInst<(outs GPR:$rd), (ins simm21_lsb0_jal:$imm20),
	"ikikat.atla", "$rd, $imm20", [], InstFormatOther>, Sched<[]>
{
	bits<21> imm20;
	bits<5> rd;
	
	let imm20{20-1} = imm20{19,9-0,10,18-11};
	let Inst{31-12} = imm20{20-1};
	let Inst{11-7} = rd;

	let Opcode = RISCVOpcode<0b1111111>.Value;
}

// BITSAY
let hasSideEffects = 0, mayLoad = 0, mayStore = 0 in
def BITSAY : RVInst<(outs GPR:$rd), (ins GPR:$rs1, simm12:$s1),
	"bitsay", "$rd, $rs1, $s1", [], InstFormatOther>, Sched<[]>
{
	bits<5> rd;
	bits<5> rs1;
	bits<1> s1;

	let Inst{31} = s1{0};
	let Inst{30-20} = 0b10101010101;
	let Inst{19-15} = rs1;
	let Inst{14-12} = 0b010;
	let Inst{11-7} = rd;
	
	let Opcode = RISCVOpcode<0b1110111>.Value;
}

// SEC_DALLAN
let hasSideEffects = 0, mayLoad = 0, mayStore = 0 in
def SEC_DALLAN : RVInst<(outs), (ins GPR:$rs1, GPR:$rs2, simm13_lsb0:$imm12, simm12:$s2),
	"sec.dallan", "$rs1, $rs2 , $imm12, $s2" , [], InstFormatOther>, Sched<[]>
{
	bits<5> rs1;
	bits<5> rs2;
	bits<13> imm12;
	bits<2> s2;
	
	let Inst{31-30} = s2{1-0};
	let Inst{29-25} = imm12{8-4};
	let Inst{24-20} = rs2;
	let Inst{19-15} = rs1;
	let Inst{14-12} = 0b111;
	let Inst{11-7} = imm12{3-0,9};
	
	let Opcode = RISCVOpcode<0b1111111>.Value;
  	
}
