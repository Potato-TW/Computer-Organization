// 110550130 劉秉驊

//Subject:     CO project 2 - Simple Single CPU
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:      
//----------------------------------------------
//Date:        
//----------------------------------------------
//Description: 
//--------------------------------------------------------------------------------
`timescale 1ns/1ps
module Simple_Single_CPU(
        clk_i,
		rst_i
		);
		
//I/O port
input         clk_i;
input         rst_i;

//Internal Signles
wire [31:0] pcout, add1out, imout, signextendout, add2out, shiftout, readdata1, readdata2, add2pcout, aluout, filealuout;
wire [4:0] writereg1;
wire [3:0] aluctrlout;
wire [2:0] aluop;
wire branch, regdst, alusrc, regwrite, zeroout;

//Greate componentes
ProgramCounter PC(
        .clk_i(clk_i),      
	    .rst_i (rst_i),     
	    .pc_in_i(add2pcout) ,   
	    .pc_out_o(pcout) 
	    );
	
Adder Adder1(
        .src1_i(32'd4),     
	    .src2_i(pcout),     
	    .sum_o(add1out)    
	    );
	
Instr_Memory IM(
        .pc_addr_i(pcout),  
	    .instr_o(imout)    
	    );

MUX_2to1 #(.size(5)) Mux_Write_Reg(
        .data0_i(imout[20:16]),
        .data1_i(imout[15:11]),
        .select_i(regdst),
        .data_o(writereg1)
        );	
		
Reg_File RF(
        .clk_i(clk_i),      
	    .rst_i(rst_i) ,     
        .RSaddr_i(imout[25:21]) ,  
        .RTaddr_i(imout[20:16]) ,  
        .RDaddr_i(writereg1) ,  
        .RDdata_i(aluout)  , 
        .RegWrite_i(regwrite),
        .RSdata_o(readdata1) ,  
        .RTdata_o(readdata2)   
        );
	
Decoder Decoder(
        .instr_op_i(imout[31:26]), 
	    .RegWrite_o(regwrite), 
	    .ALU_op_o(aluop),   
	    .ALUSrc_o(alusrc),   
	    .RegDst_o(regdst),   
		.Branch_o(branch)   
	    );

ALU_Ctrl AC(
        .funct_i(imout[5:0]),   
        .ALUOp_i(aluop),   
        .ALUCtrl_o(aluctrlout) 
        );
	
Sign_Extend SE(
        .data_i(imout[15:0]),
        .data_o(signextendout)
        );

// regfile and alu
MUX_2to1 #(.size(32)) Mux_ALUSrc(
        .data0_i(readdata2),
        .data1_i(signextendout),
        .select_i(alusrc),
        .data_o(filealuout)
        );	
		
ALU ALU(
        .src1_i(readdata1),
	    .src2_i(filealuout),
	    .ctrl_i(aluctrlout),
	    .result_o(aluout),
		.zero_o(zeroout)
	    );
		
Adder Adder2(
        .src1_i(add1out),     
	    .src2_i(shiftout),     
	    .sum_o(add2out)      
	    );
		
Shift_Left_Two_32 Shifter(
        .data_i(signextendout),
        .data_o(shiftout)
        ); 		
		
MUX_2to1 #(.size(32)) Mux_PC_Source(
        .data0_i(add1out),
        .data1_i(add2out),
        .select_i(branch & zeroout),
        .data_o(add2pcout)
        );	

endmodule
		  


