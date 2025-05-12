`timescale 1ps / 1ps

`define MRF_0_MEMORY_INST ma_wrapper_inst.ma_i.mrf_0.inst.native_mem_module.blk_mem_gen_v8_4_8_inst.memory
`define MRF_0_DUMP_FILE "dump_mrf_0.txt"

parameter MRF_DATAWIDTH = 1024;
parameter MRF_DEPTH = 64;

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


    @(posedge clk);
    src_axi_addr  = 36'h3;
    dst_bram_addr = 6'h48;
    byte_to_trans = 15'(128 * 16);
    start         = 1;
    @(posedge clk);
    start = 0;
    @(posedge done);

    @(posedge clk);
    src_axi_addr  = 36'h9;
    dst_bram_addr = 6'h32;
    byte_to_trans = 15'(128 * 16);
    start         = 1;
    @(posedge clk);
    start = 0;
    @(posedge done);

    @(posedge clk);
    src_axi_addr  = 36'h1a;
    dst_bram_addr = 6'h0;
    byte_to_trans = 15'(128 * 16);
    start         = 1;
    @(posedge clk);
    start = 0;
    @(posedge done);

    @(posedge clk);
    src_axi_addr  = 36'hf;
    dst_bram_addr = 6'h16;
    byte_to_trans = 15'(128 * 16);
    start         = 1;
    @(posedge clk);
    start = 0;
    @(posedge done);


    repeat (5) @(posedge clk);
    log_mrf(`MRF_0_DUMP_FILE, `MRF_0_MEMORY_INST);
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

task automatic log_mrf(string filename, input [MRF_DATAWIDTH-1:0] memory[0:MRF_DEPTH-1]);
  int dump_file = $fopen(filename, "w");
  for (int i = 0; i < MRF_DEPTH; i = i + 1) begin
    $fdisplay(dump_file, "mem[%04d]: %h", i, memory[i]);
  end
endtask
