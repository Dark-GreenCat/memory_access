`timescale 1ns / 1ps

module arbiter (
  input clk,
  input rst_n,

  /* Interface for User Logic */
  input                 wr_req,
  output logic          wr_gnt,
  input        [   9:0] wr_addr,
  input        [1023:0] wr_data,

  /* Interface for VRF */
  output logic [   9:0] addra,
  input        [1023:0] douta,
  output logic [1023:0] dina,
  output logic          ena,
  output logic          wea
);

  // Simple arbiter logic
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      wr_gnt <= 1'b0;
      addra  <= 10'b0;
      dina   <= 1024'b0;
      ena    <= 1'b0;
      wea    <= 1'b0;
    end else begin
      // Grant write request when wr_req is high
      wr_gnt <= wr_req;

      // Pass address and data to VRF when write request is active
      addra  <= wr_req ? wr_addr : 10'b0;
      dina   <= wr_req ? wr_data : 1024'b0;

      // Enable VRF and write enable only when write request is active
      ena    <= wr_req;
      wea    <= wr_req;
    end
  end

endmodule
