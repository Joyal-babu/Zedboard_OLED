`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.05.2022 17:12:16
// Design Name: 
// Module Name: spi_data_genr
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


module spi_data_genr(
    input       clock,                                   // global clock from board
    input       reset,                                   // global reset from board
    input       sdone,                                   // done signal for handshake from spi_control module
    (* dont_touch = "true" *) output [7:0]data_out,      // paralle data for spi interface
    output      data_vld                                 // data valid signal for handshaking, kept HIGH for min 300ns for every new data 
    );
     
    wire       sdone_fe;
    
    reg        sdone_d  = 0;
    reg        sdone_d1 = 0;
    reg   [1:0]state    = 0;    
    reg        valid    = 0;
    reg   [4:0]vld_cnt  = 0;
    reg  [19:0]dly_cnt  = 0;
    reg   [7:0]data;
    
    assign data_out = data;
    assign data_vld = valid;
    
    localparam  st0_idle          = 2'd0,
                st1_data_and_vld  = 2'd1,
                st2_wait_for_done = 2'd2,
                st3_delay         = 2'd3;
                              
    always @(posedge clock)
    begin
        if(reset)
        begin
            sdone_d  <= 0;
            sdone_d1 <= 0;
        end
        else
        begin
            sdone_d  <= sdone;
            sdone_d1 <= sdone_d;
        end
    end 
    
    assign sdone_fe = (sdone_d1 & ~sdone_d); 
    
    always @(posedge clock)
    begin
        if(reset)
        begin
            data    <= 8'h8F;
            valid   <= 0;
            vld_cnt <= 0;
            dly_cnt <= 0;
            state   <= st0_idle;
        end
        else
        begin
            case(state)
                st0_idle: begin
                    data    <= data + 4;
                    valid   <= 0;
                    vld_cnt <= 0;
                    dly_cnt <= 0;
                    state   <= st1_data_and_vld;
                end
                
                st1_data_and_vld: begin
                    data    <= data;
                    valid   <= 1;
                    dly_cnt <= 0;
                    if(vld_cnt != 'd29)
                    begin
                        vld_cnt <= vld_cnt + 1'b1;
                        state   <= st1_data_and_vld;
                    end
                    else
                    begin
                        vld_cnt <= 0;
                        state   <= st2_wait_for_done;
                    end
                end
                
                st2_wait_for_done: begin
                    data    <= data;
                    valid   <= 0;
                    vld_cnt <= 0;
                    dly_cnt <= 0;
                    if(sdone_fe)
                        state <= st3_delay;
                    else
                        state <= st2_wait_for_done;
                end
                
                st3_delay: begin
                    data    <= data;
                    valid   <= 0;
                    vld_cnt <= 0;
                    if(dly_cnt != 'd1000000)
                    begin
                        dly_cnt <= dly_cnt + 1;
                        state   <= st3_delay;
                    end
                    else
                    begin
                        dly_cnt <= 0;
                        state   <= st0_idle;
                    end
                end
            endcase
        end
    end 


ila_0 ila_inst1 (
	.clk(clock), // input wire clk


	.probe0(data),        // input wire [7:0]  probe0  
	.probe1(state),       // input wire [1:0]  probe1 
	.probe2(vld_cnt),     // input wire [4:0]  probe2 
	.probe3(dly_cnt),     // input wire [19:0]  probe3 
	.probe4(sdone),       // input wire [0:0]  probe4 
	.probe5(sdone_fe),    // input wire [0:0]  probe5 
	.probe6(valid)        // input wire [0:0]  probe6
);    
    
    
endmodule
