//110550130 BING HUA LIU

//Subject:     CO project 2 - Decoder
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:      Luke
//----------------------------------------------
//Date:        2010/8/16
//----------------------------------------------
//Description: 
//--------------------------------------------------------------------------------

module Decoder(
    instr_op_i,
	RegWrite_o,
	ALU_op_o,
	ALUSrc_o,
	RegDst_o,
	Branch_o,

	MemRead_o,
	MemtoReg_o,
	Jump_o,
	MemWrite_o
	);
     
//I/O ports
input  [6-1:0] instr_op_i;

output         RegWrite_o;
output [3-1:0] ALU_op_o;
output         ALUSrc_o;
output   [1:0]        RegDst_o;
output         Branch_o;

output			MemRead_o;
output		[1:0]	MemtoReg_o;
output			Jump_o;
output			MemWrite_o;
 
//Internal Signals
reg    [3-1:0] ALU_op_o;
reg            ALUSrc_o;
reg            RegWrite_o;
reg   [1:0]    RegDst_o;
reg            Branch_o;

reg			MemRead_o;
reg	[1:0]	MemtoReg_o;
reg			Jump_o;
reg			MemWrite_o;
//Parameter

// MemRead_o, MemtoReg_o, Jump_o, MemWrite_o
//Main function
always@(instr_op_i) begin
	{RegWrite_o, ALU_op_o, ALUSrc_o, RegDst_o, Branch_o, MemRead_o, MemtoReg_o, Jump_o, MemWrite_o} <= 13'bxxxxxxxxxxxxx;
    case(instr_op_i)
        // r
        6'b000000:
            {RegWrite_o, ALU_op_o, ALUSrc_o, RegDst_o, Branch_o, MemRead_o, MemtoReg_o, Jump_o, MemWrite_o} <= 13'b1110001000000;
        // addi
        6'b001000:
            {RegWrite_o, ALU_op_o, ALUSrc_o, RegDst_o, Branch_o, MemRead_o, MemtoReg_o, Jump_o, MemWrite_o} <= 13'b1000100000000;
        // beq  
        6'b000100:
            {RegWrite_o, ALU_op_o, ALUSrc_o, RegDst_o, Branch_o, MemRead_o, MemtoReg_o, Jump_o, MemWrite_o} <= 13'b00010xx10xx00;
        // slti

		// regdst memtoreg

        6'b001010:
            {RegWrite_o, ALU_op_o, ALUSrc_o, RegDst_o, Branch_o, MemRead_o, MemtoReg_o, Jump_o, MemWrite_o} <= 13'b1101100000000;
		// j
		6'b000010:
			{RegWrite_o, ALU_op_o, ALUSrc_o, RegDst_o, Branch_o, MemRead_o, MemtoReg_o, Jump_o, MemWrite_o} <= 13'b0xxxxxxx0xx10;
		// jal
		6'b000011:
			{RegWrite_o, ALU_op_o, ALUSrc_o, RegDst_o, Branch_o, MemRead_o, MemtoReg_o, Jump_o, MemWrite_o} <= 13'b1xxxx10x01010;
		// lw mr=1
		6'b100011:
			{RegWrite_o, ALU_op_o, ALUSrc_o, RegDst_o, Branch_o, MemRead_o, MemtoReg_o, Jump_o, MemWrite_o} <= 13'b1000100010100;
		// sw
		6'b101011:
			{RegWrite_o, ALU_op_o, ALUSrc_o, RegDst_o, Branch_o, MemRead_o, MemtoReg_o, Jump_o, MemWrite_o} <= 13'b00001xx00xx01;

    endcase
end

endmodule