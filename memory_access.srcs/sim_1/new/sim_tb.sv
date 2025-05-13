`timescale 1ps / 1ps

`define MRF_0_MEMORY_INST ma_wrapper_inst.ma_i.mrf_0.inst.native_mem_module.blk_mem_gen_v8_4_8_inst.memory
`define MRF_0_DUMP_FILE "dump_mrf_0.txt"
parameter MRF_DATAWIDTH = 1024;
parameter MRF_DEPTH = 64;


`define VRF_MEMORY_INST ma_wrapper_inst.ma_i.vrf.inst.native_mem_module.blk_mem_gen_v8_4_8_inst.memory
`define VRF_DUMP_FILE "dump_vrf.txt"
parameter VRF_DATAWIDTH = 1024;
parameter VRF_DEPTH = 1024;

module sim_tb;

  // Parameter declarations
  parameter CLK_PERIOD = 5000;  // 5ns (200 MHz)
  parameter DDR4_CLK_PERIOD = 3332;  // 3.332ns (~300 MHz)

  // Signals
  logic        clk;
  logic        rst_n;
  logic        ddr4_clk;
  logic        ddr4_rst_n;

  // MRF_0 Interface Signals
  logic        mrf_0_start_i;
  logic [35:0] mrf_0_src_axi_addr_i;
  logic [ 5:0] mrf_0_dst_bram_addr_i;
  logic [14:0] mrf_0_byte_to_trans_i;
  logic        mrf_0_done_o;

  // Arbiter Interface Signals (tie-off if unused)
  logic        arbiter_wr_req;
  logic        arbiter_wr_gnt;

  // VRF_LD Interface Signals
  logic [14:0] vrf_ld_byte_to_trans_i;
  logic        vrf_ld_done_0;
  logic [ 9:0] vrf_ld_dst_bram_addr_i;
  logic [35:0] vrf_ld_src_axi_addr_i;
  logic        vrf_ld_start_i;

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

  // Testbench stimulus
  initial begin
    // Initialize signals
    mrf_0_start_i          = 0;
    mrf_0_src_axi_addr_i   = 0;
    mrf_0_dst_bram_addr_i  = 0;
    mrf_0_byte_to_trans_i  = 0;
    mrf_0_done_o           = 0;

    arbiter_wr_req         = 0;  // Tie-off if not used
    arbiter_wr_gnt         = 0;  // Driven by ma_wrapper

    vrf_ld_byte_to_trans_i = 0;
    vrf_ld_done_0          = 0;
    vrf_ld_dst_bram_addr_i = 0;
    vrf_ld_src_axi_addr_i  = 0;
    vrf_ld_start_i         = 0;

    @(posedge rst_n);
    repeat (5) @(posedge clk);

    // Test Case 1
    fork
      // MRF_0 Transaction (2048 bytes)
      begin
        @(posedge clk);
        mrf_0_src_axi_addr_i  = 36'h0;
        mrf_0_dst_bram_addr_i = 6'h48;
        mrf_0_byte_to_trans_i = 15'(128 * 16);  // 2048 bytes
        mrf_0_start_i         = 1;
        @(posedge clk);
        mrf_0_start_i = 0;
        @(posedge mrf_0_done_o);
      end
      // VRF_LD Transactions (2 x 128 bytes)
      begin
        // First VRF_LD Transaction
        @(posedge clk);
        vrf_ld_src_axi_addr_i  = 36'h0;
        vrf_ld_dst_bram_addr_i = 10'h0;
        vrf_ld_byte_to_trans_i = 15'(128);  // 128 bytes
        vrf_ld_start_i         = 1;
        @(posedge clk);
        vrf_ld_start_i = 0;
        @(posedge vrf_ld_done_0);
        @(posedge clk);
        arbiter_wr_req = 1;
        @(posedge arbiter_wr_gnt);
        @(posedge clk);
        arbiter_wr_req = 0;

        // Second VRF_LD Transaction
        @(posedge clk);
        vrf_ld_src_axi_addr_i  = 36'h80;  // Next 128 bytes
        vrf_ld_dst_bram_addr_i = 10'h2;  // Next BRAM address
        vrf_ld_byte_to_trans_i = 15'(128);  // 128 bytes
        vrf_ld_start_i         = 1;
        @(posedge clk);
        vrf_ld_start_i = 0;
        @(posedge vrf_ld_done_0);
        @(posedge clk);
        arbiter_wr_req = 1;
        @(posedge arbiter_wr_gnt);
        @(posedge clk);
        arbiter_wr_req = 0;
      end
    join

    // Test Case 2
    fork
      // MRF_0 Transaction (2048 bytes)
      begin
        @(posedge clk);
        mrf_0_src_axi_addr_i  = 36'hc;
        mrf_0_dst_bram_addr_i = 6'h32;
        mrf_0_byte_to_trans_i = 15'(128 * 16);  // 2048 bytes
        mrf_0_start_i         = 1;
        @(posedge clk);
        mrf_0_start_i = 0;
        @(posedge mrf_0_done_o);
      end
      // VRF_LD Transactions (2 x 128 bytes)
      begin
        // First VRF_LD Transaction
        @(posedge clk);
        vrf_ld_src_axi_addr_i  = 36'h100;
        vrf_ld_dst_bram_addr_i = 10'h4;
        vrf_ld_byte_to_trans_i = 15'(128);  // 128 bytes
        vrf_ld_start_i         = 1;
        @(posedge clk);
        vrf_ld_start_i = 0;
        @(posedge vrf_ld_done_0);
        @(posedge clk);
        arbiter_wr_req = 1;
        @(posedge arbiter_wr_gnt);
        @(posedge clk);
        arbiter_wr_req = 0;

        // Second VRF_LD Transaction
        @(posedge clk);
        vrf_ld_src_axi_addr_i  = 36'h180;
        vrf_ld_dst_bram_addr_i = 10'h6;
        vrf_ld_byte_to_trans_i = 15'(128);  // 128 bytes
        vrf_ld_start_i         = 1;
        @(posedge clk);
        vrf_ld_start_i = 0;
        @(posedge vrf_ld_done_0);
        @(posedge clk);
        arbiter_wr_req = 1;
        @(posedge arbiter_wr_gnt);
        @(posedge clk);
        arbiter_wr_req = 0;
      end
    join

    // Test Case 3
    fork
      // MRF_0 Transaction (2048 bytes)
      begin
        @(posedge clk);
        mrf_0_src_axi_addr_i  = 36'h2;
        mrf_0_dst_bram_addr_i = 6'h0;
        mrf_0_byte_to_trans_i = 15'(128 * 16);  // 2048 bytes
        mrf_0_start_i         = 1;
        @(posedge clk);
        mrf_0_start_i = 0;
        @(posedge mrf_0_done_o);
      end
      // VRF_LD Transactions (2 x 128 bytes)
      begin
        // First VRF_LD Transaction
        @(posedge clk);
        vrf_ld_src_axi_addr_i  = 36'h200;
        vrf_ld_dst_bram_addr_i = 10'h8;
        vrf_ld_byte_to_trans_i = 15'(128);  // 128 bytes
        vrf_ld_start_i         = 1;
        @(posedge clk);
        vrf_ld_start_i = 0;
        @(posedge vrf_ld_done_0);
        @(posedge clk);
        arbiter_wr_req = 1;
        @(posedge arbiter_wr_gnt);
        @(posedge clk);
        arbiter_wr_req = 0;

        // Second VRF_LD Transaction
        @(posedge clk);
        vrf_ld_src_axi_addr_i  = 36'h280;
        vrf_ld_dst_bram_addr_i = 10'ha;
        vrf_ld_byte_to_trans_i = 15'(128);  // 128 bytes
        vrf_ld_start_i         = 1;
        @(posedge clk);
        vrf_ld_start_i = 0;
        @(posedge vrf_ld_done_0);
        @(posedge clk);
        arbiter_wr_req = 1;
        @(posedge arbiter_wr_gnt);
        @(posedge clk);
        arbiter_wr_req = 0;
      end
    join

    // Test Case 4
    fork
      // MRF_0 Transaction (2048 bytes)
      begin
        @(posedge clk);
        mrf_0_src_axi_addr_i  = 36'he;
        mrf_0_dst_bram_addr_i = 6'h16;
        mrf_0_byte_to_trans_i = 15'(128 * 16);  // 2048 bytes
        mrf_0_start_i         = 1;
        @(posedge clk);
        mrf_0_start_i = 0;
        @(posedge mrf_0_done_o);
      end
      // VRF_LD Transactions (2 x 128 bytes)
      begin
        // First VRF_LD Transaction
        @(posedge clk);
        vrf_ld_src_axi_addr_i  = 36'h300;
        vrf_ld_dst_bram_addr_i = 10'hc;
        vrf_ld_byte_to_trans_i = 15'(128);  // 128 bytes
        vrf_ld_start_i         = 1;
        @(posedge clk);
        vrf_ld_start_i = 0;
        @(posedge vrf_ld_done_0);
        @(posedge clk);
        arbiter_wr_req = 1;
        @(posedge arbiter_wr_gnt);
        @(posedge clk);
        arbiter_wr_req = 0;

        // Second VRF_LD Transaction
        @(posedge clk);
        vrf_ld_src_axi_addr_i  = 36'h380;
        vrf_ld_dst_bram_addr_i = 10'he;
        vrf_ld_byte_to_trans_i = 15'(128);  // 128 bytes
        vrf_ld_start_i         = 1;
        @(posedge clk);
        vrf_ld_start_i = 0;
        @(posedge vrf_ld_done_0);
        @(posedge clk);
        arbiter_wr_req = 1;
        @(posedge arbiter_wr_gnt);
        @(posedge clk);
        arbiter_wr_req = 0;
      end
    join

    repeat (5) @(posedge clk);
    log_mrf(`MRF_0_DUMP_FILE, `MRF_0_MEMORY_INST);
    log_vrf(`VRF_DUMP_FILE, `VRF_MEMORY_INST);
    $finish;
  end

  // Instantiate the wrapper
  ma_wrapper ma_wrapper_inst (
    .clk                   (clk),
    .rst_n                 (rst_n),
    .ddr4_clk              (ddr4_clk),
    .ddr4_rst_n            (ddr4_rst_n),
    .arbiter_wr_req        (arbiter_wr_req),          // Tie-off to 0 if not used
    .arbiter_wr_gnt        (arbiter_wr_gnt),          // Driven by ma_wrapper
    .mrf_0_start_i         (mrf_0_start_i),
    .mrf_0_src_axi_addr_i  (mrf_0_src_axi_addr_i),
    .mrf_0_dst_bram_addr_i (mrf_0_dst_bram_addr_i),
    .mrf_0_byte_to_trans_i (mrf_0_byte_to_trans_i),
    .mrf_0_done_o          (mrf_0_done_o),
    .vrf_ld_start_i        (vrf_ld_start_i),
    .vrf_ld_src_axi_addr_i (vrf_ld_src_axi_addr_i),
    .vrf_ld_dst_bram_addr_i(vrf_ld_dst_bram_addr_i),
    .vrf_ld_byte_to_trans_i(vrf_ld_byte_to_trans_i),
    .vrf_ld_done_0         (vrf_ld_done_0)
  );

  // Memory logging task
  task automatic log_mrf(string filename, input [MRF_DATAWIDTH-1:0] memory[0:MRF_DEPTH-1]);
    int dump_file = $fopen(filename, "w");
    for (int i = 0; i < MRF_DEPTH; i = i + 1) begin
      $fdisplay(dump_file, "mem[%04d]: %h", i, memory[i]);
    end
    $fclose(dump_file);
  endtask

  // Memory logging task
  task automatic log_vrf(string filename, input [VRF_DATAWIDTH-1:0] memory[0:VRF_DEPTH-1]);
    int dump_file = $fopen(filename, "w");
    for (int i = 0; i < VRF_DEPTH; i = i + 1) begin
      $fdisplay(dump_file, "mem[%04d]: %h", i, memory[i]);
    end
    $fclose(dump_file);
  endtask

endmodule
