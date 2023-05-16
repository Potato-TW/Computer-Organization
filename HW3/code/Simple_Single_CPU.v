//110550130 BING HUA LIU

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
module Simple_Single_CPU(
        clk_i,
        rst_i
        );
		
// //I/O port
input         clk_i;
input         rst_i;

//Internal Signles
wire [31:0] pcout, add1out, imout, signextendout, add2out, addershiftout, jumpshiftout, readdata1, readdata2, pcin, aluout, filealuout, dmout, writedata, md1, mps1out, mps2out;
wire [4:0] writereg, mwr1out;
wire [3:0] aluctrlout;
wire [2:0] aluop;
wire [1:0] memtoreg, regdst;
wire branch, alusrc, regwrite, zeroout, jump, branchtype, memread, memwrite;

wire jr=(imout[31:26]==6'b000000 && imout[5:0]==6'b001000);


//Greate componentes
ProgramCounter PC(
        .clk_i(clk_i),      
        .rst_i (rst_i),     
        .pc_in_i(pcin) ,   
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
		
Reg_File Registers(
        .clk_i(clk_i),      
	    .rst_i(rst_i) ,     
        .RSaddr_i(imout[25:21]) ,  
        .RTaddr_i(imout[20:16]) ,  
        .RDaddr_i(writereg) ,  
        .RDdata_i(writedata)  , 
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
        .Branch_o(branch),  

        .MemRead_o(memread),
	.MemtoReg_o(memtoreg),
	.Jump_o(jump),
	.MemWrite_o(memwrite)
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

MUX_2to1 #(.size(5)) Mux_Write_Reg_1(
        //regdst should be handled
        .data0_i(imout[20:16]),
        .data1_i(imout[15:11]),
        .select_i(regdst[0]),
        .data_o(mwr1out)
        );

MUX_2to1 #(.size(5)) Mux_Write_Reg_2(
        //0:MWR1  1:31
        //regdst should be handled
        .data0_i(mwr1out),
        .data1_i(5'd31),
        .select_i(regdst[1]),
        .data_o(writereg)
        );

MUX_2to1 #(.size(32)) Mux_ALUSrc(
        .data0_i(readdata2),
        .data1_i(signextendout),
        .select_i(alusrc),
        .data_o(filealuout)
        );	
        
MUX_2to1 #(.size(32)) Mux_PC_Sourc_1(
        .data0_i(add1out),
        .data1_i(add2out),
        .select_i(branch & zeroout),
        .data_o(mps1out)
        );

MUX_2to1 #(.size(32)) Mux_PC_Sourc_2(
        //0:mps1out  1:rs
        .data0_i(mps1out),
        .data1_i(readdata1),
        .select_i(jr),
        .data_o(mps2out)
        );

MUX_2to1 #(.size(32)) Mux_PC_Sourc_3(
        //0:mps2out 1:jump address
        .data0_i(mps2out),
        .data1_i({add1out[31:28], jumpshiftout[27:0]}),
        .select_i(jump),
        .data_o(pcin)
        );
		
ALU ALU(
        .src1_i(readdata1),
        .src2_i(filealuout),
        .ctrl_i(aluctrlout),
        .result_o(aluout),
        .zero_o(zeroout)
        );
	
Data_Memory Data_Memory(
	.clk_i(clk_i),
	.addr_i(aluout),
	.data_i(readdata2),
	.MemRead_i(memread),
	.MemWrite_i(memwrite),
	.data_o(dmout)
	);

MUX_2to1 #(.size(32)) Mux_DM_1(
        //0:aluout 1:dmout
        .data0_i(aluout),
        .data1_i(dmout),
        .select_i(memtoreg[0]),
        .data_o(md1)
        );

MUX_2to1 #(.size(32)) Mux_DM_2(
        .data0_i(md1),
        .data1_i(add1out),
        .select_i(memtoreg[1]),
        .data_o(writedata)
        );
	
Adder Adder2(
        .src1_i(add1out),     
        .src2_i(addershiftout),     
        .sum_o(add2out)      
        );
		
Shift_Left_Two_32 Adder2_Shifter(
        .data_i(signextendout),
        .data_o(addershiftout)
        ); 		
		
Shift_Left_Two_32 Jump_Address(
        .data_i({6'd0,imout[25:0]}),
        .data_o(jumpshiftout)
        ); 	

endmodule
