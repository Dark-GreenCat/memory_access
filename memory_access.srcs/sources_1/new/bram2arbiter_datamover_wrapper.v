`timescale 1ns / 1ps

module bram2arbiter_datamover_wrapper #(
  parameter BRAM_ADDRWIDTH = 10,
  parameter DATAWIDTH = 1024
) (
  input clk,
  input rst_n,

  /* Interface for Controller */
  output full,

  /* Interface for BRAM */
  (* X_INTERFACE_MODE = "Slave" *)
  (* X_INTERFACE_INFO = "xilinx.com:interface:bram:1.0 BRAM_PORT ADDR" *)
  input [BRAM_ADDRWIDTH-1:0] bram_addr,
  (* X_INTERFACE_INFO = "xilinx.com:interface:bram:1.0 BRAM_PORT DIN" *)
  input [DATAWIDTH-1:0] bram_wrdata,
  (* X_INTERFACE_INFO = "xilinx.com:interface:bram:1.0 BRAM_PORT EN" *)
  input bram_en,
  (* X_INTERFACE_INFO = "xilinx.com:interface:bram:1.0 BRAM_PORT WE" *)
  input bram_we,

  /* Interface for Arbiter */
  output                      wr_req,
  input                       wr_gnt,
  output [BRAM_ADDRWIDTH-1:0] wr_addr,
  output [     DATAWIDTH-1:0] wr_data
);

  // Instantiate bram2arbiter_datamover
  bram2arbiter_datamover #(
    .BRAM_ADDRWIDTH(BRAM_ADDRWIDTH),
    .DATAWIDTH(DATAWIDTH)
  ) bram2arbiter_datamover_inst (
    .clk(clk),
    .rst_n(rst_n),
    .full_o(full),
    .bram_addr(bram_addr),
    .bram_wrdata(bram_wrdata),
    .bram_en(bram_en),
    .bram_we(bram_we),
    .wr_req(wr_req),
    .wr_gnt(wr_gnt),
    .wr_addr(wr_addr),
    .wr_data(wr_data)
  );

endmodule