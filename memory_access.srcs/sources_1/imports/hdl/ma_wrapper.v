//Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
//Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2024.1 (lin64) Build 5076996 Wed May 22 18:36:09 MDT 2024
//Date        : Tue May 13 03:04:27 2025
//Host        : edabk running 64-bit CentOS Linux release 7.9.2009 (Core)
//Command     : generate_target ma_wrapper.bd
//Design      : ma_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module ma_wrapper
   (M_AXI_MRF0_araddr,
    M_AXI_MRF0_arburst,
    M_AXI_MRF0_arcache,
    M_AXI_MRF0_arlen,
    M_AXI_MRF0_arlock,
    M_AXI_MRF0_arprot,
    M_AXI_MRF0_arready,
    M_AXI_MRF0_arsize,
    M_AXI_MRF0_arvalid,
    M_AXI_MRF0_awaddr,
    M_AXI_MRF0_awburst,
    M_AXI_MRF0_awcache,
    M_AXI_MRF0_awlen,
    M_AXI_MRF0_awlock,
    M_AXI_MRF0_awprot,
    M_AXI_MRF0_awready,
    M_AXI_MRF0_awsize,
    M_AXI_MRF0_awvalid,
    M_AXI_MRF0_bready,
    M_AXI_MRF0_bresp,
    M_AXI_MRF0_bvalid,
    M_AXI_MRF0_rdata,
    M_AXI_MRF0_rlast,
    M_AXI_MRF0_rready,
    M_AXI_MRF0_rresp,
    M_AXI_MRF0_rvalid,
    M_AXI_MRF0_wdata,
    M_AXI_MRF0_wlast,
    M_AXI_MRF0_wready,
    M_AXI_MRF0_wstrb,
    M_AXI_MRF0_wvalid,
    M_AXI_VRF_araddr,
    M_AXI_VRF_arburst,
    M_AXI_VRF_arcache,
    M_AXI_VRF_arlen,
    M_AXI_VRF_arlock,
    M_AXI_VRF_arprot,
    M_AXI_VRF_arready,
    M_AXI_VRF_arsize,
    M_AXI_VRF_arvalid,
    M_AXI_VRF_awaddr,
    M_AXI_VRF_awburst,
    M_AXI_VRF_awcache,
    M_AXI_VRF_awlen,
    M_AXI_VRF_awlock,
    M_AXI_VRF_awprot,
    M_AXI_VRF_awready,
    M_AXI_VRF_awsize,
    M_AXI_VRF_awvalid,
    M_AXI_VRF_bready,
    M_AXI_VRF_bresp,
    M_AXI_VRF_bvalid,
    M_AXI_VRF_rdata,
    M_AXI_VRF_rlast,
    M_AXI_VRF_rready,
    M_AXI_VRF_rresp,
    M_AXI_VRF_rvalid,
    M_AXI_VRF_wdata,
    M_AXI_VRF_wlast,
    M_AXI_VRF_wready,
    M_AXI_VRF_wstrb,
    M_AXI_VRF_wvalid,
    clk,
    mrf0_bram_addr_o,
    mrf0_bram_en_o,
    mrf0_bram_we_o,
    mrf0_bram_wrdata_o,
    mrf0_ld_byte_to_trans_i,
    mrf0_ld_done_o,
    mrf0_ld_dst_bram_addr_i,
    mrf0_ld_src_axi_addr_i,
    mrf0_ld_start_i,
    rst_n,
    vrf_arbiter_wr_addr_o,
    vrf_arbiter_wr_data_o,
    vrf_arbiter_wr_gnt_i,
    vrf_arbiter_wr_req_o,
    vrf_ld_byte_to_trans_i,
    vrf_ld_dst_bram_addr_i,
    vrf_ld_full_o,
    vrf_ld_src_axi_addr_i,
    vrf_ld_start_i);
  output [35:0]M_AXI_MRF0_araddr;
  output [1:0]M_AXI_MRF0_arburst;
  output [3:0]M_AXI_MRF0_arcache;
  output [7:0]M_AXI_MRF0_arlen;
  output M_AXI_MRF0_arlock;
  output [2:0]M_AXI_MRF0_arprot;
  input M_AXI_MRF0_arready;
  output [2:0]M_AXI_MRF0_arsize;
  output M_AXI_MRF0_arvalid;
  output [35:0]M_AXI_MRF0_awaddr;
  output [1:0]M_AXI_MRF0_awburst;
  output [3:0]M_AXI_MRF0_awcache;
  output [7:0]M_AXI_MRF0_awlen;
  output M_AXI_MRF0_awlock;
  output [2:0]M_AXI_MRF0_awprot;
  input M_AXI_MRF0_awready;
  output [2:0]M_AXI_MRF0_awsize;
  output M_AXI_MRF0_awvalid;
  output M_AXI_MRF0_bready;
  input [1:0]M_AXI_MRF0_bresp;
  input M_AXI_MRF0_bvalid;
  input [1023:0]M_AXI_MRF0_rdata;
  input M_AXI_MRF0_rlast;
  output M_AXI_MRF0_rready;
  input [1:0]M_AXI_MRF0_rresp;
  input M_AXI_MRF0_rvalid;
  output [1023:0]M_AXI_MRF0_wdata;
  output M_AXI_MRF0_wlast;
  input M_AXI_MRF0_wready;
  output [127:0]M_AXI_MRF0_wstrb;
  output M_AXI_MRF0_wvalid;
  output [35:0]M_AXI_VRF_araddr;
  output [1:0]M_AXI_VRF_arburst;
  output [3:0]M_AXI_VRF_arcache;
  output [7:0]M_AXI_VRF_arlen;
  output M_AXI_VRF_arlock;
  output [2:0]M_AXI_VRF_arprot;
  input M_AXI_VRF_arready;
  output [2:0]M_AXI_VRF_arsize;
  output M_AXI_VRF_arvalid;
  output [35:0]M_AXI_VRF_awaddr;
  output [1:0]M_AXI_VRF_awburst;
  output [3:0]M_AXI_VRF_awcache;
  output [7:0]M_AXI_VRF_awlen;
  output M_AXI_VRF_awlock;
  output [2:0]M_AXI_VRF_awprot;
  input M_AXI_VRF_awready;
  output [2:0]M_AXI_VRF_awsize;
  output M_AXI_VRF_awvalid;
  output M_AXI_VRF_bready;
  input [1:0]M_AXI_VRF_bresp;
  input M_AXI_VRF_bvalid;
  input [1023:0]M_AXI_VRF_rdata;
  input M_AXI_VRF_rlast;
  output M_AXI_VRF_rready;
  input [1:0]M_AXI_VRF_rresp;
  input M_AXI_VRF_rvalid;
  output [1023:0]M_AXI_VRF_wdata;
  output M_AXI_VRF_wlast;
  input M_AXI_VRF_wready;
  output [127:0]M_AXI_VRF_wstrb;
  output M_AXI_VRF_wvalid;
  input clk;
  output [5:0]mrf0_bram_addr_o;
  output mrf0_bram_en_o;
  output mrf0_bram_we_o;
  output [1023:0]mrf0_bram_wrdata_o;
  input [14:0]mrf0_ld_byte_to_trans_i;
  output mrf0_ld_done_o;
  input [5:0]mrf0_ld_dst_bram_addr_i;
  input [35:0]mrf0_ld_src_axi_addr_i;
  input mrf0_ld_start_i;
  input rst_n;
  output [9:0]vrf_arbiter_wr_addr_o;
  output [1023:0]vrf_arbiter_wr_data_o;
  input vrf_arbiter_wr_gnt_i;
  output vrf_arbiter_wr_req_o;
  input [14:0]vrf_ld_byte_to_trans_i;
  input [9:0]vrf_ld_dst_bram_addr_i;
  output vrf_ld_full_o;
  input [35:0]vrf_ld_src_axi_addr_i;
  input vrf_ld_start_i;

  wire [35:0]M_AXI_MRF0_araddr;
  wire [1:0]M_AXI_MRF0_arburst;
  wire [3:0]M_AXI_MRF0_arcache;
  wire [7:0]M_AXI_MRF0_arlen;
  wire M_AXI_MRF0_arlock;
  wire [2:0]M_AXI_MRF0_arprot;
  wire M_AXI_MRF0_arready;
  wire [2:0]M_AXI_MRF0_arsize;
  wire M_AXI_MRF0_arvalid;
  wire [35:0]M_AXI_MRF0_awaddr;
  wire [1:0]M_AXI_MRF0_awburst;
  wire [3:0]M_AXI_MRF0_awcache;
  wire [7:0]M_AXI_MRF0_awlen;
  wire M_AXI_MRF0_awlock;
  wire [2:0]M_AXI_MRF0_awprot;
  wire M_AXI_MRF0_awready;
  wire [2:0]M_AXI_MRF0_awsize;
  wire M_AXI_MRF0_awvalid;
  wire M_AXI_MRF0_bready;
  wire [1:0]M_AXI_MRF0_bresp;
  wire M_AXI_MRF0_bvalid;
  wire [1023:0]M_AXI_MRF0_rdata;
  wire M_AXI_MRF0_rlast;
  wire M_AXI_MRF0_rready;
  wire [1:0]M_AXI_MRF0_rresp;
  wire M_AXI_MRF0_rvalid;
  wire [1023:0]M_AXI_MRF0_wdata;
  wire M_AXI_MRF0_wlast;
  wire M_AXI_MRF0_wready;
  wire [127:0]M_AXI_MRF0_wstrb;
  wire M_AXI_MRF0_wvalid;
  wire [35:0]M_AXI_VRF_araddr;
  wire [1:0]M_AXI_VRF_arburst;
  wire [3:0]M_AXI_VRF_arcache;
  wire [7:0]M_AXI_VRF_arlen;
  wire M_AXI_VRF_arlock;
  wire [2:0]M_AXI_VRF_arprot;
  wire M_AXI_VRF_arready;
  wire [2:0]M_AXI_VRF_arsize;
  wire M_AXI_VRF_arvalid;
  wire [35:0]M_AXI_VRF_awaddr;
  wire [1:0]M_AXI_VRF_awburst;
  wire [3:0]M_AXI_VRF_awcache;
  wire [7:0]M_AXI_VRF_awlen;
  wire M_AXI_VRF_awlock;
  wire [2:0]M_AXI_VRF_awprot;
  wire M_AXI_VRF_awready;
  wire [2:0]M_AXI_VRF_awsize;
  wire M_AXI_VRF_awvalid;
  wire M_AXI_VRF_bready;
  wire [1:0]M_AXI_VRF_bresp;
  wire M_AXI_VRF_bvalid;
  wire [1023:0]M_AXI_VRF_rdata;
  wire M_AXI_VRF_rlast;
  wire M_AXI_VRF_rready;
  wire [1:0]M_AXI_VRF_rresp;
  wire M_AXI_VRF_rvalid;
  wire [1023:0]M_AXI_VRF_wdata;
  wire M_AXI_VRF_wlast;
  wire M_AXI_VRF_wready;
  wire [127:0]M_AXI_VRF_wstrb;
  wire M_AXI_VRF_wvalid;
  wire clk;
  wire [5:0]mrf0_bram_addr_o;
  wire mrf0_bram_en_o;
  wire mrf0_bram_we_o;
  wire [1023:0]mrf0_bram_wrdata_o;
  wire [14:0]mrf0_ld_byte_to_trans_i;
  wire mrf0_ld_done_o;
  wire [5:0]mrf0_ld_dst_bram_addr_i;
  wire [35:0]mrf0_ld_src_axi_addr_i;
  wire mrf0_ld_start_i;
  wire rst_n;
  wire [9:0]vrf_arbiter_wr_addr_o;
  wire [1023:0]vrf_arbiter_wr_data_o;
  wire vrf_arbiter_wr_gnt_i;
  wire vrf_arbiter_wr_req_o;
  wire [14:0]vrf_ld_byte_to_trans_i;
  wire [9:0]vrf_ld_dst_bram_addr_i;
  wire vrf_ld_full_o;
  wire [35:0]vrf_ld_src_axi_addr_i;
  wire vrf_ld_start_i;

  ma ma_i
       (.M_AXI_MRF0_araddr(M_AXI_MRF0_araddr),
        .M_AXI_MRF0_arburst(M_AXI_MRF0_arburst),
        .M_AXI_MRF0_arcache(M_AXI_MRF0_arcache),
        .M_AXI_MRF0_arlen(M_AXI_MRF0_arlen),
        .M_AXI_MRF0_arlock(M_AXI_MRF0_arlock),
        .M_AXI_MRF0_arprot(M_AXI_MRF0_arprot),
        .M_AXI_MRF0_arready(M_AXI_MRF0_arready),
        .M_AXI_MRF0_arsize(M_AXI_MRF0_arsize),
        .M_AXI_MRF0_arvalid(M_AXI_MRF0_arvalid),
        .M_AXI_MRF0_awaddr(M_AXI_MRF0_awaddr),
        .M_AXI_MRF0_awburst(M_AXI_MRF0_awburst),
        .M_AXI_MRF0_awcache(M_AXI_MRF0_awcache),
        .M_AXI_MRF0_awlen(M_AXI_MRF0_awlen),
        .M_AXI_MRF0_awlock(M_AXI_MRF0_awlock),
        .M_AXI_MRF0_awprot(M_AXI_MRF0_awprot),
        .M_AXI_MRF0_awready(M_AXI_MRF0_awready),
        .M_AXI_MRF0_awsize(M_AXI_MRF0_awsize),
        .M_AXI_MRF0_awvalid(M_AXI_MRF0_awvalid),
        .M_AXI_MRF0_bready(M_AXI_MRF0_bready),
        .M_AXI_MRF0_bresp(M_AXI_MRF0_bresp),
        .M_AXI_MRF0_bvalid(M_AXI_MRF0_bvalid),
        .M_AXI_MRF0_rdata(M_AXI_MRF0_rdata),
        .M_AXI_MRF0_rlast(M_AXI_MRF0_rlast),
        .M_AXI_MRF0_rready(M_AXI_MRF0_rready),
        .M_AXI_MRF0_rresp(M_AXI_MRF0_rresp),
        .M_AXI_MRF0_rvalid(M_AXI_MRF0_rvalid),
        .M_AXI_MRF0_wdata(M_AXI_MRF0_wdata),
        .M_AXI_MRF0_wlast(M_AXI_MRF0_wlast),
        .M_AXI_MRF0_wready(M_AXI_MRF0_wready),
        .M_AXI_MRF0_wstrb(M_AXI_MRF0_wstrb),
        .M_AXI_MRF0_wvalid(M_AXI_MRF0_wvalid),
        .M_AXI_VRF_araddr(M_AXI_VRF_araddr),
        .M_AXI_VRF_arburst(M_AXI_VRF_arburst),
        .M_AXI_VRF_arcache(M_AXI_VRF_arcache),
        .M_AXI_VRF_arlen(M_AXI_VRF_arlen),
        .M_AXI_VRF_arlock(M_AXI_VRF_arlock),
        .M_AXI_VRF_arprot(M_AXI_VRF_arprot),
        .M_AXI_VRF_arready(M_AXI_VRF_arready),
        .M_AXI_VRF_arsize(M_AXI_VRF_arsize),
        .M_AXI_VRF_arvalid(M_AXI_VRF_arvalid),
        .M_AXI_VRF_awaddr(M_AXI_VRF_awaddr),
        .M_AXI_VRF_awburst(M_AXI_VRF_awburst),
        .M_AXI_VRF_awcache(M_AXI_VRF_awcache),
        .M_AXI_VRF_awlen(M_AXI_VRF_awlen),
        .M_AXI_VRF_awlock(M_AXI_VRF_awlock),
        .M_AXI_VRF_awprot(M_AXI_VRF_awprot),
        .M_AXI_VRF_awready(M_AXI_VRF_awready),
        .M_AXI_VRF_awsize(M_AXI_VRF_awsize),
        .M_AXI_VRF_awvalid(M_AXI_VRF_awvalid),
        .M_AXI_VRF_bready(M_AXI_VRF_bready),
        .M_AXI_VRF_bresp(M_AXI_VRF_bresp),
        .M_AXI_VRF_bvalid(M_AXI_VRF_bvalid),
        .M_AXI_VRF_rdata(M_AXI_VRF_rdata),
        .M_AXI_VRF_rlast(M_AXI_VRF_rlast),
        .M_AXI_VRF_rready(M_AXI_VRF_rready),
        .M_AXI_VRF_rresp(M_AXI_VRF_rresp),
        .M_AXI_VRF_rvalid(M_AXI_VRF_rvalid),
        .M_AXI_VRF_wdata(M_AXI_VRF_wdata),
        .M_AXI_VRF_wlast(M_AXI_VRF_wlast),
        .M_AXI_VRF_wready(M_AXI_VRF_wready),
        .M_AXI_VRF_wstrb(M_AXI_VRF_wstrb),
        .M_AXI_VRF_wvalid(M_AXI_VRF_wvalid),
        .clk(clk),
        .mrf0_bram_addr_o(mrf0_bram_addr_o),
        .mrf0_bram_en_o(mrf0_bram_en_o),
        .mrf0_bram_we_o(mrf0_bram_we_o),
        .mrf0_bram_wrdata_o(mrf0_bram_wrdata_o),
        .mrf0_ld_byte_to_trans_i(mrf0_ld_byte_to_trans_i),
        .mrf0_ld_done_o(mrf0_ld_done_o),
        .mrf0_ld_dst_bram_addr_i(mrf0_ld_dst_bram_addr_i),
        .mrf0_ld_src_axi_addr_i(mrf0_ld_src_axi_addr_i),
        .mrf0_ld_start_i(mrf0_ld_start_i),
        .rst_n(rst_n),
        .vrf_arbiter_wr_addr_o(vrf_arbiter_wr_addr_o),
        .vrf_arbiter_wr_data_o(vrf_arbiter_wr_data_o),
        .vrf_arbiter_wr_gnt_i(vrf_arbiter_wr_gnt_i),
        .vrf_arbiter_wr_req_o(vrf_arbiter_wr_req_o),
        .vrf_ld_byte_to_trans_i(vrf_ld_byte_to_trans_i),
        .vrf_ld_dst_bram_addr_i(vrf_ld_dst_bram_addr_i),
        .vrf_ld_full_o(vrf_ld_full_o),
        .vrf_ld_src_axi_addr_i(vrf_ld_src_axi_addr_i),
        .vrf_ld_start_i(vrf_ld_start_i));
endmodule
