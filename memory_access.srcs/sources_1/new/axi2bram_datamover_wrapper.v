`timescale 1ns / 1ps

module axi2bram_datamover_wrapper #(
  parameter AXI_ADDRWIDTH = 36,
  parameter BRAM_ADDRWIDTH = 10,
  parameter DATAWIDTH = 1024
) (
  input clk,
  input rst_n,

  /* Interface for Controller */
  input                       start,
  input  [ AXI_ADDRWIDTH-1:0] src_axi_addr,
  input  [BRAM_ADDRWIDTH-1:0] dst_bram_addr,
  input  [              14:0] byte_to_trans,
  output                      done,

  /* Interface for AXI4 */
  // Read Address Channel (AXI Master outputs)
  output [AXI_ADDRWIDTH-1:0] M_AXI_araddr,
  output [              1:0] M_AXI_arburst,
  output [              3:0] M_AXI_arcache,
  output [              7:0] M_AXI_arlen,
  output                     M_AXI_arlock,
  output [              2:0] M_AXI_arprot,
  output [              2:0] M_AXI_arsize,
  output                     M_AXI_arvalid,
  input                      M_AXI_arready,
  // Write Address Channel (AXI Master outputs)
  output [AXI_ADDRWIDTH-1:0] M_AXI_awaddr,
  output [              1:0] M_AXI_awburst,
  output [              3:0] M_AXI_awcache,
  output [              7:0] M_AXI_awlen,
  output                     M_AXI_awlock,
  output [              2:0] M_AXI_awprot,
  output [              2:0] M_AXI_awsize,
  output                     M_AXI_awvalid,
  input                      M_AXI_awready,
  // Write Response Channel (AXI Master inputs)
  input  [              1:0] M_AXI_bresp,
  input                      M_AXI_bvalid,
  output                     M_AXI_bready,
  // Read Data Channel (AXI Master inputs)
  input  [    DATAWIDTH-1:0] M_AXI_rdata,
  input                      M_AXI_rlast,
  input  [              1:0] M_AXI_rresp,
  input                      M_AXI_rvalid,
  output                     M_AXI_rready,
  // Write Data Channel (AXI Master outputs)
  output [    DATAWIDTH-1:0] M_AXI_wdata,
  output [  DATAWIDTH/8-1:0] M_AXI_wstrb,
  output                     M_AXI_wlast,
  output                     M_AXI_wvalid,
  input                      M_AXI_wready,

  /* Interface for BRAM */
  (* X_INTERFACE_MODE = "Master" *)
  (* X_INTERFACE_INFO = "xilinx.com:interface:bram:1.0 BRAM_PORT ADDR" *)
  output [BRAM_ADDRWIDTH-1:0] bram_addr,
    (* X_INTERFACE_INFO = "xilinx.com:interface:bram:1.0 BRAM_PORT DIN" *)
  output [DATAWIDTH-1:0] bram_wrdata,
    (* X_INTERFACE_INFO = "xilinx.com:interface:bram:1.0 BRAM_PORT EN" *)
  output bram_en, (* X_INTERFACE_INFO = "xilinx.com:interface:bram:1.0 BRAM_PORT WE" *)
  output bram_we
);


  // Instantiate axi2bram_datamover
  axi2bram_datamover #(
    .AXI_ADDRWIDTH(AXI_ADDRWIDTH),
    .BRAM_ADDRWIDTH(BRAM_ADDRWIDTH),
    .DATAWIDTH(DATAWIDTH)
  ) axi2bram_datamover_inst (
    .clk  (clk),
    .rst_n(rst_n),

    // Controller Interface
    .start_i(start),
    .src_axi_addr_i(src_axi_addr),
    .dst_bram_addr_i(dst_bram_addr),
    .byte_to_trans_i(byte_to_trans),
    .done_o(done),

    // AXI Read Address Channel
    .m_axi_araddr (M_AXI_araddr),
    .m_axi_arburst(M_AXI_arburst),
    .m_axi_arcache(M_AXI_arcache),
    .m_axi_arlen  (M_AXI_arlen),
    .m_axi_arlock (M_AXI_arlock),
    .m_axi_arprot (M_AXI_arprot),
    .m_axi_arsize (M_AXI_arsize),
    .m_axi_arvalid(M_AXI_arvalid),
    .m_axi_arready(M_AXI_arready),
    // AXI Read Data Channel
    .m_axi_rdata  (M_AXI_rdata),
    .m_axi_rlast  (M_AXI_rlast),
    .m_axi_rresp  (M_AXI_rresp),
    .m_axi_rvalid (M_AXI_rvalid),
    .m_axi_rready (M_AXI_rready),

    // BRAM Interface
    .bram_addr(bram_addr),
    .bram_wrdata(bram_wrdata),
    .bram_en(bram_en),
    .bram_we(bram_we)
  );

  // Tie off unused AXI Write Channels
  assign M_AXI_awaddr  = {AXI_ADDRWIDTH{1'b0}};
  assign M_AXI_awburst = 2'b00;
  assign M_AXI_awcache = 4'b0000;
  assign M_AXI_awlen   = 8'b0;
  assign M_AXI_awlock  = 1'b0;
  assign M_AXI_awprot  = 3'b000;
  assign M_AXI_awsize  = 3'b000;
  assign M_AXI_awvalid = 1'b0;

  assign M_AXI_wdata   = {DATAWIDTH{1'b0}};
  assign M_AXI_wstrb   = {(DATAWIDTH / 8) {1'b0}};
  assign M_AXI_wlast   = 1'b0;
  assign M_AXI_wvalid  = 1'b0;

  assign M_AXI_bready  = 1'b1;
endmodule
