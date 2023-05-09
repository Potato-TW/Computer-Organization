// 110550130 劉秉驊

//Subject:     CO project 2 - ALU Controller
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
module ALU_Ctrl(
          funct_i,
          ALUOp_i,
          ALUCtrl_o
          );
          
//I/O ports 
input      [6-1:0] funct_i;
input      [3-1:0] ALUOp_i;

output     [4-1:0] ALUCtrl_o;    
     
//Internal Signals
reg        [4-1:0] ALUCtrl_o;

always@(*) begin
    ALUCtrl_o <= 4'bxxxx;
    case (ALUOp_i)
        // addi    
        3'b000:  ALUCtrl_o <= 4'b0010; 
        // beq              
        3'b001:  ALUCtrl_o <= 4'b0110;
        // slti               
        3'b101:  ALUCtrl_o <= 4'b0111;   
        // r
        3'b110:
            case (funct_i)
                // add 0010
                6'b100000: ALUCtrl_o <= 4'b0010; 
                // sub 0110  
                6'b100010: ALUCtrl_o <= 4'b0110;    
                // and 0000
                6'b100100: ALUCtrl_o <= 4'b0000;   
                // or  0001
                6'b100101: ALUCtrl_o <= 4'b0001;                     
                // slt 0111
                6'b101010: ALUCtrl_o <= 4'b0111;    
            endcase           
    endcase
end   

endmodule      