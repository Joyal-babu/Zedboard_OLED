`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:JOYAL 
// 
// Create Date: 25.05.2022 17:26:53
// Design Name: 
// Module Name: spi_data_genr_tb
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


module spi_data_genr_tb;

    reg         clock;   
    reg         reset;   
    reg         sdone;   
    wire   [7:0]data_out;
    wire        data_vld;
    
    spi_data_genr tb1 ( .clock(clock), .reset(reset), .sdone(sdone), .data_out(data_out), .data_vld(data_vld) ); 

    always #5  clock = ~clock;
    
    initial
    begin
               clock = 1'b0;
               reset = 1'b1;
               sdone = 1'b0;
        #500   reset = 1'b0;
        #21000 sdone = 1'b1;
        #100   sdone = 1'b0;
        #21000 sdone = 1'b1;
        #100   sdone = 1'b0; 
        #21000 sdone = 1'b1;
        #100   sdone = 1'b0;
    end






endmodule
