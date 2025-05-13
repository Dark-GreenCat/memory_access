//Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
//Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2024.1 (lin64) Build 5076996 Wed May 22 18:36:09 MDT 2024
//Date        : Mon May 12 23:52:10 2025
//Host        : edabk running 64-bit CentOS Linux release 7.9.2009 (Core)
//Command     : generate_target ma_wrapper.bd
//Design      : ma_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module ma_wrapper
   (clk,
    ddr4_clk,
    ddr4_rst_n,
    mrf_0_byte_to_trans_i,
    mrf_0_done_o,
    mrf_0_dst_bram_addr_i,
    mrf_0_src_axi_addr_i,
    mrf_0_start_i,
    rst_n,
    vrf_full_o,
    vrf_ld_byte_to_trans_i,
    vrf_ld_done_0,
    vrf_ld_dst_bram_addr_i,
    vrf_ld_src_axi_addr_i,
    vrf_ld_start_i);
  input clk;
  input ddr4_clk;
  input ddr4_rst_n;
  input [14:0]mrf_0_byte_to_trans_i;
  output mrf_0_done_o;
  input [5:0]mrf_0_dst_bram_addr_i;
  input [35:0]mrf_0_src_axi_addr_i;
  input mrf_0_start_i;
  input rst_n;
  output vrf_full_o;
  input [14:0]vrf_ld_byte_to_trans_i;
  output vrf_ld_done_0;
  input [9:0]vrf_ld_dst_bram_addr_i;
  input [35:0]vrf_ld_src_axi_addr_i;
  input vrf_ld_start_i;

  wire clk;
  wire ddr4_clk;
  wire ddr4_rst_n;
  wire [14:0]mrf_0_byte_to_trans_i;
  wire mrf_0_done_o;
  wire [5:0]mrf_0_dst_bram_addr_i;
  wire [35:0]mrf_0_src_axi_addr_i;
  wire mrf_0_start_i;
  wire rst_n;
  wire vrf_full_o;
  wire [14:0]vrf_ld_byte_to_trans_i;
  wire vrf_ld_done_0;
  wire [9:0]vrf_ld_dst_bram_addr_i;
  wire [35:0]vrf_ld_src_axi_addr_i;
  wire vrf_ld_start_i;

  ma ma_i
       (.clk(clk),
        .ddr4_clk(ddr4_clk),
        .ddr4_rst_n(ddr4_rst_n),
        .mrf_0_byte_to_trans_i(mrf_0_byte_to_trans_i),
        .mrf_0_done_o(mrf_0_done_o),
        .mrf_0_dst_bram_addr_i(mrf_0_dst_bram_addr_i),
        .mrf_0_src_axi_addr_i(mrf_0_src_axi_addr_i),
        .mrf_0_start_i(mrf_0_start_i),
        .rst_n(rst_n),
        .vrf_full_o(vrf_full_o),
        .vrf_ld_byte_to_trans_i(vrf_ld_byte_to_trans_i),
        .vrf_ld_done_0(vrf_ld_done_0),
        .vrf_ld_dst_bram_addr_i(vrf_ld_dst_bram_addr_i),
        .vrf_ld_src_axi_addr_i(vrf_ld_src_axi_addr_i),
        .vrf_ld_start_i(vrf_ld_start_i));
endmodule
