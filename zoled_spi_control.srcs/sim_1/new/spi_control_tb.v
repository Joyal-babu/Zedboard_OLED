`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:JOYAL 
// 
// Create Date: 25.05.2022 10:13:28
// Design Name: 
// Module Name: spi_control_tb
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


module spi_control_tb;

    reg  clock;         
    reg  reset;         
    reg  [7:0]data_in; 
    reg  data_vld; 
    wire o_sclock;      
    wire o_sdata;      
    wire o_sdone; 
    
    spi_control tb1 (.clock(clock), .reset(reset), .data_in(data_in), .data_vld(data_vld), .o_sclock(o_sclock), .o_sdata(o_sdata), .o_sdone(o_sdone));     

    always #5 clock <= ~clock;
    
    initial
    begin 
              clock      <= 1'b0;
              reset      <= 1'b1;
              data_in    <= 8'h65;
              data_vld   <= 1'b0;
        #500  reset      <= 1'b0;
        #480  data_vld   <= 1'b1;
        #300  data_vld   <= 1'b0;
        #1000 data_in    <= 8'hD2;
              data_vld   <= 1'b1;
        #300  data_vld   <= 1'b0;        
    end

endmodule
