//Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
//Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2024.1 (lin64) Build 5076996 Wed May 22 18:36:09 MDT 2024
//Date        : Tue May 13 03:07:36 2025
//Host        : edabk running 64-bit CentOS Linux release 7.9.2009 (Core)
//Command     : generate_target ma_ddr4fake_wrapper.bd
//Design      : ma_ddr4fake_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module ma_ddr4fake_wrapper
   (c0_ddr4_ui_clk,
    c0_ddr4_ui_clk_sync_rst,
    clk,
    mrf0_ld_byte_to_trans_i,
    mrf0_ld_done_o,
    mrf0_ld_dst_bram_addr_i,
    mrf0_ld_src_axi_addr_i,
    mrf0_ld_start_i,
    rst_n,
    vrf_ld_byte_to_trans_i,
    vrf_ld_dst_bram_addr_i,
    vrf_ld_full_o,
    vrf_ld_src_axi_addr_i,
    vrf_ld_start_i);
  input c0_ddr4_ui_clk;
  input c0_ddr4_ui_clk_sync_rst;
  input clk;
  input [14:0]mrf0_ld_byte_to_trans_i;
  output mrf0_ld_done_o;
  input [5:0]mrf0_ld_dst_bram_addr_i;
  input [35:0]mrf0_ld_src_axi_addr_i;
  input mrf0_ld_start_i;
  input rst_n;
  input [14:0]vrf_ld_byte_to_trans_i;
  input [9:0]vrf_ld_dst_bram_addr_i;
  output vrf_ld_full_o;
  input [35:0]vrf_ld_src_axi_addr_i;
  input vrf_ld_start_i;

  wire c0_ddr4_ui_clk;
  wire c0_ddr4_ui_clk_sync_rst;
  wire clk;
  wire [14:0]mrf0_ld_byte_to_trans_i;
  wire mrf0_ld_done_o;
  wire [5:0]mrf0_ld_dst_bram_addr_i;
  wire [35:0]mrf0_ld_src_axi_addr_i;
  wire mrf0_ld_start_i;
  wire rst_n;
  wire [14:0]vrf_ld_byte_to_trans_i;
  wire [9:0]vrf_ld_dst_bram_addr_i;
  wire vrf_ld_full_o;
  wire [35:0]vrf_ld_src_axi_addr_i;
  wire vrf_ld_start_i;

  ma_ddr4fake ma_ddr4fake_i
       (.c0_ddr4_ui_clk(c0_ddr4_ui_clk),
        .c0_ddr4_ui_clk_sync_rst(c0_ddr4_ui_clk_sync_rst),
        .clk(clk),
        .mrf0_ld_byte_to_trans_i(mrf0_ld_byte_to_trans_i),
        .mrf0_ld_done_o(mrf0_ld_done_o),
        .mrf0_ld_dst_bram_addr_i(mrf0_ld_dst_bram_addr_i),
        .mrf0_ld_src_axi_addr_i(mrf0_ld_src_axi_addr_i),
        .mrf0_ld_start_i(mrf0_ld_start_i),
        .rst_n(rst_n),
        .vrf_ld_byte_to_trans_i(vrf_ld_byte_to_trans_i),
        .vrf_ld_dst_bram_addr_i(vrf_ld_dst_bram_addr_i),
        .vrf_ld_full_o(vrf_ld_full_o),
        .vrf_ld_src_axi_addr_i(vrf_ld_src_axi_addr_i),
        .vrf_ld_start_i(vrf_ld_start_i));
endmodule
