`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/05/2024 10:00:08 AM
// Design Name: 
// Module Name: segment
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module segment(
input [3:0] number,
output reg [0:6] segments);

always@*
    case(number)
    4'd0: segments = 7'b0000001;
    4'd1: segments = 7'b1001111;
    4'd2: segments = 7'b0010010;
    4'd3: segments = 7'b0000110;
    4'd4: segments = 7'b1001100;
    4'd5: segments = 7'b0100100;
    4'd6: segments = 7'b0100000;
    4'd7: segments = 7'b0001111;
    4'd8: segments = 7'b0000000;
    4'd9: segments = 7'b0000100;     
    endcase
endmodule
