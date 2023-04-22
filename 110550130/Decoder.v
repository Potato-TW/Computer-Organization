// 110550130 劉秉驊

//Subject:     CO project 2 - Decoder
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:      Luke
//----------------------------------------------
//Date:        
//----------------------------------------------
//Description: 
//--------------------------------------------------------------------------------
`timescale 1ns/1ps
module Decoder(
    instr_op_i,
	RegWrite_o,
	ALU_op_o,
	ALUSrc_o,
	RegDst_o,
	Branch_o
	);
     
//I/O ports
input  [6-1:0] instr_op_i;

output          RegWrite_o;
output  [3-1:0] ALU_op_o;
output          ALUSrc_o;
output          RegDst_o;
output          Branch_o;
 
//Internal Signals
reg    [3-1:0] ALU_op_o;
reg            ALUSrc_o;
reg            RegWrite_o;
reg            RegDst_o;
reg            Branch_o;

//Parameter

//Main function
always@(*) begin
    case(instr_op_i)
        // r
        6'b000000:
            {RegWrite_o, ALU_op_o, ALUSrc_o, RegDst_o, Branch_o} <= 7'b1110010;
        // addi
        6'b001000:
            {RegWrite_o, ALU_op_o, ALUSrc_o, RegDst_o, Branch_o} <= 7'b1000100;
        // beq  
        6'b000100:
            {RegWrite_o, ALU_op_o, ALUSrc_o, RegDst_o, Branch_o} <= 7'b00010x1;
        // slti
        6'b001010:
            {RegWrite_o, ALU_op_o, ALUSrc_o, RegDst_o, Branch_o} <= 7'b1101100;
    endcase
end

endmodule





                    
                    