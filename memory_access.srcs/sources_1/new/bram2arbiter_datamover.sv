`timescale 1ns / 1ps

module bram2arbiter_datamover #(
  parameter BRAM_ADDRWIDTH = 10,
  parameter DATAWIDTH = 1024
) (
  input  logic                        clk,
  input  logic                        rst_n,

  /* Interface for Controller */
  output logic                        full_o,

  /* Interface for BRAM */
  input  logic [BRAM_ADDRWIDTH-1:0]   bram_addr,
  input  logic [     DATAWIDTH-1:0]   bram_wrdata,
  input  logic                        bram_en,
  input  logic                        bram_we,

  /* Interface for Arbiter */
  output logic                        wr_req,
  input  logic                        wr_gnt,
  output logic [BRAM_ADDRWIDTH-1:0]   wr_addr,
  output logic [     DATAWIDTH-1:0]   wr_data
);

  // Registers for stored data and state
  logic [BRAM_ADDRWIDTH-1:0] addr;
  logic [     DATAWIDTH-1:0] data;
  logic                      data_valid;  // Indicates stored data waiting for grant

  // Sequential logic for storing data and managing state
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      addr       <= 0;
      data       <= 0;
      data_valid <= 1'b0;
    end else begin
      if (bram_en && bram_we && !full_o) begin
        // Store new BRAM data if not full
        addr       <= bram_addr;
        data       <= bram_wrdata;
        data_valid <= 1'b1;
      end else if (wr_req && wr_gnt) begin
        // Clear data_valid when granted
        data_valid <= 1'b0;
      end
    end
  end

  // Combinational logic for outputs
  always @(*) begin
    // Assert wr_req when data is valid
    wr_req = data_valid;

    // Assert full_o when data is valid (cannot accept new BRAM data)
    full_o = data_valid;

    // Forward addr and data to wr_addr and wr_data when wr_req and wr_gnt are high
    if (wr_req && wr_gnt) begin
      wr_addr = addr;
      wr_data = data;
    end else begin
      wr_addr = 0;
      wr_data = 0;
    end
  end

endmodule
