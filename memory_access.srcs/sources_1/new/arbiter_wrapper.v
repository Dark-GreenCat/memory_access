`timescale 1ns / 1ps

module arbiter_wrapper (
  input clk,
  input rst_n,

  /* Interface for User Logic */
  input           wr_req,
  output          wr_gnt,
  input  [   9:0] wr_addr,
  input  [1023:0] wr_data,

  /* Interface for VRF */
  output [   9:0] addra,
  input  [1023:0] douta,
  output [1023:0] dina,
  output          ena,
  output          wea
);

  // Instantiate the arbiter module
  arbiter u_arbiter (
    .clk    (clk),
    .rst_n  (rst_n),
    .wr_req (wr_req),
    .wr_gnt (wr_gnt),
    .wr_addr(wr_addr),
    .wr_data(wr_data),
    .addra  (addra),
    .douta  (douta),
    .dina   (dina),
    .ena    (ena),
    .wea    (wea)
  );

endmodule
