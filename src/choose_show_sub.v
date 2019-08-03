`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:09:55 04/16/2017 
// Design Name: 
// Module Name:    choose_show_sub 
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
module choose_show_sub(
    input [15:0] distance,
    input [19:0] altogether,
    input [19:0] onedrive,
    output reg[15:0] snum,
	 input showaltogether,
	 input showdistance
    );
	 
	 always@(*)
	 begin
	 if (showdistance)
		snum[15:0] = distance[15:0];
	 else if (showaltogether)
		begin
		snum[3:0] = altogether[3:0];
		snum[7:4] = altogether[8:5];
		snum[11:8] = altogether[13:10];
		snum[15:12] = altogether[18:15];
		end
	 else 
		begin
	   snum[3:0] = onedrive[3:0];
		snum[7:4] = onedrive[8:5];
		snum[11:8] = onedrive[13:10];
		snum[15:12] = onedrive[18:15];
		end
	 end
	 

endmodule
