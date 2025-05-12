//Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
//Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2024.1 (lin64) Build 5076996 Wed May 22 18:36:09 MDT 2024
//Date        : Mon May 12 12:36:35 2025
//Host        : edabk running 64-bit CentOS Linux release 7.9.2009 (Core)
//Command     : generate_target ma_wrapper.bd
//Design      : ma_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module ma_wrapper
   (byte_to_trans_i,
    clk,
    ddr4_clk,
    ddr4_rst_n,
    done_o,
    dst_bram_addr_i,
    rst_n,
    src_axi_addr_i,
    start_i);
  input [14:0]byte_to_trans_i;
  input clk;
  input ddr4_clk;
  input ddr4_rst_n;
  output done_o;
  input [5:0]dst_bram_addr_i;
  input rst_n;
  input [35:0]src_axi_addr_i;
  input start_i;

  wire [14:0]byte_to_trans_i;
  wire clk;
  wire ddr4_clk;
  wire ddr4_rst_n;
  wire done_o;
  wire [5:0]dst_bram_addr_i;
  wire rst_n;
  wire [35:0]src_axi_addr_i;
  wire start_i;

  ma ma_i
       (.byte_to_trans_i(byte_to_trans_i),
        .clk(clk),
        .ddr4_clk(ddr4_clk),
        .ddr4_rst_n(ddr4_rst_n),
        .done_o(done_o),
        .dst_bram_addr_i(dst_bram_addr_i),
        .rst_n(rst_n),
        .src_axi_addr_i(src_axi_addr_i),
        .start_i(start_i));
endmodule
