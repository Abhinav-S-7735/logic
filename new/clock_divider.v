`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.09.2025 23:08:16
// Design Name: 
// Module Name: clock_divider
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

// clk_divider.v
// Divides input clock 'clk' by a parameter 'DIVIDER' to generate a slower clock
module clk_divider #(
    parameter integer DIVIDER = 100000000  // default divide by 100 million ? ~1 Hz from 100 MHz
)(
    input  wire clk,       // input clock (100 MHz)
    input  wire rst_n,     // active-low asynchronous reset
    output reg  slow_clk   // output slow clock
);

    // Calculate width needed for counter
    localparam integer W = $clog2(DIVIDER);

    reg [W-1:0] counter;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            counter   <= 0;
            slow_clk  <= 0;
        end else begin
            if (counter == DIVIDER/2 - 1) begin
                counter  <= 0;
                slow_clk <= ~slow_clk;  // toggle output clock
            end else begin
                counter <= counter + 1;
            end
        end
    end

endmodule
