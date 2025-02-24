`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/05/2024 10:01:06 AM
// Design Name: 
// Module Name: clock
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


module clock(
input clk,
input reset, 
input alarm_reset,
input [1:0] btn,
input [1:0] sw,

output wire [0:6] seg0, 
output wire [4:1] select,
output wire [0:6] seg1,
output wire [4:1] select1,
output reg led,
output reg led4_b,
output reg led5_b
);

reg [30:0] count;
reg [30:0] alarm_count;
reg [5:0] secs;
reg [5:0] hrs;
reg [5:0] mins;


reg [5:0] alarm_hrs;
reg [5:0] alarm_mins;


DisplaySegment left(.clk(clk),.hour(hrs),.min(mins),.dig(seg0),.select(select));
DisplaySegment right(.clk(clk),.hour(alarm_hrs),.min(alarm_mins),.dig(seg1),.select(select1));


/***********clock************/
always@(posedge clk)
begin
    if (reset) begin
        secs <= 0;
        mins <= 0;
        hrs <= 0;
        count <= 0;
    end
    else begin
    if (count == 125000000)
    begin
    count <= 0;
    led <= ~led;
        if (secs == 6'd59) begin
            secs <= 0;
            if(mins == 6'd59) begin
                mins <= 0;
                if(hrs == 6'd23) begin
                    hrs <= 0;                  
                end
                else hrs <= hrs + 1;
            end
            else mins <= mins + 1;
        end
        else secs <= secs + 1;
    end
    else count <= count + 1;
    
    if (sw == 2'b01) begin
        if (mins == alarm_mins && hrs == alarm_hrs)
            begin
            led5_b <= 1'b1;            
            led4_b <= 1'b1;
            end
        else
            begin
            led5_b <= 1'b0;
            led4_b <= 1'b0;
            end 
    end
    else if(sw == 2'b10) begin
        hrs <= alarm_hrs;
        mins <= alarm_mins;
    end
    else begin
        led4_b <= 1'b0;
        led5_b <= 1'b0;
    end
    end
end
/*************alarm_clock*****************/
always @(posedge clk)
begin
    if(alarm_reset) begin
        alarm_mins <= 0;
        alarm_hrs <= 0;
    end
    else begin
        case(btn)
        2'b10:
        begin
            alarm_count <= alarm_count + 1;
            if (alarm_count == 62500000) begin
                if (alarm_hrs == 6'd23) alarm_hrs <= 6'd0; 
                else alarm_hrs <= alarm_hrs + 1;
                alarm_count <= 0;
            end
        end
        2'b01:
        begin
            alarm_count <= alarm_count + 1;
            if (alarm_count == 62500000)
            begin
                if (alarm_mins == 6'd50) begin
                    alarm_mins <= 0;
                    alarm_hrs <= alarm_hrs + 1;
                end
                else alarm_mins <= alarm_mins + 6'd10;
                alarm_count <= 0;
            end
        end
        default: alarm_count <= 0;
        endcase
    end
end
endmodule
