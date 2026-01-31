`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.09.2025 22:12:07
// Design Name: 
// Module Name: password_checker
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





// Top module: 3-bit password checker
module password_checker (
    input  wire       clk,
    input  wire       rst_n,
    input  wire [2:0] pwd_in,     // 3-bit input
    output wire [2:0] pwd_out,    // Stored password
    output wire       match       // High when password = 101
);

wire slow_clk;

clk_divider #(.DIVIDER(100_000_000)) u_div (
    .clk(clk),
    .rst_n(rst_n),
    .slow_clk(slow_clk)
);


    // Instantiate 3 D flip-flops (shared clk & reset)
    d_ff_async_reset dff0 (.clk(clk), .rst_n(rst_n), .d(pwd_in[0]), .q(pwd_out[0]));
    d_ff_async_reset dff1 (.clk(clk), .rst_n(rst_n), .d(pwd_in[1]), .q(pwd_out[1]));
    d_ff_async_reset dff2 (.clk(clk), .rst_n(rst_n), .d(pwd_in[2]), .q(pwd_out[2]));

    // NOT gate for the middle bit
    wire not_bit1 = ~pwd_out[1];

    // 3-input AND gate: pwd_out[2] & ~pwd_out[1] & pwd_out[0]
    assign match = pwd_out[2] & not_bit1 & pwd_out[0];

endmodule
