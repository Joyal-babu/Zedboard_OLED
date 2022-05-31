`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:JOYAL 
// 
// Create Date: 26.05.2022 12:45:43
// Design Name: 
// Module Name: spi_control_top
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


module spi_control_top(
    input  clock,                             // global clock
    input  reset,                             // global reset
   // output o_sclock,
    output o_sdone
    );
    
    wire [7:0]data;
    wire      valid;
    wire      done;
    wire      sclock;
    wire      sdata;
    
    assign o_sdone = ~done;
    
    spi_control spi_control_inst1
    (      
         .clock(clock),   
         .reset(reset),   
         .data_in(data), 
         .data_vld(valid),
         .o_sclock(sclock),
         .o_sdata(sdata), 
         .o_sdone(done)  
         );                   
    
    spi_data_genr   spi_data_genr_inst1
    (     
        .clock(clock),    
        .reset(reset),    
        .sdone(done),    
        .data_out(data), 
        .data_vld(valid)  
        );                    
    
endmodule
