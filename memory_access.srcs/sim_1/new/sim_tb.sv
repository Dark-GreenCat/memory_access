`timescale 1ps / 1ps

module sim_tb;

  // Parameter declarations
  parameter CLK_PERIOD = 5000;
  parameter DDR4_CLK_PERIOD = 3332;

  // Signals
  logic clk;
  logic rst_n;
  logic ddr4_clk;
  logic ddr4_rst_n;

  // Clock generation
  initial begin
    clk = 0;
    forever #(CLK_PERIOD / 2) clk = ~clk;
  end

  initial begin
    ddr4_clk = 0;
    forever #(DDR4_CLK_PERIOD / 2) ddr4_clk = ~ddr4_clk;
  end

  // Reset sequence
  initial begin
    rst_n      = 0;
    ddr4_rst_n = 0;
    #(CLK_PERIOD * 5);
    rst_n      = 1;
    ddr4_rst_n = 1;
  end

  logic start;
  logic [35:0] src_axi_addr;
  logic [5:0] dst_bram_addr;
  logic [14:0] byte_to_trans;
  logic done;

  // Testbench
  initial begin
    start         = 0;
    src_axi_addr  = 0;
    dst_bram_addr = 0;
    byte_to_trans = 0;
    done          = 0;
    @(posedge rst_n);
    repeat (5) @(posedge clk);


    src_axi_addr  = 36'h3;
    dst_bram_addr = 6'h7;
    byte_to_trans = 15'(128 * 16);
    start         = 1;
    @(posedge clk);
    start = 0;
    @(posedge done);



    repeat (5) @(posedge clk);
    $finish;
  end

  initial begin
    #(CLK_PERIOD * 500);
    $finish;
  end

  ma_wrapper ma_wrapper_inst (
    .clk(clk),
    .rst_n(rst_n),
    .ddr4_clk(ddr4_clk),
    .ddr4_rst_n(ddr4_rst_n),
    .start_i(start),
    .src_axi_addr_i(src_axi_addr),
    .dst_bram_addr_i(dst_bram_addr),
    .byte_to_trans_i(byte_to_trans),
    .done_o(done)
  );

endmodule
