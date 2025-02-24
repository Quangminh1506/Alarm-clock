`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/06/2023 10:32:54 AM
// Design Name: 
// Module Name: DisplaySegment
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


module DisplaySegment(
input clk,
input [5:0]hour,[5:0]min,
output reg [0:6]dig,
output reg [4:1]select
);
reg [13:0]counter;

wire [0:6]dig1,dig2,dig3,dig4;

function [3:0] mod_10;
input [5:0] number;
begin
mod_10 = (number >=50) ? 5 : ((number >= 40)? 4 :((number >= 30)? 3 :((number >= 20)? 2 :((number >= 10)? 1 :0))));
end
endfunction
 
segment min0(.number(min - mod_10(min)*10),.segments(dig1));
segment min1(.number(mod_10(min)),.segments(dig2));
segment hrs0(.number(hour - mod_10(hour)*10),.segments(dig3));
segment hrs1(.number(mod_10(hour)),.segments(dig4));

always@ (posedge clk)
begin
    counter <= counter + 1;
end

always@ (*)
begin
    case(counter[13:12])
    2'b00: 
    begin
        dig = dig1;
        select = 4'b0001;
    end
    2'b01: 
    begin
        dig = dig2;
        select = 4'b0010;
    end
    2'b10: 
    begin
        dig = dig3;
        select = 4'b0100;
    end
    2'b11: 
    begin
        dig = dig4;
        select = 4'b1000;
    end        
    endcase
end
endmodule
