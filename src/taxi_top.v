`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:41:33 04/16/2017 
// Design Name: 
// Module Name:    taxi_top 
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
module taxi_top(
	input [1:0] light,
	input restart,
	input endcar,
	input park,
	input showaltogether,
	input clk,
	input showdistance,
	input restartall,
	output [6:0] a_to_g,
	output [3:0] enable,
	output point
    );
	reg [19:0]onedrive = 'h00000;
	reg [19:0]altogether;
	reg [19:0]renewall;
	reg [15:0]distance;
	reg [28:0]clk_cnt;
	reg [3:0]park_cnt;
	wire [3:0]convlight;
	wire [15:0]snum;
	wire [3:0]fnum;

	
	always @(posedge clk)
	begin
	if (clk_cnt[28:0] == 5000000)
		clk_cnt = 0;
	else
		clk_cnt = clk_cnt + 1;
	end
	
	always @(posedge clk)
	begin
	if (clk_cnt[28:0] == 4999999)
		if (park_cnt < 10)
			park_cnt = park_cnt + 1;
		else 
			park_cnt = 'b0000;
	end
	
	//距离
	always @(posedge clk)
	begin
	if (restart || restartall)
		distance[15:0] = 0;
	else if (clk_cnt[28:0] == 4999999 && !park && !endcar)
		begin
		if (distance[3:0] < 9)
			distance[3:0] = distance[3:0] + 1;
		else 
			begin
			distance[3:0] = distance[3:0] - 9;
			if (distance[7:4] < 9)
				distance[7:4] = distance[7:4] + 1;
			else 
				begin
				distance[7:4] = distance[7:4] - 9;
				if (distance[11:8] < 9)
					distance[11:8] = distance[11:8]+1;
				else
					begin
					distance[11:8] =  distance[11:8] - 9;
					if (distance[15:12] < 9)
						distance[15:12] = distance[15:12]+1;
					else
						distance[15:0] = 'h9999;
					end
				end
			end
		end
	end
			


	//单次		
	always @(posedge clk)
	begin
	if (restart || restartall)
		begin
		if(light == 3)
			onedrive[19:0] = 20'b0000_0000_0100_1000_0000;
		else
			onedrive[19:0] = 20'b0000_0000_0100_1110_0000;
		end
	else if (clk_cnt[28:0] == 4999999 && !endcar)
		begin
		if(light == 3)
			begin
			if (park && park_cnt[3:0] == 0)
				begin
				onedrive[4:0] = onedrive[4:0] + 5;
				end		
			else if (distance[15:0] > 'h0100 && distance[3:0] == 1)
				begin
				onedrive[9:5] = onedrive[9:5] + 4;
				end	
			else if (distance[15:0] > 'h0030 && distance[3:0] == 1)
				begin	
				onedrive[9:5] = onedrive[9:5] + 3;
				end
			end
		else if(light !=3)
		begin
			if (park && park_cnt[3:0] == 0)
				begin
				onedrive[4:0] = onedrive[4:0] + 5;
				end		
			else if (distance[15:0] > 'h0100 && distance[3:0] == 1)
				begin
				onedrive[9:5] = onedrive[9:5] + 5;
				end	
			else if (distance[15:0] > 'h0030 && distance[3:0] == 1)
				begin	
				onedrive[9:5] = onedrive[9:5] + 4;
				end
			end
		end
	if (onedrive[4:0] > 9)
				begin
				onedrive[4:0] = onedrive[4:0] - 10;
				onedrive[9:5] = onedrive[9:5] + 1;
				if (onedrive[9:5] > 9)
					begin
					onedrive[9:5] = onedrive[9:5] - 10;
					onedrive[14:10] = onedrive[14:10] + 1;
					if (onedrive[14:10] > 9)
						begin
						onedrive[14:10] = onedrive[14:10] - 10;
						onedrive[19:15] = onedrive[19:15] + 1;
						if (onedrive[19:15] > 9)
							onedrive[19:0] = 'h99999;
						end
					end
				end
		else if (onedrive[9:5] > 9)
				begin
				onedrive[9:5] = onedrive[9:5] - 10;
				onedrive[14:10] = onedrive[14:10] + 1;
				if (onedrive[14:10] > 9)
					begin
					onedrive[14:10] = onedrive[14:10] - 10;
					onedrive[19:15] = onedrive[19:15] + 1;
					if (onedrive[19:15] > 9)
						onedrive[19:0] = 'h99999;
					end
				end
	end



	//总长
	always @(posedge clk)
	begin
	if (restartall && restart)
		begin
		altogether[19:0] = 20'b0000_0000_0000_0000_0000;
		renewall[19:0] = 20'b0000_0000_0000_0000_0000;
		end
	else if (endcar && !restart)
		renewall[19:0] = altogether[19:0];
	else if (restart)
		begin
		if(light == 3)
			begin
			altogether[6:0] = renewall[6:0];
			altogether[9:7] = renewall[9:7] + 1;
			altogether[14:10] = renewall[14:10] + 1;
			altogether[19:15] = renewall[19:15];
			end
		else if(light!= 3)
			begin
			altogether[4:0] = renewall[4:0];
			altogether[7:5] = renewall[7:5] + 3'b111;
			altogether[9:8] = renewall[9:8];
			altogether[19:10] = renewall[19:10] + 1;
			end
		end
	else if (clk_cnt[28:0] == 4999999 && !endcar)
		begin
			if(light == 3)
				begin
				if (park && park_cnt[3:0] == 0)
					begin
					altogether[4:0] = altogether[4:0] + 5;
					end		
				else if (distance[15:0] > 'h0100 && distance[3:0] == 1)
					begin
					altogether[9:5] = altogether[9:5] + 4;
					end	
				else if (distance[15:0] > 'h0030 && distance[3:0] == 1)
					begin	
					altogether[9:5] = altogether[9:5] + 3;
					end
				end
			else if(light != 3)
				begin
				if (park && park_cnt[3:0] == 0)
					begin
					altogether[4:0] = altogether[4:0] + 5;
					end		
				else if (distance[15:0] > 'h0100 && distance[3:0] == 1)
					begin
					altogether[9:5] = altogether[9:5] + 5;
					end	
				else if (distance[15:0] > 'h0030 && distance[3:0] == 1)
					begin	
					altogether[9:5] = altogether[9:5] + 4;
					end
				end				
		end
	if (altogether[4:0] > 9)
				begin
				altogether[4:0] = altogether[4:0] - 10;
				altogether[9:5] = altogether[9:5] + 1;
				if (altogether[9:5] > 9)
					begin
					altogether[9:5] = altogether[9:5] - 10;
					altogether[14:10] = altogether[14:10] + 1;
					if (altogether[14:10] > 9)
						begin
						altogether[14:10] = altogether[14:10] - 10;
						altogether[19:15] = altogether[19:15] + 1;
						if (altogether[19:15] > 9)
							altogether[19:0] = 'h99999;
						end
					end
				end		
		else if (altogether[9:5] > 9)
				begin
				altogether[9:5] = altogether[9:5] - 10;
				altogether[14:10] = altogether[14:10] + 1;
				if (altogether[14:10] > 9)
					begin
					altogether[14:10] = altogether[14:10] - 10;
					altogether[19:15] = altogether[19:15] + 1;
					if (altogether[19:15] > 9)
						altogether[19:0] = 'h99999;
					end
				end
	end
	
	
	
	
				
   choose_show_sub D(.distance(distance),.altogether(renewall),.showdistance(showdistance),
	.showaltogether(showaltogether),.onedrive(onedrive),.snum(snum));	
	
	light_sub A(.light(light),.convLight(convlight));
	
	findFnum_sub B(.clk_copy(clk_cnt[16:11]),.snum(snum),.fnum(fnum),.an(enable),.lighttag(convlight),.point(point));
	
	seg7ment_sub C(.num(fnum),.a_to_g(a_to_g));
	
	
	

endmodule
