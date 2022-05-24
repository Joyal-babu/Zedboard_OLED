//Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
//Date        : Tue May 24 10:55:37 2022
//Host        : laptop running 64-bit major release  (build 9200)
//Command     : generate_target design_1_wrapper.bd
//Design      : design_1_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module design_1_wrapper
   (o_sdone_0,
    sys_clock);
  output o_sdone_0;
  input sys_clock;

  wire o_sdone_0;
  wire sys_clock;

  design_1 design_1_i
       (.o_sdone_0(o_sdone_0),
        .sys_clock(sys_clock));
endmodule
