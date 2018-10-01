`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:27:17 04/16/2017 
// Design Name: 
// Module Name:    findfnum_sub 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module findFnum_sub(
	input [5:0]clk_copy,
	input [3:0]lighttag,
	input [15:0]snum,
	output reg point,
	output reg[3:0]an,
	output reg[3:0]fnum
    );
	 reg[5:0]enable;
	always @(*)
	 begin
	 enable[5:0] = clk_copy[5:0];          
	 if (enable[5:0] < 16 && enable[3:0] <= lighttag[3:0])
	  begin
		an[3:0] = 4'b0111;
		fnum[3:0] = snum[3:0];
		point = 1;
	  end
    else if (enable[5:0] < 32 && enable[3:0] <= lighttag[3:0])
	  begin
		an[3:0] = 4'b1011;
		fnum[3:0] = snum[7:4];
		point = 0;
	  end
	 else if (enable[5:0] < 48 && enable[3:0] <= lighttag[3:0])
	  begin
		an[3:0] = 4'b1101;
		fnum[3:0] = snum[11:8];
		point = 1;
	  end
	 else if (enable[5:0] <= 63 && enable[3:0] <= lighttag[3:0])
	  begin
		an[3:0] = 4'b1110;
		fnum[3:0] = snum[15:12];
		point = 1;
	  end
	 else 
	  begin
	   fnum[3:0] = snum[15:12];
	   an[3:0] = 4'b1111;
		point = 1;
	  end
	 end 

endmodule
