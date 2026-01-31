`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.09.2025 22:11:38
// Design Name: 
// Module Name: D_flip_flop
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


// D Flip-Flop with async active-low reset
module d_ff_async_reset (
    input  wire clk,     
    input  wire rst_n,   
    input  wire d,       
    output reg  q        
);
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            q <= 1'b0;   
        else
            q <= d;      
    end
endmodule
  


