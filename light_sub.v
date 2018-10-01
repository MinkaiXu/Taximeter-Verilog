`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:42:33 04/16/2017 
// Design Name: 
// Module Name:    light_sub 
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
module light_sub(
    input [1:0] light,
    output reg[3:0] convLight
    );
	 
	 always@(*)
		case(light)
		0:convLight = 4'b0001;
		1:convLight = 4'b0010;
		2:convLight = 4'b0100;
		3:convLight = 4'b1101;
		default: convLight = 4'b0000;
		endcase
		
endmodule
